Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLPC5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLPC5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVLPC5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:57:16 -0500
Received: from cantor.suse.de ([195.135.220.2]:21666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751247AbVLPC5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:57:15 -0500
From: Neil Brown <neilb@suse.de>
To: Dave Jones <davej@redhat.com>
Date: Fri, 16 Dec 2005 13:56:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17314.11514.650036.686071@cse.unsw.edu.au>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: message from Dave Jones on Thursday December 15
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051215223000.GU23349@stusta.de>
	<20051215231538.GF3419@redhat.com>
	<20051216004740.GV23349@stusta.de>
	<20051216005056.GG3419@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 15, davej@redhat.com wrote:
> On Fri, Dec 16, 2005 at 01:47:40AM +0100, Adrian Bunk wrote:
> 
>  > > [*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
>  > > for a long time -- people were reporting overflows there before we
>  > > enabled 4K stacks.
>  > 
>  > I remember someone from the XFS maintainers (Nathan?) saying they 
>  > believe having solved all XFS stack issues.
>  > 
>  > If there are any XFS issues left, do you have a pointer to them?
> 
> The last one I saw may have been actually been more related
> to the block layer problem. iirc that was a user NFS exporting
> XFS on a raid1 array.

Yeh, I've noticed that nfsd seems to figure often in these.  As nfsd
lives on the same (in-kernel) stack as the filesystem and device
drives, it will add a couple of hundred bytes to the call trace.

A typical nfsd call trace is
 nfsd -> svc_process -> nfsd_dispatch -> nfsd3_proc_write ->
   nfsd_write ->nfsd_vfs_write -> vfs_writev

(errr. nfsd_vfs_write is inline, large, and called twice, that ain't
good)

These add up to over 300 bytes on the stack.
Looking at each of these, I see that nfsd_write (which includes
 nfsd_vfs_write) contributes 0x8c to stack usage itself!!

It turns out this is because it puts a 'struct iattr' on the stack so
it can kill suid if needed.  The following patch saves about 50 bytes
off the stack in this call path.

I sometimes wish that gcc could be told to optimise for stack usage -
a lot of variables on the stack are dead at some call points, yet they
stay there using space anyway.  The only way to save this space seem
to be to move the code which uses those variable into a separate
function, but we really shouldn't *have* to do these optimisations by
hand!

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/vfs.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2005-12-12 16:00:40.000000000 +1100
+++ ./fs/nfsd/vfs.c	2005-12-16 13:48:31.000000000 +1100
@@ -869,6 +869,16 @@ out:
 	return err;
 }
 
+static void kill_suid(struct dentry *dentry)
+{
+	struct iattr	ia;
+	ia.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
+
+	down(&dentry->d_inode->i_sem);
+	notify_change(dentry, &ia);
+	up(&dentry->d_inode->i_sem);
+}
+
 static inline int
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 				loff_t offset, struct kvec *vec, int vlen,
@@ -922,14 +932,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	}
 
 	/* clear setuid/setgid flag after write */
-	if (err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID))) {
-		struct iattr	ia;
-		ia.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
-
-		down(&inode->i_sem);
-		notify_change(dentry, &ia);
-		up(&inode->i_sem);
-	}
+	if (err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID)))
+		kill_suid(dentry);
 
 	if (err >= 0 && stable) {
 		static ino_t	last_ino;
