Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKILMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTKILMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:12:24 -0500
Received: from mel1.uecomm.net.au ([203.94.129.130]:39565 "EHLO
	mel1.unite.net.au") by vger.kernel.org with ESMTP id S262373AbTKILMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:12:23 -0500
Subject: Re: kernel 2.6 : cdc_acm problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031109122039.47e78a91.colin@colino.net>
References: <20031109122039.47e78a91.colin@colino.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068376305.6807.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 22:11:46 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-09 at 22:20, Colin Leroy wrote:
> Hi,
> 
> just to report a problem with kernel 2.6.0-tes9-benh.. Using my GPRS phone
> to access internet spits out lots (real lots) of these to syslog:
> 
> Nov  8 23:36:21 chloe kernel: Call trace:
> Nov  8 23:36:21 chloe kernel:  [c000b604] dump_stack+0x18/0x28
> Nov  8 23:36:21 chloe kernel:  [c000885c] check_bug_trap+0x84/0x98
> Nov  8 23:36:21 chloe kernel:  [c0008940] ProgramCheckException+0xd0/0x170
> Nov  8 23:36:21 chloe kernel:  [c0007ee0] ret_from_except_full+0x0/0x4c
> Nov  8 23:36:21 chloe kernel:  [c0021250] local_bh_enable+0x28/0x60
> Nov  8 23:36:21 chloe kernel:  [c0109c68] ppp_input+0x204/0x21c
> Nov  8 23:36:21 chloe kernel:  [c010e99c] ppp_async_input+0x50c/0x618
> Nov  8 23:36:21 chloe kernel:  [c010d890] ppp_asynctty_receive+0x50/0xac
> Nov  8 23:36:21 chloe kernel:  [c00d5c7c] flush_to_ldisc+0xa0/0xb0
> Nov  8 23:36:21 chloe kernel:  [c00d5d34] tty_flip_buffer_push+0x1c/0x3c
> Nov  8 23:36:21 chloe kernel:  [d98fb250] acm_read_bulk+0xdc/0x138
> [cdc_acm]
> Nov  8 23:36:21 chloe kernel:  [c017e298] usb_hcd_giveback_urb+0x90/0xac
> Nov  8 23:36:21 chloe kernel:  [c0187ac8] finish_urb+0xd8/0xec
> Nov  8 23:36:21 chloe kernel:  [c0188f28] dl_done_list+0x7c/0x128
> Nov  8 23:36:21 chloe kernel:  [c0189a48] ohci_irq+0xec/0x1b4
> Nov  8 23:36:21 chloe kernel: Badness in local_bh_enable at
> kernel/softirq.c:121
> 
> This makes the computer very irresponsive and the log-storm emptied the
> battery in about 20 minutes :-)

Looks like a bug calling local_bh_enable with irq off, though it isn't
clear who is disabling them at this point. I don't have time to track
it down more precisely right now, it could be either OHCI finishing the
urbs within a spinlock_irqsave or some TTY or PPP issue, the ACM driver
doesn't seem to play with irq masking by itself.

Ben.
