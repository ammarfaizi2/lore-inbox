Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUATGVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUATGVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:21:21 -0500
Received: from ozlabs.org ([203.10.76.45]:1487 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265130AbUATGVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:21:19 -0500
Date: Tue, 20 Jan 2004 17:21:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@digeo.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Bug fix for hugepages on ppc64
Message-ID: <20040120062111.GG6455@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@digeo.com>, Anton Blanchard <anton@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Currently the flag indicating whether or not hugepages are allowed
below 4GB is not correctly propagated across fork(), which can lead to
oopses.  The patch below fixes this.

diff -urN ppc64-linux-2.5/include/asm-ppc64/mmu_context.h linux-gogogo/include/asm-ppc64/mmu_context.h
--- ppc64-linux-2.5/include/asm-ppc64/mmu_context.h	2003-12-18 09:29:18.000000000 +1100
+++ linux-gogogo/include/asm-ppc64/mmu_context.h	2004-01-19 15:36:43.518987021 +1100
@@ -81,6 +81,8 @@
 {
 	long head;
 	unsigned long flags;
+	/* This does the right thing across a fork (I hope) */
+	unsigned long low_hpages = mm->context & CONTEXT_LOW_HPAGES;
 
 	spin_lock_irqsave(&mmu_context_queue.lock, flags);
 
@@ -91,6 +93,7 @@
 
 	head = mmu_context_queue.head;
 	mm->context = mmu_context_queue.elements[head];
+	mm->context |= low_hpages;
 
 	head = (head < LAST_USER_CONTEXT-1) ? head+1 : 0;
 	mmu_context_queue.head = head;


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
