Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVG2Ipu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVG2Ipu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVG2Ipr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:45:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56517 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262514AbVG2Ipg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:45:36 -0400
Date: Fri, 29 Jul 2005 10:44:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729084444.GC7302@elte.hu>
References: <20050728090948.GA24222@elte.hu> <200507281914.j6SJErg31398@unix-os.sc.intel.com> <20050729070447.GA3032@elte.hu> <20050729070702.GA3327@elte.hu> <42E9E91B.9050403@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9E91B.9050403@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> Please test that len is a constant, or else the inlining is too large 
> for the non constant case.

yeah. fix below.

	Ingo

-----
noticed by Eric Dumazet: unrolling should be dependent on a constant
length, otherwise inlining gets too large.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/prefetch.h |  128 ++++++++++++++++++++++++-----------------------
 1 files changed, 66 insertions(+), 62 deletions(-)

Index: linux-prefetch-task/include/linux/prefetch.h
===================================================================
--- linux-prefetch-task.orig/include/linux/prefetch.h
+++ linux-prefetch-task/include/linux/prefetch.h
@@ -64,37 +64,39 @@ static inline void prefetch_range(void *
 	/*
 	 * Unroll agressively:
 	 */
-	if (len <= PREFETCH_STRIDE)
-		prefetch(cp);
-	else if (len <= 2*PREFETCH_STRIDE) {
-		prefetch(cp);
-		prefetch(cp + PREFETCH_STRIDE);
-	}
-	else if (len <= 3*PREFETCH_STRIDE) {
-		prefetch(cp);
-		prefetch(cp + PREFETCH_STRIDE);
-		prefetch(cp + 2*PREFETCH_STRIDE);
-	}
-	else if (len <= 4*PREFETCH_STRIDE) {
-		prefetch(cp);
-		prefetch(cp + PREFETCH_STRIDE);
-		prefetch(cp + 2*PREFETCH_STRIDE);
-		prefetch(cp + 3*PREFETCH_STRIDE);
-	}
-	else if (len <= 5*PREFETCH_STRIDE) {
-		prefetch(cp);
-		prefetch(cp + PREFETCH_STRIDE);
-		prefetch(cp + 2*PREFETCH_STRIDE);
-		prefetch(cp + 3*PREFETCH_STRIDE);
-		prefetch(cp + 4*PREFETCH_STRIDE);
-	}
-	else if (len <= 6*PREFETCH_STRIDE) {
-		prefetch(cp);
-		prefetch(cp + PREFETCH_STRIDE);
-		prefetch(cp + 2*PREFETCH_STRIDE);
-		prefetch(cp + 3*PREFETCH_STRIDE);
-		prefetch(cp + 4*PREFETCH_STRIDE);
-		prefetch(cp + 5*PREFETCH_STRIDE);
+	if (__builtin_constant_p(len) && (len <= 6*PREFETCH_STRIDE)) {
+		if (len <= PREFETCH_STRIDE)
+			prefetch(cp);
+		else if (len <= 2*PREFETCH_STRIDE) {
+			prefetch(cp);
+			prefetch(cp + PREFETCH_STRIDE);
+		}
+		else if (len <= 3*PREFETCH_STRIDE) {
+			prefetch(cp);
+			prefetch(cp + PREFETCH_STRIDE);
+			prefetch(cp + 2*PREFETCH_STRIDE);
+		}
+		else if (len <= 4*PREFETCH_STRIDE) {
+			prefetch(cp);
+			prefetch(cp + PREFETCH_STRIDE);
+			prefetch(cp + 2*PREFETCH_STRIDE);
+			prefetch(cp + 3*PREFETCH_STRIDE);
+		}
+		else if (len <= 5*PREFETCH_STRIDE) {
+			prefetch(cp);
+			prefetch(cp + PREFETCH_STRIDE);
+			prefetch(cp + 2*PREFETCH_STRIDE);
+			prefetch(cp + 3*PREFETCH_STRIDE);
+			prefetch(cp + 4*PREFETCH_STRIDE);
+		}
+		else if (len <= 6*PREFETCH_STRIDE) {
+			prefetch(cp);
+			prefetch(cp + PREFETCH_STRIDE);
+			prefetch(cp + 2*PREFETCH_STRIDE);
+			prefetch(cp + 3*PREFETCH_STRIDE);
+			prefetch(cp + 4*PREFETCH_STRIDE);
+			prefetch(cp + 5*PREFETCH_STRIDE);
+		}
 	} else
 		for (; cp < end; cp += PREFETCH_STRIDE)
 			prefetch(cp);
@@ -110,37 +112,39 @@ static inline void prefetchw_range(void 
 	/*
 	 * Unroll agressively:
 	 */
-	if (len <= PREFETCH_STRIDE)
-		prefetchw(cp);
-	else if (len <= 2*PREFETCH_STRIDE) {
-		prefetchw(cp);
-		prefetchw(cp + PREFETCH_STRIDE);
-	}
-	else if (len <= 3*PREFETCH_STRIDE) {
-		prefetchw(cp);
-		prefetchw(cp + PREFETCH_STRIDE);
-		prefetchw(cp + 2*PREFETCH_STRIDE);
-	}
-	else if (len <= 4*PREFETCH_STRIDE) {
-		prefetchw(cp);
-		prefetchw(cp + PREFETCH_STRIDE);
-		prefetchw(cp + 2*PREFETCH_STRIDE);
-		prefetchw(cp + 3*PREFETCH_STRIDE);
-	}
-	else if (len <= 5*PREFETCH_STRIDE) {
-		prefetchw(cp);
-		prefetchw(cp + PREFETCH_STRIDE);
-		prefetchw(cp + 2*PREFETCH_STRIDE);
-		prefetchw(cp + 3*PREFETCH_STRIDE);
-		prefetchw(cp + 4*PREFETCH_STRIDE);
-	}
-	else if (len <= 6*PREFETCH_STRIDE) {
-		prefetchw(cp);
-		prefetchw(cp + PREFETCH_STRIDE);
-		prefetchw(cp + 2*PREFETCH_STRIDE);
-		prefetchw(cp + 3*PREFETCH_STRIDE);
-		prefetchw(cp + 4*PREFETCH_STRIDE);
-		prefetchw(cp + 5*PREFETCH_STRIDE);
+	if (__builtin_constant_p(len) && (len <= 6*PREFETCH_STRIDE)) {
+		if (len <= PREFETCH_STRIDE)
+			prefetchw(cp);
+		else if (len <= 2*PREFETCH_STRIDE) {
+			prefetchw(cp);
+			prefetchw(cp + PREFETCH_STRIDE);
+		}
+		else if (len <= 3*PREFETCH_STRIDE) {
+			prefetchw(cp);
+			prefetchw(cp + PREFETCH_STRIDE);
+			prefetchw(cp + 2*PREFETCH_STRIDE);
+		}
+		else if (len <= 4*PREFETCH_STRIDE) {
+			prefetchw(cp);
+			prefetchw(cp + PREFETCH_STRIDE);
+			prefetchw(cp + 2*PREFETCH_STRIDE);
+			prefetchw(cp + 3*PREFETCH_STRIDE);
+		}
+		else if (len <= 5*PREFETCH_STRIDE) {
+			prefetchw(cp);
+			prefetchw(cp + PREFETCH_STRIDE);
+			prefetchw(cp + 2*PREFETCH_STRIDE);
+			prefetchw(cp + 3*PREFETCH_STRIDE);
+			prefetchw(cp + 4*PREFETCH_STRIDE);
+		}
+		else if (len <= 6*PREFETCH_STRIDE) {
+			prefetchw(cp);
+			prefetchw(cp + PREFETCH_STRIDE);
+			prefetchw(cp + 2*PREFETCH_STRIDE);
+			prefetchw(cp + 3*PREFETCH_STRIDE);
+			prefetchw(cp + 4*PREFETCH_STRIDE);
+			prefetchw(cp + 5*PREFETCH_STRIDE);
+		}
 	} else
 		for (; cp < end; cp += PREFETCH_STRIDE)
 			prefetchw(cp);
