Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282677AbRK0AGb>; Mon, 26 Nov 2001 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282682AbRK0AGW>; Mon, 26 Nov 2001 19:06:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61826 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282677AbRK0AGI>;
	Mon, 26 Nov 2001 19:06:08 -0500
Date: Mon, 26 Nov 2001 16:05:59 -0800 (PST)
Message-Id: <20011126.160559.57441929.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: trond.myklebust@fys.uio.no, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Fix knfsd readahead cache in 2.4.15
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011126.155347.45872112.davem@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
	<15362.53694.192797.275363@esther.cse.unsw.edu.au>
	<20011126.155347.45872112.davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Mon, 26 Nov 2001 15:53:47 -0800 (PST)
   
   There are other problems remaining, this function is a logical
   mess.

Replying to myself, I'd suggest a patch like the following to clear up
all the issues discovered:

--- fs/nfsd/vfs.c.~1~	Sun Oct 21 02:47:53 2001
+++ fs/nfsd/vfs.c	Mon Nov 26 16:03:40 2001
@@ -545,32 +545,43 @@
 static inline struct raparms *
 nfsd_get_raparms(dev_t dev, ino_t ino)
 {
-	struct raparms	*ra, **rap, **frap = NULL;
+	struct raparms	*ra, *fra;
 	int depth = 0;
 	
-	for (rap = &raparm_cache; (ra = *rap); rap = &ra->p_next) {
+	ra = raparm_cache;
+	fra = NULL;
+	do {
 		if (ra->p_ino == ino && ra->p_dev == dev)
 			goto found;
+
 		depth++;
+
 		if (ra->p_count == 0)
-			frap = rap;
-	}
-	depth = nfsdstats.ra_size*11/10;
-	if (!frap)
+			fra = ra;
+
+		ra = ra->p_next;
+	} while (ra != raparm_cache);
+
+	if (!fra)
 		return NULL;
-	rap = frap;
-	ra = *frap;
-	memset(ra, 0, sizeof(*ra));
+
+	ra = fra;
 	ra->p_dev = dev;
 	ra->p_ino = ino;
+	ra->p_reada = 0;
+	ra->p_ramax = 0;
+	ra->p_raend = 0;
+	ra->p_ralen = 0;
+	ra->p_rawin = 0;
+
 found:
-	if (rap != &raparm_cache) {
-		*rap = ra->p_next;
-		ra->p_next   = raparm_cache;
+	if (ra != raparm_cache)
 		raparm_cache = ra;
-	}
+
 	ra->p_count++;
-	nfsdstats.ra_depth[depth*10/nfsdstats.ra_size]++;
+
+	nfsdstats.ra_depth[(depth <= 10 ? depth : 10)]++;
+
 	return ra;
 }
 
@@ -1576,9 +1587,13 @@
 		dprintk("nfsd: allocating %d readahead buffers.\n",
 			cache_size);
 		memset(raparml, 0, sizeof(struct raparms) * cache_size);
+
+		/* Circular list. */
 		for (i = 0; i < cache_size - 1; i++) {
 			raparml[i].p_next = raparml + i + 1;
 		}
+		raparml[i].p_next = raparml;
+
 		raparm_cache = raparml;
 	} else {
 		printk(KERN_WARNING
