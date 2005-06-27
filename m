Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVF0XKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVF0XKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVF0XIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:08:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262093AbVF0XCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:02:31 -0400
Date: Mon, 27 Jun 2005 16:01:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com
Subject: [05/07] Add "memory" clobbers to the x86 inline asm of strncmp and friends
Message-ID: <20050627230144.GN9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


From: Linus Torvalds <torvalds@ppc970.osdl.org>

Add "memory" clobbers to the x86 inline asm of strncmp and friends

They don't actually clobber memory, but gcc doesn't even know they
_read_ memory, so can apparently re-order memory accesses around them.

Which obviously does the wrong thing if the memory access happens to
change the memory that the compare function is accessing..

Verified to fix a strange boot problem by Jens Axboe.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 include/asm-i386/string.h |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/asm-i386/string.h b/include/asm-i386/string.h
--- a/include/asm-i386/string.h
+++ b/include/asm-i386/string.h
@@ -116,7 +116,8 @@ __asm__ __volatile__(
 	"orb $1,%%al\n"
 	"3:"
 	:"=a" (__res), "=&S" (d0), "=&D" (d1)
-		     :"1" (cs),"2" (ct));
+	:"1" (cs),"2" (ct)
+	:"memory");
 return __res;
 }
 
@@ -138,8 +139,9 @@ __asm__ __volatile__(
 	"3:\tsbbl %%eax,%%eax\n\t"
 	"orb $1,%%al\n"
 	"4:"
-		     :"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
-		     :"1" (cs),"2" (ct),"3" (count));
+	:"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
+	:"1" (cs),"2" (ct),"3" (count)
+	:"memory");
 return __res;
 }
 
@@ -158,7 +160,9 @@ __asm__ __volatile__(
 	"movl $1,%1\n"
 	"2:\tmovl %1,%0\n\t"
 	"decl %0"
-	:"=a" (__res), "=&S" (d0) : "1" (s),"0" (c));
+	:"=a" (__res), "=&S" (d0)
+	:"1" (s),"0" (c)
+	:"memory");
 return __res;
 }
 
@@ -175,7 +179,9 @@ __asm__ __volatile__(
 	"leal -1(%%esi),%0\n"
 	"2:\ttestb %%al,%%al\n\t"
 	"jne 1b"
-	:"=g" (__res), "=&S" (d0), "=&a" (d1) :"0" (0),"1" (s),"2" (c));
+	:"=g" (__res), "=&S" (d0), "=&a" (d1)
+	:"0" (0),"1" (s),"2" (c)
+	:"memory");
 return __res;
 }
 
@@ -189,7 +195,9 @@ __asm__ __volatile__(
 	"scasb\n\t"
 	"notl %0\n\t"
 	"decl %0"
-	:"=c" (__res), "=&D" (d0) :"1" (s),"a" (0), "0" (0xffffffffu));
+	:"=c" (__res), "=&D" (d0)
+	:"1" (s),"a" (0), "0" (0xffffffffu)
+	:"memory");
 return __res;
 }
 
@@ -333,7 +341,9 @@ __asm__ __volatile__(
 	"je 1f\n\t"
 	"movl $1,%0\n"
 	"1:\tdecl %0"
-	:"=D" (__res), "=&c" (d0) : "a" (c),"0" (cs),"1" (count));
+	:"=D" (__res), "=&c" (d0)
+	:"a" (c),"0" (cs),"1" (count)
+	:"memory");
 return __res;
 }
 
@@ -369,7 +379,7 @@ __asm__ __volatile__(
 	"je 2f\n\t"
 	"stosb\n"
 	"2:"
-	: "=&c" (d0), "=&D" (d1)
+	:"=&c" (d0), "=&D" (d1)
 	:"a" (c), "q" (count), "0" (count/4), "1" ((long) s)
 	:"memory");
 return (s);	
@@ -392,7 +402,8 @@ __asm__ __volatile__(
 	"jne 1b\n"
 	"3:\tsubl %2,%0"
 	:"=a" (__res), "=&d" (d0)
-	:"c" (s),"1" (count));
+	:"c" (s),"1" (count)
+	:"memory");
 return __res;
 }
 /* end of additional stuff */
@@ -473,7 +484,8 @@ static inline void * memscan(void * addr
 		"dec %%edi\n"
 		"1:"
 		: "=D" (addr), "=c" (size)
-		: "0" (addr), "1" (size), "a" (c));
+		: "0" (addr), "1" (size), "a" (c)
+		: "memory");
 	return addr;
 }
 
