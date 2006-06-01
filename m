Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWFAFT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWFAFT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWFAFT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:19:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751640AbWFAFTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:19:55 -0400
Date: Wed, 31 May 2006 22:24:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: James.Bottomley@SteelEye.com, torvalds@osdl.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.17-rc5
Message-Id: <20060531222410.08dd6728.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0606010757400.4387@kai.makisara.local>
References: <1149092818.22134.45.camel@mulgrave.il.steeleye.com>
	<Pine.LNX.4.63.0606010757400.4387@kai.makisara.local>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 08:05:49 +0300 (EEST)
Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:

> On Wed, 31 May 2006, James Bottomley wrote:
> 
> > This is my current slew of small bug fixes which either fix serious
> > bugs, or are completely safe for this -rc5 stage of the kernel.  I've
> > added one more since I last sent you this pull request (the fix memory
> > building non-aligned sg lists)
> > 
> > The patch is available from:
> > 
> > master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> > 
> > The short changelog is:
> > 
> > Bryan Holty:
> >   o fix memory building non-aligned sg lists
> > 
> I looked at 
> www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;.
> 
> This patch does the following change:
> 
> - int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
> + int nr_pages = PAGE_ALIGN(bufflen + sgl[0].offset);
> 
> This seems to wrong: the new version is missing the right shift. For 
> instance, offset=0 and bufflen=4096 results in 4096 and not 1!
> 
> (Using asm-x86_64, the new version translates to
> ((bufflen + sgl[0].offset+PAGE_SIZE-1)&(~(PAGE_SIZE-1)))
> )
> 
> According to the original patch by Brian, the change should probably have 
> been to (or something equivalent):
> 
> +       int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> 
> PAGE_SHIFT;
> 
> This was tested by several people. Did anyone test the version put into 
> scsi-rc-fixes-2.6.git?
> 

argh, that was me "improving" things.

--- devel/drivers/scsi/scsi_lib.c~scsi-properly-count-the-number-of-pages-in-scsi_req_map_sg-fix	2006-05-31 22:22:12.000000000 -0700
+++ devel-akpm/drivers/scsi/scsi_lib.c	2006-05-31 22:22:34.000000000 -0700
@@ -367,7 +367,7 @@ static int scsi_req_map_sg(struct reques
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = PAGE_ALIGN(bufflen + sgl[0].offset);
+	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
_

