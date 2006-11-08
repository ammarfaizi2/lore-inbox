Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423850AbWKHWso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423850AbWKHWso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423848AbWKHWso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:48:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:16430 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423838AbWKHWsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:48:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ajva+IcysCMVnNOMvi3tbUpJB189ZfS1hi8mIWL7QQsKGyFkMWJMc6wEddLmARfakOopMTBcgpyEgjtgmIAJO9TaetTv0mIA5wypyMLW0WSUtxCKEICAG3O27+zgieh2dOSzkmhnKaDrhU7fXYKYyYJNfBqSsOWDw9NfPyzKSxw=
Date: Thu, 9 Nov 2006 01:48:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061108224837.GG4972@martell.zuzino.mipt.ru>
References: <20061108222453.GA6408@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108222453.GA6408@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 04:24:53PM -0600, Serge E. Hallyn wrote:
> +struct vfs_cap_data_struct {

"_struct" suffix is useless here: "struct" is already typed.

> +	__u32 version;
> +	__u32 effective;
> +	__u32 permitted;
> +	__u32 inheritable;
> +};
> +
> +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> +{
> +	cap->version = le32_to_cpu(cap->version);
> +	cap->effective = le32_to_cpu(cap->effective);
> +	cap->permitted = le32_to_cpu(cap->permitted);
> +	cap->inheritable = le32_to_cpu(cap->inheritable);
> +}

This pretty much defeats sparse endian checking. You will get warnings
regardless of whether u32 or le32 are used.

One solution is to fork vfs_cap_data into __le* variant outside of
__KERNEL__ and u* variant internal to kernel (obviously inside
__KERNEL__). Then convert_to_le(), takes 2 arguments:
struct vfs_cap_data_core * and struct vfs_cap_data *. check_cap_sanity()
operates on core structure, et al.

As a side effect you can do interesting things with core structure
later.

Here is one part of GFS2 endian annotations I'm currently doing (still
not finally ready) which should demonstrate all I've said. Note that
after this patch in-core part of GFS2 rindex can lose all padding
on-disk version has.

>From 69254b2cd50d72220133c1e6f0a7ceba53cf5293 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 7 Nov 2006 02:58:28 +0300
Subject: [PATCH 8/11] gfs2: struct gfs2_rindex
---
 fs/gfs2/ondisk.c            |   15 +++++++--------
 fs/gfs2/rgrp.c              |   10 +++++-----
 include/linux/gfs2_ondisk.h |   18 +++++++++++++++---
 3 files changed, 27 insertions(+), 16 deletions(-)

index 1701829..139f977 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -95,15 +95,14 @@ void gfs2_sb_in(struct gfs2_sb *sb, cons
 	memcpy(sb->sb_locktable, str->sb_locktable, GFS2_LOCKNAME_LEN);
 }
 
-void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf)
+void gfs2_rindex_in(struct gfs2_rindex *ri,
+		    const struct gfs2_rindex_disk *ri_disk)
 {
-	const struct gfs2_rindex *str = buf;
-
-	ri->ri_addr = be64_to_cpu(str->ri_addr);
-	ri->ri_length = be32_to_cpu(str->ri_length);
-	ri->ri_data0 = be64_to_cpu(str->ri_data0);
-	ri->ri_data = be32_to_cpu(str->ri_data);
-	ri->ri_bitbytes = be32_to_cpu(str->ri_bitbytes);
+	ri->ri_addr = be64_to_cpu(ri_disk->ri_addr);
+	ri->ri_length = be32_to_cpu(ri_disk->ri_length);
+	ri->ri_data0 = be64_to_cpu(ri_disk->ri_data0);
+	ri->ri_data = be32_to_cpu(ri_disk->ri_data);
+	ri->ri_bitbytes = be32_to_cpu(ri_disk->ri_bitbytes);
 
 }
 
index 2c67ea6..d6d3752 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -442,12 +442,12 @@ static int gfs2_ri_update(struct gfs2_in
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct inode *inode = &ip->i_inode;
 	struct gfs2_rgrpd *rgd;
-	struct gfs2_rindex ri_disk;
+	struct gfs2_rindex_disk ri_disk;
 	struct file_ra_state ra_state;
 	u64 junk = ip->i_di.di_size;
 	int error;
 
-	if (do_div(junk, sizeof(struct gfs2_rindex))) {
+	if (do_div(junk, sizeof(struct gfs2_rindex_disk))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
@@ -456,12 +456,12 @@ static int gfs2_ri_update(struct gfs2_in
 
 	file_ra_state_init(&ra_state, inode->i_mapping);
 	for (sdp->sd_rgrps = 0;; sdp->sd_rgrps++) {
-		loff_t pos = sdp->sd_rgrps * sizeof(struct gfs2_rindex);
+		loff_t pos = sdp->sd_rgrps * sizeof(struct gfs2_rindex_disk);
 		error = gfs2_internal_read(ip, &ra_state, (char *)&ri_disk, &pos,
-					    sizeof(struct gfs2_rindex));
+					    sizeof(struct gfs2_rindex_disk));
 		if (!error)
 			break;
-		if (error != sizeof(struct gfs2_rindex)) {
+		if (error != sizeof(struct gfs2_rindex_disk)) {
 			if (error > 0)
 				error = -EIO;
 			goto fail;
index 91d066a..ebab0f0 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -140,7 +140,7 @@ struct gfs2_sb {
  * resource index structure
  */
 
-struct gfs2_rindex {
+struct gfs2_rindex_disk {
 	__be64 ri_addr;	/* grp block disk address */
 	__be32 ri_length;	/* length of rgrp header in fs blocks */
 	__u32 __pad;
@@ -153,6 +153,19 @@ struct gfs2_rindex {
 	__u8 ri_reserved[64];
 };
 
+struct gfs2_rindex {
+	__u64 ri_addr;	/* grp block disk address */
+	__u32 ri_length;	/* length of rgrp header in fs blocks */
+	__u32 __pad;
+
+	__u64 ri_data0;	/* first data location */
+	__u32 ri_data;	/* num of data blocks in rgrp */
+
+	__u32 ri_bitbytes;	/* number of bytes in data bitmaps */
+
+	__u8 ri_reserved[64];
+};
+
 /*
  * resource group header structure
  */
@@ -441,8 +454,7 @@ #ifdef __KERNEL__
 extern void gfs2_inum_in(struct gfs2_inum *no, const void *buf);
 extern void gfs2_inum_out(const struct gfs2_inum *no, void *buf);
 extern void gfs2_sb_in(struct gfs2_sb *sb, const void *buf);
-extern void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf);
-extern void gfs2_rindex_out(const struct gfs2_rindex *ri, void *buf);
+extern void gfs2_rindex_in(struct gfs2_rindex *ri, const struct gfs2_rindex_disk *ri_disk);
 extern void gfs2_rgrp_in(struct gfs2_rgrp *rg, const void *buf);
 extern void gfs2_rgrp_out(const struct gfs2_rgrp *rg, void *buf);
 extern void gfs2_dinode_in(struct gfs2_dinode *di, const void *buf);
-- 
1.4.1


