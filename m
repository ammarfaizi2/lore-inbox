Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWC2Ani@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWC2Ani (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWC2Ani
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:43:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:43168 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750713AbWC2Anh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:43:37 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="16337270:sNHT6146217476"
Message-Id: <200603290027.k2T0R7g32314@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Tue, 28 Mar 2006 16:27:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZSxMfxr6gMEsIsQ8OR0DYRRxpRBwAAOw6w
In-Reply-To: <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Tuesday, March 28, 2006 3:48 PM
> Could we simply define these smb_mb__*_clear_bit to be noops
> and then make the atomic bit ops to have full barriers? That would satisfy 
> Nick's objections.

Oh, it also penalize all other 1,055 call site of clear_bit(), though I don't
know how many actually needs memory barrier.  I suspect some need "lock"
barrier, some need "unlock" barrier, and of course some needs full fence.

Why not make unlock_buffer use test_and_clear_bit()?  Utilizing it's implied
full memory fence and throw away the return value?  OK, OK, this is obscured.
Then introduce clear_bit_memory_fence API or some sort.

- Ken


diff -Nurp linux-2.6.16/fs/buffer.c linux-2.6.16.ken/fs/buffer.c
--- linux-2.6.16/fs/buffer.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16.ken/fs/buffer.c	2006-03-28 17:20:02.000000000 -0800
@@ -78,8 +78,7 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
-	clear_buffer_locked(bh);
-	smp_mb__after_clear_bit();
+	test_clear_buffer_locked(bh);
 	wake_up_bit(&bh->b_state, BH_Lock);
 }
 
