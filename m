Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWHKXCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWHKXCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHKXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:02:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:7612 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751246AbWHKXCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DQ8e0NIgUYu49Iy7DoGHNFiDDZerMkgIQk5o9RpK5rstBmC51lmJZDfirQoXpOuH2i+OeRKBYjiIdfeFEEYTHSHOtML7S1QT/dC1VFfMfvdWb1WzNRVK8ASD6F4mwwwdvAgU2n/dmTjhmTA5VPyV357OfdkCRV50U6Uz0Harq2E=
Message-ID: <5c49b0ed0608111602g78448347v77b10be2ef1db7f6@mail.gmail.com>
Date: Fri, 11 Aug 2006 16:02:35 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Hans Reiser" <reiser@namesys.com>
Subject: Re: partial reiser4 review comments
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Alexander Zarochentsev" <zam@namesys.com>,
       "Andrew Morton" <akpm@osdl.org>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44DCC49C.3020304@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060803001741.4ee9ff72.akpm@osdl.org>
	 <20060803142644.GC20405@infradead.org>
	 <200608061838.35004.zam@namesys.com>
	 <20060809085946.GA6177@infradead.org> <44D9A86F.3010304@namesys.com>
	 <5c49b0ed0608101131h55f1505eo44b78603e2e8d3c2@mail.gmail.com>
	 <44DCC49C.3020304@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Hans Reiser <reiser@namesys.com> wrote:
> Nate Diller wrote:
>
> > On 8/9/06, Hans Reiser <reiser@namesys.com> wrote:
> >
> >> Christoph Hellwig wrote:
> >>
> >> > I must admit that standalone code snipplet doesn't really tell me a
> >> lot.
> >> >
> >> >Do you mean the possibility to pass around a filesystem-defined
> >> structure
> >> >to multiple allocator calls?  I'm pretty sure can add that, I though it
> >> >would be useful multiple times in the past but always found ways around
> >> >it.
> >> >
> >> >
> >> >
> >> Assuming I understand your discussion, I see two ways to go, one is to
> >> pass around fs specific state and continue to call into the FS many
> >> times, and the other is to instead provide the fs with helper functions
> >> that accomplish readahead calculation, page allocation, etc., and let
> >> the FS keep its state naturally without having to preserve it in some fs
> >> defined structure.  The second approach would be cleaner code design,
> >> that would also ease cross-os porting of filesystems, in my view.
> >
> >
> > the second approach is the one i was heading towards with my
> > unfinished a_ops patches.  *please* won't someone pay me to do that
> > work...
> >
> > NATE
> >
> >
> You might describe it in a paragraph or so instead of just mentioning
> it.....;-)
>

start by making tree_lock (write) private, using the interface
detailed below.  No one should be able to add/remove pages from the
address space without going through the a_ops interface.  this patch
is part of a (much) larger unfinished, and outdated, set intended to
put this interface in place.  people familiar with this code will
immediately note that there are a few hard problems to solve here,
most notably the various {truncate|invalidate}_mapping_pages calls,
and the locking involved.  Cleaning up the inode reclaim paths a bit
should help this, and that work is unfinished as well.

I'm always hesitant to post stuff like this, because -ENOPATCH is
really an appropriate response here.

NATE

diff -urpN linux-2.6.15-rc5-mm1/include/linux/fs.h
linux-extent/include/linux/fs.h
--- linux-2.6.15-rc5-mm1/include/linux/fs.h	2005-12-10 16:49:30.000000000 -0800
+++ linux-extent/include/linux/fs.h	2006-08-11 15:47:19.000000000 -0700
@@ -340,18 +340,33 @@ struct address_space;
 struct writeback_control;

 struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
-	int (*sync_page)(struct page *);
-
-	/* Write back some dirty pages from this mapping. */
-	int (*writepages)(struct address_space *, struct writeback_control *);
-
 	/* Set a page dirty */
+	/* takes lock to move lists, update counts */
 	int (*set_page_dirty)(struct page *page);
+	/* get rid of this, all it does is unplug blkdev */
+	int (*sync_page)(struct page *);

+	/*
+	 * Write back dirty pages / invalidate all pages that fall within
+	 * the given page range (end byte inclusive).  These only affect
+	 * pages already cached in this mapping.
+	 */
+	int (*writepages)(struct address_space *mapping,
+			  struct writeback_control *wbc);
+	int (*invalidate_range)(struct address_space *mapping,
+				pgoff_t index, unsigned nr_pages);
+
+	/*
+	 * Read / create pages within the given index extent.  These
+	 * silently skip any pages which are already cached in this mapping.
+	 *
+	 * Return the number of pages allocated within the range, or an error.
+	 */
+	/* filp here is wierd */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
+			pgoff_t index, unsigned nr_pages);
+	int (*instantiate_range)(struct address_space *mapping, pgoff_t index,
+			unsigned nr_pages);

 	/*
 	 * ext3 requires that a successful prepare_write() call be followed
