Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWJEViI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWJEViI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWJEViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:38:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932237AbWJEViF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:38:05 -0400
Date: Thu, 5 Oct 2006 14:37:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: <tim.c.chen@linux.intel.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061005143748.2f6594a2.akpm@osdl.org>
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So how's this look?

I worry a bit that someone's hardware might go and prefetch that static
variable even when we didn't ask it to.  Can that happen?




Tim and Ananiev report that the recent WARN_ON_ONCE changes cause increased
cache misses with the tbench workload.  Apparently due to the access to the
newly-added static variable.

Rearrange the code so that we don't touch that variable unless the warning is
going to trigger.

Also rework the logic so that the static variable starts out at zero, so we
can move it into bss.

It would seem logical to mark the static variable as __read_mostly too.  But
it would be wrong, because that would put it back into the vmlinux image, and
the kernel will never read from this variable in normal operation anyway. 
Unless the compiler or hardware go and do some prefetching on us?

For some reason this patch shrinks softirq.o text by 40 bytes.

Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-generic/bug.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN include/asm-generic/bug.h~fix-warn_on--warn_on_once-regression include/asm-generic/bug.h
--- a/include/asm-generic/bug.h~fix-warn_on--warn_on_once-regression
+++ a/include/asm-generic/bug.h
@@ -41,14 +41,14 @@
 #endif
 #endif
 
-#define WARN_ON_ONCE(condition)	({			\
-	static int __warn_once = 1;			\
-	typeof(condition) __ret_warn_once = (condition);\
-							\
-	if (likely(__warn_once))			\
-		if (WARN_ON(__ret_warn_once)) 		\
-			__warn_once = 0;		\
-	unlikely(__ret_warn_once);			\
+#define WARN_ON_ONCE(condition)	({				\
+	static int __warned;					\
+	typeof(condition) __ret_warn_once = (condition);	\
+								\
+	if (unlikely(__ret_warn_once))				\
+		if (WARN_ON(!__warned)) 			\
+			__warned = 1;				\
+	unlikely(__ret_warn_once);				\
 })
 
 #ifdef CONFIG_SMP
_

