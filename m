Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWJFEGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWJFEGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWJFEGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:06:44 -0400
Received: from mga03.intel.com ([143.182.124.21]:52761 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751773AbWJFEGn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:06:43 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,268,1157353200"; 
   d="scan'208"; a="127627019:sNHT30440116"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Fri, 6 Oct 2006 08:06:37 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F42E0@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Thread-Index: AcboxorD06NiddCQR26uQ96xmASQjwANhYaQ
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <tim.c.chen@linux.intel.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Oct 2006 04:06:42.0431 (UTC) FILETIME=[D4AF78F0:01C6E8FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apparently due to the access to the
> newly-added static variable.

The cache miss was increased as a result of instructions reordering but
not due to the newly-added static variable. The original patch have
added local but not static variable. Newly-added local variable compiler
has placed in register.
The original patch made reordering of tests-register-and-jump and
test-memory-and-jump instructions. That was a side effect of the patch.
To watch closely ordering of 'if (a && b)' or 'if (b && a)' becomes more
weight than 'unlikely()' using if 'a' is in register and 'b' is in
memory. I would say: unlikely() cost is 10:1; ordering cost is 1000:1.

Leonid 

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Friday, October 06, 2006 1:38 AM
To: Ananiev, Leonid I
Cc: tim.c.chen@linux.intel.com; Jeremy Fitzhardinge;
herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression


So how's this look?

I worry a bit that someone's hardware might go and prefetch that static
variable even when we didn't ask it to.  Can that happen?




Tim and Ananiev report that the recent WARN_ON_ONCE changes cause
increased
cache misses with the tbench workload.  Apparently due to the access to
the
newly-added static variable.

Rearrange the code so that we don't touch that variable unless the
warning is
going to trigger.

Also rework the logic so that the static variable starts out at zero, so
we
can move it into bss.

It would seem logical to mark the static variable as __read_mostly too.
But
it would be wrong, because that would put it back into the vmlinux
image, and
the kernel will never read from this variable in normal operation
anyway. 
Unless the compiler or hardware go and do some prefetching on us?

For some reason this patch shrinks softirq.o text by 40 bytes.

Cc: Tim Chen <tim.c.chen@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-generic/bug.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN include/asm-generic/bug.h~fix-warn_on--warn_on_once-regression
include/asm-generic/bug.h
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
+#define WARN_ON_ONCE(condition)	({
\
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
