Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130429AbQKYAZM>; Fri, 24 Nov 2000 19:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130439AbQKYAZC>; Fri, 24 Nov 2000 19:25:02 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:23286 "EHLO
        tytlal.z.streaker.org") by vger.kernel.org with ESMTP
        id <S130429AbQKYAYy>; Fri, 24 Nov 2000 19:24:54 -0500
Date: Fri, 24 Nov 2000 15:28:31 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001124152831.A5696@valinux.com>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Nov 20, 2000 at 11:38:38AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Rik van Riel:
> Luckily my patch fixes some of the suspect areas in
> VM-global [...]

Would you say that the below patch is just the try_to_free_pages
bug fix, then?

Index: mm/vmscan.c
--- mm/vmscan.c.prev
+++ mm/vmscan.c	Fri Nov 24 15:17:59 2000
@@ -401,4 +401,5 @@ int try_to_free_pages(unsigned int gfp_m
 	int priority;
 	int count = SWAP_CLUSTER_MAX;
+	int loopcount = count;
 	int killed = 0;
 
@@ -409,5 +410,5 @@ int try_to_free_pages(unsigned int gfp_m
 
 again:
-	priority = 5;
+	priority = 6;
 	do {
 		while (shrink_mmap(priority, gfp_mask)) {
@@ -431,5 +432,10 @@ again:
 
 		shrink_dcache_memory(priority, gfp_mask);
-	} while (--priority > 0);
+
+		/* Only lower priority if we didn't make progress. */
+		if (count == loopcount)
+			--priority;
+		loopcount = count;
+	} while (priority > 0);
 done:
 	unlock_kernel();
@@ -454,6 +460,9 @@ done:
 	}
 
-	/* Return success if we freed a page. */
-	return priority > 0;
+	/* Return success if we have enough free memory or we freed a page. */
+	if (nr_free_pages > freepages.low)
+		return 1;
+
+	return count < SWAP_CLUSTER_MAX;
 }
 

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
