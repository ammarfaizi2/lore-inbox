Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263383AbTC2FKy>; Sat, 29 Mar 2003 00:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTC2FKx>; Sat, 29 Mar 2003 00:10:53 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59829 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263383AbTC2FKv>; Sat, 29 Mar 2003 00:10:51 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Date: Sat, 29 Mar 2003 16:21:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16005.11608.478233.424677@notabene.cse.unsw.edu.au>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
       Bill Huey <billh@gnuppy.monkey.org>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
In-Reply-To: message from Thomas Schlichter on Friday March 28
References: <20030327092207.GA1248@gnuppy.monkey.org>
	<20030327200702.A30403@namesys.com>
	<200303281012.26031.schlicht@uni-mannheim.de>
	<200303281157.51743.schlicht@uni-mannheim.de>
X-Mailer: VM 7.13 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 28, schlicht@uni-mannheim.de wrote:
> On Mar 27, 2003 18:07, Oleg Drokin wrote:
> > sb->s_export_op->find_exported_dentry is NULL
> > in reiserfs_decode_fh, well. In fact we never set this field at all.
> > What is supposed to be there, anyway?
> > I guess following patch should fix the problem.
> 
> Yes, it did fix the problem, but now I was not allowed anymore to compile NFS 
> as a module as I need reiserfs to be in the kernel... :-(
> 
> > In fact I guess somebody should put find_exported_dentry() declaration to
> > include/linux/fs.h or something like that.
> > Also absolutely the same problem must exist if you try to export fat 
> filesystem.
> 
> That is true, too. I saw the Oops with a VFAT partition, too
> 
> I just wonder why the code in fs/nfsd/export.c lines 684-687 does not work. 
> This code should set the find_exported_dentry field correctly. But I do not 
> know when this function (exp_export()) is called...
> 

One possibility is that you are using the new nfs-utils 1.0.3, but you
reported the bug before I announced it (though it was in CVS and on
kernel.org by then so maybe...)!
The new code uses a different path to export filesystems which didn't
include the setting of find_exported_dentry.
The following patch should fix that.

If you aren't using 1.0.3, then I am at a loss.  A filesystem can only
be exported via call to exp_export, and that does set
  sb->s_export_op->find_exported_dentry

NeilBrown


 ----------- Diffstat output ------------
 ./fs/nfsd/export.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 4 deletions(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2003-03-28 10:51:35.000000000 +1100
+++ ./fs/nfsd/export.c	2003-03-29 16:14:04.000000000 +1100
@@ -270,6 +270,11 @@ void svc_export_request(struct cache_det
 	(*bpp)[-1] = '\n';
 }
 
+extern struct dentry *
+find_exported_dentry(struct super_block *sb, void *obj, void *parent,
+		     int (*acceptable)(void *context, struct dentry *de),
+		     void *context);
+
 static struct svc_export *svc_export_lookup(struct svc_export *, int);
 int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
@@ -342,6 +347,39 @@ int svc_export_parse(struct cache_detail
 		err = get_int(&mesg, &an_int);
 		if (err) goto out;
 		exp.ex_fsid = an_int;
+
+
+		/* We currently export only dirs and regular files.
+		 * This is what umountd does.
+		 */
+		err = -ENOTDIR;
+		if (!S_ISDIR(nd.dentry->d_inode->i_mode) &&
+		    !S_ISREG(nd.dentry->d_inode->i_mode))
+			goto out;
+
+		err = -EINVAL;
+		/* There are two requirements on a filesystem to be exportable.
+		 * 1:  We must be able to identify the filesystem from a number.
+		 *       either a device number (so FS_REQUIRES_DEV needed)
+		 *       or an FSID number (so NFSEXP_FSID needed).
+		 * 2:  We must be able to find an inode from a filehandle.
+		 *       This means that s_export_op must be set.
+		 */
+		if (!(nd.dentry->d_inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV)) {
+			if (!(exp.ex_flags & NFSEXP_FSID)) {
+				dprintk("exp_export: export of non-dev fs without fsid");
+				goto out;
+			}
+		}
+		if (!nd.dentry->d_inode->i_sb->s_export_op) {
+			dprintk("exp_export: export of invalid fs type.\n");
+			goto out;
+		}
+
+		/* Ok, we can export it */;
+		if (!nd.dentry->d_inode->i_sb->s_export_op->find_exported_dentry)
+			nd.dentry->d_inode->i_sb->s_export_op->find_exported_dentry =
+				find_exported_dentry;
 	}
 
 	expp = svc_export_lookup(&exp, 1);
@@ -594,10 +632,6 @@ static void exp_unhash(struct svc_export
 	svc_expkey_cache.nextcheck = get_seconds();
 }
 	
-extern struct dentry *
-find_exported_dentry(struct super_block *sb, void *obj, void *parent,
-		     int (*acceptable)(void *context, struct dentry *de),
-		     void *context);
 /*
  * Export a file system.
  */
