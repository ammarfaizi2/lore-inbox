Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131941AbRBDPdE>; Sun, 4 Feb 2001 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131959AbRBDPcz>; Sun, 4 Feb 2001 10:32:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:37617 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131941AbRBDPcl>; Sun, 4 Feb 2001 10:32:41 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Mathias.Froehlich@gmx.net
Subject: [patch] make tmpfs_statfs more user friendly
From: Christoph Rohland <cr@sap.com>
Message-ID: <m31ytemq7u.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Feb 2001 16:37:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The following patch make shmem_statfs report some sensible size
estimates in the case that the user does not give a size limit.

This should make it more error prone when used as /tmp

Greetings
                Christoph

diff -uNr 2.4.1-tmpfs/mm/shmem.c 2.4.1-tmpfs-fstat/mm/shmem.c
--- 2.4.1-tmpfs/mm/shmem.c	Sun Feb  4 16:08:57 2001
+++ 2.4.1-tmpfs-fstat/mm/shmem.c	Sun Feb  4 16:09:50 2001
@@ -696,13 +696,20 @@
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sb->u.shmem_sb.stat_lock);
-	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
-	    sb->u.shmem_sb.max_inodes != ULONG_MAX) {
+	if (sb->u.shmem_sb.max_blocks == ULONG_MAX) {
+		/*
+		 * This is only a guestimate and not honoured.
+		 * We need it to make some programs happy which like to
+		 * test the free space of a file system.
+		 */
+		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);
+		buf->f_blocks = buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks;
+	} else {
 		buf->f_blocks = sb->u.shmem_sb.max_blocks;
 		buf->f_bavail = buf->f_bfree = sb->u.shmem_sb.free_blocks;
-		buf->f_files = sb->u.shmem_sb.max_inodes;
-		buf->f_ffree = sb->u.shmem_sb.free_inodes;
 	}
+	buf->f_files = sb->u.shmem_sb.max_inodes;
+	buf->f_ffree = sb->u.shmem_sb.free_inodes;
 	spin_unlock (&sb->u.shmem_sb.stat_lock);
 	buf->f_namelen = 255;
 	return 0;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
