Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWICLRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWICLRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 07:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWICLRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 07:17:23 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:64145 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751234AbWICLRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 07:17:22 -0400
Date: Sun, 3 Sep 2006 13:13:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
In-Reply-To: <1157031127.3384.791.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609031245240.31445@yvahk01.tjqt.qr>
References: <1157031127.3384.791.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static void buf_lo_before_commit(struct gfs2_sbd *sdp)
>+{
>+	struct buffer_head *bh;
>+	struct gfs2_log_descriptor *ld;
>+	struct gfs2_bufdata *bd1 = NULL, *bd2;
>+	unsigned int total = sdp->sd_log_num_buf;
>+	unsigned int offset = sizeof(struct gfs2_log_descriptor);
>+	unsigned int limit;
>+	unsigned int num;
>+	unsigned n;
>+	__be64 *ptr;
>+
>+	offset += (sizeof(__be64) - 1);

-()

>+		ld = (struct gfs2_log_descriptor *)bh->b_data;
>+		ptr = (__be64 *)(bh->b_data + offset);

Hm too bad that b_data (include/linux/buffer_head.h) is a char*.

>+	gfs2_replay_incr_blk(sdp, &start);
>+
>+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
>+		blkno = be64_to_cpu(*ptr++);
>+
>+		sdp->sd_found_blocks++;
>+
>+		if (gfs2_revoke_check(sdp, blkno, start))
>+			continue;
>+
>+		error = gfs2_replay_read_block(jd, start, &bh_log);
>+                if (error)
>+                        return error;

Last two lines do not match your usual indent.

>+static void buf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
>+{
>+	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
>+	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
>+
>+	if (error) {
>+		gfs2_meta_sync(ip->i_gl,
>+			       DIO_START | DIO_WAIT);

gfs2_meta_sync() would fit on one line.

>+	offset += (2*sizeof(__be64) - 1);

>+#ifndef __LOPS_DOT_H__
>+#define __LOPS_DOT_H__

+struct gfs2_log_operations;

Making sure every .h file would "compile" on its own, this also means #include
<linux/list.h> for the below, f.ex..

>+
>+static inline void lops_init_le(struct gfs2_log_element *le,
>+				const struct gfs2_log_operations *lops)
>+{
>+	INIT_LIST_HEAD(&le->le_list);
>+	le->le_ops = lops;
>+}
>+
>+#endif /* __LOPS_DOT_H__ */

>+MODULE_DESCRIPTION("Global File System");
>+MODULE_AUTHOR("Red Hat, Inc.");
>+MODULE_LICENSE("GPL");

Maybe there should be at least one humna person listen in AUTHOR.

>+static const struct address_space_operations aspace_aops = {
>+	.writepage = gfs2_aspace_writepage,
>+	.releasepage = gfs2_releasepage,
>+};

Not all multi-line structs (such as these) have a , on the last element.

>+void gfs2_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh,
>+			 int meta)
>+{
>+	struct gfs2_bufdata *bd;
>+
>+	if (meta)
>+		lock_page(bh->b_page);
>+
>+	if (bh->b_private) {
>+		if (meta)
>+			unlock_page(bh->b_page);
>+		return;
>+	}
>+
>+	bd = kmem_cache_alloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL),
>+	memset(bd, 0, sizeof(struct gfs2_bufdata));
>+	bd->bd_bh = bh;
>+	bd->bd_gl = gl;
>+
>+	INIT_LIST_HEAD(&bd->bd_list_tr);
>+	if (meta) {
>+		lops_init_le(&bd->bd_le, &gfs2_buf_lops);
>+	} else {
>+		lops_init_le(&bd->bd_le, &gfs2_databuf_lops);
>+	}

-{}

>+void gfs2_inum_in(struct gfs2_inum *no, char *buf)
>+{
>+	struct gfs2_inum *str = (struct gfs2_inum *)buf;
>+
>+	no->no_formal_ino = be64_to_cpu(str->no_formal_ino);
>+	no->no_addr = be64_to_cpu(str->no_addr);
>+}

Hm, how about

void gfs2_inum_in(struct gfs2_inum *no, void *buf)
{
	const struct gfs2_inum *str = buf;

	no->no_formal_ino = be64_to_cpu(str->no_formal_ino);
	no->no_addr = be64_to_cpu(str->no_addr);
}

That is, making the 2nd argument a void*, and the cast can go away. The callers
most likely also can have their casts dropped, since to-void* is also implicit.
Also applies to

+void gfs2_inum_out(const struct gfs2_inum *no, char *buf)
+static void gfs2_meta_header_in(struct gfs2_meta_header *mh, char *buf)
+static void gfs2_meta_header_out(struct gfs2_meta_header *mh, char *buf)
+void gfs2_sb_in(struct gfs2_sb *sb, char *buf)
+void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf)
+void gfs2_rgrp_in(struct gfs2_rgrp *rg, char *buf)
+void gfs2_rgrp_out(struct gfs2_rgrp *rg, char *buf)
+void gfs2_quota_in(struct gfs2_quota *qu, char *buf)
+void gfs2_dinode_in(struct gfs2_dinode *di, char *buf)
+void gfs2_dinode_out(struct gfs2_dinode *di, char *buf)
+void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf)
+void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf)
+void gfs2_inum_range_out(struct gfs2_inum_range *ir, char *buf)
+void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf)
+void gfs2_statfs_change_out(struct gfs2_statfs_change *sc, char *buf)
+void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf)

>+++ b/fs/gfs2/ops_address.c
>+	if (likely(file != &gfs2_internal_file_sentinal)) {

The thing is usually called "sentinel". Alan might prove me wrong that both
spelling variants are possible :-)

>+static int gfs2_commit_write(struct file *file, struct page *page,
>+			     unsigned from, unsigned to)
>+{
>+	struct inode *inode = page->mapping->host;
>+	struct gfs2_inode *ip = GFS2_I(inode);
>+	struct gfs2_sbd *sdp = GFS2_SB(inode);
>+	int error = -EOPNOTSUPP;
>+	struct buffer_head *dibh;
>+	struct gfs2_alloc *al = &ip->i_alloc;;
>+
>+	if (gfs2_assert_withdraw(sdp, gfs2_glock_is_locked_by_me(ip->i_gl)))
>+                goto fail_nounlock;
>+
>+	error = gfs2_meta_inode_buffer(ip, &dibh);
>+	if (error)
>+		goto fail_endtrans;
>+
>+	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>+
>+	if (gfs2_is_stuffed(ip)) {
>+		uint64_t file_size;
>+		void *kaddr;
>+
>+		file_size = ((uint64_t)page->index << PAGE_CACHE_SHIFT) + to;
>+
>+		kaddr = kmap_atomic(page, KM_USER0);
>+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode) + from,
>+		       (char *)kaddr + from, to - from);

Nocast kaddr + from.

>+static void stuck_releasepage(struct buffer_head *bh)
>+{
>+static unsigned limit = 0;

Is this really ok to have?



Jan Engelhardt
-- 

-- 
VGER BF report: H 0.000958328
