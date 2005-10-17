Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVJQPzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVJQPzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVJQPzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:55:19 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:47234 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751408AbVJQPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:55:17 -0400
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
Organization: IBM
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] Test for sb_getblk return value
Date: Mon, 17 Oct 2005 13:56:10 -0200
User-Agent: KMail/1.8
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
References: <20051017132306.GA30328@br.ibm.com> <9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com>
In-Reply-To: <9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bm8UD1yKsys5d/X"
Message-Id: <200510171356.11639.glommer@br.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bm8UD1yKsys5d/X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm resending it now with the changes you suggested. 
Actually, 2 copies of it follows. 

In the first one(v2), I kept the style in the changes in resize.c, as this 
seems to be the default way things like this are done there. In the other, 
(v3), I did statement checks in the way you suggested in both files.

Also, sorry for the last mail. I got a problem with my relay, and my mail 
address was sent wrong before I noticed that. Mails sent to it will probably 
return.

On Monday 17 October 2005 12:10, Jesper Juhl wrote:
> On 10/17/05, Glauber de Oliveira Costa <glauber@br.ibm.com> wrote:
> > Hi all,
> >
> > As we discussed earlier, I'm sending a patch that adds test for the
> > return value of sb_getblk. This time I focused on the code of the ext2/3
> > filesystems. I'm assuming that getblk fails happens due to I/O errors
> > and thus returning returning an EIO back wherever it's needed.
> >
> >
> > -  bh = sb_getblk(inode->i_sb, parent);
> > +  if (!(bh = sb_getblk(inode->i_sb, parent))){
> > +   err = -EIO;
> > +   break;
> > +  }
>
> Would be more readable as
>
>   bh = sb_getblk(inode->i_sb, parent);
>   if (!bh) {
>    err = -EIO;
>    break;
>   }
>
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================

--Boundary-00=_bm8UD1yKsys5d/X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch_getblk_ext3.v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_getblk_ext3.v2"

diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/inode.c linux-2.6.14-rc2-cleanp/fs/ext2/inode.c
--- linux-2.6.14-rc2-orig/fs/ext2/inode.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/inode.c	2005-10-17 14:17:54.000000000 +0000
@@ -440,6 +440,10 @@ static int ext2_alloc_branch(struct inod
 		 * the pointer to new one, then send parent to disk.
 		 */
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh){
+			err = -EIO;
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/inode.c linux-2.6.14-rc2-cleanp/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-10-09 20:26:54.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/inode.c	2005-10-17 14:23:50.000000000 +0000
@@ -523,7 +523,6 @@ static int ext3_alloc_branch(handle_t *h
 			if (!nr)
 				break;
 			branch[n].key = cpu_to_le32(nr);
-			keys = n+1;
 
 			/*
 			 * Get buffer_head for parent block, zero it out
@@ -531,6 +530,9 @@ static int ext3_alloc_branch(handle_t *h
 			 * parent to disk.  
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
+			if (!bh)
+				break;	
+			keys = n+1;
 			branch[n].bh = bh;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
@@ -864,6 +866,10 @@ struct buffer_head *ext3_getblk(handle_t
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		if (!bh){
+			*errp = -EIO;
+			return NULL;
+		}
 		if (buffer_new(&dummy)) {
 			J_ASSERT(create != 0);
 			J_ASSERT(handle != 0);
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/resize.c linux-2.6.14-rc2-cleanp/fs/ext3/resize.c
--- linux-2.6.14-rc2-orig/fs/ext3/resize.c	2005-10-09 19:58:40.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/resize.c	2005-10-17 13:02:07.000000000 +0000
@@ -117,7 +117,8 @@ static struct buffer_head *bclean(handle
 	struct buffer_head *bh;
 	int err;
 
-	bh = sb_getblk(sb, blk);
+	if (!(bh = sb_getblk(sb, blk)))
+		return ERR_PTR(-EIO);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
 		brelse(bh);
 		bh = ERR_PTR(err);
@@ -201,7 +202,10 @@ static int setup_new_group_blocks(struct
 
 		ext3_debug("update backup group %#04lx (+%d)\n", block, bit);
 
-		gdb = sb_getblk(sb, block);
+		if (!(gdb = sb_getblk(sb, block))){
+			err = -EIO;
+			goto exit_bh;
+		}
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
 			brelse(gdb);
 			goto exit_bh;
@@ -642,7 +646,10 @@ static void update_backups(struct super_
 		    (err = ext3_journal_restart(handle, EXT3_MAX_TRANS_DATA)))
 			break;
 
-		bh = sb_getblk(sb, group * bpg + blk_off);
+		if (!(bh = sb_getblk(sb, group * bpg + blk_off))){
+			err = -EIO;
+			goto exit_err;
+		}
 		ext3_debug("update metadata backup %#04lx\n",
 			  (unsigned long)bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))

--Boundary-00=_bm8UD1yKsys5d/X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch_getblk_ext3.v3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_getblk_ext3.v3"

diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/inode.c linux-2.6.14-rc2-cleanp/fs/ext2/inode.c
--- linux-2.6.14-rc2-orig/fs/ext2/inode.c	2005-09-26 13:58:15.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/inode.c	2005-10-17 14:17:54.000000000 +0000
@@ -440,6 +440,10 @@ static int ext2_alloc_branch(struct inod
 		 * the pointer to new one, then send parent to disk.
 		 */
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh){
+			err = -EIO;
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/inode.c linux-2.6.14-rc2-cleanp/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-10-09 20:26:54.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/inode.c	2005-10-17 14:23:50.000000000 +0000
@@ -523,7 +523,6 @@ static int ext3_alloc_branch(handle_t *h
 			if (!nr)
 				break;
 			branch[n].key = cpu_to_le32(nr);
-			keys = n+1;
 
 			/*
 			 * Get buffer_head for parent block, zero it out
@@ -531,6 +530,9 @@ static int ext3_alloc_branch(handle_t *h
 			 * parent to disk.  
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
+			if (!bh)
+				break;	
+			keys = n+1;
 			branch[n].bh = bh;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
@@ -864,6 +866,10 @@ struct buffer_head *ext3_getblk(handle_t
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		if (!bh){
+			*errp = -EIO;
+			return NULL;
+		}
 		if (buffer_new(&dummy)) {
 			J_ASSERT(create != 0);
 			J_ASSERT(handle != 0);
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/resize.c linux-2.6.14-rc2-cleanp/fs/ext3/resize.c
--- linux-2.6.14-rc2-orig/fs/ext3/resize.c	2005-10-09 19:58:40.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/resize.c	2005-10-17 14:23:01.000000000 +0000
@@ -118,6 +118,8 @@ static struct buffer_head *bclean(handle
 	int err;
 
 	bh = sb_getblk(sb, blk);
+	if (!bh)
+		return ERR_PTR(-EIO);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
 		brelse(bh);
 		bh = ERR_PTR(err);
@@ -202,6 +204,10 @@ static int setup_new_group_blocks(struct
 		ext3_debug("update backup group %#04lx (+%d)\n", block, bit);
 
 		gdb = sb_getblk(sb, block);
+		if (!bh){
+			err = -EIO;
+			goto exit_bh;
+		}
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
 			brelse(gdb);
 			goto exit_bh;
@@ -643,6 +649,10 @@ static void update_backups(struct super_
 			break;
 
 		bh = sb_getblk(sb, group * bpg + blk_off);
+		if (!bh){
+			err = -EIO;
+			goto exit_err;
+		}
 		ext3_debug("update metadata backup %#04lx\n",
 			  (unsigned long)bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))

--Boundary-00=_bm8UD1yKsys5d/X--
