Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJPR1F>; Wed, 16 Oct 2002 13:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJPR1F>; Wed, 16 Oct 2002 13:27:05 -0400
Received: from mailc.telia.com ([194.22.190.4]:43750 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S261258AbSJPR1D>;
	Wed, 16 Oct 2002 13:27:03 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Johannes Erdfelt <johannes@erdfelt.com>
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
References: <Pine.LNX.4.44.0210082025570.16233-100000@p4.localdomain>
	<3DA34204.1030708@pacbell.net>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Oct 2002 19:32:45 +0200
In-Reply-To: <3DA34204.1030708@pacbell.net>
Message-ID: <m2n0peuw5e.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> >>>>How does 2.5.41 work for you?
> >>>
> >>>It seems to be fixed. Thanks.
> >>
> >>Heh, that's pretty funny.  There were not any uhci specific fixes in
> >>2.5.41...
> >>
> >>Not complaining,
> > Actually, there were. This patch is in 2.5.41.
> 
> And wouldn't have changed any oopsing behavior, I assure you.
> 
> Your panic was being caused by something else.  I saw plenty
> of strange 2.5.40 behavior indicative of someone walking over
> memory they didn't own, and maybe your panic was another case.

The problem is back in 2.5.43, although it doesn't happen on every
boot. I think I first saw this problem in 2.5.35.

The oops looks the same as usual. The oops happens because urb->hcpriv
is NULL in uhci_result_control() so the list_empty() check oopses.

At the end of uhci_urb_enqueue() this code

	if (ret != -EINPROGRESS) {
		uhci_destroy_urb_priv (uhci, urb);
		return ret;
	}

appears to be calling uhci_destroy_urb_priv() without having acquired
the urb_list_lock. Can this be the cause of my problem?


Unable to handle kernel NULL pointer dereference at virtual address 00000014
*pde = 00000000
Oops: 0000
usb-storage uhci-hcd usbcore  
CPU:    0
EIP:    0060:[<c482e4d7>]    Not tainted
EFLAGS: 00010006
EIP is at uhci_result_control+0x17/0x210 [uhci-hcd]
eax: 00000000   ebx: c3b2a420   ecx: 00010002   edx: ffffffea
esi: 00000014   edi: 00010002   ebp: c3b2a420   esp: c3b81db8
ds: 0068   es: 0068   ss: 0068
Process usb.agent (pid: 203, threadinfo=c3b80000 task=c3e760a0)
Stack: c3c7d15c 00000082 00000000 c3b2a420 00000000 00010002 c1145600 c482f357 
       c1145600 c3b2a420 00000202 c1145740 c1145740 c1145600 c1145600 c482fd51 
       c1145600 c3b2a420 c1145600 00000003 0000000a c3b81e68 c4818de7 c1145600 
Call Trace:
 [<c482f357>] uhci_transfer_result+0x67/0x1a0 [uhci-hcd]
 [<c482fd51>] uhci_irq+0xf1/0x130 [uhci-hcd]
 [<c4818de7>] usb_hcd_irq+0x17/0x30 [usbcore]
 [<c010881d>] handle_IRQ_event+0x2d/0x50
 [<c01089fd>] do_IRQ+0xad/0x140
 [<c0107478>] common_interrupt+0x18/0x20
 [<c0127182>] do_wp_page+0x1c2/0x3d0
 [<c0111c49>] __wake_up+0x39/0x40
 [<c0127eaf>] handle_mm_fault+0xdf/0x150
 [<c0150c4c>] dput+0x1c/0x1a0
 [<c01102fd>] do_page_fault+0x14d/0x4cf
 [<c011d1fb>] update_wall_time+0xb/0x40
 [<c011fb55>] do_sigaction+0xd5/0x110
 [<c011ff29>] sys_rt_sigaction+0x99/0xf0
 [<c013c793>] filp_close+0xa3/0xb0
 [<c011f2b4>] sys_rt_sigprocmask+0x144/0x200
 [<c01101b0>] do_page_fault+0x0/0x4cf
 [<c01074bd>] error_code+0x2d/0x40

Code: 8b 40 14 39 f0 75 0a b8 ea ff ff ff e9 d4 01 00 00 8b 54 24 
 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
