Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWFAPgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWFAPgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWFAPgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:36:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18498 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030204AbWFAPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:36:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=uE9JEiohsTRMWxW5q5Fasq7bIM0sEOeDtAhLp1tqg5bZMGRPCY6Gaqk5nRA00aCvLUDR4Daj7uJihxVacX5nUvlfkk8ujfx4Rn54eSanuMPXmK5ShWzJTmAEOHyeEVR+8nj1KuN+eFfa65jjZvJKJyBN8bIAyOAh1P6ewtndBL0=
Message-ID: <447F0905.8020600@gmail.com>
Date: Thu, 01 Jun 2006 17:34:06 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       scjody@modernduck.com, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> 
Hello,

just another locking bug, I wonder if this wasn't discussed yet, but I can't
find it.

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {hardirq-on-W} -> {in-hardirq-R} usage.
events/0/8 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (hl_irqs_lock){--+.}, at: [<f88e4e09>] highlevel_host_reset+0x15/0x63 [ieee1394]
{hardirq-on-W} state was registered at:
  [<c013e3af>] lockdep_acquire+0x59/0x6e
  [<c03a982c>] _write_lock+0x3e/0x4c
  [<f88e5772>] hpsb_register_highlevel+0xe1/0x123 [ieee1394]
  [<f88e5fd1>] init_csr+0x2f/0x46 [ieee1394]
  [<f883a1a8>] 0xf883a1a8
  [<c0144e9a>] sys_init_module+0x151/0x1c97
  [<c03aa13b>] syscall_call+0x7/0xb
irq event stamp: 380
hardirqs last  enabled at (379): [<c03aa183>] restore_nocheck+0x12/0x15
hardirqs last disabled at (380): [<c01038df>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (0): [<c011f8c1>] copy_process+0x577/0x157e
softirqs last disabled at (0): [<00000000>] 0x0

other info that might help us debug this:
no locks held by events/0/8.

stack backtrace:
 [<c0103f56>] show_trace+0x1b/0x1d
 [<c0104694>] dump_stack+0x26/0x28
 [<c013c1f4>] print_usage_bug+0x22a/0x234
 [<c013cc24>] mark_lock+0x565/0x6b0
 [<c013d748>] __lockdep_acquire+0x3b8/0xc3b
 [<c013e3af>] lockdep_acquire+0x59/0x6e
 [<c03a94a3>] _read_lock+0x3e/0x4c
 [<f88e4e09>] highlevel_host_reset+0x15/0x63 [ieee1394]
 [<f88e27f3>] hpsb_selfid_complete+0x222/0x2fe [ieee1394]
 [<f895fe83>] ohci_irq_handler+0x705/0x9d2 [ohci1394]
 [<c014b30d>] handle_IRQ_event+0x31/0x65
 [<c014c52f>] handle_fasteoi_irq+0x6f/0xc8
 [<c0105b3a>] do_IRQ+0x61/0x87
 =======================
 [<c01038e9>] common_interrupt+0x25/0x2c
 [<f895bb65>] set_phy_reg+0x94/0x107 [ohci1394]
 [<f895c488>] ohci_devctl+0x43a/0x651 [ohci1394]
 [<f88e2034>] hpsb_reset_bus+0x34/0x38 [ieee1394]
 [<f88e43bc>] delayed_reset_bus+0xa5/0xf3 [ieee1394]
 [<c01333b7>] run_workqueue+0x7e/0xf5
 [<c0133fd5>] worker_thread+0x130/0x14b
 [<c0136f47>] kthread+0xc5/0xea
 [<c0101005>] kernel_thread_helper+0x5/0xb


-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
