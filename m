Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWIAMr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWIAMr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWIAMr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:47:57 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:37505 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751257AbWIAMr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:47:56 -0400
Date: Fri, 1 Sep 2006 14:43:43 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
In-Reply-To: <1157031054.3384.788.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr>
References: <1157031054.3384.788.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+	if (!PageUptodate(page)) {

BTW (general question), who had the idea of developing so many 
camelcase-named VM functions?

>+	if ((sdp->sd_args.ar_data == GFS2_DATA_ORDERED) || gfs2_is_jdata(ip))
            ^                                         ^
not required

>+	u64 *bp;
>+	u64 bn;

General question: I actually wonder what's preffered for kernel code, uX or 
uintX_t?

>+	for (i = ip->i_di.di_height; i--;)
>+		mp->mp_list[i] = (__u16)do_div(b, sdp->sd_inptrs);

Drop the cast if possible. do_div returns an integer.

>+static inline u64 *metapointer(struct buffer_head *bh, int *boundary,
>+			       unsigned int height, const struct metapath *mp)
>+{
>+	unsigned int head_size = (height > 0) ?
>+		sizeof(struct gfs2_meta_header) : sizeof(struct gfs2_dinode);
>+	u64 *ptr;
>+	*boundary = 0;
>+	ptr = ((u64 *)(bh->b_data + head_size)) + mp->mp_list[height];
>+	if (ptr + 1 == (u64*)(bh->b_data + bh->b_size))
                           ^
Add a space, to go in line with the other casts.

>+	bsize = (gfs2_is_dir(ip)) ? sdp->sd_jbsize : sdp->sd_sb.sb_bsize;

() again.

>+int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsigned *extlen)
>+{
>+	struct gfs2_inode *ip = GFS2_I(inode);
>+	struct gfs2_sbd *sdp = GFS2_SB(inode);
>+	struct metapath mp;
>+	struct buffer_head *bh;
>+	int boundary;
>+	int create = *new;
>+
>+	BUG_ON(!extlen);
>+	BUG_ON(!dblock);
>+	BUG_ON(!new);
>+
>+	bmap_lock(inode, create);
>+	bh = gfs2_block_pointers(inode, lblock, new, dblock, &boundary, &mp);
>+	*extlen = 1;
>+
>+	if (bh && !IS_ERR(bh) && *dblock && !*new) {

This looks like it involves a lot of booleans. I'd prefer
  bh != NULL && !IS_ERR(bh) && *dblock != 0 && *new != 0
to make it clear pointers and integers are involved.

>+			(*extlen)++;

++*extlen?

>+		top = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
>+			mp->mp_list[0];
>+		bottom = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
>+			sdp->sd_diptrs;

These casts can probably go also away, if b_data is a void* and sd_diptrs is an
integer.

>+++ b/fs/gfs2/format.h
>@@ -0,0 +1,21 @@
>+/*
>+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
>+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
>+ *
>+ * This copyrighted material is made available to anyone wishing to use,
>+ * modify, copy, or redistribute it subject to the terms and conditions
>+ * of the GNU General Public License v.2.
>+ */
>+
>+#ifndef __FORMAT_DOT_H__
>+#define __FORMAT_DOT_H__
>+
>+static const uint32_t gfs2_old_fs_formats[] = {
>+	0
>+};
>+
>+static const uint32_t gfs2_old_multihost_formats[] = {
>+	0
>+};

Should not these go into a .c file instead?

>+++ b/fs/gfs2/glops.c

>+static void inode_go_sync(struct gfs2_glock *gl, int flags)
>+{
>+	int meta = (flags & DIO_METADATA);
>+	int data = (flags & DIO_DATA);
>+
>+	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
>+		if (meta && data) {
>+			gfs2_page_sync(gl, flags | DIO_START);
>+			gfs2_log_flush(gl->gl_sbd, gl);
>+			gfs2_meta_sync(gl, flags | DIO_START | DIO_WAIT);
>+			gfs2_page_sync(gl, flags | DIO_WAIT);
>+			clear_bit(GLF_DIRTY, &gl->gl_flags);
>+		} else if (meta) {
>+			gfs2_log_flush(gl->gl_sbd, gl);
>+			gfs2_meta_sync(gl, flags | DIO_START | DIO_WAIT);
>+		} else if (data)
>+			gfs2_page_sync(gl, flags | DIO_START | DIO_WAIT);
>+		if (flags & DIO_RELEASE)
>+			gfs2_ail_empty_gl(gl);
>+	}
>+
>+}

Nothing major, I noticed an empty line at the end of function.

>+static void inode_go_unlock(struct gfs2_holder *gh)
>+{
>+	struct gfs2_glock *gl = gh->gh_gl;
>+	struct gfs2_inode *ip = gl->gl_object;
>+
>+	if (ip) {
>+		if (test_bit(GLF_DIRTY, &gl->gl_flags))
>+			gfs2_inode_attr_in(ip);
>+
>+		gfs2_meta_cache_flush(ip);
>+	}
>+}

How about inverting the if() to:

	if(ip == NULL)
		return;
	if(test_bit(GLF_DIRTY, &gl->gl_flags))
		gfs_inode_attr_in(ip);
	gfs2_meta_cache_flush(ip);


>+++ b/fs/gfs2/inode.c
>+	inode->i_mode = ip->i_di.di_mode;
>+	inode->i_nlink = ip->i_di.di_nlink;
>+	inode->i_uid = ip->i_di.di_uid;
>+	inode->i_gid = ip->i_di.di_gid;
>+	i_size_write(inode, ip->i_di.di_size);
>+	inode->i_atime.tv_sec = ip->i_di.di_atime;
>+	inode->i_mtime.tv_sec = ip->i_di.di_mtime;
>+	inode->i_ctime.tv_sec = ip->i_di.di_ctime;
>+	inode->i_atime.tv_nsec = 0;
>+	inode->i_mtime.tv_nsec = 0;
>+	inode->i_ctime.tv_nsec = 0;
>+	inode->i_blksize = PAGE_SIZE;
>+	inode->i_blocks = ip->i_di.di_blocks <<
>+		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
>+
>+	if (ip->i_di.di_flags & GFS2_DIF_IMMUTABLE)
>+		inode->i_flags |= S_IMMUTABLE;
>+	else
>+		inode->i_flags &= ~S_IMMUTABLE;
>+
>+	if (ip->i_di.di_flags & GFS2_DIF_APPENDONLY)
>+		inode->i_flags |= S_APPEND;
>+	else
>+		inode->i_flags &= ~S_APPEND;
>+}
>+
>+/**
>+ * gfs2_inode_attr_out - Copy attributes from VFS inode into the dinode
>+ * @ip: The GFS2 inode
>+ *
>+ * Only copy out the attributes that we want the VFS layer
>+ * to be able to modify.
>+ */
>+
>+void gfs2_inode_attr_out(struct gfs2_inode *ip)
>+{
>+	struct inode *inode = &ip->i_inode;
>+
>+	gfs2_assert_withdraw(GFS2_SB(inode),
>+		(ip->i_di.di_mode & S_IFMT) == (inode->i_mode & S_IFMT));
>+	ip->i_di.di_mode = inode->i_mode;
>+	ip->i_di.di_uid = inode->i_uid;
>+	ip->i_di.di_gid = inode->i_gid;
>+	ip->i_di.di_atime = inode->i_atime.tv_sec;
>+	ip->i_di.di_mtime = inode->i_mtime.tv_sec;
>+	ip->i_di.di_ctime = inode->i_ctime.tv_sec;
>+}

I suggest

	struct whateverneededhere *di = &ip->i_di;
	di->di_mode = inode->i_mode;
	...

>+int gfs2_dinode_dealloc(struct gfs2_inode *ip)
>+{
>+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
>+	struct gfs2_alloc *al;
>+	struct gfs2_rgrpd *rgd;
>+	int error;
>+
>+	if (ip->i_di.di_blocks != 1) {
>+		if (gfs2_consist_inode(ip))
>+			gfs2_dinode_print(&ip->i_di);
>+		return -EIO;
>+	}
>+
>+	al = gfs2_alloc_get(ip);
>+
>+	error = gfs2_quota_hold(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
>+	if (error)
>+		goto out;

If the quota is not going to change, is the call needed?

>+/**
>+ * glock_compare_atime - Compare two struct gfs2_glock structures for sort
>+ * @arg_a: the first structure
>+ * @arg_b: the second structure
>+ *
>+ * Returns: 1 if A > B
>+ *         -1 if A < B
>+ *          0 if A = B

Correct from a math POV, in computing, it's "==" :-)

>+static int glock_compare_atime(const void *arg_a, const void *arg_b)
>+{
>+	struct gfs2_holder *gh_a = *(struct gfs2_holder **)arg_a;
>+	struct gfs2_holder *gh_b = *(struct gfs2_holder **)arg_b;

const struct gfs2_holder *gh_a = *(const struct gfs2_holder **)arg_a;

IMO, try not to remove const'ness by casting. If [members of] gh_a were
intended to be writable, make glock_compare_atime take (void *, void *)
instead.

>+	struct lm_lockname *a = &gh_a->gh_gl->gl_name;
>+	struct lm_lockname *b = &gh_b->gh_gl->gl_name;
>+	int ret = 0;
>+
>+	if (a->ln_number > b->ln_number)
>+		ret = 1;
>+	else if (a->ln_number < b->ln_number)
>+		ret = -1;
>+	else {
>+		if (gh_a->gh_state == LM_ST_SHARED &&
>+		    gh_b->gh_state == LM_ST_EXCLUSIVE)
>+			ret = 1;
>+		else if (gh_a->gh_state == LM_ST_SHARED &&
>+			 (gh_b->gh_flags & GL_ATIME))
>+			ret = 1;
>+	}
>+
>+	return ret;
>+}

You can do an "early return",

function() {
	if(a->ln_number > b->ln_number)
		return 1;
	else if(a->ln_number < b->ln_number)
		return -1;

	if(gh_a->gh_state == LM_ST_SHARED && gh_b->gh_state == LM_ST_EXCLUSIVE)
		return 1;
	if(gh_a->gh_state == LM_ST_SHARED && (gh_b->gh_flags & GL_ATIME))
		return 1;

	return 0;
}

The two nice side effects of early-return and if-inversion (see above) are that
indentation is reduced (CodingStyle: "The answer to that is that if you need
more than 3 levels of indentation, you're screwed anyway, and should fix your
program.")

and one can follow the possible flows more easily (to take CS wording "A human
brain can generally easily keep track of about 7 different things, anything
more and it gets confused.") because some conditions are evicted early.

>+#ifndef __INODE_DOT_H__
>+#define __INODE_DOT_H__
>+
>+static inline int gfs2_is_stuffed(struct gfs2_inode *ip)
>+{
>+	return !ip->i_di.di_height;
>+}
>+
>+static inline int gfs2_is_jdata(struct gfs2_inode *ip)
>+{
>+	return ip->i_di.di_flags & GFS2_DIF_JDATA;
>+}
>+
>+static inline int gfs2_is_dir(struct gfs2_inode *ip)
>+{
>+	return S_ISDIR(ip->i_di.di_mode);
>+}
>+
>+void gfs2_inode_attr_in(struct gfs2_inode *ip);
>+void gfs2_inode_attr_out(struct gfs2_inode *ip);
>+struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum *inum, unsigned type);
>+struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum *inum);
>+
>+int gfs2_inode_refresh(struct gfs2_inode *ip);
>+
>+int gfs2_dinode_dealloc(struct gfs2_inode *inode);
>+int gfs2_change_nlink(struct gfs2_inode *ip, int diff);
>+struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name, 
>+			   int is_root, struct nameidata *nd);
>+struct inode *gfs2_createi(struct gfs2_holder *ghs, const struct qstr *name,
>+			   unsigned int mode);
>+int gfs2_rmdiri(struct gfs2_inode *dip, const struct qstr *name,
>+		struct gfs2_inode *ip);
>+int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
>+		   struct gfs2_inode *ip);
>+int gfs2_ok_to_move(struct gfs2_inode *this, struct gfs2_inode *to);
>+int gfs2_readlinki(struct gfs2_inode *ip, char **buf, unsigned int *len);
>+
>+int gfs2_glock_nq_atime(struct gfs2_holder *gh);
>+int gfs2_glock_nq_m_atime(unsigned int num_gh, struct gfs2_holder *ghs);
>+
>+int gfs2_setattr_simple(struct gfs2_inode *ip, struct iattr *attr);
>+
>+struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
>+
>+#endif /* __INODE_DOT_H__ */

I prefer to have function prototypes above any static inlines, in case a
static-inline function uses one of these functions. Do it as you find best.



So far I have seen more extern than static functions. Please make any functions
that are not used across two or more files static too if that has not already
been done.




Jan Engelhardt
-- 
