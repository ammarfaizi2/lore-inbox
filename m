Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313854AbSDUVrY>; Sun, 21 Apr 2002 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSDUVrX>; Sun, 21 Apr 2002 17:47:23 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13454 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313854AbSDUVrW>;
	Sun, 21 Apr 2002 17:47:22 -0400
Date: Sun, 21 Apr 2002 23:30:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp for 2.5.8: find_last_bit_set
Message-ID: <20020421213018.GA25043@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For software suspend [enabling suspend to disk on any machine], I need
find_last_bit_set interface. Here it is, please apply.

								Pavel

--- clean.2.5/include/asm-generic/bitops.h	Tue Nov 28 02:47:38 2000
+++ linux-swsusp/include/asm-generic/bitops.h	Sun Apr 21 20:40:55 2002
@@ -51,6 +51,12 @@
 	return ((mask & *addr) != 0);
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
--- clean.2.5/include/asm-i386/bitops.h	Thu Apr 18 22:46:15 2002
+++ linux-swsusp/include/asm-i386/bitops.h	Sun Apr 21 21:15:07 2002
@@ -414,6 +414,12 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
--- clean.2.5/include/linux/bitops.h	Mon Nov  5 21:42:13 2001
+++ linux-swsusp/include/linux/bitops.h	Sun Apr 21 21:15:07 2002
@@ -1,6 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
-
+#include <asm/bitops.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -35,6 +35,47 @@
 		r += 1;
 	}
 	return r;
+}
+
+/*
+ * fls: find last bit set.
+ */
+
+extern __inline__ int generic_fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+extern __inline__ int get_bitmask_order(unsigned int count)
+{
+	int order;
+	
+	order = fls(count);
+	return order;	/* We could be slightly more clever with -1 here... */
 }
 
 /*

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
