Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUI2Rgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUI2Rgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUI2Rgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:36:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30682 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268706AbUI2RgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:36:19 -0400
Date: Wed, 29 Sep 2004 19:33:43 +0200
From: Jens Axboe <axboe@suse.de>
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 1 New compile/sparse warning (overnight build)
Message-ID: <20040929173343.GF2322@suse.de>
References: <1096478522.20465.11.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096478522.20465.11.camel@cherrybomb.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29 2004, John Cherry wrote:
> This sparse warning was introduced with patch 1.2000 (axboe).
> In fs/bio.c (line 509),
> 
> 	if (copy_from_user(addr, (char *) p, bvec->bv_len))
> 
> should probably be
> 
> 	if (copy_from_user(addr, (char __user *) p, bvec->bv_len))

It's not a new warning, just look at your own generated output:

> New warnings:
> -------------
> fs/bio.c:509:30: warning: incorrect type in argument 2 (different
> address spaces)
> fs/bio.c:509:30:    expected void const [noderef] *from<asn:1>
> fs/bio.c:509:30:    got char *<noident>
> 
> 
> Fixed warnings:
> ---------------
> fs/bio.c:462:31: warning: incorrect type in argument 2 (different
> address spaces)
> fs/bio.c:462:31:    expected void const [noderef] *from<asn:1>
> fs/bio.c:462:31:    got char *<noident>

The warning simply moved. This should fix it, though.

Signed-off-by: Jens Axboe <axboe@suse.de>

===== fs/bio.c 1.67 vs edited =====
--- 1.67/fs/bio.c	2004-09-28 17:59:14 +02:00
+++ edited/fs/bio.c	2004-09-29 19:34:39 +02:00
@@ -497,7 +497,7 @@
 	 * success
 	 */
 	if (!write_to_vm) {
-		unsigned long p = uaddr;
+		char __user *p = (char __user *) uaddr;
 
 		/*
 		 * for a write, copy in data to kernel pages
@@ -506,7 +506,7 @@
 		bio_for_each_segment(bvec, bio, i) {
 			char *addr = page_address(bvec->bv_page);
 
-			if (copy_from_user(addr, (char *) p, bvec->bv_len))
+			if (copy_from_user(addr, p, bvec->bv_len))
 				goto cleanup;
 			p += bvec->bv_len;
 		}

-- 
Jens Axboe

