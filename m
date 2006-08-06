Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWHFOiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWHFOiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHFOiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:38:23 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:34228 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S932524AbWHFOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:38:22 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: partial reiser4 review comments
Date: Sun, 6 Aug 2006 18:38:34 +0400
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
References: <20060803001741.4ee9ff72.akpm@osdl.org> <20060803142644.GC20405@infradead.org>
In-Reply-To: <20060803142644.GC20405@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608061838.35004.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (481/060804)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2006 18:26, Christoph Hellwig wrote:
> On Thu, Aug 03, 2006 at 12:17:41AM -0700, Andrew Morton wrote:
> > - running igrab() in the writepage() path is really going to hammer
> >   inode_lock.  Something else will need to be done here.
> >
> > - Running iput() in entd() is a bit surprising.  iirc there are
> > various ways in which this can recur into the filesystem, perform
> > I/O, etc.  I guess it works..
> >
> >   But again, it will hammer inode_lock.
>
> XFS used to do this and it caused lots of problems.  What xfs does
> now is to keep an iocount in the inode for outstanding I/Os and
> ->clear_inode waits for that I/O to finish using hashed waitqueues. 
> It would be nice to have a facility like that in generic code.
>
> > - reiser4_readpages() shouldn't need to clean up the remaining
> > pages on *pages.  read_cache_pages() does that now.
>
> Without looking at the code I remember someone from the Namesys
> people told me they could use plain mpage_readpages now.  Anything
> still blocking using that function?

reiser4 tries to reduce number of tree lookups. better, if there would 
be one tree lookup for one readpages call.

what we are currently doing in a not-yet-submitted patch (below), i 
don't see how it can be done by mpage_readpages.

+struct uf_readpages_context {
+	lock_handle lh;
+	coord_t coord;
+};
+
+/* A callback function for readpages_unix_file/read_cache_pages.
+ * It assumes that the file is build of extents.
+ *
+ * @data -- a pointer to reiser4_readpages_context object,
+ *            to save the twig lock and the coord between
+ *            read_cache_page iterations.
+ * @page -- page to start read.
+ */
+static int uf_readpages_filler(void * data, struct page * page)
+{
+	struct uf_readpages_context *rc = data;
+	jnode * node;
+	int ret = 0;
+	reiser4_extent *ext;
+	__u64 ext_index;
+	int cbk_done = 0;
+	struct address_space * mapping = page->mapping;
+
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		return 0;
+	}
+	node = jnode_of_page(page);
+	if (unlikely(IS_ERR(node))) {
+		ret = PTR_ERR(node);
+		goto err;
+	}
+	if (rc->lh.node == 0) {
+		/* no twig lock  - have to do tree search. */
+		reiser4_key key;
+	repeat:
+		unlock_page(page);
+		key_by_inode_and_offset_common(
+			mapping->host, page_offset(page), &key);
+		ret = coord_by_key(
+			&get_super_private(mapping->host->i_sb)->tree,
+			&key, &rc->coord, &rc->lh,
+			ZNODE_READ_LOCK, FIND_EXACT,
+			TWIG_LEVEL, TWIG_LEVEL, CBK_UNIQUE, NULL);
+		lock_page(page);
+		cbk_done = 1;
+		if (ret != 0)
+			goto err;
+	}
+	ret = zload(rc->coord.node);
+	if (ret)
+		goto err;
+	ext = extent_by_coord(&rc->coord);
+	ext_index = extent_unit_index(&rc->coord);
+	if (page->index < ext_index || page->index >= ext_index + 
extent_get_width(ext))
+	{
+		/* the page index doesn't belong to the extent unit which the coord 
points to,
+		 *  -- release the lock and repeat with tree search. */
+		zrelse(rc->coord.node);
+		done_lh(&rc->lh);
+		/* we can be here after a CBK call only in case of corruption of the 
tree
+		 * or the tree lookup algorithm bug. */
+		if (unlikely(cbk_done)) {
+			ret = RETERR(-EIO);
+			goto err;
+		}
+		goto repeat;
+	}
+	ret = do_readpage_extent(ext, page->index - ext_index, page);
+	zrelse(rc->coord.node);
+	if (ret) {
+err:
+		unlock_page(page);
+	}
+	jput(node);
+	return ret;
+}
+
+/**
+ * readpages_unix_file - called by the readahead code, starts reading 
for each
+ * page of given list of pages
+ */
+int readpages_unix_file(
+	struct file *file, struct address_space *mapping,
+	struct list_head *pages, unsigned nr_pages)
+{
+	reiser4_context *ctx;
+	struct uf_readpages_context rc;
+	int ret;
+
+	ctx = init_context(mapping->host->i_sb);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+	init_lh(&rc.lh);
+	ret = read_cache_pages(mapping, pages,  uf_readpages_filler, &rc);
+	done_lh(&rc.lh);
+	context_set_commit_async(ctx);
+	/* close the transaction to protect further page allocation from 
deadlocks */
+	txn_restart(ctx);
+	reiser4_exit_context(ctx);
+	return ret;
+}

what it does do yet -- it doesn't use one bio for more than one page.

BTW, read_cache_page() and mpage_readpages are similar, I guess the 
second can be rewritten using the first one, no?

> > - General comment: the lack of support for extended ttributes,
> > access control lists and direct-io is a big problem and it's
> > getting bigger.  I don't see how a vendor could support reiser4
> > without these features and permanent lack of vendor support will
> > hurt.
> >
> >   What's the plan here?
>
> Another issue is the lack of support for blocksize < pagesize.   This
> prevents it from beeing used across architectures.  Even worse when I
> tried the last time it didn't allow me to create a 64k blocksize
> filesystem that I could actually test on ppc64.

-- 
Alex.

