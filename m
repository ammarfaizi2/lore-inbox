Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWJCAJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWJCAJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 20:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965538AbWJCAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 20:09:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34000 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965110AbWJCAJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 20:09:05 -0400
From: Neil Brown <neilb@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Date: Tue, 3 Oct 2006 10:08:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.43531.490273.284884@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, "David M. Grimes" <dgrimes@navisite.com>,
       Atal Shargorodsky <atal@codefidence.com>,
       Gilad Ben-Yossef <gilad@codefidence.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 001 of 8] knfsd: Add nfs-export support to tmpfs
In-Reply-To: message from Hugh Dickins on Friday September 29
References: <20060929130518.23919.patches@notabene>
	<1060929030839.24024@suse.de>
	<20060928232953.6da08f19.akpm@osdl.org>
	<17692.49605.248998.607609@cse.unsw.edu.au>
	<Pine.LNX.4.64.0609292014160.23046@blonde.wat.veritas.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday September 29, hugh@veritas.com wrote:
> 
> But one anxiety, regarding i_ino.  That's an unsigned long originating
> from last_inode in fs/inode.c, isn't it?  Here getting cast to a __u32
> to make up one part of the file handle, which will then be cast back
> to an unsigned long for ilookup later.

Good point.  Another __u32 in the filehandle is called for.  It will
always be 0 on 32bit arches, but that's not big deal (it will almost
always be 0 on 64bit to...)

> Then there's the lesser but more tiresome problem, of i_ino collisions
> on 32-bit arches.  tmpfs hasn't worried about that to date, just taken
> whatever new_inode() has given it from last_inode: but perhaps these
> file handles now make that more of a concern?

Yes.....
The i_generation will still be different so we wont get to files with
the same filehandle.  But once an inum is reused, the previous one
won't be visible in the hash table any more.  This is easily fixed by
using ilookup5 and testing the i_generation.

There is still the fact that the duplicate inode numbers will be
visible on the client.  I don't think this will upset the NFS client
code as it uses the full filehandle to differentiate files.  I could
confuse usespace, but no worse than tmpfs already could confuse
userspace.  So I think this can be considered to be a non-problem.

So: this patch extends the filehandle to store 64bits of inode number
(high word, then low word, each in host-endian) and uses ilookup5 to
ensure that inum reuse doesn't confuse the server.

It even compiles and appear to work!

Thanks,
NeilBrown

----------------

Fix issues with nfs exporting of tmpfs

Two particular problem:
 i_ino can be 64bit, so use 64 bits in filehandle to store it.

 i_ino can be reused, so use ilookup5 and i_generation to avoid any
  possible confusion.

Cc: Hugh Dickins <hugh@veritas.com>
Cc: "David M. Grimes" <dgrimes@navisite.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./mm/shmem.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff .prev/mm/shmem.c ./mm/shmem.c
--- .prev/mm/shmem.c	2006-09-29 11:52:44.000000000 +1000
+++ ./mm/shmem.c	2006-10-03 09:54:11.000000000 +1000
@@ -1962,16 +1962,25 @@ static struct dentry *shmem_get_parent(s
 	return ERR_PTR(-ESTALE);
 }
 
+static int shmem_match(struct inode *ino, void *vfh)
+{
+	__u32 *fh = vfh;
+	__u64 inum = fh[2];
+	inum = (inum << 32) | fh[1];
+	return ino->i_ino == inum && fh[0] == ino->i_generation;
+}
+
 static struct dentry *shmem_get_dentry(struct super_block *sb, void *vfh)
 {
 	struct dentry *de = NULL;
 	struct inode *inode;
 	__u32 *fh = vfh;
+	__u64 inum = fh[2];
+	inum = (inum << 32) | fh[1];
 
-	inode = ilookup(sb, (unsigned long)fh[0]);
+	inode = ilookup5(sb, (unsigned long)(inum+fh[0]), shmem_match, vfh);
 	if (inode) {
-		if (inode->i_generation == fh[1])
-			de = d_find_alias(inode);
+		de = d_find_alias(inode);
 		iput(inode);
 	}
 
@@ -1982,7 +1991,7 @@ static struct dentry *shmem_decode_fh(st
 				      int (*acceptable)(void *context, struct dentry *de),
 				      void *context)
 {
-	if (len < 2)
+	if (len < 3)
 		return ERR_PTR(-ESTALE);
 
 	return sb->s_export_op->find_exported_dentry(sb, fh, NULL, acceptable, context);
@@ -1992,7 +2001,7 @@ static int shmem_encode_fh(struct dentry
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (*len < 2)
+	if (*len < 3)
 		return 255;
 
 	if (hlist_unhashed(&inode->i_hash)) {
@@ -2004,14 +2013,16 @@ static int shmem_encode_fh(struct dentry
 		static DEFINE_SPINLOCK(lock);
 		spin_lock(&lock);
 		if (hlist_unhashed(&inode->i_hash))
-			insert_inode_hash(inode);
+			__insert_inode_hash(inode,
+					    inode->i_ino + inode->i_generation);
 		spin_unlock(&lock);
 	}
 
-	fh[0] = inode->i_ino;
-	fh[1] = inode->i_generation;
+	fh[0] = inode->i_generation;
+	fh[1] = inode->i_ino;
+	fh[2] = ((__u64)inode->i_ino) >> 32;
 
-	*len = 2;
+	*len = 3;
 	return 1;
 }
 
