Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSGDBQZ>; Wed, 3 Jul 2002 21:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGDBQY>; Wed, 3 Jul 2002 21:16:24 -0400
Received: from rj.SGI.COM ([192.82.208.96]:39606 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317307AbSGDBQX>;
	Wed, 3 Jul 2002 21:16:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Wed, 03 Jul 2002 05:48:09 +0200."
             <20020703034809.GI474@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 11:18:48 +1000
Message-ID: <10962.1025745528@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 05:48:09 +0200, 
Pavel Machek <pavel@ucw.cz> wrote:
>Okay. So we want modules and want them unload. And we want it bugfree.
>
>So... then its okay if module unload is *slow*, right?
>
>I believe you can just freeze_processes(), unload module [now its
>safe, you *know* noone is using that module, because all processes are
>in your refrigerator], thaw_processes().

The devil is in the details.

You must not freeze the process doing rmmod, that way lies deadlock.

Modules can run their own kernel threads.  When the module shuts down
it terminates the threads but we must wait until the process entries
for the threads have been reaped.  If you are not careful, the zombie
clean up code can refer to the module that no longer exists.  You must
not freeze any threads that belong to the module.

You must not freeze any process that has entered the module but not yet
incremented the use count, nor any process that has decremented the use
count but not yet left the module.  Simply looking at the EIP after
freeze is not enough.  Module code with a use count of 0 is allowed to
call any function as long as that function does not sleep.  That rule
used to be safe, but adding preempt has turned that safe rule into a
race, freezing processes has the same effect as preempt.

Using freeze or any other quiesce style operation requires that the
module clean up be split into two parts.  The logic must be :-

Check usecount == 0

Call module unregister routine.  Unlike the existing clean up code,
this only removes externally visible interfaces, it does not delete
module structures.

<handwaving>
  Outside the module, do whatever it takes to ensure that nothing is
  executing any module code, including threads, command callbacks etc.
</handwaving>

Check the usecount again.

If usecount is non-zero then some other code entered the module after
checking the usecount the first time and before unregister completed.
Either mark the module for delayed delete or reactivate the module by
calling the module's register routine.

If usecount is still 0 after the handwaving, then it is safe to call
the final module clean up routine to destroy its structures, release
hardware etc.  Then (and only then) is it safe to free the module.


Rusty and I agree that if (and it's a big if) we want to support module
unloading safely then this is the only sane way to do it.  It requires
some moderately complex handwaving code, changes to every module (split
init and cleanup in two) and a new version of modutils in order to do
this method.  Because of the high cost, Rusty is exploring other
options before diving into a kernel wide change.

