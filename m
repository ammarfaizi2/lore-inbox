Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUHTHPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUHTHPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHTHPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:15:33 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:44181 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267605AbUHTHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:15:01 -0400
Subject: Re: [PATCH] bio_uncopy_user mem leak
From: Greg Afinogenov <antisthenes@inbox.ru>
To: linux-kernel@vger.kernel.org
In-Reply-To: <41256DC9.7070500@kolivas.org>
References: <1092909598.8364.5.camel@localhost>
	 <412489E5.7000806@kolivas.org> <1092923494.12138.1667.camel@watt.suse.com>
	 <20040819195521.GC12363@tpkurt.garloff.de>  <41256DC9.7070500@kolivas.org>
Content-Type: text/plain
Message-Id: <1092986104.7882.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Aug 2004 02:15:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 22:19, Con Kolivas wrote:
> Kurt Garloff wrote:
> > Hi Chris,
> > 
> > On Thu, Aug 19, 2004 at 09:51:34AM -0400, Chris Mason wrote:
> > 
> >>On Thu, 2004-08-19 at 07:07, Con Kolivas wrote:
> >>
> >>>Ok I just tested this patch discretely and indeed the memory leak goes 
> >>>away but it still produces coasters so something is still amuck. Just as 
> >>>a data point; burning DVDs and data cds is ok. Burning audio *and 
> >>>videocds* is not.
> >>
> >>It might be the cold medicine talking, but I think we need something
> >>like this.  gcc tested it for me, beyond that I make no promises....
> >>
> >>--- l/fs/bio.c.1	2004-08-19 09:36:13.596858736 -0400
> >>+++ l/fs/bio.c	2004-08-19 09:47:46.392537784 -0400
> >>@@ -454,6 +454,7 @@
> >> 	 */
> >> 	if (!ret) {
> >> 		if (!write_to_vm) {
> >>+			unsigned long p = uaddr;
> >> 			bio->bi_rw |= (1 << BIO_RW);
> >> 			/*
> >> 	 		 * for a write, copy in data to kernel pages
> >>@@ -462,8 +463,9 @@
> >> 			bio_for_each_segment(bvec, bio, i) {
> >> 				char *addr = page_address(bvec->bv_page);
> >> 
> >>-				if (copy_from_user(addr, (char *) uaddr, bvec->bv_len))
> >>+				if (copy_from_user(addr, (char *) p, bvec->bv_len))
> >> 					goto cleanup;
> >>+				p += bvec->bv_len;
> >> 			}
> >> 		}
> >> 
> > 
> > 
> > Hmm, that patch would make a lot of sense to me.
> > 
> > It matches the problem description; burning data CDs, we don't
> > use bounce buffers, so that does not use this code path. Here,
> > it looks like we copied the same userspace page again and again
> > into a multisegment BIO. Ouch!
> > 
> > Not yet tested either :-(
> 
> Ok looks like your cold medicine is working well for you ;-). This patch 
> on top of the other patch has the memory freeing _and_ burns good cds. 
> Well done. I only tested with a video cd. Can someone confirm audio cd 
> (although it seems obvious it would help both).
> 
> Andrew did you threaten to make a 2.6.8.2 since 2.6.8{,.1} cannot safely 
> burn an audio cd?
> 
> Cheers,
> Con

Yup, it works fine with audio CDs too.  Great!



