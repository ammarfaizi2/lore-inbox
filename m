Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbRACTmy>; Wed, 3 Jan 2001 14:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbRACTmo>; Wed, 3 Jan 2001 14:42:44 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15610 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130475AbRACTm2>; Wed, 3 Jan 2001 14:42:28 -0500
Date: Wed, 3 Jan 2001 17:11:38 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
In-Reply-To: <Pine.LNX.4.10.10101031103440.7739-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101031709010.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Linus Torvalds wrote:
> On Wed, 3 Jan 2001, Rik van Riel wrote:
> > 
> > I rediffed this trivial patch by Andrea (that went
> > into 2.2.19-pre5) which adds 2nd chance replacement
> > to the dentry cache, this should make our dcache
> > behave a little bit better than the current FIFO.
> 
> Looks ok, but I'd be happier if the
> 
> 	dentry->d_flags |= DCACHE_REFERENCED;
> 
> line would be inside the dcache lock (ie just move it up a line). 

OK, here's a new patch ;)

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
+++ linux-2.4.0-prerelease/fs/dcache.c	Wed Jan  3 17:10:50 2001
@@ -339,10 +339,17 @@
 
 		if (tmp == &dentry_unused)
 			break;
-		dentry_stat.nr_unused--;
 		list_del_init(tmp);
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
+		/* If the dentry was recently referenced, don't free it. */
+		if (dentry->d_flags & DCACHE_REFERENCED) {
+			dentry->d_flags &= ~DCACHE_REFERENCED;
+			list_add(&dentry->d_lru, &dentry_unused);
+			continue;
+		}
+		dentry_stat.nr_unused--;
+
 		/* Unused dentry with a count? */
 		if (atomic_read(&dentry->d_count))
 			BUG();
@@ -732,6 +739,7 @@
 				continue;
 		}
 		__dget_locked(dentry);
+		dentry->d_flags |= DCACHE_REFERENCED;
 		spin_unlock(&dcache_lock);
 		return dentry;
 	}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
