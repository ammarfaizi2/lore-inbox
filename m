Return-Path: <linux-kernel-owner+w=401wt.eu-S932547AbXAIXoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbXAIXoU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbXAIXoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:44:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:50951 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547AbXAIXoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:44:19 -0500
Date: Tue, 9 Jan 2007 17:44:18 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: Re: [PATCH 3/3] eCryptfs: Encrypted passthrough
Message-ID: <20070109234418.GB32343@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com> <20070109222337.GF16578@us.ibm.com> <20070109144203.ce1ed092.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109144203.ce1ed092.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 02:42:03PM -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 16:23:37 -0600
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> 
> > +				page_virt = (char *)kmap(page);
> 
> Do we _have_ to use kmap here?  It's slow and theoretically deadlocky.
> kmap_atomic() is much preferred.
> 
> Can the other kmap() calls in ecryptfs be converted?

We will look into doing this.

> We'd actually like to remove kmap() one day.  Not much chance of that, but
> it's an objective.
> 
> > +				if (!page_virt) {
> > +					rc = -ENOMEM;
> > +					printk(KERN_ERR "Error mapping page\n");
> > +					goto out;
> > +				}
> > +				memset(page_virt, 0, PAGE_CACHE_SIZE);
> > +				if (page->index == 0) {
> > +					rc = ecryptfs_read_xattr_region(
> > +						page_virt, file->f_path.dentry);
> 
> Are we assured that ecryptfs_read_xattr_region() cannot overrun the
> page?

Yes:

---
int ecryptfs_read_xattr_region(char *page_virt, struct dentry*ecryptfs_dentry)
{
	ssize_t size;
	int rc = 0;

	size = ecryptfs_getxattr(ecryptfs_dentry, ECRYPTFS_XATTR_NAME,
				 page_virt, ECRYPTFS_DEFAULT_EXTENT_SIZE);
---

That winds up calling the lower filesystem's getxattr with
ECRYPTFS_DEFAULT_EXTENT_SIZE as the size parameter. eCryptfs validates
this value against PAGE_CACHE_SIZE in main.c::ecryptfs_init().

> > +					set_header_info(page_virt, crypt_stat);
> > +				}
> 
> The kernel must always run flush_dcache_page() after modifying a pagecache
> page by hand.  Please review all of ecryptfs for this.

We will work on some patches to address these issues.

Mike
