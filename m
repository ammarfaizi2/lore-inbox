Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTHKEwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbTHKEwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:52:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:16558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270971AbTHKEwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:52:00 -0400
Date: Sun, 10 Aug 2003 21:52:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Warren Togami <warren@togami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test3 compusa USB optical mouse
Message-Id: <20030810215205.1028d3de.akpm@osdl.org>
In-Reply-To: <1060565776.2888.3.camel@laptop>
References: <1060565776.2888.3.camel@laptop>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Togami <warren@togami.com> wrote:
>
> I normally use Logitech optical USB mice in Linux.  I bought a "CompUSA
> Optical USB Notebook Mouse" for $14 and the following happens in dmesg
> in kernel-2.6.0-test3.
> 
> Known bug?  Should I Bugzilla this?
> 
> hub 1-1:0: debounce: port 2: delay 100ms stable 4 status 0x301
> hub 1-1:0: new USB device on port 2, assigned address 8
> drivers/usb/core/message.c: selecting invalid configuration 0
> usb 1-1.2: failed to set device 8 default configuration (error=-22)
> hub 1-1:0: new USB device on port 2, assigned address 9
> drivers/usb/core/message.c: selecting invalid configuration 0
> usb 1-1.2: failed to set device 9 default configuration (error=-22)

You don't state whether the mouse actually works.

Assuming it doesn't, yes, please bugzilla it, or bug the folks at
linux-usb-devel@lists.sourceforge.net

> Debug: sleeping function called from invalid context at
> include/asm/uaccess.h:473
> Call Trace:
>  [<c011ab9b>] __might_sleep+0x5b/0x80
>  [<c010cc66>] save_v86_state+0x66/0x1f0
>  [<c010d737>] handle_vm86_fault+0xa7/0x8c0
>  [<c01519fb>] do_sync_write+0x8b/0xc0
>  [<c01a1e15>] inode_has_perm+0x65/0xa0
>  [<c010b820>] do_general_protection+0x0/0xa0
>  [<c010aae5>] error_code+0x2d/0x38
>  [<c010a93b>] syscall_call+0x7/0xb

This is probably due to userspace performing a system call while the CPU
has interrupts disabled.  Privileged apps can do this - the X server and
hwclock are two examples.

Longer-term we probably need to remove the irqs_disabled() test from
__might_sleep().

