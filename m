Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSLWFQo>; Mon, 23 Dec 2002 00:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSLWFQo>; Mon, 23 Dec 2002 00:16:44 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:54518 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266576AbSLWFQn>;
	Mon, 23 Dec 2002 00:16:43 -0500
Date: Mon, 23 Dec 2002 16:24:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, davidm@hpl.hp.com
Subject: Re: [RESEND][PATCH] better compat_jiffies_to_clock_t
Message-Id: <20021223162438.367ae28c.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0212222112490.1225-100000@home.transmeta.com>
References: <20021223145439.368d4d05.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0212222112490.1225-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2002 21:14:07 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> I don't like using "long long" and divisions.
> 
> Since this code is currently only used for 64-bit targets, is there any
> reason to use "long long" at all, and not just use "long"? I can see a
> 64-bit target where "long long" would be 128 bits, and this would do the
> wrong thing.

I have no problem with just long.  David Mosberger suggested the
"long long" because it would always be the longest integer type
and therefore overflow less often (if at all).  But for now, you
are right.

New patch attached.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.52-32bit.base/include/linux/compat.h 2.5.52-32bit.clock/include/linux/compat.h
--- 2.5.52-32bit.base/include/linux/compat.h	2002-12-16 14:49:54.000000000 +1100
+++ 2.5.52-32bit.clock/include/linux/compat.h	2002-12-17 15:20:18.000000000 +1100
@@ -9,9 +9,11 @@
 #ifdef CONFIG_COMPAT
 
 #include <linux/stat.h>
+#include <linux/param.h>	/* for HZ */
 #include <asm/compat.h>
 
-#define compat_jiffies_to_clock_t(x)	((x) / (HZ / COMPAT_USER_HZ))
+#define compat_jiffies_to_clock_t(x)	\
+		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
 struct compat_utimbuf {
 	compat_time_t		actime;
