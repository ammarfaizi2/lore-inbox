Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUFBQH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUFBQH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFBQH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:07:56 -0400
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:51906 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S263457AbUFBQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:05:30 -0400
Subject: Why does local_bh_enable warn of disabled IRQ's with the Tulip
	Driver.
From: Alex Bennee <kernel-hacker@bennee.com>
To: "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>,
       "Linux-SH (m17n)" <linux-sh@m17n.org>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1086192323.7714.25.camel@cambridge.braddahead.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 02 Jun 2004 17:05:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well I seemed to of merged the ST40 PCI stuff with better success that
my last attempt at a forward port. However I'm confused by the failure
to start up the ethernet properly. As you see with the trace I get a
warning about the failure to enable irqs:

...
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
eth0: tulip_up(), irq==4.
eth0: Done tulip_up(), CSR0 fff94800, CSR5 fc675414 CSR6 ff972117.
Badness in local_bh_enable at kernel/softirq.c:136
 
Call trace:
[<880185f4>] local_bh_enable+0x74/0xa0
[<8810bcec>] dev_open+0xac/0x160
[<8810d6e8>] dev_change_flags+0x48/0x140
[<88111720>] dev_mc_upload+0x0/0x40
[<8802ad20>] __print_symbol+0x0/0x140
[<88014600>] printk+0x0/0x1e0
[<88014600>] printk+0x0/0x1e0
[<88002102>] init+0x22/0x140
[<88173378>] __func__.4+0x1f4/0x16748
[<88004264>] kernel_thread_helper+0x4/0x20

What I can't figure out is what:

#define __local_bh_enable() \
		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)

Is aiming to do. Seeing as I haven't enabled PREEMPT yet it seems
pointless messing with the preempt count. Why is it considered bad to
have irqs enabled when enabling the bh handler? Is it just the tulip
driver isn't following the correct 2.6 IRQ semantics?

-- 
Alex, Kernel Hacker: http://www.bennee.com/~alex/

Mommy, what happens to your files when you die?

