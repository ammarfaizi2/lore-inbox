Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbQLHAvg>; Thu, 7 Dec 2000 19:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQLHAvZ>; Thu, 7 Dec 2000 19:51:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11626 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130886AbQLHAvN>; Thu, 7 Dec 2000 19:51:13 -0500
Date: Fri, 8 Dec 2000 01:20:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre25
Message-ID: <20001208012052.A23992@inspiron.random>
In-Reply-To: <E1447Fx-0002vA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1447Fx-0002vA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 07, 2000 at 08:03:00PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 08:03:00PM +0000, Alan Cox wrote:
> 
> Ok we believe the VM crash looping printing error messages is now fixed.

Such bug can't generate crashes. Did you ever reproduced crashes on your 8Mb
486 with 2.2.18pre24?

> Marcelo finally figured it out and my 8Mb 486 has been running 2.2.18pre
> with that fix and stably[1].

diff -urN 2.2.18pre24/mm/filemap.c 2.2.18pre25/mm/filemap.c
--- 2.2.18pre24/mm/filemap.c	Wed Nov 29 19:28:29 2000
+++ 2.2.18pre25/mm/filemap.c	Fri Dec  8 00:41:45 2000
@@ -220,8 +220,10 @@
 			 * throttling.
 			 */
 
-			if (!try_to_free_buffers(page, wait))
+			if (!try_to_free_buffers(page, wait)) { 
+				if(--count < 0) break;
 				goto refresh_clock;
+			}
 			return 1;
 		}
 
ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre24aa1/00_account-failed-buffer-tries-1

--- 2.2.17pre19/mm/filemap.c	Tue Aug 22 14:54:13 2000
+++ /tmp/filemap.c	Thu Aug 24 01:05:50 2000
@@ -179,6 +179,8 @@
 		if ((gfp_mask & __GFP_DMA) && !PageDMA(page))
 			continue;
 
+		count--;
+
 		/*
 		 * Is it a page swap page? If so, we want to
 		 * drop it if it is no longer used, even if it
@@ -224,7 +226,7 @@
 			return 1;
 		}
 
-	} while (--count > 0);
+	} while (count > 0);
 	return 0;
 }
 
lftp> pwd
ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.17pre19
								 ^^^^^^^^^^^
lftp> ls -l account-failed-buffer-tries-1 
-rw-r--r--   1 korg     korg          407 Sep  5 22:43 account-failed-buffer-tries-1
					  ^^^^^^
lftp> 

Only difference is that pre25 keeps decreasing `count' for locked, mapped and
out-of-zone pages and that means it will still fail to shrink the cache when it
looks at the unlucky part of the physical memory while the
account-failed-buffer-tries-1 intentionally doesn't decrease `count' in that
cases to avoid failing in such unlucky cases.

account-failed-buffer-tries-1 is included in VM-global-7 and it was
described in the 2.2.18pre21aa2 email to l-k (CC'ed you) in date Fri, 17 Nov
2000 18:54:43 +0100:

[..]
00_account-failed-buffer-tries-1

        Account also the failed buffer tries during shrink_mmap. (me)  
        (this is included in the VM-global that I maintain against vanilla
        2.2.x btw)
[..]

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
