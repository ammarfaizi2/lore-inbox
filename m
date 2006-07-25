Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWGYCV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWGYCV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWGYCV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:21:59 -0400
Received: from ns.suse.de ([195.135.220.2]:39041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932407AbWGYCV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:21:59 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 12:21:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17605.32781.909741.310735@cse.unsw.edu.au>
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
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 24, akpm@osdl.org wrote:
> On Sat, 22 Jul 2006 09:17:59 -0400
> Theodore Tso <tytso@mit.edu> wrote:
> > The net of all of this is the inode validity test should be:
> > 
> >  	(ino >= EXT3_FIRST_INO(sb)) && (ino <= ...->s_inodes_count))
> 
> I agree; I made that change.
> 

Yeh, my bad.  I double checked the second comparison but not the first
:-(

> > However, I would suggest that we *not* allow remote NFS users to get
> > access to the journal inode or the resize inode, please?  That's only
> > going to cause mischief of the DoS attack kind.....  
> 
> <looks at Neil>

See, I had a funny feeling that someone was watching me ....

I doubt there is much room for a real problem here.  
To get to the point of IO on any of these files, you would need root
access to the whole filesystem anyway.

The follow patch should do what is suggested though.

> 
> <then looks at ext2>

Hmmm. are two looks allowed in the same email?

NeilBrown

----------------------------
Make ext3 reject filehandles referring to special files.

Inodes earlier than the 'first' inode (e.g. journal,
resize) should be rejected early - except the root inode.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/exportfs/expfs.c |    4 +++-
 ./fs/ext3/super.c     |   15 +++++++++++++++
 ./include/linux/fs.h  |    2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff .prev/fs/exportfs/expfs.c ./fs/exportfs/expfs.c
--- .prev/fs/exportfs/expfs.c	2006-07-25 12:19:21.000000000 +1000
+++ ./fs/exportfs/expfs.c	2006-07-25 12:16:12.000000000 +1000
@@ -392,7 +392,8 @@ out:
 }
 
 
-static struct dentry *export_iget(struct super_block *sb, unsigned long ino, __u32 generation)
+struct dentry *export_iget(struct super_block *sb, unsigned long ino,
+			   __u32 generation)
 {
 
 	/* iget isn't really right if the inode is currently unallocated!!
@@ -434,6 +435,7 @@ static struct dentry *export_iget(struct
 	}
 	return result;
 }
+EXPORT_SYMBOL_GPL(export_iget);
 
 
 static struct dentry *get_object(struct super_block *sb, void *vobjp)

diff .prev/fs/ext3/super.c ./fs/ext3/super.c
--- .prev/fs/ext3/super.c	2006-07-25 12:19:21.000000000 +1000
+++ ./fs/ext3/super.c	2006-07-25 12:19:43.000000000 +1000
@@ -554,6 +554,20 @@ static int ext3_show_options(struct seq_
 	return 0;
 }
 
+
+static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+
+	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+
+	return export_iget(sb, ino, generation);
+}
+
+
 #ifdef CONFIG_QUOTA
 #define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
 #define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
@@ -622,6 +636,7 @@ static struct super_operations ext3_sops
 
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {

diff .prev/include/linux/fs.h ./include/linux/fs.h
--- .prev/include/linux/fs.h	2006-07-25 12:19:21.000000000 +1000
+++ ./include/linux/fs.h	2006-07-25 12:15:32.000000000 +1000
@@ -1381,6 +1381,8 @@ extern struct dentry *
 find_exported_dentry(struct super_block *sb, void *obj, void *parent,
 		     int (*acceptable)(void *context, struct dentry *de),
 		     void *context);
+struct dentry *export_iget(struct super_block *sb, unsigned long ino,
+			   __u32 generation);
 
 struct file_system_type {
 	const char *name;
