Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSHEFcl>; Mon, 5 Aug 2002 01:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318297AbSHEFcl>; Mon, 5 Aug 2002 01:32:41 -0400
Received: from zok.SGI.COM ([204.94.215.101]:18849 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318225AbSHEFcN>;
	Mon, 5 Aug 2002 01:32:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kingsley Cheung <kingsley@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug in "sys_init_module"? 
In-reply-to: Your message of "Mon, 05 Aug 2002 14:57:07 +1000."
             <Pine.LNX.4.44.0208051241290.11259-100000@kingsley.sw.oz.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 15:35:29 +1000
Message-ID: <3340.1028525729@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002 14:57:07 +1000 (EST), 
Kingsley Cheung <kingsley@aurema.com> wrote:
>Please cc me since I'm not on the mailing list.
>
>Assume that one script invokes modprobe which calls "sys_init_module" 
>first.  The big kernel lock is taken and then plenty of sanity checks 
>done. After dependencies are checked and updated, the "init_module" 
>function of the module is invoked. Now if this function happens to block, 
>the kernel lock is dropped. A call to "sys_init_module" by modprobe in 
>the other script to initialise a second module dependent on the first 
>could then take the big kernel lock, check the dependencies and find them 
>okay, and then have its "init_module" function invoked. And if this 
>second module relies on the first module being properly initialised 
>before it is loaded, this can break. 

This is a trade off between two conflicting requirements.  If a module
fails during initialization then we want the module symbols to debug
the module.  But those same symbols should not be considered valid when
doing insmod.  The query_module() interface does not have the
flexibility to distinguish between the two types of user space query.

In any case the problem is bigger than module symbols.  What happens
when a module_init breaks after registering some functions?  The
functions are registered and can be called, but the module is stuffed.
insmod symbols are just one instance of the wider problem - if a module
fails during init or exit and does not recover then the kernel is in an
unreliable state.  It is broken, you get to keep the pieces.

On my todo list for modutils 2.5 is to invoke init_module() from a
separate task.  That task will be killed by the kernel oops (there is
no way for userspace to recover from oops) but the parent insmod will
detect the failure and say

  init_module() for foo failed.  The kernel is in an unreliable state.

