Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbSLREcn>; Tue, 17 Dec 2002 23:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSLREcn>; Tue, 17 Dec 2002 23:32:43 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:39381 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267133AbSLREcl>;
	Tue, 17 Dec 2002 23:32:41 -0500
Date: Wed, 18 Dec 2002 15:40:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: Intel P6 vs P7 system call performance
Message-Id: <20021218154023.29726d09.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
References: <3DFFED33.2020201@transmeta.com>
	<Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

On Tue, 17 Dec 2002 20:07:53 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>
> Btw, on another tangent - Andrew Morton reports that APM is unhappy about
> the fact that the fast system call stuff required us to move the segments
> around a bit. That's probably because the APM code has the old APM segment
> numbers hardcoded somewhere, but I don't see where (I certainly knew about
> the segment number issue, and tried to update the cases I saw).

I looked at this yesterday and decided that it was OK as well.

> Debugging help would be appreciated, especially from somebody who knows
> the APM code.

It would help to know what "unhappy" means :-)

Does the following fix it for you? Untested, assumes cache lines are 32
bytes.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.52-200212181207/include/asm-i386/segment.h 2.5.52-200212181207-apm/include/asm-i386/segment.h
--- 2.5.52-200212181207/include/asm-i386/segment.h	2002-12-18 15:25:48.000000000 +1100
+++ 2.5.52-200212181207-apm/include/asm-i386/segment.h	2002-12-18 15:38:34.000000000 +1100
@@ -65,9 +65,9 @@
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
 /*
- * The GDT has 23 entries but we pad it to cacheline boundary:
+ * The GDT has 25 entries but we pad it to cacheline boundary:
  */
-#define GDT_ENTRIES 24
+#define GDT_ENTRIES 28
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
