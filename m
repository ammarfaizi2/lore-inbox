Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbUBZPGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUBZPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:06:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:27289 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261859AbUBZPGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:06:08 -0500
Subject: [PATCH] fix small highmem bio bounce bvec handling glitch
From: Christophe Saout <christophe@saout.de>
Reply-To: Christophe Saout <christophe@saout.de>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077807966.10397.2.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 16:06:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Oops, forgot to Cc LKML]

while going through the bio highmem handling code I noticed a small
glitch. __end_that_request_first might modify the bv_offset and bv_len
if the segment was partially completed. The bio-read-bounce-back code
should use the unmodified bv_offset when copying the segment data:

--- linux.orig/mm/highmem.c	2004-01-21 19:08:45.000000000 +0100
+++ linux/mm/highmem.c	2004-02-26 15:47:14.574722576 +0100
@@ -294,7 +294,12 @@
 		if (tovec->bv_page == fromvec->bv_page)
 			continue;
 
-		vfrom = page_address(fromvec->bv_page) + fromvec->bv_offset;
+		/*
+		 * fromvec->bv_offset and fromvec->bv_len might have been
+		 * modified by the block layer, so use the original copy,
+		 * bounce_copy_vec already uses tovec->bv_len
+		 */
+		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
 
 		bounce_copy_vec(tovec, vfrom);
 	}

