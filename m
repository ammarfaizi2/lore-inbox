Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTJZTGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTJZTGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:06:16 -0500
Received: from gandalf.tausq.org ([64.81.244.94]:26505 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S263423AbTJZTGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:06:13 -0500
Date: Sun, 26 Oct 2003 11:10:20 -0800
From: Randolph Chung <tausq@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix __div64_32 to do division properly
Message-ID: <20031026191020.GL24406@tausq.org>
Reply-To: Randolph Chung <tausq@debian.org>
References: <20031026152412.GK24406@tausq.org> <Pine.LNX.4.44.0310260931501.934-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310260931501.934-100000@home.osdl.org>
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I can tell, this one is buggy and can cause total lockups with 
> an infinite loop:

oops, you are absolutely right....

your version seems to be ok. i tested it with all two-bit combinations
of dividend and divisors,  i.e.

for (b1 = 63; b1 > 0; b1--) {
    for (b2 = b1-1; b2 > 0; b2--) {
        for (b3 = 31; b3 > 0; b3--) {
            for (b4 = b3-1; b4 > 0; b4--) {
                dividend = (1ULL<<b1) | (1ULL<<b2);
                divisor = (1UL<<b3) | (1UL<<b4);
                testdiv(dividend, divisor);
            }
        }
    }
}

and it seems to be ok (and it catches the problem you pointed out). is
that an interesting enough subset? :-)

anyway, here's a new patch tested as above and with the original
nanosleep problem. (i removed the top variable from your version since
it's not used)

thx
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/


Index: lib/div64.c
===================================================================
RCS file: /var/cvs/linux-2.6/lib/div64.c,v
retrieving revision 1.1
diff -u -p -r1.1 div64.c
--- lib/div64.c	29 Jul 2003 17:02:19 -0000	1.1
+++ lib/div64.c	26 Oct 2003 19:04:47 -0000
@@ -25,25 +25,34 @@
 
 uint32_t __div64_32(uint64_t *n, uint32_t base)
 {
-	uint32_t low, low2, high, rem;
+	uint64_t rem = *n;
+	uint64_t b = base;
+	uint64_t res, d = 1;
+	uint32_t high = rem >> 32;
 
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
+	/* Reduce the thing a bit first */
+	res = 0;
+	if (high >= base) {
+		high /= base;
+		res = (uint64_t) high << 32;
+		rem -= (uint64_t) (high*base) << 32;
+	}
 
-	*n = low +
-		((uint64_t)low2 << 16) +
-		((uint64_t)high << 32);
+	while ((int64_t)b > 0 && b < rem) {
+		b <<= 1;
+		d <<= 1;
+	}
 
+	do {
+		if (rem >= b) {
+			rem -= b;
+			res += d;
+		}
+		b >>= 1;
+		d >>= 1;
+	} while (d);
+
+	*n = res;
 	return rem;
 }
 
