Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVG2HMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVG2HMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVG2HJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:09:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13757 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262055AbVG2HHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:07:21 -0400
Date: Fri, 29 Jul 2005 09:07:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729070702.GA3327@elte.hu>
References: <20050728090948.GA24222@elte.hu> <200507281914.j6SJErg31398@unix-os.sc.intel.com> <20050729070447.GA3032@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729070447.GA3032@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Sorry, this is not enough.  Switch stack on ia64 is 528 bytes.  We 
> > need to prefetch 5 lines.  It probably should use prefetch_range().  
> 
> ok, how about the additional patch below? Does this do the trick on 
> ia64? It makes complete sense on every architecture to prefetch from 
> below the current kernel stack, in the expectation of the next task 
> touching the stack. The only difference is that for ia64 the 'expected 
> minimum stack footprint' is larger, due to the switch_stack.

the patch below unrolls the prefetch_range() loop manually, for up to 5 
cachelines prefetched. This patch, ontop of the 4 previous patches, 
should generate similar code to the assembly code in your original 
patch. The full patch-series is:

 patches/prefetch-next.patch
 patches/prefetch-mm.patch
 patches/prefetch-kstack-size.patch
 patches/prefetch-unroll.patch

	Ingo

---------
unroll prefetch_range() loops manually.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/prefetch.h |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

Index: linux/include/linux/prefetch.h
===================================================================
--- linux.orig/include/linux/prefetch.h
+++ linux/include/linux/prefetch.h
@@ -58,11 +58,38 @@ static inline void prefetchw(const void 
 static inline void prefetch_range(void *addr, size_t len)
 {
 #ifdef ARCH_HAS_PREFETCH
-	char *cp;
+	char *cp = addr;
 	char *end = addr + len;
 
-	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
+	/*
+	 * Unroll agressively:
+	 */
+	if (len <= PREFETCH_STRIDE)
 		prefetch(cp);
+	else if (len <= 2*PREFETCH_STRIDE) {
+		prefetch(cp);
+		prefetch(cp + PREFETCH_STRIDE);
+	}
+	else if (len <= 3*PREFETCH_STRIDE) {
+		prefetch(cp);
+		prefetch(cp + PREFETCH_STRIDE);
+		prefetch(cp + 2*PREFETCH_STRIDE);
+	}
+	else if (len <= 4*PREFETCH_STRIDE) {
+		prefetch(cp);
+		prefetch(cp + PREFETCH_STRIDE);
+		prefetch(cp + 2*PREFETCH_STRIDE);
+		prefetch(cp + 3*PREFETCH_STRIDE);
+	}
+	else if (len <= 5*PREFETCH_STRIDE) {
+		prefetch(cp);
+		prefetch(cp + PREFETCH_STRIDE);
+		prefetch(cp + 2*PREFETCH_STRIDE);
+		prefetch(cp + 3*PREFETCH_STRIDE);
+		prefetch(cp + 4*PREFETCH_STRIDE);
+	} else
+		for (; cp < end; cp += PREFETCH_STRIDE)
+			prefetch(cp);
 #endif
 }
 
