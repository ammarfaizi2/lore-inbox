Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbUABMKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUABMKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:10:15 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:3819 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265527AbUABMKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:10:08 -0500
To: Jens Axboe <axboe@suse.de>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	<20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com>
	<1073034412.4429.1.camel@laptop.fenrus.com> <m2k74a8vyr.fsf@telia.com>
	<20040102105915.GO5523@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2004 13:09:49 +0100
In-Reply-To: <20040102105915.GO5523@suse.de>
Message-ID: <m2brpm8sc2.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Fri, Jan 02 2004, Peter Osterlund wrote:
> > Arjan van de Ven <arjanv@redhat.com> writes:
> > 
> > > On Fri, 2004-01-02 at 02:30, Peter Osterlund wrote:
> > > 
> > > > The packet writing code has the restriction that a bio must not span a
> > > > packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> > > > to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> > > > returns 2048, which is less than len, which is 4096 if the whole page
> > > > is mapped, so the bio_add_page() call fails.
> > > 
> > > devicemapper has similar restrictions for raid0 format; in that case
> > > it's device-mappers job to split the page/bio. Just as it is UDF's task
> > > to do the same I suspect...
> > 
> > Old versions of the packet writing code did just that, but Jens told
> > me that bio splitting was evil, so when the merge_bvec_fn
> > functionality was added to the kernel, I started to use it.
> > 
> >         http://lists.suse.com/archive/packet-writing/2002-Aug/0044.html
> 
> Splitting is evil, but unfortunately it's a necessary evil... There are
> a few kernel helpers to make supporting it easier (see bio_split()). Not
> so sure how well that'll work for you, you may have to do the grunt work
> yourself.

OK, I'll fix the packet writing code.

> > If merge_bvec_fn is not supposed to be able to handle the need of the
> > packet writing code, I can certainly resurrect my bio splitting code.
> 
> Only partially. Read my email: you _must_ accept a page addition to an
> empty bio. You can refuse others. For the single page case, you may need
> to split.
> 
> > Btw, for some reason, this bug is not triggered when using the UDF
> > filesystem on a CDRW. I've only seen it with the ext2 filesystem.
> 
> Does UDF use mpage? The fact that it doesn't trigger on UDF doesn't mean
> that packet writing isn't breaking the API :)

Agreed, this was not meant to excuse the packet writing code, just
some additional trivia.

Btw, is this API documented somewhere, or does it have to be reverse
engineered by means of understanding implementation details in
mpage_writepage() and similar functions? ;) May I suggest this patch?

--- linux/drivers/block/ll_rw_blk.c.old	2004-01-02 12:56:55.000000000 +0100
+++ linux/drivers/block/ll_rw_blk.c	2004-01-02 13:07:25.000000000 +0100
@@ -173,9 +173,11 @@
  * are dynamic, and thus we have to query the queue whether it is ok to
  * add a new bio_vec to a bio at a given offset or not. If the block device
  * has such limitations, it needs to register a merge_bvec_fn to control
- * the size of bio's sent to it. Per default now merge_bvec_fn is defined for
- * a queue, and only the fixed limits are honored.
- *
+ * the size of bio's sent to it. Note that a block device *must* allow a
+ * single page to be added to an empty bio. The block device driver may want
+ * to use the bio_split() function to deal with these bio's. Per default
+ * no merge_bvec_fn is defined for a queue, and only the fixed limits are
+ * honored.
  */
 void blk_queue_merge_bvec(request_queue_t *q, merge_bvec_fn *mbfn)
 {

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
