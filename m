Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274240AbRISWpj>; Wed, 19 Sep 2001 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274238AbRISWp3>; Wed, 19 Sep 2001 18:45:29 -0400
Received: from [195.223.140.107] ([195.223.140.107]:30703 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274240AbRISWpV>;
	Wed, 19 Sep 2001 18:45:21 -0400
Date: Thu, 20 Sep 2001 00:45:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shane Wegner <shane@cm.nu>
Cc: Martin MOKREJ? <mmokrejs@natur.cuni.cz>, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010920004543.Z720@athlon.random>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919153441.A30940@cm.nu>; from shane@cm.nu on Wed, Sep 19, 2001 at 03:34:41PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:34:41PM -0700, Shane Wegner wrote:
> Hi,
> 
> I'm getting the same thing here.  At least it looks similar
> though I'm not sure what's causing it.  Dual PIII 850, 1gb
							 ^^^ perfect
> ram, 300mb swap.
> 
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> c012e052
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> c012e052
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> c012e052

yes, please try this fix and let me know if it helps:

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
