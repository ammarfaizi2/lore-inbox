Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUEMXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUEMXor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUEMXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:44:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:4246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263962AbUEMXoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:44:46 -0400
Date: Thu, 13 May 2004 16:46:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: jgarzik@pobox.com, Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040513164605.0cd9868e.akpm@osdl.org>
In-Reply-To: <20040513164226.7efb2a83.akpm@osdl.org>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
	<20040513164226.7efb2a83.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> hm, I'm trying to decrypt how the driver accesses the hardware.  It's
> taking copies of kernel virtual addresses based off hpet_virt_address, but
> there are no readl's or writel's in there.  Is the actual device access
> done over in time_hpet.c?
> 

Oh.  That's why the volatiles are there.

+static int
+hpet_release (struct inode *inode, struct file *file)
+{
+	struct hpet_dev	*devp;
+	volatile struct hpet_timer *timer;
+
+	devp = file->private_data;
+	timer = devp->hd_timer;
+
+	spin_lock_irq(&hpet_lock);
+
+	timer->hpet_config &= ~Tn_INT_ENB_CNF_MASK;

local variable `timer' points at hardware.

Methinks this all should be converted to readl and friends, no?
