Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318328AbSHEHWB>; Mon, 5 Aug 2002 03:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSHEHWB>; Mon, 5 Aug 2002 03:22:01 -0400
Received: from mail.aurema.com ([203.31.96.1]:27145 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S318328AbSHEHVz>;
	Mon, 5 Aug 2002 03:21:55 -0400
Date: Mon, 5 Aug 2002 17:25:21 +1000 (EST)
From: Kingsley Cheung <kingsley@aurema.com>
X-X-Sender: kingsley@kingsley.sw.oz.au
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug in "sys_init_module"? 
In-Reply-To: <3340.1028525729@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0208051552270.11259-100000@kingsley.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Keith Owens wrote:

> Kingsley Cheung <kingsley@aurema.com> wrote:
> >Please cc me since I'm not on the mailing list.
> >
> >Assume that one script invokes modprobe which calls "sys_init_module" 
> >first.  The big kernel lock is taken and then plenty of sanity checks 
> >done. After dependencies are checked and updated, the "init_module" 
> >function of the module is invoked. Now if this function happens to block, 
> >the kernel lock is dropped. A call to "sys_init_module" by modprobe in 
> >the other script to initialise a second module dependent on the first 
> >could then take the big kernel lock, check the dependencies and find them 
> >okay, and then have its "init_module" function invoked. And if this 
> >second module relies on the first module being properly initialised 
> >before it is loaded, this can break. 
> 
> This is a trade off between two conflicting requirements.  If a module
> fails during initialization then we want the module symbols to debug
> the module.  But those same symbols should not be considered valid when
> doing insmod.  The query_module() interface does not have the
> flexibility to distinguish between the two types of user space query.
>
> In any case the problem is bigger than module symbols.  What happens
> when a module_init breaks after registering some functions?  The
> functions are registered and can be called, but the module is stuffed.
> insmod symbols are just one instance of the wider problem - if a module
> fails during init or exit and does not recover then the kernel is in an
> unreliable state.  It is broken, you get to keep the pieces.
>

Keith,

Thanks for the quick reply. I understand the need for having the module 
symbols in early for debugging purposes.  However, I'm not sure I see what 
the invalid state of the module symbols has to do with the problem. 

Now I'm assuming you're saying the module symbols are invalid because the  
initialisation function has yet to complete.  Please correct me if I'm 
wrong.  For this reason shouldn't another concurrent call to 
"sys_init_module" wait or be prevented from invoking the "init_module" 
function of a module that is dependent on the first module until the 
first module has its initialisation complete?  For debugging purposes 
"query_module" should still be able to see the symbols and other relevant 
data of the first module but no module dependent on the first 
uninitialised module should ever be loaded. 

Anyway, at this point I'm still not certain I've completely grasped your 
reply. Maybe I didn't make my first email clear.  If this is so, then 
what I was saying is that the invocation of "init_module" functions of 
*dependent* modules needs be appropriately serialised.  Right now 
"sys_init_module" is relying on the big kernel lock to completely 
serialise these calls but if any "init_module" function blocks, the 
kernel lock is released and this serialisation can be broken.  Maybe one 
way to avoid this is to check the flags of modules depended on during 
"sys_init_module". So if the MOD_RUNNING flag is not set for the module 
we depend on, then the module currently being loaded must have its 
invocation of "sys_init_module" wait or return an appropriate error 
indicating why.

		Kingsley

