Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSGDCUH>; Wed, 3 Jul 2002 22:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317320AbSGDCUG>; Wed, 3 Jul 2002 22:20:06 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:20705 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317318AbSGDCUE>; Wed, 3 Jul 2002 22:20:04 -0400
Message-ID: <3D23B21E.9030102@didntduck.org>
Date: Wed, 03 Jul 2002 22:25:34 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
References: <10962.1025745528@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		 Leaders
PrivateKeith Owens wrote:
> On Wed, 3 Jul 2002 05:48:09 +0200, 
> Pavel Machek <pavel@ucw.cz> wrote:
> 
>>Okay. So we want modules and want them unload. And we want it bugfree.
>>
>>So... then its okay if module unload is *slow*, right?
>>
>>I believe you can just freeze_processes(), unload module [now its
>>safe, you *know* noone is using that module, because all processes are
>>in your refrigerator], thaw_processes().
> 
> 
> The devil is in the details.
> 
> You must not freeze the process doing rmmod, that way lies deadlock.
> 
> Modules can run their own kernel threads.  When the module shuts down
> it terminates the threads but we must wait until the process entries
> for the threads have been reaped.  If you are not careful, the zombie
> clean up code can refer to the module that no longer exists.  You must
> not freeze any threads that belong to the module.
> 
> You must not freeze any process that has entered the module but not yet
> incremented the use count, nor any process that has decremented the use
> count but not yet left the module.  Simply looking at the EIP after
> freeze is not enough.  Module code with a use count of 0 is allowed to
> call any function as long as that function does not sleep.  That rule
> used to be safe, but adding preempt has turned that safe rule into a
> race, freezing processes has the same effect as preempt.
> 
> Using freeze or any other quiesce style operation requires that the
> module clean up be split into two parts.  The logic must be :-
> 
> Check usecount == 0
> 
> Call module unregister routine.  Unlike the existing clean up code,
> this only removes externally visible interfaces, it does not delete
> module structures.
> 
> <handwaving>
>   Outside the module, do whatever it takes to ensure that nothing is
>   executing any module code, including threads, command callbacks etc.
> </handwaving>
> 
> Check the usecount again.
> 
> If usecount is non-zero then some other code entered the module after
> checking the usecount the first time and before unregister completed.
> Either mark the module for delayed delete or reactivate the module by
> calling the module's register routine.
> 
> If usecount is still 0 after the handwaving, then it is safe to call
> the final module clean up routine to destroy its structures, release
> hardware etc.  Then (and only then) is it safe to free the module.
> 
> 
> Rusty and I agree that if (and it's a big if) we want to support module
> unloading safely then this is the only sane way to do it.  It requires
> some moderately complex handwaving code, changes to every module (split
> init and cleanup in two) and a new version of modutils in order to do
> this method.  Because of the high cost, Rusty is exploring other
> options before diving into a kernel wide change.

Why not treat a module just like any other structure?  Obtain a 
reference to it _before_ using it.  I propose this change:

- When a module is inserted, it has a reference count of 1.  This keeps 
it loaded.
- get_module() obtains a reference to a module.  It cannot fail.
- put_module() releases a reference to a module.  If it goes to zero, 
the exit callback is called and then module is safely freeable.
- sys_delete_module calls the deregister callback.  When this function 
returns, it is gauranteed that the reference count will not increase 
again.  It then does a put_module().

pseudo code here:

void get_module(struct module *mod)
{
	atomic_inc(&mod->uc.usecount);
}

void put_module(struct module *mod)
{
	if (atomic_dec_and_lock(&mod->uc.usecount, &unload_lock)) {
		if (mod->exit)
			mod->exit();
		free_module(mod);
		spin_unlock(&unload_lock);
	}
}

sys_delete_module()
{
	mod->deregister();
	put_module(mod);
}

