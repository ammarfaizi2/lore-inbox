Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTENFwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 01:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTENFw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 01:52:29 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:11277 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S261923AbTENFw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 01:52:26 -0400
Date: Wed, 14 May 2003 00:05:04 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: axel@pearbough.net
Subject: Re: drivers/scsi/aic7xxx/aic7xxx_osm.c: warning is error
Message-ID: <493702704.1052892304@aslan.scsiguy.com>
In-Reply-To: <20030514031826.GB29926@holomorphy.com>
References: <20030514004009.GA20914@neon.pearbough.net> <20030514031826.GB29926@holomorphy.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't reproduce this with gcc-3.2; does this do better?
> 
> I also removed some extremely fishy arithmetic in a check for crossing
> 4GB boundaries; I hope you don't mind.

I mind.  The replacement code is still wrong.

>  
>  	consumed = 1;
> -	sg->addr = ahc_htole32(addr & 0xFFFFFFFF);
> +	sg->addr = ahc_htole32(addr & ~0U);

This assumes that an unsigned int is 32bits.  The old code assumed
that a long is at least 32bits.  Constants are promoted up to long
if they will not fit in an int.

>  	scb->platform_data->xfer_len += len;
> -	if (sizeof(bus_addr_t) > 4
> -	 && (ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
> +	if (sizeof(bus_addr_t) > 4 &&
> +			(ahc->flags & AHC_39BIT_ADDRESSING) != 0) {

Superfluous style change.  The original style is intended and you will
see that this style is consistently used throughout the driver.

>  		/*
> -		 * Due to DAC restrictions, we can't
> -		 * cross a 4GB boundary.
> +		 * Due to DAC restrictions, we can't cross 4GB boundaries.
> +		 * Right shift by 30 to find GB-granularity placement
> +		 * without getting tripped up by anal compilers.
>  		 */
> -		if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
> +		if ((addr >> 30) < 4 && ((addr + len - 1) >> 30) >= 4) {

What happens if the starting address is 0x00000070XXXXXXXX?  We cannot
cross any 4GB boundary in the entire 64bit address space.  The previous
code did that with the exception that the constant must be promoted
to ULL:

		if ((addr ^ (addr + len - 1)) & 0xFFFFFFFF00000000ULL) {

In other words, the high 32bits of the starting and ending address had 
better be the same (x ^ x == 0).

> @@ -764,12 +766,22 @@ ahc_linux_map_seg(struct ahc_softc *ahc,
>  			consumed++;
>  			next_sg = sg + 1;
>  			next_sg->addr = 0;
> -			next_len = 0x100000000 - (addr & 0xFFFFFFFF);
> +
> +			/*
> +			 * 2's complement arithmetic assumed.
> +			 * We want: 4GB - low 32 bits of addr
> +			 * to find the length of the low segment
> +			 * and to subtract it out from the high
> +			 */
> +			next_len = -((uint32_t)addr);
>  			len -= next_len;

This still leaves a bug. next_len and len are reversed.  I also feel
that the previous code, if properly promoted, is clearer.  There is no
need for a comment and the compiler should do the same truncation as
is performed in the above code.

> -			next_len |= ((addr >> 8) + 0x1000000) & 0x7F000000;
> +
> +			/* c.f. struct ahc_dma_seg for meaning of high byte */
> +			next_len |= ((addr >> 8) + AHC_SG_LEN_MASK + 1)
> +						& AHC_SG_HIGH_ADDR_MASK;

Using (AHC_SG_LEN_MASK + 1) to mean 4GB >> 8 is not a way to make the
code more readable.

My patch for these issues follows.  A more formal BK submission will
follow tomorrow.

Comments have indicated since the 2.4.X days that Linux will never allocate
segments that cross a 4GB boundary.  If this is truely enforced, then this
code can just be removed.  It was only added out of paranoia (hence the
printf) while adding high address support to the driver.

--
Justin

==== //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c#222 (text+ko) -
//depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c#224 (text+ko) ==== content
@@ -751,12 +751,14 @@
 	scb->platform_data->xfer_len += len;
 	if (sizeof(bus_addr_t) > 4
 	 && (ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+
 		/*
 		 * Due to DAC restrictions, we can't
 		 * cross a 4GB boundary.
 		 */
-		if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
+		if ((addr ^ (addr + len - 1)) & 0xFFFFFFFF00000000ULL) {
 			struct	 ahc_dma_seg *next_sg;
+			uint32_t first_len;
 			uint32_t next_len;
 
 			printf("Crossed Seg\n");
@@ -767,12 +769,14 @@
 			consumed++;
 			next_sg = sg + 1;
 			next_sg->addr = 0;
-			next_len = 0x100000000 - (addr & 0xFFFFFFFF);
-			len -= next_len;
-			next_len |= ((addr >> 8) + 0x1000000) & 0x7F000000;
+			first_len = 0x100000000ULL - (addr & 0xFFFFFFFF);
+			next_len = len - first_len;
+			len = first_len;
+			next_len |=
+			    ((addr >> 8) + 0x1000000) & AHC_SG_HIGH_ADDR_MASK;
 			next_sg->len = ahc_htole32(next_len);
 		}
-		len |= (addr >> 8) & 0x7F000000;
+		len |= (addr >> 8) & AHC_SG_HIGH_ADDR_MASK;
 	}
 	sg->len = ahc_htole32(len);
 	return (consumed);
==== //depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic79xx_osm.c#161 (text+ko) -
//depot/aic7xxx/linux/drivers/scsi/aic7xxx/aic79xx_osm.c#163 (text+ko) ==== content
@@ -761,8 +761,9 @@
 		 * Due to DAC restrictions, we can't
 		 * cross a 4GB boundary.
 		 */
-		if ((addr ^ (addr + len - 1)) & ~0xFFFFFFFF) {
+		if ((addr ^ (addr + len - 1)) & 0xFFFFFFFF00000000ULL) {
 			struct	 ahd_dma_seg *next_sg;
+			uint32_t first_len;
 			uint32_t next_len;
 
 			printf("Crossed Seg\n");
@@ -773,12 +774,14 @@
 			consumed++;
 			next_sg = sg + 1;
 			next_sg->addr = 0;
-			next_len = 0x100000000 - (addr & 0xFFFFFFFF);
-			len -= next_len;
-			next_len |= ((addr >> 8) + 0x1000000) & 0x7F000000;
+			first_len = 0x100000000ULL - (addr & 0xFFFFFFFF);
+			next_len = len - first_len;
+			len = next_len;
+			next_len |=
+			    ((addr >> 8) + 0x1000000) & AHD_SG_HIGH_ADDR_MASK;
 			next_sg->len = ahd_htole32(next_len);
 		}
-		len |= (addr >> 8) & 0x7F000000;
+		len |= (addr >> 8) & AHD_SG_HIGH_ADDR_MASK;
 	}
 	sg->len = ahd_htole32(len);
 	return (consumed);

