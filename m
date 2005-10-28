Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVJ1W6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVJ1W6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbVJ1W6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:58:19 -0400
Received: from serv01.siteground.net ([70.85.91.68]:57308 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750799AbVJ1W6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:58:18 -0400
Date: Fri, 28 Oct 2005 15:58:12 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: [was Re: Linux 2.6.14 ] Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
Message-ID: <20051028225812.GA6744@localhost.localdomain>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 05:28:50PM -0700, Linus Torvalds wrote:
> 
>       Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"

(http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=79b95a454bb5c1d9b7287d1016a70885ba3f346c)

Well, Andi's patch here wasn't just a small optimization as the changelog 
suggests. It helped EM64T boxes a great deal.  Just to make sure, I 
reran 2.6.14 with the attached patch and got about 45% better performance 
with iozone Initial write.  This was on a 2 cpu 4 thread SMP Xeon with 8G ram,
with 2 processes performing io to 4G files on a IDE drive.  
Maybe it wouldn't have caused breakage on some AMD boxes if the following
additional check for swiotlb was added.  Can this go into 2.6.15 please?

Thanks,
Kiran

Originally by Andi Kleen.  Patch prevents the block layer from bouncing if 
a hard or soft iommu is present.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.14/include/asm-x86_64/pci.h
===================================================================
--- linux-2.6.14.orig/include/asm-x86_64/pci.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14/include/asm-x86_64/pci.h	2005-10-27 21:42:41.000000000 -0700
@@ -51,9 +51,9 @@
  * this boolean for bounce buffer decisions
  *
  * On AMD64 it mostly equals, but we set it to zero to tell some subsystems
- * that an IOMMU is available.
+ * that a hard or soft IOMMU is available.
  */
-#define PCI_DMA_BUS_IS_PHYS	(no_iommu ? 1 : 0)
+#define PCI_DMA_BUS_IS_PHYS	((no_iommu && !swiotlb) ? 1 : 0)
 
 /*
  * x86-64 always supports DAC, but sometimes it is useful to force
