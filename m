Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUEaTFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUEaTFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUEaTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 15:05:37 -0400
Received: from scanmail3.cableone.net ([24.116.0.123]:21510 "EHLO
	mail.cableone.net") by vger.kernel.org with ESMTP id S264710AbUEaTF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 15:05:27 -0400
Date: Mon, 31 May 2004 13:05:25 -0600
From: Colin Gibbs <colin@gibbsonline.net>
To: linux-kernel@vger.kernel.org
Subject: nfsd readahead
Message-ID: <20040531190525.GA20916@alpha.gibbsonline.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Server: High Performance Mail Server - http://surgemail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was having problems with slow streaming reads over nfs. After much
investigation, I found that nfsd uses its own cache of readahead
parameters and that:
(1) they were not being reused
(2) they were not being initialized properly

For (1) decrement p_count after the read is done. I don't see any other
users of these readahead parameters, so I guess its ok.

For (2) call file_ra_state_init.

With these changes, I get 35MB/s reads from disk over nfs. Before I got
7MB/s.

The bit with the stats is entirely optional.


Colin

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfsd-readahead.patch"

diff -urN -X diff-exclude linux-2.6.6/fs/nfsd/stats.c monolith-2.6.6/fs/nfsd/stats.c
--- linux-2.6.6/fs/nfsd/stats.c	2004-03-12 01:22:24.000000000 -0700
+++ monolith-2.6.6/fs/nfsd/stats.c	2004-05-27 11:19:51.000000000 -0600
@@ -65,7 +65,7 @@
 
 	/* newline and ra-cache */
 	seq_printf(seq, "\nra %u", nfsdstats.ra_size);
-	for (i=0; i<11; i++)
+	for (i=0; i<12; i++)
 		seq_printf(seq, " %u", nfsdstats.ra_depth[i]);
 	seq_putc(seq, '\n');
 	
diff -urN -X diff-exclude linux-2.6.6/fs/nfsd/vfs.c monolith-2.6.6/fs/nfsd/vfs.c
--- linux-2.6.6/fs/nfsd/vfs.c	2004-04-29 22:46:44.000000000 -0600
+++ monolith-2.6.6/fs/nfsd/vfs.c	2004-05-27 13:06:26.000000000 -0600
@@ -564,8 +564,10 @@
 static spinlock_t ra_lock = SPIN_LOCK_UNLOCKED;
 
 static inline struct raparms *
-nfsd_get_raparms(dev_t dev, ino_t ino)
+nfsd_get_raparms(struct file *file)
 {
+	dev_t dev = file->f_dentry->d_inode->i_sb->s_dev;
+	ino_t ino = file->f_dentry->d_inode->i_ino;
 	struct raparms	*ra, **rap, **frap = NULL;
 	int depth = 0;
 
@@ -579,6 +581,7 @@
 	}
 	depth = nfsdstats.ra_size*11/10;
 	if (!frap) {	
+		nfsdstats.ra_depth[11]++;
 		spin_unlock(&ra_lock);
 		return NULL;
 	}
@@ -586,7 +589,7 @@
 	ra = *frap;
 	ra->p_dev = dev;
 	ra->p_ino = ino;
-	memset(&ra->p_ra, 0, sizeof(ra->p_ra));
+	file_ra_state_init(&ra->p_ra, file->f_mapping);
 found:
 	if (rap != &raparm_cache) {
 		*rap = ra->p_next;
@@ -658,7 +661,7 @@
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
+	ra = nfsd_get_raparms(&file);
 	if (ra)
 		file.f_ra = ra->p_ra;
 
@@ -674,8 +677,12 @@
 	}
 
 	/* Write back readahead params */
-	if (ra)
+	if (ra) {
+		spin_lock(&ra_lock);
 		ra->p_ra = file.f_ra;
+		ra->p_count--;
+		spin_unlock(&ra_lock);
+	}
 
 	if (err >= 0) {
 		nfsdstats.io_read += err;
diff -urN -X diff-exclude linux-2.6.6/include/linux/nfsd/stats.h monolith-2.6.6/include/linux/nfsd/stats.h
--- linux-2.6.6/include/linux/nfsd/stats.h	2003-11-26 13:43:37.000000000 -0700
+++ monolith-2.6.6/include/linux/nfsd/stats.h	2004-05-27 11:20:56.000000000 -0600
@@ -25,7 +25,7 @@
 					 * of available threads were in use */
 	unsigned int	th_fullcnt;	/* number of times last free thread was used */
 	unsigned int	ra_size;	/* size of ra cache */
-	unsigned int	ra_depth[11];	/* number of times ra entry was found that deep
+	unsigned int	ra_depth[12];	/* number of times ra entry was found that deep
 					 * in the cache (10percentiles). [10] = not found */
 };
 

--uAKRQypu60I7Lcqm--
