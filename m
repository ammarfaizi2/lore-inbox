Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTAHAQa>; Tue, 7 Jan 2003 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTAHAQa>; Tue, 7 Jan 2003 19:16:30 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:17287 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267598AbTAHAQ1>; Tue, 7 Jan 2003 19:16:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Olaf Kirch <okir@suse.de>
Date: Wed, 8 Jan 2003 11:24:39 +1100
Message-ID: <15899.28615.568667.410231@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix NFS IRIX compatibility braindamage
In-Reply-To: message from Olaf Kirch on Monday January 6
References: <200210291208.g9TC8s305165@hera.kernel.org>
	<20030106193320.GD16489@codemonkey.org.uk>
	<20030106195021.GD8269@suse.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 6, okir@suse.de wrote:
> On Mon, Jan 06, 2003 at 07:33:20PM +0000, Dave Jones wrote:
> > I'm going through the old 2.4 changelogs looking for bits that
> > have been missed out, the little one liners have been going
> > direct to Linus/maintainer, but here's the first one I'm
> > unsure of..
> > 
> > Any reason this is missing in 2.5 ?
> 
> I think I sent it to the NFS mailing list and forgot about it
> afterwards.
> 
> The problem this patch tries to address is that the current code allows
> diskless clients to chmod device files, even when the directory is
> exported read-only.

This has been on my list of things to follow up in 2.5 .... for quite
a while.  Thanks for the prompting.

I'll commit to getting an appropriate patch to Linus, probably
something like the following.

Thanks,
NeilBrown


 ----------- Diffstat output ------------
 ./fs/nfsd/nfsproc.c         |    4 ++--
 ./fs/nfsd/vfs.c             |    8 ++++----
 ./include/linux/nfsd/nfsd.h |    3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff ./fs/nfsd/nfsproc.c~current~ ./fs/nfsd/nfsproc.c
--- ./fs/nfsd/nfsproc.c~current~	2003-01-08 11:20:22.000000000 +1100
+++ ./fs/nfsd/nfsproc.c	2003-01-08 11:20:41.000000000 +1100
@@ -250,11 +250,11 @@ nfsd_proc_create(struct svc_rqst *rqstp,
 					/* this is probably a permission check..
 					 * at least IRIX implements perm checking on
 					 *   echo thing > device-special-file-or-pipe
-					 * by does a CREATE with type==0
+					 * by doing a CREATE with type==0
 					 */
 					nfserr = nfsd_permission(newfhp->fh_export,
 								 newfhp->fh_dentry,
-								 MAY_WRITE);
+								 MAY_WRITE|MAY_LOCAL_ACCESS);
 					if (nfserr && nfserr != nfserr_rofs)
 						goto out_unlock;
 				}

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2003-01-08 11:20:51.000000000 +1100
+++ ./fs/nfsd/vfs.c	2003-01-08 11:23:00.000000000 +1100
@@ -1515,11 +1515,11 @@ nfsd_permission(struct svc_export *exp, 
 		inode->i_uid, inode->i_gid, current->fsuid, current->fsgid);
 #endif
 
-	/* only care about readonly exports for files and
-	 * directories. links don't have meaningful write access,
-	 * and all else is local to the client
+	/* Normally we reject any write/sattr etc access on a read-only file
+	 * system.  But if it is IRIX doing check on write-access for a 
+	 * device special file, we ignore rofs.
 	 */
-	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)) 
+	if (!(acc & MAY_LOCAL_ACCESS))
 		if (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC)) {
 			if (EX_RDONLY(exp) || IS_RDONLY(inode))
 				return nfserr_rofs;

diff ./include/linux/nfsd/nfsd.h~current~ ./include/linux/nfsd/nfsd.h
--- ./include/linux/nfsd/nfsd.h~current~	2003-01-08 11:18:25.000000000 +1100
+++ ./include/linux/nfsd/nfsd.h	2003-01-08 11:19:51.000000000 +1100
@@ -38,7 +38,8 @@
 #define MAY_TRUNC		16
 #define MAY_LOCK		32
 #define MAY_OWNER_OVERRIDE	64
-#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
+#define	MAY_LOCAL_ACCESS	128 /* IRIX doing local access check on device special file*/
+#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
 # error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_OWNER_OVERRIDE."
 #endif
 #define MAY_CREATE		(MAY_EXEC|MAY_WRITE)
