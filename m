Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbUKJE1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUKJE1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUKJE1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:27:05 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:6077 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261873AbUKJE0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:26:55 -0500
Message-ID: <419197EA.9090809@cyberone.com.au>
Date: Wed, 10 Nov 2004 15:24:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Schmidt <zaphodb@zaphods.net>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel
 2.6.9 Multiple Page Allocation Failures
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net>
In-Reply-To: <20041110020327.GE20754@zaphods.net>
Content-Type: multipart/mixed;
 boundary="------------080307060904030302030206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307060904030302030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Stefan Schmidt wrote:

>On Tue, Nov 09, 2004 at 05:39:20PM -0800, Andrew Morton wrote:
>
>>Well you've definitely used up all the memory which is available for atomic
>>allocations.  Are you using an increased /proc/sys/vm/min_free_kbytes there?
>>
>Yes, vm.min_free_kbytes=8192.
>For other vm-settings find sysctl.conf attached.
>
>Netdev: tg3 BCM5704r03, TSO off, ~32kpps rx, ~35kpps tx, ~2 rx errors/s
>
>
>>As for the application collapse: dunno.  Maybe networking broke.  It would
>>be interesting to test Linus's current tree, at
>>ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.10-rc1-bk19.gz
>>
>Will try that tomorrow. Would you suggest printing out show_free_areas();
>there too? I don't know what kind of an overhead that will generate on
>subsequent stack traces.
>
>

Stefan,
Can you try the following patch, please? It is diffed against 2.6.10-rc1,
but I think it should apply to -mm kernels as well.

Basically 2.6.8 and earlier kernels had some quirks in the page allocator
that would allow for example, a large portion of "DMA" memory to be reserved
for network memory allocations (atomic allocations). After 'fixing' this
problem, 2.6.9 is effectively left with about a quarter the amount of memory
reserved for network allocations compared with 2.6.8.

The following patch roughly restores parity there. Thanks.

Nick


--------------080307060904030302030206
Content-Type: text/x-patch;
 name="mm-restore-atomic-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-restore-atomic-buffer.patch"




---

 linux-2.6-npiggin/mm/page_alloc.c |   41 +++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff -puN mm/page_alloc.c~mm-restore-atomic-buffer mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~mm-restore-atomic-buffer	2004-11-10 15:13:33.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-11-10 14:57:54.000000000 +1100
@@ -1935,8 +1935,12 @@ static void setup_per_zone_pages_min(voi
 			                   lowmem_pages;
 		}
 
-		zone->pages_low = zone->pages_min * 2;
-		zone->pages_high = zone->pages_min * 3;
+		/*
+		 * When interpreting these watermarks, just keep in mind that:
+		 * zone->pages_min == (zone->pages_min * 4) / 4;
+		 */
+		zone->pages_low   = (zone->pages_min * 5) / 4;
+		zone->pages_high  = (zone->pages_min * 6) / 4;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 }
@@ -1945,24 +1949,25 @@ static void setup_per_zone_pages_min(voi
  * Initialise min_free_kbytes.
  *
  * For small machines we want it small (128k min).  For large machines
- * we want it large (16MB max).  But it is not linear, because network
+ * we want it large (64MB max).  But it is not linear, because network
  * bandwidth does not increase linearly with machine size.  We use
  *
- *	min_free_kbytes = sqrt(lowmem_kbytes)
+ * 	min_free_kbytes = 4 * sqrt(lowmem_kbytes), for better accuracy:
+ *	min_free_kbytes = sqrt(lowmem_kbytes * 16)
  *
  * which yields
  *
- * 16MB:	128k
- * 32MB:	181k
- * 64MB:	256k
- * 128MB:	362k
- * 256MB:	512k
- * 512MB:	724k
- * 1024MB:	1024k
- * 2048MB:	1448k
- * 4096MB:	2048k
- * 8192MB:	2896k
- * 16384MB:	4096k
+ * 16MB:	512k
+ * 32MB:	724k
+ * 64MB:	1024k
+ * 128MB:	1448k
+ * 256MB:	2048k
+ * 512MB:	2896k
+ * 1024MB:	4096k
+ * 2048MB:	5792k
+ * 4096MB:	8192k
+ * 8192MB:	11584k
+ * 16384MB:	16384k
  */
 static int __init init_per_zone_pages_min(void)
 {
@@ -1970,11 +1975,11 @@ static int __init init_per_zone_pages_mi
 
 	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
 
-	min_free_kbytes = int_sqrt(lowmem_kbytes);
+	min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
 	if (min_free_kbytes < 128)
 		min_free_kbytes = 128;
-	if (min_free_kbytes > 16384)
-		min_free_kbytes = 16384;
+	if (min_free_kbytes > 65536)
+		min_free_kbytes = 65536;
 	setup_per_zone_pages_min();
 	setup_per_zone_protection();
 	return 0;

_

--------------080307060904030302030206--
