Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWHDAxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWHDAxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWHDAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:53:48 -0400
Received: from mx1.suse.de ([195.135.220.2]:23745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932587AbWHDAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:53:47 -0400
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Fri, 4 Aug 2006 10:53:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17618.39572.764990.76181@cse.unsw.edu.au>
Cc: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Next 2.6.17-stable review cycle will be starting in about 24	hours
In-Reply-To: message from Greg KH on Thursday August 3
References: <20060803074850.GA28301@kroah.com>
	<1154623652.3905.76.camel@aeonflux.holtmann.net>
	<20060803170020.GA10784@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 3, greg@kroah.com wrote:
> On Thu, Aug 03, 2006 at 06:47:32PM +0200, Marcel Holtmann wrote:
> > Hi Greg,
> > 
> > > This is a heads up that the next 2.6.17-stable review cycle will be
> > > starting in about 24 hours.  I've caught up on all pending -stable
> > > patches that I know about and placed them in our queue, which can be
> > > browsed online at:
> > > 	http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=tree;f=queue-2.6.17
> > > 
> > > If anyone sees that this queue is missing something that they feel
> > > should get into the next 2.6.17-stable release, please let us know at
> > > stable@kernel.org within the next 24 hours or so.
> > 
> > instead of ext3-avoid-triggering-ext3_error-on-bad-nfs-file-handle.patch
> > it makes more sense to include the revised patches from Neil:
> > 
> > http://comments.gmane.org/gmane.linux.kernel/430323
> > 
> > It seems that these are not merged upstream, but my understanding was
> > that they were the best way to fix this. For RHEL4 we are going with
> > these two patches. 
> 
> Hm, I just went with what Neil sent me for inclusion.  Neil, do you want
> me to change the patches you sent us?

I think the patch you have is adequate for ext3.  It closes the
important hole.  I think the extra patch for ext3 in the gmane link
above is not entirely necessary so I wouldn't push it for stable.
That doesn't make it a wrong choice for RHEL4 though.

The ext2 patch, on the other hand, should probably go in to stable.

I include it below so you don't have to scrape it off the web page...

NeilBrown

---------------------------------
Have ext2 reject file handles with bad inode numbers early.

This prevents bad inode numbers from triggering errors in
ext2_get_inode.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/ext2/super.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff .prev/fs/ext2/super.c ./fs/ext2/super.c
--- .prev/fs/ext2/super.c	2006-07-28 10:37:57.000000000 +1000
+++ ./fs/ext2/super.c	2006-07-28 11:43:09.000000000 +1000
@@ -251,6 +251,46 @@ static struct super_operations ext2_sops
 #endif
 };
 
+static struct dentry *ext2_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext2_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext2_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
+
 /* Yes, most of these are left as NULL!!
  * A NULL value implies the default, which works with ext2-like file
  * systems, but can be improved upon.
@@ -258,6 +298,7 @@ static struct super_operations ext2_sops
  */
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
+	.get_dentry = ext2_get_dentry,
 };
 
 static unsigned long get_sb_block(void **data)
