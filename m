Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUJOVO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUJOVO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268440AbUJOVO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:14:28 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:50521 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268439AbUJOVOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:14:24 -0400
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
	: oops...]
From: Paul Fulghum <paulkf@microgate.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1097872927.5119.5.camel@krustophenia.net>
References: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org>
	 <1097861761.2820.18.camel@deimos.microgate.com>
	 <1097872927.5119.5.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1097874840.2915.18.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 16:14:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 15:42, Lee Revell wrote:
> > Either way, the generic IRQ code should deal with
> > duplicates without generating an oops.
> 
> Agreed, this bug should be fixed either way.


I just finished some more testing,
and the problem is just as I described.

I was able to reproduce the problem using the
synclink driver by modifying it to use a constant
string for request_irq() devname on multiple
devices sharing the same irq number.

Bug trigger summary:
* multiple devices sharing same irq number
* devices have same devname (as passed to request_irq())
* devices are removed in same order as added

I added some printk statements as shown below:

Oct 15 15:41:22 deimos kernel: SyncLink serial driver $Revision: 4.32 $
...
Oct 15 15:41:22 deimos kernel: register_handler_proc:action=e27ad7e0 action->dir=e95b2800 name=synclink irq=9
Oct 15 15:41:22 deimos kernel: SyncLink PCI v1 ttySL0: IO=ECE8 IRQ=9 Mem=FBF80000,FEBFF000 MaxFrameSize=4096
...
Oct 15 15:41:22 deimos kernel: register_handler_proc:action=e27ad6a0 action->dir=e8b35e60 name=synclink irq=9
Oct 15 15:41:22 deimos kernel: SyncLink PCI v1 ttySL1: IO=ECF0 IRQ=9 Mem=FBF40000,FEBFF000 MaxFrameSize=4096
...
Oct 15 15:41:30 deimos kernel: Unloading SyncLink serial driver: $Revision: 4.32 $
...
Oct 15 15:41:30 deimos kernel: unregister_handler_proc:action=e27ad7e0 action->dir=e95b2800 irq=9
Oct 15 15:41:30 deimos kernel: remove_proc_entry:de=e8b35e60 name=synclink
Oct 15 15:41:30 deimos kernel: unregister_handler_proc:action=e27ad6a0 action->dir=e8b35e60 irq=9
Oct 15 15:41:30 deimos kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oct 15 15:41:30 deimos kernel:  printing eip:
Oct 15 15:41:30 deimos kernel: c0186535
Oct 15 15:41:30 deimos kernel: *pde = 00000000
Oct 15 15:41:30 deimos kernel: Oops: 0000 [#1]
Oct 15 15:41:30 deimos kernel: PREEMPT 
Oct 15 15:41:30 deimos kernel: Modules linked in: synclink n_hdlc e100 aic7xxx
Oct 15 15:41:30 deimos kernel: CPU:    0
Oct 15 15:41:30 deimos kernel: EIP:    0060:[<c0186535>]    Not tainted VLI
Oct 15 15:41:30 deimos kernel: EFLAGS: 00210246   (2.6.9-rc4-mm1) 
Oct 15 15:41:30 deimos kernel: EIP is at remove_proc_entry+0x25/0x170
Oct 15 15:41:30 deimos kernel: eax: 00000000   ebx: e27ad6a0   ecx: ffffffff   edx: ebfe8e00
Oct 15 15:41:30 deimos kernel: esi: e1700000   edi: 00000000   ebp: c0470b20   esp: e17c3ee8
Oct 15 15:41:30 deimos kernel: ds: 007b   es: 007b   ss: 0068
Oct 15 15:41:30 deimos kernel: Process rmmod (pid: 3385, threadinfo=e17c2000 task=e6f700c0)
Oct 15 15:41:31 deimos kernel: Stack: e17c3ef4 c01323be c03998e0 e27ad6a0 00000000 e27ad6a0 e1700000 00000009 
Oct 15 15:41:31 deimos kernel:        c0131f86 00000000 ebfe8e00 e17c2000 00200212 e1700000 ec92ca60 c03eb1c0 
Oct 15 15:41:31 deimos kernel:        00000000 ec9232a2 00000009 e1700000 ec9283c7 ea8e19b0 e1700000 ec923940 
Oct 15 15:41:31 deimos kernel: Call Trace:
Oct 15 15:41:31 deimos kernel:  [<c01323be>] unregister_handler_proc+0x3e/0x70
Oct 15 15:41:31 deimos kernel:  [<c0131f86>] free_irq+0xb6/0x130
Oct 15 15:41:31 deimos kernel:  [<ec9232a2>] mgsl_release_resources+0x1c2/0x200 [synclink]
Oct 15 15:41:31 deimos kernel:  [<ec9283c7>] hdlcdev_exit+0x27/0x40 [synclink]
Oct 15 15:41:31 deimos kernel:  [<ec923940>] synclink_cleanup+0x50/0xe0 [synclink]

A cleaned up version:
---------------------
register_handler_proc:action=e27ad7e0 action->dir=e95b2800 name=synclink irq=9
register_handler_proc:action=e27ad6a0 action->dir=e8b35e60 name=synclink irq=9
unregister_handler_proc:action=e27ad7e0 action->dir=e95b2800 irq=9
remove_proc_entry:de=e8b35e60 name=synclink
unregister_handler_proc:action=e27ad6a0 action->dir=e8b35e60 irq=9
*Earth Shattering Kaboom*

You can see that:
1. proc entry e95b2800 is allocated for IRQ action e27ad7e0
2. proc entry e8b35e60 is allocated for IRQ action e27ad6a0
3. proc entry e8b35e60 is freed when IRQ action e27ad7e0 is freed (Wrong!)
4. when IRQ action e27ad6a0 is freed the kernel touches e8b35e60 (already gone!)

After allocation synclink shows up twice in /proc/irq/9
I'm unsure of the best way to correct this.
Disallow duplicate entries? Refine the proc entry search
on removal to use more than just the name to match?
I bet Ingo knows best :-)

-- 
Paul Fulghum
paulkf@microgate.com

