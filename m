Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTENEhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTENEhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:37:04 -0400
Received: from holomorphy.com ([66.224.33.161]:29120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261188AbTENEg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:36:56 -0400
Date: Tue, 13 May 2003 21:49:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: gibbs@scsiguy.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <20030514044934.GC29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	gibbs@scsiguy.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahc_linux_map_seg() has several style and compile-time issues:

(1) if (sizeof(bus_addr_t) > 4 && ...) linewraps oddly
(2) ~0xFFFFFFFF is always 0; the check for being above 4GB never succeeds
(3) 0x100000000 overflows int and hence vanishes, causing a compile error
	on gcc-3.3 and effectively being identical to its replacement here
(4) constants describing the upper byte of the length are not used
(5) return is a keyword, not a function
(6) uint32_t used instead of u32 (contrary to Linux conventions)
(7) it's randomly panicking in a driver; at least complain in a comment

This is basically a compilefix for axel@pearbough.net's compile failure,
with some added cleanup. (2) should cause data corruption on x440,
NUMA-Q, and ES7000 almost every time this is called, so I guess this
qualifies as a runtime bugfix too. Oddly, I'm not seeing any even on
64GB NUMA-Q, so it's probably bouncing due to some other bug.

For the connoisseur, I've attached before/after disassemblies
demonstrating that the if () whose failure is caused by (2) is a very,
very, very real problem. In order to isolate the code, I uninlined
ahc_linux_map_seg() so the code could be isolated from the rest of
everything. It's clear well over half the function was missing before.
Also note the calls to panic() are made by jmps to the end of the
function. This is 5f in the -'s, and f3 in the +'s. i.e. you can
very easily tell from the disassembly that one of the panic()'s is
missing, i.e. the if () in question is compiled out.


--- ../disasm.old	2003-05-13 21:24:42.000000000 -0700
+++ ../disasm.new	2003-05-13 21:24:23.000000000 -0700
@@ -1,38 +1,80 @@
 <ahc_linux_map_seg>:
 55                   	push   %ebp
 89 e5                	mov    %esp,%ebp
-83 ec 10             	sub    $0x10,%esp
-89 75 f8             	mov    %esi,0xfffffff8(%ebp)
-8b 55 14             	mov    0x14(%ebp),%edx
-8b 75 0c             	mov    0xc(%ebp),%esi
+83 ec 14             	sub    $0x14,%esp
 89 5d f4             	mov    %ebx,0xfffffff4(%ebp)
-8b 4d 18             	mov    0x18(%ebp),%ecx
-8b 5d 1c             	mov    0x1c(%ebp),%ebx
+8b 55 0c             	mov    0xc(%ebp),%edx
+8b 5d 14             	mov    0x14(%ebp),%ebx
+89 75 f8             	mov    %esi,0xfffffff8(%ebp)
+8b 75 18             	mov    0x18(%ebp),%esi
 89 7d fc             	mov    %edi,0xfffffffc(%ebp)
-8b 7d 10             	mov    0x10(%ebp),%edi
-8b 46 34             	mov    0x34(%esi),%eax
+8b 7d 1c             	mov    0x1c(%ebp),%edi
+8b 42 34             	mov    0x34(%edx),%eax
 40                   	inc    %eax
 3d 80 00 00 00       	cmp    $0x80,%eax
-77 36                	ja     c02654ef <ahc_linux_map_seg+0x5f>
-89 17                	mov    %edx,(%edi)
-8b 46 20             	mov    0x20(%esi),%eax
-01 58 0c             	add    %ebx,0xc(%eax)
+0f 87 c9 00 00 00    	ja     c0265583 <ahc_linux_map_seg+0xf3>
+c7 45 f0 01 00 00 00 	movl   $0x1,0xfffffff0(%ebp)
+8b 45 10             	mov    0x10(%ebp),%eax
+89 18                	mov    %ebx,(%eax)
+8b 55 0c             	mov    0xc(%ebp),%edx
+8b 42 20             	mov    0x20(%edx),%eax
+01 78 0c             	add    %edi,0xc(%eax)
 8b 45 08             	mov    0x8(%ebp),%eax
 f6 80 17 01 00 00 01 	testb  $0x1,0x117(%eax)
-74 0d                	je     c02654da <ahc_linux_map_seg+0x4a>
-0f ac ca 08          	shrd   $0x8,%ecx,%edx
-89 d0                	mov    %edx,%eax
+0f 84 8e 00 00 00    	je     c026556d <ahc_linux_map_seg+0xdd>
+89 f2                	mov    %esi,%edx
+89 d8                	mov    %ebx,%eax
+c1 ea 1e             	shr    $0x1e,%edx
+0f ac f0 1e          	shrd   $0x1e,%esi,%eax
+83 fa 00             	cmp    $0x0,%edx
+77 71                	ja     c0265560 <ahc_linux_map_seg+0xd0>
+83 f8 03             	cmp    $0x3,%eax
+77 6c                	ja     c0265560 <ahc_linux_map_seg+0xd0>
+89 f8                	mov    %edi,%eax
+31 d2                	xor    %edx,%edx
+01 d8                	add    %ebx,%eax
+11 f2                	adc    %esi,%edx
+83 c0 ff             	add    $0xffffffff,%eax
+83 d2 ff             	adc    $0xffffffff,%edx
+0f ac d0 1e          	shrd   $0x1e,%edx,%eax
+c1 ea 1e             	shr    $0x1e,%edx
+83 fa 00             	cmp    $0x0,%edx
+77 05                	ja     c0265513 <ahc_linux_map_seg+0x83>
+83 f8 03             	cmp    $0x3,%eax
+76 4d                	jbe    c0265560 <ahc_linux_map_seg+0xd0>
+c7 04 24 66 57 31 c0 	movl   $0xc0315766,(%esp,1)
+e8 11 d8 eb ff       	call   c0122d30 <printk>
+8b 55 0c             	mov    0xc(%ebp),%edx
+8b 42 34             	mov    0x34(%edx),%eax
+83 c0 02             	add    $0x2,%eax
+3d 80 00 00 00       	cmp    $0x80,%eax
+77 54                	ja     c0265583 <ahc_linux_map_seg+0xf3>
+c7 45 f0 02 00 00 00 	movl   $0x2,0xfffffff0(%ebp)
+8b 45 10             	mov    0x10(%ebp),%eax
+89 da                	mov    %ebx,%edx
+0f ac f2 08          	shrd   $0x8,%esi,%edx
+81 c2 00 00 00 01    	add    $0x1000000,%edx
+81 e2 00 00 00 7f    	and    $0x7f000000,%edx
+c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
+89 d8                	mov    %ebx,%eax
+f7 d8                	neg    %eax
+29 c7                	sub    %eax,%edi
+09 d0                	or     %edx,%eax
+8b 55 10             	mov    0x10(%ebp),%edx
+89 42 0c             	mov    %eax,0xc(%edx)
+0f ac f3 08          	shrd   $0x8,%esi,%ebx
+89 d8                	mov    %ebx,%eax
 25 00 00 00 7f       	and    $0x7f000000,%eax
-09 c3                	or     %eax,%ebx
-89 5f 04             	mov    %ebx,0x4(%edi)
+09 c7                	or     %eax,%edi
+8b 45 10             	mov    0x10(%ebp),%eax
+89 78 04             	mov    %edi,0x4(%eax)
+8b 45 f0             	mov    0xfffffff0(%ebp),%eax
 8b 5d f4             	mov    0xfffffff4(%ebp),%ebx
-b8 01 00 00 00       	mov    $0x1,%eax
 8b 75 f8             	mov    0xfffffff8(%ebp),%esi
 8b 7d fc             	mov    0xfffffffc(%ebp),%edi
 89 ec                	mov    %ebp,%esp
 5d                   	pop    %ebp
 c3                   	ret    
-c7 04 24 80 38 32 c0 	movl   $0xc0323880,(%esp,1)
-e8 75 cf eb ff       	call   c0122470 <panic>
+c7 04 24 00 39 32 c0 	movl   $0xc0323900,(%esp,1)
+e8 e1 ce eb ff       	call   c0122470 <panic>
 90                   	nop    
-8d 74 26 00          	lea    0x0(%esi,1),%esi

Applies cleanly to 2.5.69-bk8 and/or current bk.


-- wli

diff -prauN linux-2.5.69-bk8-1/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.5.69-bk8-2/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.5.69-bk8-1/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-13 17:26:56.000000000 -0700
+++ linux-2.5.69-bk8-2/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-13 20:22:22.000000000 -0700
@@ -744,18 +744,20 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
 		      "Increase AHC_NSEG\n");
 
 	consumed = 1;
-	sg->addr = ahc_htole32(addr & 0xFFFFFFFF);
+	sg->addr = ahc_htole32((u32)addr);
 	scb->platform_data->xfer_len += len;
-	if (sizeof(bus_addr_t) > 4
-	 && (ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+	if (sizeof(bus_addr_t) > 4 &&
+			(ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
 		/*
-		 * Due to DAC restrictions, we can't
-		 * cross a 4GB boundary.
+		 * Due to DAC restrictions, we can't cross 4GB boundaries.
+		 * Right shift by 30 to find GB-granularity placement
+		 * without getting tripped up by anal compilers.
 		 */
-		if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
+		if ((addr >> 30) < 4 && ((addr + len - 1) >> 30) >= 4) {
 			struct	 ahc_dma_seg *next_sg;
-			uint32_t next_len;
+			u32 next_len;
 
+			/* somebody clean this up to return an error */
 			printf("Crossed Seg\n");
 			if ((scb->sg_count + 2) > AHC_NSEG)
 				panic("Too few segs for dma mapping.  "
@@ -764,15 +766,25 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
 			consumed++;
 			next_sg = sg + 1;
 			next_sg->addr = 0;
-			next_len = 0x100000000 - (addr & 0xFFFFFFFF);
+
+			/*
+			 * 2's complement arithmetic assumed.
+			 * We want: 4GB - low 32 bits of addr
+			 * to find the length of the low segment
+			 * and to subtract it out from the high
+			 */
+			next_len = -((u32)addr);
 			len -= next_len;
-			next_len |= ((addr >> 8) + 0x1000000) & 0x7F000000;
+
+			/* c.f. struct ahc_dma_seg for meaning of high byte */
+			next_len |= ((addr >> 8) + AHC_SG_LEN_MASK + 1)
+						& AHC_SG_HIGH_ADDR_MASK;
 			next_sg->len = ahc_htole32(next_len);
 		}
-		len |= (addr >> 8) & 0x7F000000;
+		len |= (addr >> 8) & AHC_SG_HIGH_ADDR_MASK;
 	}
 	sg->len = ahc_htole32(len);
-	return (consumed);
+	return consumed;
 }
 
 /************************  Host template entry points *************************/
