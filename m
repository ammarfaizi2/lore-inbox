Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTDOWyr (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTDOWyr 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:54:47 -0400
Received: from [12.47.58.203] ([12.47.58.203]:9642 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264145AbTDOWyd convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 18:54:33 -0400
Date: Tue, 15 Apr 2003 16:05:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030415160530.2520c61c.akpm@digeo.com>
In-Reply-To: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 15 Apr 2003 23:06:20.0674 (UTC) FILETIME=[A0ACD620:01C303A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
>
> 
> http://www.philou.org/2.5.67-mm3/2.5.67-mm3.log

This is a great bug report.  Thanks.

The 1394 warnings are known about and I think Ben is working on it.

The NMI watchdog hit is nasty:

NMI Watchdog detected LOCKUP on CPU0, eip c011eb82, registers:
CPU:    0
EIP:    0060:[<c011eb82>]    Tainted: GF  VLI
EFLAGS: 00200086
EIP is at .text.lock.sched+0x10c/0x12a
eax: d79c8000   ebx: d8c578fc   ecx: 00000000   edx: d8c57800
esi: c03a9d20   edi: d774a0c0   ebp: d79c9d94   esp: d79c9d88
ds: 007b   es: 007b   ss: 0068
Process gkrellm (pid: 458, threadinfo=d79c8000 task=dd7152a0)
Stack: d8c578fc d7eaa400 d774a0c0 d79c9da4 c0235e80 c03a9d20 d77491a0 d79c9db0 
       c0265b88 d8c578fc d79c9dbc e0a9d76c d8c578d0 d79c9de0 e0aa1c61 d8c57800 
       e0a97b62 d7d2f894 00200286 00000008 00000004 e0ab38bc d79c9e08 e0aa25f5 
Call Trace:
 [<c0235e80>] kobject_get+0x70/0x80
 [<c0265b88>] get_device+0x18/0x30
 [<e0a9d76c>] usb_get_dev+0x1c/0x30 [usbcore]
 [<e0aa1c61>] hcd_submit_urb+0x71/0x180 [usbcore]
 [<e0a97b62>] hidinput_report_event+0x32/0x50 [hid]
 [<e0ab38bc>] usb_hcd_operations+0x0/0x24 [usbcore]
 [<e0aa25f5>] usb_submit_urb+0x1d5/0x250 [usbcore]
 [<e0a95274>] hid_irq_in+0x34/0xb0 [hid]
 [<e0aa2104>] usb_hcd_giveback_urb+0x24/0x40 [usbcore]
 [<e0a8f23f>] uhci_finish_completion+0x8f/0xf0 [uhci_hcd]
 [<e0aa214c>] usb_hcd_irq+0x2c/0x60 [usbcore]
 [<c010d7f8>] handle_IRQ_event+0x38/0x60
 [<c010da74>] do_IRQ+0xc4/0x190
 [<c010be0c>] common_interrupt+0x18/0x20
 [<c016007b>] unregister_chrdev_region+0x2b/0x100
 [<c0235e2e>] kobject_get+0x1e/0x80
 [<c018b2a0>] check_perm+0x20/0x120
 [<c0157aa7>] get_empty_filp+0x77/0x100
 [<c0155f5f>] dentry_open+0x21f/0x250
 [<c0155d36>] filp_open+0x66/0x70
 [<c0164423>] getname+0x93/0xd0
 [<c01562c5>] sys_open+0x55/0x90
 [<c010b49f>] syscall_call+0x7/0xb

What has happened here is that you were in the middle of a kobject_get(),
holding spin_lock(&kobj_lock) when an interrupt came in.  The USB interrupt
handler comes in and ends up calling kobject_get() again.  This CPU already
holds the lock and blamyouredead.

Turning kobj_lock into an IRQ-safe lock would appear to be a sufficient fix.

