Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTJXEQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJXEQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 00:16:42 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:30701 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S261966AbTJXEQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 00:16:41 -0400
Date: Thu, 23 Oct 2003 21:20:03 -0700
From: Randolph Chung <tausq@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] fix __div64_32 to do division properly
Message-ID: <20031024042002.GA24406@tausq.org>
Reply-To: Randolph Chung <tausq@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The generic __div64_32 in lib/div64.c only handles "small" divisors. If
the divisor is full 32-bits, it returns invalid results. This patch 
fixes it. (this is used e.g. in nanosleep)

thanks
randolph

Index: lib/div64.c
===================================================================
RCS file: /var/cvs/linux-2.6/lib/div64.c,v
retrieving revision 1.1
diff -u -p -r1.1 div64.c
--- lib/div64.c	29 Jul 2003 17:02:19 -0000	1.1
+++ lib/div64.c	24 Oct 2003 04:10:59 -0000
@@ -25,25 +25,27 @@
 
 uint32_t __div64_32(uint64_t *n, uint32_t base)
 {
-	uint32_t low, low2, high, rem;
+	uint64_t rem = *n;
+	uint64_t b = base;
+	uint64_t res = 0, d = 1;
 
-	low   = *n   & 0xffffffff;
-	high  = *n  >> 32;
-	rem   = high % (uint32_t)base;
-	high  = high / (uint32_t)base;
-	low2  = low >> 16;
-	low2 += rem << 16;
-	rem   = low2 % (uint32_t)base;
-	low2  = low2 / (uint32_t)base;
-	low   = low  & 0xffff;
-	low  += rem << 16;
-	rem   = low  % (uint32_t)base;
-	low   = low  / (uint32_t)base;
+	if (b > 0) {
+		while (b < rem) {
+			b <<= 1;
+			d <<= 1;
+		}
+	}
 
-	*n = low +
-		((uint64_t)low2 << 16) +
-		((uint64_t)high << 32);
+	do {
+		if (rem >= b) {
+			rem -= b;
+			res += d;
+		}
+		b >>= 1;
+		d >>= 1;
+	} while (d);
 
+	*n = res;
 	return rem;
 }
 

-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
