Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUHSNua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUHSNua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHSNua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:50:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:2749 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266163AbUHSNu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:50:27 -0400
Subject: Re: [PATCH] bio_uncopy_user mem leak
From: Chris Mason <mason@suse.com>
To: Con Kolivas <kernel@kolivas.org>, axboe@suse.de
Cc: Greg Afinogenov <antisthenes@inbox.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, garloff@suse.de
In-Reply-To: <412489E5.7000806@kolivas.org>
References: <1092909598.8364.5.camel@localhost>
	 <412489E5.7000806@kolivas.org>
Content-Type: text/plain
Message-Id: <1092923494.12138.1667.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 09:51:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 07:07, Con Kolivas wrote:
> Greg Afinogenov wrote:
> > I'd just like to point out that this patch does not, as may be expected,
> > result in functional audio CDs.  It merely results in a successful burn
> > process and a CD full of noise.
> > 
> > Perhaps this should be tested/fixed?
> 
> Ok I just tested this patch discretely and indeed the memory leak goes 
> away but it still produces coasters so something is still amuck. Just as 
> a data point; burning DVDs and data cds is ok. Burning audio *and 
> videocds* is not.

It might be the cold medicine talking, but I think we need something
like this.  gcc tested it for me, beyond that I make no promises....

--- l/fs/bio.c.1	2004-08-19 09:36:13.596858736 -0400
+++ l/fs/bio.c	2004-08-19 09:47:46.392537784 -0400
@@ -454,6 +454,7 @@
 	 */
 	if (!ret) {
 		if (!write_to_vm) {
+			unsigned long p = uaddr;
 			bio->bi_rw |= (1 << BIO_RW);
 			/*
 	 		 * for a write, copy in data to kernel pages
@@ -462,8 +463,9 @@
 			bio_for_each_segment(bvec, bio, i) {
 				char *addr = page_address(bvec->bv_page);
 
-				if (copy_from_user(addr, (char *) uaddr, bvec->bv_len))
+				if (copy_from_user(addr, (char *) p, bvec->bv_len))
 					goto cleanup;
+				p += bvec->bv_len;
 			}
 		}
 





