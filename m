Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRANNRb>; Sun, 14 Jan 2001 08:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRANNRM>; Sun, 14 Jan 2001 08:17:12 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:19572
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132655AbRANNRI>; Sun, 14 Jan 2001 08:17:08 -0500
Date: Sun, 14 Jan 2001 14:16:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] limit mmap_cache nulling (2.2.19-7)
Message-ID: <20010114141655.C604@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch against 2.2.19-7 adds checks in do_munmap and 
merge_segments to limit the nulling of mmap_cache to the cases where
the cached vma is in the affected area.

Comments?


--- linux-2.2.19-7/mm/mmap.c~	Sun Jan 14 13:43:50 2001
+++ linux-2.2.19-7/mm/mmap.c	Sun Jan 14 14:02:04 2001
@@ -689,8 +689,11 @@
 		kmem_cache_free(vm_area_cachep, extra);
 
 	free_pgtables(mm, prev, addr, addr+len);
+		
+	if (mm->mmap_cache && mm->mmap_cache->vm_start < addr+len 
+	    && mm->mmap_cache->vm_end > addr)
+		mm->mmap_cache = NULL;	/* Kill the cache. */
 
-	mm->mmap_cache = NULL;	/* Kill the cache. */
 	return 0;
 }
 
@@ -867,7 +870,9 @@
 		kmem_cache_free(vm_area_cachep, mpnt);
 		mpnt = prev;
 	}
-	mm->mmap_cache = NULL;		/* Kill the cache. */
+       if (mm->mmap_cache && mm->mmap_cache->vm_start < end_addr 
+           && mm->mmap_cache->vm_end > start_addr)
+	       mm->mmap_cache = NULL;		/* Kill the cache. */
 }
 
 void __init vma_init(void)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Are they taking DDT?
                -- Vice President Dan Quayle asking doctors at a Manhattan
                   AIDS clinic about their treatments of choice, 4/30/92
                   (reported in Esquire, 8/92, and NY Post early May 92)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
