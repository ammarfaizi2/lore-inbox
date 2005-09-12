Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVILFB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVILFB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 01:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVILFB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 01:01:29 -0400
Received: from colin.muc.de ([193.149.48.1]:59141 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751167AbVILFB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 01:01:28 -0400
Date: 12 Sep 2005 07:01:22 +0200
Date: Mon, 12 Sep 2005 07:01:22 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <20050912050122.GA3830@muc.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <201750000.1126494444@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201750000.1126494444@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 08:07:25PM -0700, Martin J. Bligh wrote:
> Finally got my damned x440 box back - won't build -mm2 (-mm1 is fine)
> 
> arch/i386/kernel/srat.c:141: #error "MAX_NR_ZONES != 3, chunk_to_zone requires review"
> make[1]: *** [arch/i386/kernel/srat.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 09/11/05-00:57:13 Build the kernel. Failed rc = 2
> 09/11/05-00:57:13 build: kernel build Failed rc = 1
> 09/11/05-00:57:13 command complete: (2) rc=126
> 
> x86_64-dma32.patch:-#define MAX_NR_ZONES                3       /* Sync this wi
> h ZONES_SHIFT */
> x86_64-dma32.patch:-#define ZONES_SHIFT         2       /* ceil(log2(MAX_NR_ZON
> S)) */
> x86_64-dma32.patch:+#define MAX_NR_ZONES                4       /* Sync this wi
> h ZONES_SHIFT */
> x86_64-dma32.patch:+#define ZONES_SHIFT         3       /* ceil(log2(MAX_NR_ZON
> S)) */
> 
> Andi, does that need changing on ia32 as well as x86_64, or are you
> just missing some ifdefs? Looks to me like the rest of the patch is
> specific to x86_64.

It should be a straight forward fix - the new zone is empty on i386.
Ok I reviewed chunk_to_zone and it should be ok with the new empty
zone. So just the appended patch should work. Can you test?

-AndI

Make i386 compile again with fourth DMA32 zone

The code should deal with an additiona empty zone, so fix up the
#error.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/srat.c
===================================================================
--- linux.orig/arch/i386/kernel/srat.c
+++ linux/arch/i386/kernel/srat.c
@@ -137,8 +137,8 @@ static void __init parse_memory_affinity
 		 "enabled and removable" : "enabled" ) );
 }
 
-#if MAX_NR_ZONES != 3
-#error "MAX_NR_ZONES != 3, chunk_to_zone requires review"
+#if MAX_NR_ZONES != 4
+#error "MAX_NR_ZONES != 4, chunk_to_zone requires review"
 #endif
 /* Take a chunk of pages from page frame cstart to cend and count the number
  * of pages in each zone, returned via zones[].



