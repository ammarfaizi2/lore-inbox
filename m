Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVERWqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVERWqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVERWqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:46:19 -0400
Received: from everest.sosdg.org ([66.93.203.161]:45758 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262347AbVERWo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:44:29 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Thu, 19 May 2005 06:44:15 +0800
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20050518224415.GA5768@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: f4a2161a70e9ca874377242522da36ff
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] time_after_eq fix
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The two macros time_after and time_after_eq were added to do wrapping
correctly, but only time_after does it the right way, time_after_eq has
been wrong since the very beginning(v2.1.127, 07-Nov-1998).  Now this
patch fixes it.

And I don't agree with the the original code comment. I don't think this
is gcc's fault.  If it is "a good compiler" or "a really good compiler",
trying to be smarter than human, it wouldn't still be a C compiler.
So I'd like it be removed.

Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>
---

 jiffies.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -pruN 2.6.12-rc4-mm2/include/linux/jiffies.h 2.6.12-rc4-mm2-cy/include/linux/jiffies.h
--- 2.6.12-rc4-mm2/include/linux/jiffies.h	2005-03-03 17:12:13.000000000 +0800
+++ 2.6.12-rc4-mm2-cy/include/linux/jiffies.h	2005-05-19 05:32:52.000000000 +0800
@@ -102,9 +102,7 @@ static inline u64 get_jiffies_64(void)
  *
  * time_after(a,b) returns true if the time a is after time b.
  *
- * Do this with "<0" and ">=0" to only test the sign of the result. A
- * good compiler would generate better code (and a really good compiler
- * wouldn't care). Gcc is currently neither.
+ * Do this with "<0" and "<=0" to only test the sign of the result.
  */
 #define time_after(a,b)		\
 	(typecheck(unsigned long, a) && \
@@ -115,7 +113,7 @@ static inline u64 get_jiffies_64(void)
 #define time_after_eq(a,b)	\
 	(typecheck(unsigned long, a) && \
 	 typecheck(unsigned long, b) && \
-	 ((long)(a) - (long)(b) >= 0))
+	 ((long)(b) - (long)(a) <= 0))
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
 /*
