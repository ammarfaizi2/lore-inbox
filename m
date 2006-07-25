Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWGYChh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWGYChh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWGYChh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:37:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932416AbWGYChg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:37:36 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 12:36:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17605.33733.51148.46400@cse.unsw.edu.au>
Cc: Theodore Tso <tytso@mit.edu>, jack@suse.cz, 20@madingley.org,
       marcel@holtmann.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
In-Reply-To: message from Andrew Morton on Monday July 24
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>
	<17600.30372.397971.955987@cse.unsw.edu.au>
	<20060721170627.4cbea27d.akpm@osdl.org>
	<20060722131759.GC7321@thunk.org>
	<20060724185604.9181714c.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 24, akpm@osdl.org wrote:
> 
> <then looks at ext2>

Yeh.... this patch is somewhat different to the others, yet similar...

I didn't bother changing ext2_get_inode at all, but just defined a
get_dentry export_op so that bad inode numbers never get to
ext2_get_inode via nfsd.

So in this case I had to test for the upper bound as well as the lower
bound.

Putting it another way,
 ext3_get_dentry reject certain inums that are known to be a problem.
 ext2_get_dentry allows only those inums that could possibly be ok.

So if you (anyone) prefer one approach over the other, making the
change so they both fs take the same approach would be trivial.

Compile tested only

NeilBrown


------------------------------------
Have ext2 reject file handles with bad inode numbers early.

This prevents bad inode numbers from triggering errors in
ext2_get_inode.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/ext2/super.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff .prev/fs/ext2/super.c ./fs/ext2/super.c
--- .prev/fs/ext2/super.c	2006-07-25 12:29:10.000000000 +1000
+++ ./fs/ext2/super.c	2006-07-25 12:31:04.000000000 +1000
@@ -251,6 +251,20 @@ static struct super_operations ext2_sops
 #endif
 };
 
+static struct dentry *ext2_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+
+	if (ino != EXT2_ROOT_INO && ino < EXT2_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	return export_iget(sb, ino, generation);
+}
+
 /* Yes, most of these are left as NULL!!
  * A NULL value implies the default, which works with ext2-like file
  * systems, but can be improved upon.
@@ -258,6 +272,7 @@ static struct super_operations ext2_sops
  */
 static struct export_operations ext2_export_ops = {
 	.get_parent = ext2_get_parent,
+	.get_dentry = ext2_get_dentry,
 };
 
 static unsigned long get_sb_block(void **data)
