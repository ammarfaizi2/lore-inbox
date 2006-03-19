Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWCSS3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWCSS3T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWCSS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:29:19 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:35222 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751569AbWCSS3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:29:19 -0500
Date: Sun, 19 Mar 2006 19:29:12 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] -mm: Small CFQ I/O sched optimization
Message-ID: <20060319182912.GA28886@rhlx01.fht-esslingen.de>
References: <20060315172422.GA25435@rhlx01.fht-esslingen.de> <20060315185240.GV3595@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315185240.GV3595@suse.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[new patch below]

On Wed, Mar 15, 2006 at 07:52:40PM +0100, Jens Axboe wrote:
> On Wed, Mar 15 2006, Andreas Mohr wrote:

> > During some heavy testing on a single-HDD UP P3/700 my instrumentation showed
> > that case 0 was the *only* thing occurring, no request wrapping ever inside
> > this function.
> > Is that expected behaviour??
> 
> Hmm that does sound a little strange - care to do the same
> instrumentation for 'as' to see if this is just a 'cfq' anomaly?

Indeed, this is CFQ-only, AS gets much less uniform data passed in.


> > +#define CFQ_RQ1_WRAP	0x01 /* request 1 wraps */
> > +#define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */
> 
> Please put these near where they are used, it's a little confusing to
> have to go look for them. They only make sense in cfq_choose_req().

Done.

> >   * Lifted from AS - choose which of crq1 and crq2 that is best served now.
> > - * We choose the request that is closest to the head right now. Distance
> > + * We choose the request that is closest to the head right now. Distances
> >   * behind the head are penalized and only allowed to a certain extent.
> 
> I sort-of prefer 'distance' here, you may want to change that to an 'is'
> though :-)

Right, that's better.


> > +     /* by doing switch() on the bit mask "wrap" we avoid having to
> > +      * check two variables for all permutations: --> faster! */

> Multiple line comments have /* and */ on a separate line.

Oh, indeed, fixed.


> Andrew will ask you to move that 'case' to be lined up with the
> 'switch'.

Done.

Created new CFQ patch plus equivalent patch to AS (which additionally
resolves the "shut up, gcc" part in a more elegant way as used in CFQ).
Also now added a comment about the "both crqs wrapped" case.

Thanks,

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.16-rc6-mm2/block/cfq-iosched.c.orig	2006-03-20 03:14:26.000000000 +0100
+++ linux-2.6.16-rc6-mm2/block/cfq-iosched.c	2006-03-20 00:00:24.000000000 +0100
@@ -362,14 +362,16 @@
 /*
  * Lifted from AS - choose which of crq1 and crq2 that is best served now.
  * We choose the request that is closest to the head right now. Distance
- * behind the head are penalized and only allowed to a certain extent.
+ * behind the head is penalized and only allowed to a certain extent.
  */
 static struct cfq_rq *
 cfq_choose_req(struct cfq_data *cfqd, struct cfq_rq *crq1, struct cfq_rq *crq2)
 {
 	sector_t last, s1, s2, d1 = 0, d2 = 0;
-	int r1_wrap = 0, r2_wrap = 0;	/* requests are behind the disk head */
 	unsigned long back_max;
+#define CFQ_RQ1_WRAP	0x01 /* request 1 wraps */
+#define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */
+	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
 
 	if (crq1 == NULL || crq1 == crq2)
 		return crq2;
@@ -401,35 +403,47 @@
 	else if (s1 + back_max >= last)
 		d1 = (last - s1) * cfqd->cfq_back_penalty;
 	else
-		r1_wrap = 1;
+		wrap |= CFQ_RQ1_WRAP;
 
 	if (s2 >= last)
 		d2 = s2 - last;
 	else if (s2 + back_max >= last)
 		d2 = (last - s2) * cfqd->cfq_back_penalty;
 	else
-		r2_wrap = 1;
+		wrap |= CFQ_RQ2_WRAP;
 
 	/* Found required data */
-	if (!r1_wrap && r2_wrap)
-		return crq1;
-	else if (!r2_wrap && r1_wrap)
-		return crq2;
-	else if (r1_wrap && r2_wrap) {
-		/* both behind the head */
-		if (s1 <= s2)
+
+	/*
+	 * By doing switch() on the bit mask "wrap" we avoid having to
+	 * check two variables for all permutations: --> faster!
+	 */
+	switch (wrap) {
+	case 0: /* common case for CFQ: crq1 and crq2 not wrapped */
+		if (d1 < d2)
 			return crq1;
-		else
+		else if (d2 < d1)
 			return crq2;
-	}
+		else {
+			if (s1 >= s2)
+				return crq1;
+			else
+				return crq2;
+		}
 
-	/* Both requests in front of the head */
-	if (d1 < d2)
+	case CFQ_RQ2_WRAP:
 		return crq1;
-	else if (d2 < d1)
+	case CFQ_RQ1_WRAP:
 		return crq2;
-	else {
-		if (s1 >= s2)
+	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both crqs wrapped */
+	default:
+		/*
+		 * Since both rqs are wrapped,
+		 * start with the one that's further behind head
+		 * (--> only *one* back seek required),
+		 * since back seek takes more time than forward.
+		 */
+		if (s1 <= s2)
 			return crq1;
 		else
 			return crq2;




--- linux-2.6.16-rc6-mm2/block/as-iosched.c.orig	2006-03-20 03:14:21.000000000 +0100
+++ linux-2.6.16-rc6-mm2/block/as-iosched.c	2006-03-19 21:31:28.000000000 +0100
@@ -460,8 +460,11 @@
 as_choose_req(struct as_data *ad, struct as_rq *arq1, struct as_rq *arq2)
 {
 	int data_dir;
-	sector_t last, s1, s2, d1, d2;
-	int r1_wrap=0, r2_wrap=0;	/* requests are behind the disk head */
+	sector_t last, s1, s2, d1 = 0, d2 = 0;
+#define AS_RQ1_WRAP   0x01 /* request 1 wraps */
+#define AS_RQ2_WRAP   0x02 /* request 2 wraps */
+	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
+
 	const sector_t maxback = MAXBACK;
 
 	if (arq1 == NULL || arq1 == arq2)
@@ -486,40 +489,48 @@
 		d1 = s1 - last;
 	else if (s1+maxback >= last)
 		d1 = (last - s1)*BACK_PENALTY;
-	else {
-		r1_wrap = 1;
-		d1 = 0; /* shut up, gcc */
-	}
+	else
+		wrap |= AS_RQ1_WRAP;
 
 	if (s2 >= last)
 		d2 = s2 - last;
 	else if (s2+maxback >= last)
 		d2 = (last - s2)*BACK_PENALTY;
-	else {
-		r2_wrap = 1;
-		d2 = 0;
-	}
+	else
+		wrap |= AS_RQ2_WRAP;
 
 	/* Found required data */
-	if (!r1_wrap && r2_wrap)
-		return arq1;
-	else if (!r2_wrap && r1_wrap)
-		return arq2;
-	else if (r1_wrap && r2_wrap) {
-		/* both behind the head */
-		if (s1 <= s2)
+
+	/*
+	 * By doing switch() on the bit mask "wrap" we avoid having to
+	 * check two variables for all permutations: --> faster!
+	 */
+	switch (wrap) {
+	case 0: /* arq1 and arq2 not wrapped */
+		if (d1 < d2)
 			return arq1;
-		else
+		else if (d2 < d1)
 			return arq2;
-	}
+		else {
+			if (s1 >= s2)
+				return arq1;
+			else
+				return arq2;
+		}
 
-	/* Both requests in front of the head */
-	if (d1 < d2)
+	case AS_RQ2_WRAP:
 		return arq1;
-	else if (d2 < d1)
+	case AS_RQ1_WRAP:
 		return arq2;
-	else {
-		if (s1 >= s2)
+	case (AS_RQ1_WRAP|AS_RQ2_WRAP): /* both arqs wrapped */
+	default:
+		/*
+		 * Since both rqs are wrapped,
+		 * start with the one that's further behind head
+		 * (--> only *one* back seek required),
+		 * since back seek takes more time than forward.
+		 */
+		if (s1 <= s2)
 			return arq1;
 		else
 			return arq2;
