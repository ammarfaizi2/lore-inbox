Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRIBXS2>; Sun, 2 Sep 2001 19:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270269AbRIBXST>; Sun, 2 Sep 2001 19:18:19 -0400
Received: from mons.uio.no ([129.240.130.14]:45278 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S270224AbRIBXR7>;
	Sun, 2 Sep 2001 19:17:59 -0400
MIME-Version: 1.0
Message-ID: <15250.48673.742037.730692@charged.uio.no>
Date: Mon, 3 Sep 2001 01:17:53 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: NFS client bug
In-Reply-To: <E15dfb7-0000Vd-00@the-village.bc.nu>
In-Reply-To: <E15dfb7-0000Vd-00@the-village.bc.nu>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > [remove CD, insert original CD]

     > 	ls

     > 	[stale NFS file handle - cached on client - wrong]

     > It then gets more bizarre

     > 	cd /mnt/cdrom/somedir

     > 	[Looks ok a new filehandle, works ok] ls [Immediate stale NFS
     > 	file handle from client - no traffic]

     > It seems this 'dead' handle remains stuck in the system until
     > umount.

Yes. We normally mark inodes permanently as being stale as a mechanism
to avoid problems with the unfsd server. The latter can actually reuse
both the inode number *and* the filehandle, thus making it impossible
to tell which file you are writing to.

Normally, we arrange for the inode to be sent to the great /dev/null
in the sky via 'remove_inode_hash()' in nfs_revalidate_inode(),
however the whole mechanism will not (and should for obvious reasons
not) apply to the root inode.

The appended patch has been available for some time on my WWW site,
and was in fact sent both to Linus & the L-K list several months
ago. It failed to make 'top priority' on my list of resends simply due
to the issues with mmap writes. Now that the latter has been settled,
I can start pestering Linus & you with this one again. ;-)

Cheers,
   Trond

diff -u --recursive --new-file linux-2.4.6-mmap/fs/nfs/inode.c linux-2.4.6-stale/fs/nfs/inode.c
--- linux-2.4.6-mmap/fs/nfs/inode.c	Wed Jul  4 20:48:01 2001
+++ linux-2.4.6-stale/fs/nfs/inode.c	Wed Jul  4 21:06:57 2001
@@ -662,7 +662,7 @@
 	if ((fattr->mode & S_IFMT) != (inode->i_mode & S_IFMT))
 		return 1;
 
-	if (is_bad_inode(inode))
+	if (is_bad_inode(inode) || NFS_STALE(inode))
 		return 1;
 
 	/* Has the filehandle changed? If so is the old one stale? */
@@ -863,24 +863,22 @@
 int
 __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
-	int		 status = 0;
+	int		 status = -ESTALE;
 	struct nfs_fattr fattr;
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%x/%Ld)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode));
 
 	lock_kernel();
-	if (!inode || is_bad_inode(inode) || NFS_STALE(inode)) {
-		unlock_kernel();
-		return -ESTALE;
-	}
+	if (!inode || is_bad_inode(inode))
+ 		goto out_nowait;
+	if (NFS_STALE(inode) && inode != inode->i_sb->s_root->d_inode)
+ 		goto out_nowait;
 
 	while (NFS_REVALIDATING(inode)) {
 		status = nfs_wait_on_inode(inode, NFS_INO_REVALIDATING);
-		if (status < 0) {
-			unlock_kernel();
-			return status;
-		}
+		if (status < 0)
+			goto out_nowait;
 		if (time_before(jiffies,NFS_READTIME(inode)+NFS_ATTRTIMEO(inode))) {
 			status = NFS_STALE(inode) ? -ESTALE : 0;
 			goto out_nowait;
@@ -894,7 +892,8 @@
 			 inode->i_dev, (long long)NFS_FILEID(inode), status);
 		if (status == -ESTALE) {
 			NFS_FLAGS(inode) |= NFS_INO_STALE;
-			remove_inode_hash(inode);
+			if (inode != inode->i_sb->s_root->d_inode)
+				remove_inode_hash(inode);
 		}
 		goto out;
 	}
@@ -907,6 +906,8 @@
 	}
 	dfprintk(PAGECACHE, "NFS: (%x/%Ld) revalidation complete\n",
 		inode->i_dev, (long long)NFS_FILEID(inode));
+
+	NFS_FLAGS(inode) &= ~NFS_INO_STALE;
 out:
 	NFS_FLAGS(inode) &= ~NFS_INO_REVALIDATING;
 	wake_up(&inode->i_wait);

