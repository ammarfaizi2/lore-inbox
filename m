Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVAUWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVAUWGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVAUWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:05:41 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17098 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262531AbVAUV4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:56:55 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: device-mapper: fix TB stripe data corruption
Date: Fri, 21 Jan 2005 15:57:38 -0600
User-Agent: KMail/1.7.1
Cc: Roland Dreier <roland@topspin.com>, Benjamin LaHaise <bcrl@kvack.org>,
       Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <20050121181203.GI10195@agk.surrey.redhat.com> <200501211512.45524.kevcorry@us.ibm.com> <52651qqy1s.fsf@topspin.com>
In-Reply-To: <52651qqy1s.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211557.38764.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 3:20 pm, Roland Dreier wrote:
>     Kevin> We have to take a mod of the chunk value and the number of
>     Kevin> stripes (which can be a non-power-of-2, so a shift won't
>     Kevin> work). It's been my understanding that you couldn't mod a
>     Kevin> 64-bit value with a 32-bit value in the kernel.
>
> If I understand you correctly, do_div() (defined in <asm/div64.h>)
> does what you need.  Look at asm-generic/div64.h for a good
> description of the precise semantics of do_div().

Thanks for the tip, Roland. That seems to be exactly what we needed.  Here's a 
different version of Alasdair's patch that changes chunk to 64-bit and uses 
do_div().

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


In stripe_map(), change chunk to 64-bit and use do_div to divide and mod by
the number of stripes.

--- diff/drivers/md/dm-stripe.c 2005-01-21 15:55:02.093379864 -0600
+++ source/drivers/md/dm-stripe.c 2005-01-21 15:54:25.400957960 -0600
@@ -173,9 +173,8 @@
  struct stripe_c *sc = (struct stripe_c *) ti->private;
 
  sector_t offset = bio->bi_sector - ti->begin;
- uint32_t chunk = (uint32_t) (offset >> sc->chunk_shift);
- uint32_t stripe = chunk % sc->stripes; /* 32bit modulus */
- chunk = chunk / sc->stripes;
+ sector_t chunk = offset >> sc->chunk_shift;
+ uint32_t stripe = do_div(chunk, sc->stripes);
 
  bio->bi_bdev = sc->stripe[stripe].dev->bdev;
  bio->bi_sector = sc->stripe[stripe].physical_start +
@@ -210,7 +209,7 @@
 
 static struct target_type stripe_target = {
  .name   = "striped",
- .version= {1, 0, 1},
+ .version= {1, 0, 2},
  .module = THIS_MODULE,
  .ctr    = stripe_ctr,
  .dtr    = stripe_dtr,
