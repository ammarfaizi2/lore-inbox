Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSHEExg>; Mon, 5 Aug 2002 00:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318297AbSHEExg>; Mon, 5 Aug 2002 00:53:36 -0400
Received: from smtp.sw.oz.au ([203.31.96.1]:8968 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S318295AbSHEExf>;
	Mon, 5 Aug 2002 00:53:35 -0400
Date: Mon, 5 Aug 2002 14:57:07 +1000 (EST)
From: Kingsley Cheung <kingsley@aurema.com>
X-X-Sender: kingsley@kingsley.sw.oz.au
To: linux-kernel@vger.kernel.org
Subject: Possible Bug in "sys_init_module"?
Message-ID: <Pine.LNX.4.44.0208051241290.11259-100000@kingsley.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Please cc me since I'm not on the mailing list.

While debugging several proprietary modules at work with a dual SMP x86 
box running a 2.4.18 kernel, I noticed that when attempting to 
concurrently execute two scripts that loaded and unloaded a stack of 
modules, the box kept on crashing.  In my search for the problem I noticed 
that the function "sys_init_module" in kernel/module.c may have a 
possible bug.

Assume that one script invokes modprobe which calls "sys_init_module" 
first.  The big kernel lock is taken and then plenty of sanity checks 
done. After dependencies are checked and updated, the "init_module" 
function of the module is invoked. Now if this function happens to block, 
the kernel lock is dropped. A call to "sys_init_module" by modprobe in 
the other script to initialise a second module dependent on the first 
could then take the big kernel lock, check the dependencies and find them 
okay, and then have its "init_module" function invoked. And if this 
second module relies on the first module being properly initialised 
before it is loaded, this can break. 

Is this an issue that requires attention? Or am I overlooking something  
in the code? 

Thanks,
Kingsley



