Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRC3VtT>; Fri, 30 Mar 2001 16:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRC3VtB>; Fri, 30 Mar 2001 16:49:01 -0500
Received: from jalon.able.es ([212.97.163.2]:14070 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131665AbRC3Vs4>;
	Fri, 30 Mar 2001 16:48:56 -0500
Date: Fri, 30 Mar 2001 23:48:04 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
   Linus Torvalds <torvalds@transmeta.com>,
   Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] multiline string cleanup
Message-ID: <20010330234804.A27780@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, kernel developers.

This is one other try to make kernel sources gcc-3.0 friendly. This cleans
some muti-line asm strings in checksum.h and floppy.h (this were the only
ones reported in my kernel build, perhaps there are more in drivers I do
not use).

I have not tested the changes with older binutils, as Alan suggested, but
the changes are made following other __asm__ pieces in the kernel. They
build with gcc-3.0-20010326 snapshot and binutils-2.10.1.0.2.

BTW, I have a doubt: as assembler is written in the rest of kernel (get,
for example, system.h):

static inline unsigned long _get_base(char * addr)
{
    unsigned long __base;
    __asm__("movb %3,%%dh\n\t"
        "movb %2,%%dl\n\t"
        "shll $16,%%edx\n\t"
        "movw %1,%%dx"
        :"=&d" (__base)
        :"m" (*((addr)+2)),
         "m" (*((addr)+4)),
         "m" (*((addr)+7)));
    return __base;
}

the first asm line is not tabbed, the result is:

movb %3,%%dh
	movb %2,%%dl
	shll $16,%%edx
	movw %1,%%dx

so is really format (tabs) so important ?


Patch inlined
=============== patch-mls
--- linux-2.4.3/include/asm-i386/checksum.h.orig	Fri Mar 30 23:13:22 2001
+++ linux-2.4.3/include/asm-i386/checksum.h	Fri Mar 30 23:24:04 2001
@@ -69,25 +69,24 @@
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
+	__asm__ __volatile__(
+	"movl (%1), %0\n\t"
+	"subl $4, %2\n\t"
+	"jbe 2f\n\t"
+	"addl 4(%1), %0\n\t"
+	"adcl 8(%1), %0\n\t"
+	"adcl 12(%1), %0\n"
+	"1:\tadcl 16(%1), %0\n\t"
+	"lea 4(%1), %1\n\t"
+	"decl %2\n\t"
+	"jne	1b\n\t"
+	"adcl $0, %0\n\t"
+	"movl %0, %2\n\t"
+	"shrl $16, %0\n\t"
+	"addw %w2, %w0\n\t"
+	"adcl $0, %0\n\t"
+	"notl %0\n"
+	"2:"
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
@@ -102,10 +101,9 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
-		"
+	__asm__(
+		"addl %1, %0\n\t"
+		"adcl $0xffff, %0"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
 	);
@@ -118,12 +116,11 @@
 						   unsigned short proto,
 						   unsigned int sum) 
 {
-    __asm__("
-	addl %1, %0
-	adcl %2, %0
-	adcl %3, %0
-	adcl $0, %0
-	"
+    __asm__(
+	"addl %1, %0\n\t"
+	"adcl %2, %0\n\t"
+	"adcl %3, %0\n\t"
+	"adcl $0, %0"
 	: "=r" (sum)
 	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
     return sum;
@@ -158,19 +155,18 @@
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
+	__asm__(
+		"addl 0(%1), %0\n\t"
+		"adcl 4(%1), %0\n\t"
+		"adcl 8(%1), %0\n\t"
+		"adcl 12(%1), %0\n\t"
+		"adcl 0(%2), %0\n\t"
+		"adcl 4(%2), %0\n\t"
+		"adcl 8(%2), %0\n\t"
+		"adcl 12(%2), %0\n\t"
+		"adcl %3, %0\n\t"
+		"adcl %4, %0\n\t"
+		"adcl $0, %0"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr), 
 		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
--- linux-2.4.3/include/asm-i386/floppy.h.orig	Fri Mar 30 23:24:25 2001
+++ linux-2.4.3/include/asm-i386/floppy.h	Fri Mar 30 23:32:36 2001
@@ -75,28 +75,28 @@
 
 #ifndef NO_FLOPPY_ASSEMBLER
 	__asm__ (
-       "testl %1,%1
-	je 3f
-1:	inb %w4,%b0
-	andb $160,%b0
-	cmpb $160,%b0
-	jne 2f
-	incw %w4
-	testl %3,%3
-	jne 4f
-	inb %w4,%b0
-	movb %0,(%2)
-	jmp 5f
-4:     	movb (%2),%0
-	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
-	decl %1
-	incl %2
-	testl %1,%1
-	jne 1b
-3:	inb %w4,%b0
-2:	"
+	"testl %1,%1\n\t"
+	"je 3f\n"
+	"1:\tinb %w4,%b0\n\t"
+	"andb $160,%b0\n\t"
+	"cmpb $160,%b0\n\t"
+	"jne 2f\n\t"
+	"incw %w4\n\t"
+	"testl %3,%3\n\t"
+	"jne 4f\n\t"
+	"inb %w4,%b0\n\t"
+	"movb %0,(%2)\n\t"
+	"jmp 5f\n"
+	"4:\tmovb (%2),%0\n\t"
+	"outb %b0,%w4\n"
+	"5:\tdecw %w4\n\t"
+	"outb %0,$0x80\n\t"
+	"decl %1\n\t"
+	"incl %2\n\t"
+	"testl %1,%1\n\t"
+	"jne 1b\n"
+	"3:\tinb %w4,%b0\n\t"
+	"2:"
        : "=a" ((char) st), 
        "=c" ((long) virtual_dma_count), 
        "=S" ((long) virtual_dma_addr)

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

