Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbRACTbC>; Wed, 3 Jan 2001 14:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRACTan>; Wed, 3 Jan 2001 14:30:43 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:46328 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130026AbRACTal>; Wed, 3 Jan 2001 14:30:41 -0500
Date: Wed, 3 Jan 2001 16:59:16 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] dcache 2nd chance replacement
Message-ID: <Pine.LNX.4.21.0101031653100.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I rediffed this trivial patch by Andrea (that went
into 2.2.19-pre5) which adds 2nd chance replacement
to the dentry cache, this should make our dcache
behave a little bit better than the current FIFO.

I know this probably isn't of any help under very low
and very high loads, but it should provide a nice
improvement under medium loads...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- linux-2.4.0-prerelease/include/linux/dcache.h.orig	Wed Jan  3 16:33:43 2001
+++ linux-2.4.0-prerelease/include/linux/dcache.h	Wed Jan  3 16:43:29 2001
@@ -115,6 +115,7 @@
 					 * If this dentry points to a directory, then
 					 * s_nfsd_free_path semaphore will be down
 					 */
+#define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 
 extern spinlock_t dcache_lock;
 
--- linux-2.4.0-prerelease/fs/dcache.c.orig	Wed Jan  3 16:33:09 2001
+++ linux-2.4.0-prerelease/fs/dcache.c	Wed Jan  3 16:43:10 2001
@@ -339,10 +339,18 @@
 
 		if (tmp == &dentry_unused)
 			break;
-		dentry_stat.nr_unused--;
 		list_del_init(tmp);
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
+		/* If the dentry was recently referenced, don't free it. */
+		if (dentry->d_flags & DCACHE_REFERENCED) {
+			dentry->d_flags &= ~DCACHE_REFERENCED;
+			list_add(&dentry->d_lru, &dentry_unused);
+			count--;
+			continue;
+		}
+		dentry_stat.nr_unused--;
+
 		/* Unused dentry with a count? */
 		if (atomic_read(&dentry->d_count))
 			BUG();
@@ -733,6 +741,7 @@
 		}
 		__dget_locked(dentry);
 		spin_unlock(&dcache_lock);
+		dentry->d_flags |= DCACHE_REFERENCED;
 		return dentry;
 	}
 	spin_unlock(&dcache_lock);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
