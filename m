Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265449AbTIEQGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbTIEQGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:06:53 -0400
Received: from [24.136.46.5] ([24.136.46.5]:62478 "EHLO
	svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S265449AbTIEQGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:06:51 -0400
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
From: Robert Love <rml@tech9.net>
To: Andreas Jaeger <aj@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       rth@redhat.com, linux-kernel@vger.kernel.org, jh@suse.cz
In-Reply-To: <ho65k76z9v.fsf@byrd.suse.de>
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org>
	 <ho65k76z9v.fsf@byrd.suse.de>
Content-Type: text/plain
Message-Id: <1062778587.8510.10.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 05 Sep 2003 12:16:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 11:17, Andreas Jaeger wrote:


> Since unit-at-a-time has better inlining heuristics the better way is
> to add the used attribute - but that takes some time.  The short-term
> solution would be to add the compiler flag,

Won't we get a linker error if a static symbol is used but
optimized-away?  It shouldn't be hard to fix the n linker errors that
crop up.

And why are we using static symbols in inline assembly outside of the
compilation scope?

Anyhow, if it generates an error, this isn't hard to fix.

Here is the start...

	Robert Love


--- linux-rml/include/linux/compiler.h	Fri Sep  5 11:57:56 2003
+++ linux/include/linux/compiler.h	Fri Sep  5 12:02:02 2003
@@ -74,6 +74,19 @@
 #define __attribute_pure__	/* unimplemented */
 #endif
 
+/*
+ * As of gcc 3.2, we can mark a function as 'used' and gcc will assume that,
+ * even if it does not find a reference to it in any compilation unit.  We
+ * need this for gcc 3.4 and beyond, which can optimize on a program-wide
+ * scope, and not just one file at a time, to avoid static symbols being
+ * discarded.
+ */
+#if (__GNUC__ == 3 && __GNUC_MINOR__ > 1) || __GNUC__ > 3
+#define __attribute_used__	__attribute__((used))
+#else
+#define __attribute_used__	/* unimplemented */
+#endif
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\


