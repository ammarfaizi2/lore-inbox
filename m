Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUFED3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUFED3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 23:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUFED3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 23:29:51 -0400
Received: from holomorphy.com ([207.189.100.168]:52394 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264484AbUFED3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 23:29:49 -0400
Date: Fri, 4 Jun 2004 20:29:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, pj@sgi.com, mikpe@csd.uu.se,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040605032937.GP21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, pj@sgi.com, mikpe@csd.uu.se,
	nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
	hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
	manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
References: <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <20040604112730.534cca55.akpm@osdl.org> <20040604183815.GI21007@holomorphy.com> <20040605025131.GO21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040605025131.GO21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 07:51:31PM -0700, William Lee Irwin III wrote:
> ... and as someone pointed out:
> -		if (!realloc(cpus, 2*upper))
> +		if (!(cpus = realloc(cpus, 2*upper)))

--- nr_cpus.c.orig4	2004-06-04 20:25:36.000000000 -0700
+++ nr_cpus.c	2004-06-04 20:26:08.000000000 -0700
@@ -17,20 +17,24 @@
 
 static int detect_nr_cpus(void)
 {
-	unsigned long *cpus = malloc(sizeof(long));
+	unsigned long *tmp, *cpus = malloc(sizeof(long));
 	size_t upper, middle, lower = sizeof(long);
 	int ret = -ENOMEM;
 
 	if (!cpus)
 		return -ENOMEM;
 	for (upper = lower; getaffinity(0, upper, cpus) < 0; upper *= 2) {
-		if (!(cpus = realloc(cpus, 2*upper)))
+		if (!(tmp = realloc(cpus, 2*upper)))
 			goto out;
+		else
+			cpus = tmp;
 	}
 	while (lower < upper - 1) {
 		middle = (lower + upper)/2;
-		if (!(cpus = realloc(cpus, middle)))
+		if (!(tmp = realloc(cpus, middle)))
 			goto out;
+		else
+			cpus = tmp;
 		if (getaffinity(0, middle, cpus) < 0)
 			lower = middle;
 		else
