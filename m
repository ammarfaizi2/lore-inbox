Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTENDFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 23:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTENDFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 23:05:47 -0400
Received: from holomorphy.com ([66.224.33.161]:60095 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262284AbTENDFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 23:05:44 -0400
Date: Tue, 13 May 2003 20:18:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <20030514031826.GB29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axel@pearbough.net
References: <20030514004009.GA20914@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514004009.GA20914@neon.pearbough.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:40:09AM +0200, axel@pearbough.net wrote:
> today compiled 2.5.69-bk8 with gcc version 3.3 20030510 and a warning in
> drivers/scsi/aic7xxx/aic7xxx_osm.c resulted in an error because of gcc flag
> -Werror.

I can't reproduce this with gcc-3.2; does this do better?

I also removed some extremely fishy arithmetic in a check for crossing
4GB boundaries; I hope you don't mind.


-- wli


diff -prauN linux-2.5.69-bk8-1/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.5.69-bk8-2/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.5.69-bk8-1/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-13 17:26:56.000000000 -0700
+++ linux-2.5.69-bk8-2/drivers/scsi/aic7xxx/aic7xxx_osm.c	2003-05-13 19:56:26.000000000 -0700
@@ -744,18 +744,20 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
 		      "Increase AHC_NSEG\n");
 
 	consumed = 1;
-	sg->addr = ahc_htole32(addr & 0xFFFFFFFF);
+	sg->addr = ahc_htole32(addr & ~0U);
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
 			uint32_t next_len;
 
+			/* somebody clean this up to return an error */
 			printf("Crossed Seg\n");
 			if ((scb->sg_count + 2) > AHC_NSEG)
 				panic("Too few segs for dma mapping.  "
@@ -764,12 +766,22 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
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
+			next_len = -((uint32_t)addr);
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
 	return (consumed);
