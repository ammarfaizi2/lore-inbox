Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154015-28471>; Mon, 7 Sep 1998 09:26:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19109 "EHLO penguin.e-mind.com" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <154149-28471>; Mon, 7 Sep 1998 08:56:10 -0400
Date: Mon, 7 Sep 1998 17:10:49 +0200 (CEST)
From: Andrea Arcangeli <arcangeli@mbox.queen.it>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linux-kernel@vger.rutgers.edu
Subject: Re: IPv4 kernel messages
In-Reply-To: <199809070016.RAA09205@dm.cobaltmicro.com>
Message-ID: <Pine.LNX.3.96.980907170554.1492A-100000@dragon.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 6 Sep 1998, David S. Miller wrote:

>Here is the lifesaver development utility I have been using for a long

Cool! ;-)

>time to verify all major changes made to Sparc and MIPS checksumming
>routines.  It won't work for you as-is, but you can figure out what it
>is supposed to do and link the PPC and M68k csum routines into it to
>perform verifications.  Note there is an ugly piece of MIPS inline asm
>in here which you'll need to remove too as the last thing I used this
>for was the Cobalt kernels :-)  Note it also performs performance

The asm looks wrong.

>/* XXX */
>static __inline__ unsigned short int csum_fold(unsigned int sum)
>{
>	__asm__("
>	.set	noat            
>	sll	$1,%0,16
>	addu	%0,$1
>	sltu	$1,%0,$1
        ^^^^^^^^^^^^^^^^

With my MIPS emulator sltu do soemthing like "<" C operator, $1 return
only 0 or 1 and so the asm seems far from what csum_fold should do (I
emulated the asm in C and does not work).

Here my C implementation of csum_fold() that seems to work with the
csum_partial() in the current arch/i386/lib/checksum.c.

--- cksum_helper.c.orig	Mon Sep  7 14:51:25 1998
+++ cksum_helper.c	Mon Sep  7 17:17:24 1998
@@ -180,6 +180,15 @@
 /* XXX */
 static __inline__ unsigned short int csum_fold(unsigned int sum)
 {
+#ifndef __mips__ /* or better #ifndef buggy ;-) */
+	union {
+		u16 s[2];
+		u32 l;
+	} l_util;
+	
+	REDUCE;
+	return ~sum & 0xffff;
+#else
 	__asm__("
 	.set	noat            
 	sll	$1,%0,16
@@ -194,6 +203,7 @@
 	: "$1");
 
  	return sum;
+#endif
 }
 
 static int filenum = 0;
@@ -215,6 +225,7 @@
 
 struct timeval random_seed;
 
+#if 0
 static void verify_ip_fast_csum(void)
 {
 	struct iphdr **buffers;
@@ -280,6 +291,7 @@
 	printf("Out of memory in verify_ip_fast_csum!\n");
 	exit(1);
 }
+#endif
 
 static char compare_buffer[2048];
 
@@ -555,6 +567,7 @@
 
 #define N 10000
 
+#if 0
 static void measure_ip_fast_csum(void)
 {
 	struct iphdr **buffers;
@@ -607,6 +620,7 @@
 	printf("Out of memory in measure_ip_fast_csum!\n");
 	exit(1);
 }
+#endif
 
 #define NBUFS 256
 
@@ -748,7 +762,7 @@
 	exit(1);
 }
 
-void main(int argc, char **argv)
+int main(int argc, char **argv)
 {
 	verify_csum_partial();
 #if 0

Andrea[s] Arcangeli


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
