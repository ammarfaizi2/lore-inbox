Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRAJU5h>; Wed, 10 Jan 2001 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRAJU5S>; Wed, 10 Jan 2001 15:57:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:3161
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129933AbRAJU5K>; Wed, 10 Jan 2001 15:57:10 -0500
Date: Wed, 10 Jan 2001 21:57:01 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [uPATCH] Nulling mmap_cache iff needed (2.4.0)
Message-ID: <20010110215701.D971@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following (trivial) patch against 2.4.0 (but should apply cleanly
against 241p1) makes do_munmap only null our precious cache if the
pointer contained therein is invalidated by the unmapping. I doubt it
will make any measurable difference but it seems straightforward
enough to be done anyway.

Running kernel compiles and starting X/gnome with this patch raises my 
cache hit rate a couple of percentage points, and I have a feeling that
there might be work loads out there that hit this kernel path more often
that these.

Comments?


diff -aur linux-2.4.0-clean/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.0-clean/mm/mmap.c	Sat Dec 30 18:35:19 2000
+++ linux/mm/mmap.c	Tue Jan  9 23:30:03 2001
@@ -712,7 +712,10 @@
 		if (mm->mmap_avl)
 			avl_remove(mpnt, &mm->mmap_avl);
 	}
-	mm->mmap_cache = NULL;	/* Kill the cache. */
+	if (mm->mmap_cache && mm->mmap_cache->vm_start < addr+len 
+	    && mm->mmap_cache->vm_end > addr)
+		mm->mmap_cache = NULL;	/* Kill the cache. */
+
 	spin_unlock(&mm->page_table_lock);
 
 	/* Ok - we have the memory areas we should free on the 'free' list,


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"It's like an Alcatraz around my neck."
-Boston mayor Menino on the shortage of city parking spaces
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
