Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945940AbWGOBGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945940AbWGOBGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 21:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945941AbWGOBGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 21:06:49 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:33543 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1945940AbWGOBGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 21:06:48 -0400
Date: Sat, 15 Jul 2006 11:06:45 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1-mm2
Message-ID: <20060715010645.GB11515@gondor.apana.org.au>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <44B73FEE.6040908@reub.net> <20060714000551.649ca455.akpm@osdl.org> <20060715000458.GB9334@gondor.apana.org.au> <20060714172010.fcc50c0a.akpm@osdl.org> <20060715002623.GE9334@gondor.apana.org.au> <20060714173517.cdd58097.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714173517.cdd58097.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 05:35:17PM -0700, Andrew Morton wrote:
>
> Actually, it was added three-odd weeks back.

Oops, I had done a git-read-tree v2.6.17 when tracking down a bug
and forgot to revert to HEAD.

BTW, how about making WARN_ON/WARN_ON_ONCE always return the
condition? That would mean you could do

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
index 8ceab7b..7abe5e0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -16,12 +16,14 @@ #define BUG_ON(condition) do { if (unlik
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-#define WARN_ON(condition) do { \
-	if (unlikely((condition)!=0)) { \
+#define WARN_ON(condition) ({ \
+	int __ret = condition; \
+	if (unlikely(__ret)) { \
 		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
 		dump_stack(); \
 	} \
-} while (0)
+	unlikely(__ret); \
+})
 #endif
 
 #else /* !CONFIG_BUG */
@@ -41,14 +43,12 @@ #endif
 #define WARN_ON_ONCE(condition)				\
 ({							\
 	static int __warn_once = 1;			\
-	int __ret = 0;					\
+	int __ret = condition;				\
 							\
-	if (unlikely((condition) && __warn_once)) {	\
+	if (WARN_ON(__warn_once && __ret)) {		\
 		__warn_once = 0;			\
-		WARN_ON(1);				\
-		__ret = 1;				\
 	}						\
-	__ret;						\
+	unlikely(__ret);				\
 })
 
 #ifdef CONFIG_SMP
