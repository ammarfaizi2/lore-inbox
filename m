Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVHXV3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVHXV3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHXV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:29:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47798 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932262AbVHXV3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:29:16 -0400
Subject: Re: question on memory barrier
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050824124348.44686.qmail@web25807.mail.ukl.yahoo.com>
References: <20050824124348.44686.qmail@web25807.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Aug 2005 22:57:46 +0100
Message-Id: <1124920666.13833.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-24 at 14:43 +0200, moreau francis wrote:
> I'm currently trying to write a USB driver for Linux. The device must be
> configured by writing some values into the same register but I want to be
> sure that the writing order is respected by either the compiler and the cpu.

The Linux kernel defines writel() in such a way that for each platform a
series of writel() calls are ordered with respect to the processor. In
other words if on one processor you issue 

	writel(0, foo);
	writel(1, foo);
	writel(2, foo);

the hardware will see 0, 1, 2. writel does not guarantee that the write
occurs immediately so while you know the writes are ordered you don't
know the write has "arrived" at the device when the writel() call
returns. That isn't usually a problem except when delays are required.
Then you need to avoid PCI posting and do

	writel(0, foo);
	readl(foo);
	udelay(50);
	writel(1, foo);

The only other complication is multiprocessor systems - if you have
multiple places that may issue these I/O's you may need a lock to
protect them from both processors configuring at the same time, and in
theory an mmiowb() call to ensure the first processor has finished its
I/O before the second starts - ie

	spin_lock(&conf_lock);
	writel(0, foo);
	writel(1, foo);
	mmiowb();
	spin_unlock(&conf_lock);


The "wmb/rmb" are barriers to memory not to device I/O. The locking
functions (spin_unlock etc) are implicit memory barriers, but atomic
operations are not.

Generally speaking if you use writel the right semantics just happen,
and that is why the writel definition is the way it is.

