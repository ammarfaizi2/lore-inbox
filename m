Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWJ1BvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWJ1BvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 21:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWJ1BvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 21:51:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751546AbWJ1BvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 21:51:14 -0400
Date: Fri, 27 Oct 2006 18:50:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
In-Reply-To: <20061028011126.GB22273@kroah.com>
Message-ID: <Pine.LNX.4.64.0610271840270.3849@g5.osdl.org>
References: <20061026191131.003f141d@localhost.localdomain>
 <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz>
 <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org>
 <20061027114237.d577c153.akpm@osdl.org> <20061027114729.49185fd2@freekitty>
 <20061027131529.980cd53e.akpm@osdl.org> <Pine.LNX.4.64.0610271323020.3849@g5.osdl.org>
 <Pine.LNX.4.64.0610271347320.3849@g5.osdl.org> <20061028011126.GB22273@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2006, Greg KH wrote:
> 
> Heh, ok, I'll take this idea, and Andrew's patch, and rework things for
> the next round of 2.6.20-rc kernels, and mark the current stuff as
> BROKEN for now.

My interface stuff is kind of designed for:

 - keep the current "init" sequence as-is for now

 - keep the _actual_ PCI probing non-parallel, so that we actually do all 
   the bus _discovery_ in a repeatable and sane order.

 - use the new "execute_in_parallel()" interface for things that actually 
   _sleep_. For example, all the PCI IDE _driver_ attachement should be 
   done synchronously, but perhaps the code that tries to see if there are 
   actual disks (ie the stuff that has timeouts etc) can use the parallel 
   execution.

 - module loading would do a "allow_parallel(1)" and 
   "wait_for_parallel(1)" thing when calling the module init function (so 
   that a module could use "execute_in_parallel()" whether compiled in or 
   not, and each "init level" at boot would also do this (with some bigger 
   number, like 10), so that for drivers etc that want to do async stuff, 
   they can do so in parallel (but they'd still have done the actual hard 
   device find/init serially - keeping the link order relevant for things 
   like IDE controller discovery)

How does this sound?

There's really no reason to parallelise the actual PCI config cycles and 
probing and stuff. It's only when some driver knows that it might have to 
do some longer-running thing that it might want to execute a thread in 
parallel with other things - but it still needs to be done in a controlled 
situation, so that when "driver_init()" stops and "filesystem_init()" 
starts, we must wait for all the driver-init parallel tasks to finish 
(since "filesystem_init()" is allowed to depend on them).

Hmm?

		Linus
