Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbREFKkR>; Sun, 6 May 2001 06:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135443AbREFKj4>; Sun, 6 May 2001 06:39:56 -0400
Received: from smtp.mountain.net ([198.77.1.35]:19465 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S135427AbREFKjt>;
	Sun, 6 May 2001 06:39:49 -0400
Message-ID: <3AF529BD.49FEFBF8@mountain.net>
Date: Sun, 06 May 2001 06:38:53 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] kill warning from gcc 3.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch stops the warning "Multiline strings are deprecated" from
gcc 3.0 [20010423] in include/asm-i386/checksum.h. I expect there
are more of these to be found.

Cheers,
Tom

$ diff -u include/asm-i386/checksum.h~ include/asm-i386/checksum.h
--- include/asm-i386/checksum.h~	Mon Jan  8 10:56:14 2001
+++ include/asm-i386/checksum.h	Sun May  6 06:17:28 2001
@@ -69,25 +69,23 @@
 					  unsigned int ihl) {
 	unsigned int sum;
 
-	__asm__ __volatile__("
-	    movl (%1), %0
-	    subl $4, %2
-	    jbe 2f
-	    addl 4(%1), %0
-	    adcl 8(%1), %0
-	    adcl 12(%1), %0
-1:	    adcl 16(%1), %0
-	    lea 4(%1), %1
-	    decl %2
-	    jne	1b
-	    adcl $0, %0
-	    movl %0, %2
-	    shrl $16, %0
-	    addw %w2, %w0
-	    adcl $0, %0
-	    notl %0
-2:
-	    "
+	__asm__ __volatile__("movl (%1), %0\n\t"
+			     "subl $4, %2\n\t"
+			     "jbe 2f\n\t"
+			     "addl 4(%1), %0\n\t"
+			     "adcl 8(%1), %0\n\t"
+			     "adcl 12(%1), %0\n"
+			     "1:	adcl 16(%1), %0\n\t"
+			     "lea 4(%1), %1\n\t"
+			     "decl %2\n\t"
+			     "jne	1b\n\t"
+			     "adcl $0, %0\n\t"
+			     "movl %0, %2\n\t"
+			     "shrl $16, %0\n\t"
+			     "addw %w2, %w0\n\t"
+			     "adcl $0, %0\n\t"
+			     "notl %0\n"
+			     "2:\n"
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
@@ -118,14 +116,12 @@
 						   unsigned short proto,
 						   unsigned int sum) 
 {
-    __asm__("
-	addl %1, %0
-	adcl %2, %0
-	adcl %3, %0
-	adcl $0, %0
-	"
-	: "=r" (sum)
-	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
+    __asm__("addl %1, %0\n\t"
+	    "adcl %2, %0\n\t"
+	    "adcl %3, %0\n\t"
+	    "adcl $0, %0\n\t"
+	    : "=r" (sum)
+	    : "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
     return sum;
 }
 
@@ -158,19 +154,17 @@
 						     unsigned short proto,
 						     unsigned int sum) 
 {
-	__asm__("
-		addl 0(%1), %0
-		adcl 4(%1), %0
-		adcl 8(%1), %0
-		adcl 12(%1), %0
-		adcl 0(%2), %0
-		adcl 4(%2), %0
-		adcl 8(%2), %0
-		adcl 12(%2), %0
-		adcl %3, %0
-		adcl %4, %0
-		adcl $0, %0
-		"
+	__asm__("addl 0(%1), %0\n\t"
+		"adcl 4(%1), %0\n\t"
+		"adcl 8(%1), %0\n\t"
+		"adcl 12(%1), %0\n\t"
+		"adcl 0(%2), %0\n\t"
+		"adcl 4(%2), %0\n\t"
+		"adcl 8(%2), %0\n\t"
+		"adcl 12(%2), %0\n\t"
+		"adcl %3, %0\n\t"
+		"adcl %4, %0\n\t"
+		"adcl $0, %0\n\t"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr), 
 		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
