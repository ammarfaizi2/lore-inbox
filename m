Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSBEHgl>; Tue, 5 Feb 2002 02:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSBEHga>; Tue, 5 Feb 2002 02:36:30 -0500
Received: from [65.169.83.229] ([65.169.83.229]:4480 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S289341AbSBEHfd>; Tue, 5 Feb 2002 02:35:33 -0500
Date: Tue, 5 Feb 2002 01:34:45 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, tytso@mit.edu
Subject: [PATCH] Allow PRNG to Use Faster SHA Code
Message-ID: <20020205073445.GA1313@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.18-pre8
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is a diff against 2.4.18-pre8. It allows the PRNG
(Pseudorandom Number Generator) in the kernel to take advantage of
faster (but slightly larger) SHA code that was already present in the
kernel. 

Ben Pharr
ben@benpharr.com


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="random.patch"

diff -urN -X dontdiff linux-2.4.18-pre8plain/CREDITS linux-2.4.18-pre8/CREDITS
--- linux-2.4.18-pre8plain/CREDITS	Tue Feb  5 00:50:33 2002
+++ linux-2.4.18-pre8/CREDITS	Mon Feb  4 23:28:30 2002
@@ -2343,6 +2343,14 @@
 S: 13353 Berlin
 S: Germany
 
+N: Benjamin Pharr
+E: ben@benpharr.com
+W: http://www.benpharr.com
+P: 1024D/6859792C 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
+D: Pseudorandom Number Generator Configuration Options
+S: E-mail for current address
+S: Mississippi, USA
+
 N: Emanuel Pirker
 E: epirker@edu.uni-klu.ac.at
 D: AIC5800 IEEE 1394, RAW I/O on 1394
diff -urN -X dontdiff linux-2.4.18-pre8plain/Documentation/Configure.help linux-2.4.18-pre8/Documentation/Configure.help
--- linux-2.4.18-pre8plain/Documentation/Configure.help	Tue Feb  5 00:50:33 2002
+++ linux-2.4.18-pre8/Documentation/Configure.help	Tue Feb  5 00:31:19 2002
@@ -17172,7 +17172,7 @@
   will issue the hlt instruction if nothing is to be done, thereby
   sending the processor to sleep and saving power.
 
-ACPI support
+acpi support
 CONFIG_ACPI
   ACPI/OSPM support for Linux is currently under development. As such,
   this support is preliminary and EXPERIMENTAL.  Configuring ACPI
@@ -24359,6 +24359,21 @@
   order to effectively use VLANs.  See the VLAN web page for more
   information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
   you can safely say 'N'.
+
+Smallest/Worst Performance SHA Code
+CONFIG_SHA_CODE_SIZE_0
+  Setting this will make the Pseudorandom Number Generator use the
+  smallest version of the SHA code, but also the slowest. It is 50%
+  slower than the largest/fastest version, but 6k smaller. This is
+  probably best for machines with small amounts of memory.
+
+Largest/Best Performance SHA Code
+CONFIG_SHA_CODE_SIZE_3
+  Setting this will make the Pseudorandom Number Generator use the
+  largest version of the SHA code, but also the fastest. It is
+  approximately twice as fast compared to the smallest/slowest code,
+  but 6kB larger. This is the obvious default for machines with
+  adequate amounts of memory.
 
 #
 # A couple of things I keep forgetting:
diff -urN -X dontdiff linux-2.4.18-pre8plain/drivers/char/Config.in linux-2.4.18-pre8/drivers/char/Config.in
--- linux-2.4.18-pre8plain/drivers/char/Config.in	Tue Feb  5 00:50:35 2002
+++ linux-2.4.18-pre8/drivers/char/Config.in	Tue Feb  5 00:21:41 2002
@@ -105,6 +105,11 @@
    dep_tristate 'Support for user-space parallel port device drivers' CONFIG_PPDEV $CONFIG_PARPORT
 fi
 
+comment 'Pseudorandom Number Generator Options'
+choice 'SHA Code Size/Performance' \
+   	"Smallest/Slowest	CONFIG_SHA_CODE_SIZE_0 \
+   	Largest/Fastest 	CONFIG_SHA_CODE_SIZE_3" Largest/Fastest
+
 source drivers/i2c/Config.in
 
 mainmenu_option next_comment
diff -urN -X dontdiff linux-2.4.18-pre8plain/drivers/char/random.c linux-2.4.18-pre8/drivers/char/random.c
--- linux-2.4.18-pre8plain/drivers/char/random.c	Fri Nov  9 16:01:21 2001
+++ linux-2.4.18-pre8/drivers/char/random.c	Tue Feb  5 00:19:36 2002
@@ -863,8 +863,14 @@
 #define HASH_EXTRA_SIZE 80
 #define HASH_TRANSFORM SHATransform
 
-/* Various size/speed tradeoffs are available.  Choose 0..3. */
-#define SHA_CODE_SIZE 0
+/* Various size/speed tradeoffs are available. Defined in 
+ * kernel configuration files.
+ *
+ * CONFIG_SHA_CODE_SIZE_0 	smallest/slowest
+ * CONFIG_SHA_CODE_SIZE_1
+ * CONFIG_SHA_CODE_SIZE_2
+ * CONFIG_SHA_CODE_SIZE_3	largest/fastest
+ */
 
 /*
  * SHA transform algorithm, taken from code written by Peter Gutmann,
@@ -918,7 +924,7 @@
     E = digest[ 4 ];
 
     /* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-#if SHA_CODE_SIZE == 0
+#ifdef CONFIG_SHA_CODE_SIZE_0
     /*
      * Approximately 50% of the speed of the largest version, but
      * takes up 1/16 the space.  Saves about 6k on an i386 kernel.
@@ -938,7 +944,8 @@
 	TEMP += ROTL(5, A) + E + W[i];
 	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
     }
-#elif SHA_CODE_SIZE == 1
+#endif
+#ifdef CONFIG_SHA_CODE_SIZE_1
     for (i = 0; i < 20; i++) {
 	TEMP = f1(B, C, D) + K1 + ROTL(5, A) + E + W[i];
 	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
@@ -955,7 +962,8 @@
 	TEMP = f4(B, C, D) + K4 + ROTL(5, A) + E + W[i];
 	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
     }
-#elif SHA_CODE_SIZE == 2
+#endif
+#ifdef CONFIG_SHA_CODE_SIZE_2
     for (i = 0; i < 20; i += 5) {
 	subRound( A, B, C, D, E, f1, K1, W[ i   ] );
 	subRound( E, A, B, C, D, f1, K1, W[ i+1 ] );
@@ -984,7 +992,8 @@
 	subRound( C, D, E, A, B, f4, K4, W[ i+3 ] );
 	subRound( B, C, D, E, A, f4, K4, W[ i+4 ] );
     }
-#elif SHA_CODE_SIZE == 3 /* Really large version */
+#endif
+#ifdef CONFIG_SHA_CODE_SIZE_3 /* Really large version */
     subRound( A, B, C, D, E, f1, K1, W[  0 ] );
     subRound( E, A, B, C, D, f1, K1, W[  1 ] );
     subRound( D, E, A, B, C, f1, K1, W[  2 ] );
@@ -1068,8 +1077,6 @@
     subRound( D, E, A, B, C, f4, K4, W[ 77 ] );
     subRound( C, D, E, A, B, f4, K4, W[ 78 ] );
     subRound( B, C, D, E, A, f4, K4, W[ 79 ] );
-#else
-#error Illegal SHA_CODE_SIZE
 #endif
 
     /* Build message digest */

--W/nzBZO5zC0uMSeA--
