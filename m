Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272282AbRISWjt>; Wed, 19 Sep 2001 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272793AbRISWjl>; Wed, 19 Sep 2001 18:39:41 -0400
Received: from [195.223.140.107] ([195.223.140.107]:11759 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272282AbRISWjc>;
	Wed, 19 Sep 2001 18:39:32 -0400
Date: Thu, 20 Sep 2001 00:39:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010920003956.X720@athlon.random>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>; from mmokrejs@natur.cuni.cz on Wed, Sep 19, 2001 at 04:21:43PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 04:21:43PM +0200, Martin MOKREJ? wrote:
> Hi,
>   I tried 2.4.10-pre12 and run some mysql big tests (actually
> mysql/tests/fork_big.pl ). And, the load is coming up and down from 17 to
> 6 .... and now, it's 1.7 only and I see in dmesg:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2

Ok, I'm pretty certain I got it, I didn't noticed here because it can be
reproduced only with HIGHMEM and I didn't had time to test highmem yet
(btw, highmem emulation would been enough to reproduce it).

It was really an allocator bug. Totally untested fix appended
but recommended anyways for integration.

Marcelo can you also test it in your workload (feel free to use eepro100
too now).

--- 2.4.10pre11aa1/mm/page_alloc.c.~1~	Tue Sep 18 15:39:50 2001
+++ 2.4.10pre11aa1/mm/page_alloc.c	Thu Sep 20 00:36:11 2001
@@ -369,6 +369,7 @@
 		return NULL;
 	}
 
+ rebalance:
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;
@@ -380,10 +381,13 @@
 			if (!z)
 				break;
 
-			page = rmqueue(z, order);
-			if (page)
-				return page;
+			if (zone_free_pages(z, order) > z->pages_min) {
+				page = rmqueue(z, order);
+				if (page)
+					return page;
+			}
 		}
+		goto rebalance;
 	} else {
 		/* 
 		 * Check that no other task is been killed meanwhile,

Andrea
