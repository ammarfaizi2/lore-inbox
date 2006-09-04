Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWIDM5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWIDM5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIDM5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:57:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964861AbWIDM5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:57:49 -0400
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr>
References: <1157031054.3384.788.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 14:01:59 +0100
Message-Id: <1157374919.3384.909.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-09-01 at 14:43 +0200, Jan Engelhardt wrote:
> >+	if (!PageUptodate(page)) {
> 
> BTW (general question), who had the idea of developing so many 
> camelcase-named VM functions?
> 
> >+	if ((sdp->sd_args.ar_data == GFS2_DATA_ORDERED) || gfs2_is_jdata(ip))
>             ^                                         ^
> not required
> 
ok.

> >+	u64 *bp;
> >+	u64 bn;
> 
> General question: I actually wonder what's preffered for kernel code, uX or 
> uintX_t?
> 
My personal preference has always been for the uX style, if only because
it seems to fit in with the other __uX, __beX, __leX so I've been moving
them gradually towards that style. Since you've flagged it up, I've
changed the remaining ones over.

> >+	for (i = ip->i_di.di_height; i--;)
> >+		mp->mp_list[i] = (__u16)do_div(b, sdp->sd_inptrs);
> 
> Drop the cast if possible. do_div returns an integer.
> 
ok.

> >+static inline u64 *metapointer(struct buffer_head *bh, int *boundary,
> >+			       unsigned int height, const struct metapath *mp)
> >+{
> >+	unsigned int head_size = (height > 0) ?
> >+		sizeof(struct gfs2_meta_header) : sizeof(struct gfs2_dinode);
> >+	u64 *ptr;
> >+	*boundary = 0;
> >+	ptr = ((u64 *)(bh->b_data + head_size)) + mp->mp_list[height];
> >+	if (ptr + 1 == (u64*)(bh->b_data + bh->b_size))
>                            ^
> Add a space, to go in line with the other casts.
>
> >+	bsize = (gfs2_is_dir(ip)) ? sdp->sd_jbsize : sdp->sd_sb.sb_bsize;
> 
> () again.
> 
both done.

> >+int gfs2_extent_map(struct inode *inode, u64 lblock, int *new, u64 *dblock, unsigned *extlen)
> >+{
> >+	struct gfs2_inode *ip = GFS2_I(inode);
> >+	struct gfs2_sbd *sdp = GFS2_SB(inode);
> >+	struct metapath mp;
> >+	struct buffer_head *bh;
> >+	int boundary;
> >+	int create = *new;
> >+
> >+	BUG_ON(!extlen);
> >+	BUG_ON(!dblock);
> >+	BUG_ON(!new);
> >+
> >+	bmap_lock(inode, create);
> >+	bh = gfs2_block_pointers(inode, lblock, new, dblock, &boundary, &mp);
> >+	*extlen = 1;
> >+
> >+	if (bh && !IS_ERR(bh) && *dblock && !*new) {
> 
> This looks like it involves a lot of booleans. I'd prefer
>   bh != NULL && !IS_ERR(bh) && *dblock != 0 && *new != 0
> to make it clear pointers and integers are involved.
> 
ok.

> >+			(*extlen)++;
> 
> ++*extlen?
> 
ok.
> >+		top = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
> >+			mp->mp_list[0];
> >+		bottom = (uint64_t *)(bh->b_data + sizeof(struct gfs2_dinode)) +
> >+			sdp->sd_diptrs;
> 
> These casts can probably go also away, if b_data is a void* and sd_diptrs is an
> integer.
> 
bh->b_data is a char* unfortunately.

> >+++ b/fs/gfs2/format.h
[content of format.h snipped]
> Should not these go into a .c file instead?
> 
yes, now moved into super.c and format.h is gone.

> >+++ b/fs/gfs2/glops.c
> 
> >+static void inode_go_sync(struct gfs2_glock *gl, int flags)
[rest of function snipped]
> 
> Nothing major, I noticed an empty line at the end of function.
> 
ok.

> >+static void inode_go_unlock(struct gfs2_holder *gh)
[rest of function snipped]
> 
> How about inverting the if() to:
> 
> 	if(ip == NULL)
> 		return;
> 	if(test_bit(GLF_DIRTY, &gl->gl_flags))
> 		gfs_inode_attr_in(ip);
> 	gfs2_meta_cache_flush(ip);
> 
ok, done.

> 
> >+++ b/fs/gfs2/inode.c
[functions gfs2_inode_attr_in and gfs2_inode_attr_out snipped]
> I suggest
> 
> 	struct whateverneededhere *di = &ip->i_di;
> 	di->di_mode = inode->i_mode;
> 	...
> 
ok, done.

> >+int gfs2_dinode_dealloc(struct gfs2_inode *ip)
> >+{
> >+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
> >+	struct gfs2_alloc *al;
> >+	struct gfs2_rgrpd *rgd;
> >+	int error;
> >+
> >+	if (ip->i_di.di_blocks != 1) {
> >+		if (gfs2_consist_inode(ip))
> >+			gfs2_dinode_print(&ip->i_di);
> >+		return -EIO;
> >+	}
> >+
> >+	al = gfs2_alloc_get(ip);
> >+
> >+	error = gfs2_quota_hold(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
> >+	if (error)
> >+		goto out;
> 
> If the quota is not going to change, is the call needed?
> 
It reads in the quota information (if required) and prevents any other
process fiddling with it during the deallocation. The "no change" is
because the quota is actually updated during the deallocation at various
stages rather than "up front" in this case.

> >+/**
> >+ * glock_compare_atime - Compare two struct gfs2_glock structures for sort
[function snipped]
> const struct gfs2_holder *gh_a = *(const struct gfs2_holder **)arg_a;
> 
> IMO, try not to remove const'ness by casting. If [members of] gh_a were
> intended to be writable, make glock_compare_atime take (void *, void *)
> instead.
> 
yes, and updated accordingly. Also changed the comparison as suggested.

> I prefer to have function prototypes above any static inlines, in case a
> static-inline function uses one of these functions. Do it as you find best.
> 
Ok. I haven't changed them yet, but I'll bear that in mind for the
future.

> 
> 
> So far I have seen more extern than static functions. Please make any functions
> that are not used across two or more files static too if that has not already
> been done.
> 
> 
> 
> 
> Jan Engelhardt

I've had a number of patches from Adrian Bunk along those lines, so that
I don't think there are any functions currently not used across multiple
files which are not marked static. On the otherhand, there is probably
some scope for moving some functions around to allow them being marked
static.

Its a question really of how large we want to let a particular file grow
and where its possible to draw a sensible line between the various
functions. I think the greatest scope for this is probably between the
ops_X.[ch] and X.[ch] files so I'll add that to my list to look at later
on.

URLs of commits relating to this email:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=75d3b817a0b48425da921052955cc58f20bbab52
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=a91ea69ffd3f8a0b7139bfd44042ab384461e631
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=cd915493fce912f1bd838ee1250737ecf33b8fae
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=c26687113aea9a11c6f23ddf668f1fe43eca4ce7

I've also updated to a base of Linus' latest tree since the last set of
commits, but that didn't require any changes to GFS2,

Steve.


