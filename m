Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946013AbWGOKcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbWGOKcU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 06:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946015AbWGOKcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 06:32:20 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:53519 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1946013AbWGOKcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 06:32:19 -0400
Date: Sat, 15 Jul 2006 20:32:07 +1000
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
Message-ID: <20060715103207.GA17727@gondor.apana.org.au>
References: <20060715002623.GE9334@gondor.apana.org.au> <20060714173517.cdd58097.akpm@osdl.org> <20060715010645.GB11515@gondor.apana.org.au> <20060714.224001.71089810.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714.224001.71089810.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 10:40:01PM -0700, David Miller wrote:
>
> Wouldn't it be cleaner to wrap this unlikely around
> the top-level "({ })"?  When it sits on a line by
> itself it looks strange, that much is true :)

Sure, in fact there was a name clash as well with __ret and
I forgot to update the arch-specific versions.

[PATCH] Let WARN_ON/WARN_ON_ONCE return the condition

Letting WARN_ON/WARN_ON_ONCE return the condition means that you
could do

if (WARN_ON(blah)) {
	handle_impossible_case
}

Rather than

if (unlikely(blah)) {
	WARN_ON(1)
	handle_impossible_case
}

I checked all the newly added WARN_ON_ONCE users and none of them
test the return status so we can still change it.

Signed-off-by: Herbert Xu herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 8ceab7b..672ca90 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -16,12 +16,14 @@ #define BUG_ON(condition) do { if (unlik
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-#define WARN_ON(condition) do { \
-	if (unlikely((condition)!=0)) { \
+#define WARN_ON(condition) unlikely({ \
+	int __ret_warn_on = (condition); \
+	if (unlikely(__ret_warn_on)) { \
 		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
 		dump_stack(); \
 	} \
-} while (0)
+	__ret_warn_on; \
+})
 #endif
 
 #else /* !CONFIG_BUG */
@@ -34,21 +36,19 @@ #define BUG_ON(condition) do { if (condi
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-#define WARN_ON(condition) do { if (condition) ; } while(0)
+#define WARN_ON(condition) unlikely((condition))
 #endif
 #endif
 
 #define WARN_ON_ONCE(condition)				\
-({							\
+unlikely({						\
 	static int __warn_once = 1;			\
-	int __ret = 0;					\
+	int __ret_warn_once = (condition);		\
 							\
-	if (unlikely((condition) && __warn_once)) {	\
-		__warn_once = 0;			\
-		WARN_ON(1);				\
-		__ret = 1;				\
-	}						\
-	__ret;						\
+	if (likely(__warn_once))			\
+		if (WARN_ON(__ret_warn_once)) 		\
+			__warn_once = 0;		\
+	__ret_warn_once;				\
 })
 
 #ifdef CONFIG_SMP
diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
index f44b529..a5f503f 100644
--- a/include/asm-powerpc/bug.h
+++ b/include/asm-powerpc/bug.h
@@ -70,9 +70,10 @@ #define __WARN() do {						\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 } while (0)
 
-#define WARN_ON(x) do {						\
-	if (__builtin_constant_p(x)) {				\
-		if (x)						\
+#define WARN_ON(x) unlikely({					\
+	long __ret_warn_on = (x);				\
+	if (__builtin_constant_p(__ret_warn_on)) {		\
+		if (__ret_warn_on)				\
 			__WARN();				\
 	} else {						\
 		__asm__ __volatile__(				\
@@ -80,11 +81,12 @@ #define WARN_ON(x) do {						\
 		".section __bug_table,\"a\"\n"			\
 		"\t"PPC_LONG"	1b,%1,%2,%3\n"			\
 		".previous"					\
-		: : "r" ((long)(x)),				\
+		: : "r" (__ret_warn_on),			\
 		    "i" (__LINE__ + BUG_WARNING_TRAP),		\
 		    "i" (__FILE__), "i" (__FUNCTION__));	\
 	}							\
-} while (0)
+	__ret_warn_on;						\
+})
 
 #define HAVE_ARCH_BUG
 #define HAVE_ARCH_BUG_ON
