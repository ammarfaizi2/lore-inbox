Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTLZWfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLZWfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:35:20 -0500
Received: from rth.ninka.net ([216.101.162.244]:20352 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264454AbTLZWfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:35:15 -0500
Date: Fri, 26 Dec 2003 14:34:54 -0800
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: (irda) Badness in local_bh_enable at kernel/softirq.c:121
Message-Id: <20031226143454.4b871d15.davem@redhat.com>
In-Reply-To: <20031226130031.A14007@flint.arm.linux.org.uk>
References: <20031226130031.A14007@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003 13:00:31 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> I've just been testing w83977af_ir with ircomm on a NetWinder (ARM) and
> a Nokia mobile phone, and, while closing down the connection by exiting
> minicom, I saw this which looks particularly evil.  I'm not sure exactly
> when this occurred because I was running minicom over ssh.

This is akin to the PPP issues, and all of this basically is telling
that the TTY driver's locking conflicts with networking quite badly.

In this case:

> Badness in local_bh_enable at kernel/softirq.c:121
> [<c00429c4>] (local_bh_enable+0x0/0x84) from [<c014d1b4>] (dev_queue_xmit+0x108/0x20c)
> [<c014d0ac>] (dev_queue_xmit+0x0/0x20c) from [<bf00ee68>] (irlap_send_data_primary_poll+0xdc/0x1c4 [irda])

local_bh_enable() with hardware interrupts disabled, which is
racy and illegal.  Who disabled CPU interrupts?  Let's see:

> [<bf03b4b0>] (ircomm_tty_shutdown+0x0/0x178 [ircomm_tty]) from [<bf03a9c0>] (ircomm_tty_close+0x15c/0x240 [ircomm_tty])

And this is where the spin_lock_irqsave() occurs, that leads
to all of the trouble.
