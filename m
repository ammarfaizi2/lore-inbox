Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310116AbSB1VbA>; Thu, 28 Feb 2002 16:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310114AbSB1V3Y>; Thu, 28 Feb 2002 16:29:24 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:18114 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310118AbSB1V0o>; Thu, 28 Feb 2002 16:26:44 -0500
Message-Id: <5.1.0.14.2.20020228130345.0d3efec0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 28 Feb 2002 13:26:22 -0800
To: linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] 2.4.x:include/asm-i386/checksum.h GCC 3.X warning fixes
Cc: marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Could you please apply patch below. It just fixes "multi line string" 
warnings.
2.5.X already has that fix. Patch is against 2.4.19-pre1.

btw People were complaining that GCC 3.0 is slower than 2.X.
3.1 seems to be as fast as 2.96. Compiled kernel size is about the same. 
And everything
works just fine on my dual Athlon box.

Patch URL (in case mailer messed up spaces)
         http://bluez.sf.net/checksum.h.patch.gz

Thanks
Max

--- include/asm-i386/checksum.h.orig    Wed Feb 27 20:12:26 2002
+++ include/asm-i386/checksum.h Tue Feb 26 21:36:53 2002
@@ -69,25 +69,24 @@
                                           unsigned int ihl) {
         unsigned int sum;

-       __asm__ __volatile__("
-           movl (%1), %0
-           subl $4, %2
-           jbe 2f
-           addl 4(%1), %0
-           adcl 8(%1), %0
-           adcl 12(%1), %0
-1:         adcl 16(%1), %0
-           lea 4(%1), %1
-           decl %2
-           jne 1b
-           adcl $0, %0
-           movl %0, %2
-           shrl $16, %0
-           addw %w2, %w0
-           adcl $0, %0
-           notl %0
-2:
-           "
+       __asm__ __volatile__(
+       "       movl (%1), %0   ;\n"
+       "       subl $4, %2     ;\n"
+       "       jbe 2f          ;\n"
+       "       addl 4(%1), %0  ;\n"
+       "       adcl 8(%1), %0  ;\n"
+       "       adcl 12(%1), %0 ;\n"
+       "1:     adcl 16(%1), %0 ;\n"
+       "       lea 4(%1), %1   ;\n"
+       "       decl %2         ;\n"
+       "       jne     1b      ;\n"
+       "       adcl $0, %0     ;\n"
+       "       movl %0, %2     ;\n"
+       "       shrl $16, %0    ;\n"
+       "       addw %w2, %w0   ;\n"
+       "       adcl $0, %0     ;\n"
+       "       notl %0         ;\n"
+       "2:                     "
         /* Since the input registers which are loaded with iph and ipl
            are modified, we must also specify them as outputs, or gcc
            will assume they contain their original values. */
@@ -102,10 +101,9 @@

  static inline unsigned int csum_fold(unsigned int sum)
  {
-       __asm__("
-               addl %1, %0
-               adcl $0xffff, %0
-               "
+       __asm__(
+               "addl %1, %0;\n"
+               "adcl $0xffff, %0;\n"
                 : "=r" (sum)
                 : "r" (sum << 16), "0" (sum & 0xffff0000)
         );
@@ -118,14 +116,14 @@
                                                    unsigned short proto,
                                                    unsigned int sum)
  {
-    __asm__("
-       addl %1, %0
-       adcl %2, %0
-       adcl %3, %0
-       adcl $0, %0
-       "
-       : "=r" (sum)
-       : "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
+       __asm__(
+               "addl %1, %0;\n"
+               "adcl %2, %0;\n"
+               "adcl %3, %0;\n"
+               "adcl $0, %0;\n"
+               : "=r" (sum)
+               : "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256),
+               "0"(sum));
      return sum;
  }

@@ -158,19 +156,18 @@
                                                      unsigned short proto,
                                                      unsigned int sum)
  {
-       __asm__("
-               addl 0(%1), %0
-               adcl 4(%1), %0
-               adcl 8(%1), %0
-               adcl 12(%1), %0
-               adcl 0(%2), %0
-               adcl 4(%2), %0
-               adcl 8(%2), %0
-               adcl 12(%2), %0
-               adcl %3, %0
-               adcl %4, %0
-               adcl $0, %0
-               "
+       __asm__(
+               "addl 0(%1),  %0;\n"
+               "adcl 4(%1),  %0;\n"
+               "adcl 8(%1),  %0;\n"
+               "adcl 12(%1), %0;\n"
+               "adcl 0(%2),  %0;\n"
+               "adcl 4(%2),  %0;\n"
+               "adcl 8(%2),  %0;\n"
+               "adcl 12(%2), %0;\n"
+               "adcl %3, %0;\n"
+               "adcl %4, %0;\n"
+               "adcl $0, %0;\n"
                 : "=&r" (sum)
                 : "r" (saddr), "r" (daddr),
                   "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));


