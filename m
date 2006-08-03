Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWHCQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWHCQIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWHCQIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:08:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3087 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932473AbWHCQIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:08:21 -0400
Date: Thu, 3 Aug 2006 12:08:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Problem: irq 217: nobody cared + backtrace
In-Reply-To: <9a8748490608030717x1db108f1m2cc616459bb776db@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Jesper Juhl wrote:

> Hi,
> 
> A server of mine just dumped a backtrace (below).
> The machine seems to be running fine, but it would be nice to know
> what the cause of this dump is.
> The box is running 2.6.18-rc3-git3
> Full dmesg output is attached.
> If more info than what is below is needed, then just ask and I'll
> provide it if I can.
> 
> 
> e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
> eth0.20: add 01:00:5e:00:00:01 mcast address to master interface
> IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
> irq 217: nobody cared (try booting with the "irqpoll" option)
>  [<c0103a3c>] show_trace_log_lvl+0x152/0x165
>  [<c0103a5e>] show_trace+0xf/0x13
>  [<c0103b59>] dump_stack+0x15/0x19
>  [<c013846e>] __report_bad_irq+0x24/0x7f
>  [<c0138552>] note_interrupt+0x6b/0xd5
>  [<c0137ca8>] __do_IRQ+0xf4/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c02d61b7>] uhci_irq+0x27/0x153
>  [<c02c45e8>] usb_hcd_irq+0x24/0x53
>  [<c0137b84>] handle_IRQ_event+0x26/0x56
>  [<c0137c4c>] __do_IRQ+0x98/0x100
>  [<c01050a1>] do_IRQ+0x95/0xbc
>  [<c0103502>] common_interrupt+0x1a/0x20
>  [<c0100e64>] mwait_idle+0x30/0x35
>  [<c0100d45>] cpu_idle+0x78/0x81
>  [<c04bf7fb>] start_kernel+0x173/0x19d
>  [<c0100210>] 0xc0100210
> DWARF2 unwinder stuck at 0xc0100210
> Leftover inexact backtrace:
>  =======================
> handlers:
> [<c02c45c4>] (usb_hcd_irq+0x0/0x53)
> Disabling IRQ #217

This beats me.  You didn't have any USB devices attached, did you?  There 
was nothing in the dmesg log about them.

Since no device was using IRQ 217 except for the UHCI controller, there 
seem to be only two possibilities.  Either the controller is broken and 
generating IRQs for no reason at all, or else some other device is using 
IRQ 217 when the system thinks it should be using a different line.

Has this happened more than once?  In case it happens again, here's how 
you can get more information.  Turn on CONFIG_USB_DEBUG and 
CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say 
/sys/kernel/debug).  Then after the problem occurs, save a copy of 

	/sys/kernel/debug/uhci/0000:00:1d.1

That will indicate whether the UHCI controller thinks it is sending an 
interrupt request.

Alan Stern

