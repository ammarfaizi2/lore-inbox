Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSFXTfj>; Mon, 24 Jun 2002 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSFXTfi>; Mon, 24 Jun 2002 15:35:38 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:41457 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315200AbSFXTfc>; Mon, 24 Jun 2002 15:35:32 -0400
Subject: efficient copy_to_user and copy_from_user routines in Linux Kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCB119CD8.D6AE7B3D-ON85256BE2.006AC911@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 24 Jun 2002 14:34:08 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/24/2002 03:34:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a 2.5.19 patch that improves the performance of IA32 copy_to_user
and copy_from_user routines used by :

(1) tcpip protocol stack
(2) file systems

The 2.5.19 copy routines use the movsl instruction.  We found that when the
src or dst addresses are not aligned on 8 bytes, performance can be
improved
by using the integer registers instead of the movsl instruction.  For
tcpip,
the src or dst addresses are often misaligned.

The patch uses the integer registers if :

(1) length of the copy >= 64 AND src or dst not aligned on 8 bytes.

We found that the patch improves both network throughput and overall
CPU utilization of the sender/receiver when tested using netperf.

Here are some netperf (www.netperf.org) 2.5.19 UP results with and without
the patch :

client & server used for test : 996MHz Pentium III Intel PRO/1000 Gb

netperf 12865 -l 60 -H perf1 -t TCP_STREAM -c -C -i 10,2 -I 95,10 -s 65536
-S 65536

The message size used by netperf was varied from 512...65536, MTU was 1500.

       2.5.19        2.5.19+patch   -- % improvement using patch --
 msg   Throughput    Throughput                   Sender   Receiver
 size  10^6bits/s    10^6bits/s     Throughput      CPU         CPU

  512      741.84      842.00          13.5 %     -1.6 %      0.0 %
 1024      816.61      922.77          13.0 %     -2.8 %      0.0 %
 2048      854.06      940.02          10.1 %     -4.7 %     10.0 %
 4096      913.12      940.12           3.0 %     -1.5 %     19.9 %
 8192      925.36      940.34           1.7 %    -16.3 %     27.9 %
16384      936.51      935.84          -0.1 %      1.8 %     33.4 %
32768      875.11      892.54           2.0 %     -2.5 %     33.9 %
65536      885.79      930.38           5.0 %    -21.0 %     13.3 %

We also instrumented the copy routines in order to measure the number of
CPU cycles required to copy a 1448 byte piece of memory :

        buffer    CPU
method  aligned   cycles
------  -------   ------
movsl   YES       3000
movsl   NO        7000
integer NO        4000

Badari Pulavarty has suggested using mmx registers instead of integer
registers in the unrolled loop copy method.  We are both investigating
the performance of the copy routines when the mmx registers are used.

Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088

Here is the patch:

diff -Naur linux-519/include/asm-i386/uaccess.h
linux-519copy/include/asm-i386/uaccess.h
--- linux-519/include/asm-i386/uaccess.h  Wed Jun 12 12:37:00 2002
+++ linux-519copy/include/asm-i386/uaccess.h    Mon Jun 17 07:52:46 2002
@@ -253,55 +253,199 @@
  */

 /* Generic arbitrary sized copy.  */
-#define __copy_user(to,from,size)                          \
-do {                                                 \
-     int __d0, __d1;                                       \
-     __asm__ __volatile__(                                 \
-           "0:   rep; movsl\n"                             \
-           "     movl %3,%0\n"                             \
-           "1:   rep; movsb\n"                             \
-           "2:\n"                                          \
-           ".section .fixup,\"ax\"\n"                      \
-           "3:   lea 0(%3,%0,4),%0\n"                      \
-           "     jmp 2b\n"                           \
-           ".previous\n"                                   \
-           ".section __ex_table,\"a\"\n"                   \
-           "     .align 4\n"                         \
-           "     .long 0b,3b\n"                            \
-           "     .long 1b,2b\n"                            \
-           ".previous"                               \
-           : "=&c"(size), "=&D" (__d0), "=&S" (__d1)       \
-           : "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)    \
-           : "memory");                                    \
-} while (0)
+#define __copy_user(to,from,size)                          \
+do {                                                 \
+     int __d0, __d1, __d2;                                         \
+     __asm__ __volatile__(                                 \
+                "       cmpl $63, %0\n"                               \
+                "       jbe  5f\n"                                    \
+                "       mov %%si, %%ax\n"                             \
+                "       test $7, %%al\n"                              \
+                "       jz  5f\n"                                     \
+                "       .align 2,0x90\n"                              \
+                "0:     movl 32(%4), %%eax\n"                         \
+            "       cmpl $67, %0\n"                              \
+                "       jbe 1f\n"                                     \
+                "       movl 64(%4), %%eax\n"                         \
+                "       .align 2,0x90\n"                              \
+           "1:     movl 0(%4), %%eax\n"                          \
+                "       movl 4(%4), %%edx\n"                          \
+                "2:     movl %%eax, 0(%3)\n"                          \
+           "21:    movl %%edx, 4(%3)\n"                          \
+           "       movl 8(%4), %%eax\n"                          \
+           "       movl 12(%4),%%edx\n"                          \
+           "3:     movl %%eax, 8(%3)\n"                          \
+           "31:    movl %%edx, 12(%3)\n"                         \
+           "       movl 16(%4), %%eax\n"                         \
+           "       movl 20(%4), %%edx\n"                         \
+                "4:     movl %%eax, 16(%3)\n"                         \
+                "41:    movl %%edx, 20(%3)\n"                         \
+                "       movl 24(%4), %%eax\n"                         \
+                "       movl 28(%4), %%edx\n"                         \
+                "10:    movl %%eax, 24(%3)\n"                         \
+                "51:    movl %%edx, 28(%3)\n"                         \
+                "       movl 32(%4), %%eax\n"                         \
+                "       movl 36(%4), %%edx\n"                         \
+                "11:    movl %%eax, 32(%3)\n"                         \
+                "61:    movl %%edx, 36(%3)\n"                         \
+                "       movl 40(%4), %%eax\n"                         \
+                "       movl 44(%4), %%edx\n"                         \
+                "12:    movl %%eax, 40(%3)\n"                         \
+                "71:    movl %%edx, 44(%3)\n"                         \
+                "       movl 48(%4), %%eax\n"                         \
+                "       movl 52(%4), %%edx\n"                         \
+                "13:    movl %%eax, 48(%3)\n"                         \
+                "81:    movl %%edx, 52(%3)\n"                         \
+                "       movl 56(%4), %%eax\n"                         \
+                "       movl 60(%4), %%edx\n"                         \
+                "14:    movl %%eax, 56(%3)\n"                         \
+                "91:    movl %%edx, 60(%3)\n"                         \
+                "       addl $-64, %0\n"                              \
+                "       addl $64, %4\n"                               \
+                "       addl $64, %3\n"                               \
+                "       cmpl $63, %0\n"                               \
+                "       ja  0b\n"                                     \
+           "5:   movl  %0, %%eax\n"                            \
+                "       shrl  $2, %0\n"                               \
+                "       andl  $3, %%eax\n"                            \
+                "       cld\n"                                        \
+                "6:     rep; movsl\n"                                 \
+                "       movl %%eax, %0\n"                             \
+           "7:   rep; movsb\n"                             \
+           "8:\n"                                          \
+           ".section .fixup,\"ax\"\n"                      \
+           "9:   lea 0(%%eax,%0,4),%0\n"                   \
+           "     jmp 8b\n"                           \
+                "15:    movl %6, %0\n"                                \
+                "       jmp 8b\n"                                     \
+           ".previous\n"                                   \
+           ".section __ex_table,\"a\"\n"                   \
+           "     .align 4\n"                         \
+           "     .long 2b,15b\n"                           \
+           "     .long 21b,15b\n"                    \
+           "     .long 3b,15b\n"                           \
+           "     .long 31b,15b\n"                    \
+           "     .long 4b,15b\n"                           \
+           "     .long 41b,15b\n"                    \
+           "     .long 10b,15b\n"                      \
+           "     .long 51b,15b\n"                    \
+           "     .long 11b,15b\n"                    \
+           "     .long 61b,15b\n"                    \
+           "     .long 12b,15b\n"                    \
+           "     .long 71b,15b\n"                    \
+           "     .long 13b,15b\n"                    \
+           "     .long 81b,15b\n"                    \
+           "     .long 14b,15b\n"                          \
+           "     .long 91b,15b\n"                    \
+           "     .long 6b,9b\n"                            \
+                "       .long 7b,8b\n"                                \
+           ".previous"                               \
+           : "=&c"(size), "=&D" (__d0), "=&S" (__d1)       \
+           :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)         \
+           : "eax", "edx", "memory");                      \
+ } while (0)
+

 #define __copy_user_zeroing(to,from,size)                        \
 do {                                                 \
-     int __d0, __d1;                                       \
+     int __d0, __d1, __d2;                                 \
      __asm__ __volatile__(                                 \
-           "0:   rep; movsl\n"                             \
-           "     movl %3,%0\n"                             \
-           "1:   rep; movsb\n"                             \
-           "2:\n"                                          \
-           ".section .fixup,\"ax\"\n"                      \
-           "3:   lea 0(%3,%0,4),%0\n"                      \
-           "4:   pushl %0\n"                         \
-           "     pushl %%eax\n"                            \
-           "     xorl %%eax,%%eax\n"                       \
-           "     rep; stosb\n"                             \
-           "     popl %%eax\n"                             \
-           "     popl %0\n"                          \
-           "     jmp 2b\n"                           \
-           ".previous\n"                                   \
-           ".section __ex_table,\"a\"\n"                   \
-           "     .align 4\n"                         \
-           "     .long 0b,3b\n"                            \
-           "     .long 1b,4b\n"                            \
-           ".previous"                               \
-           : "=&c"(size), "=&D" (__d0), "=&S" (__d1)       \
-           : "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)    \
-           : "memory");                                    \
-} while (0)
+                "       cmpl $63, %0\n"                               \
+                "       jbe  5f\n"                                    \
+                "       movl %%di, %%ax\n"                            \
+                "       test $7, %%al\n"                              \
+                "       jz   5f\n"                                    \
+                "       .align 2,0x90\n"                              \
+                "0:     movl 32(%4), %%eax\n"                         \
+           "       cmpl $67, %0\n"                               \
+                "       jbe 2f\n"                                     \
+                "1:     movl 64(%4), %%eax\n"                         \
+                "       .align 2,0x90\n"                              \
+           "2:     movl 0(%4), %%eax\n"                          \
+                "21:    movl 4(%4), %%edx\n"                          \
+                "       movl %%eax, 0(%3)\n"                          \
+           "       movl %%edx, 4(%3)\n"                          \
+           "3:     movl 8(%4), %%eax\n"                          \
+           "31:    movl 12(%4),%%edx\n"                          \
+           "       movl %%eax, 8(%3)\n"                          \
+           "       movl %%edx, 12(%3)\n"                         \
+           "4:     movl 16(%4), %%eax\n"                         \
+           "41:    movl 20(%4), %%edx\n"                         \
+                "       movl %%eax, 16(%3)\n"                         \
+                "       movl %%edx, 20(%3)\n"                         \
+                "10:    movl 24(%4), %%eax\n"                         \
+                "51:    movl 28(%4), %%edx\n"                         \
+                "       movl %%eax, 24(%3)\n"                         \
+                "       movl %%edx, 28(%3)\n"                         \
+                "11:    movl 32(%4), %%eax\n"                         \
+                "61:    movl 36(%4), %%edx\n"                         \
+                "       movl %%eax, 32(%3)\n"                         \
+                "       movl %%edx, 36(%3)\n"                         \
+                "12:    movl 40(%4), %%eax\n"                         \
+                "71:    movl 44(%4), %%edx\n"                         \
+                "       movl %%eax, 40(%3)\n"                         \
+                "       movl %%edx, 44(%3)\n"                         \
+                "13:    movl 48(%4), %%eax\n"                         \
+                "81:    movl 52(%4), %%edx\n"                         \
+                "       movl %%eax, 48(%3)\n"                         \
+                "       movl %%edx, 52(%3)\n"                         \
+                "14:    movl 56(%4), %%eax\n"                         \
+                "91:    movl 60(%4), %%edx\n"                         \
+                "       movl %%eax, 56(%3)\n"                         \
+                "       movl %%edx, 60(%3)\n"                         \
+                "       addl $-64, %0\n"                              \
+                "       addl $64, %4\n"                               \
+                "       addl $64, %3\n"                               \
+                "       cmpl $63, %0\n"                               \
+                "       ja  0b\n"                                     \
+           "5:   movl  %0, %%eax\n"                            \
+                "       shrl  $2, %0\n"                               \
+                "       andl $3, %%eax\n"                             \
+                "       cld\n"                                        \
+                "6:     rep; movsl\n"                                 \
+                "       movl %%eax,%0\n"                              \
+           "7:   rep; movsb\n"                             \
+           "8:\n"                                          \
+           ".section .fixup,\"ax\"\n"                      \
+           "9:   lea 0(%%eax,%0,4),%0\n"                   \
+           "16:  pushl %0\n"                             \
+           "     pushl %%eax\n"                            \
+           "     xorl %%eax,%%eax\n"                       \
+           "     rep; stosb\n"                             \
+           "     popl %%eax\n"                             \
+           "     popl %0\n"                          \
+           "     jmp 8b\n"                           \
+                "15:    movl %6, %0\n"                                \
+                "       jmp 8b\n"                                     \
+           ".previous\n"                                   \
+           ".section __ex_table,\"a\"\n"                   \
+           "     .align 4\n"                         \
+           "     .long 0b,16b\n"                           \
+           "     .long 1b,16b\n"                           \
+           "     .long 2b,16b\n"                           \
+           "     .long 21b,16b\n"                    \
+           "     .long 3b,16b\n"                           \
+           "     .long 31b,16b\n"                    \
+           "     .long 4b,16b\n"                           \
+           "     .long 41b,16b\n"                    \
+           "     .long 10b,16b\n"                      \
+           "     .long 51b,16b\n"                    \
+           "     .long 11b,16b\n"                    \
+           "     .long 61b,16b\n"                    \
+           "     .long 12b,16b\n"                    \
+           "     .long 71b,16b\n"                    \
+           "     .long 13b,16b\n"                    \
+           "     .long 81b,16b\n"                    \
+           "     .long 14b,16b\n"                          \
+           "     .long 91b,16b\n"                    \
+           "     .long 6b,9b\n"                            \
+                "       .long 7b,16b\n"                               \
+           ".previous"                               \
+           : "=&c"(size), "=&D" (__d0), "=&S" (__d1)       \
+           :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)         \
+           : "eax", "edx", "memory");                      \
+ } while (0)

 /* We let the __ versions of copy_from/to_user inline, because they're
often
  * used in fast paths and have only a small space overhead.
@@ -578,24 +722,16 @@
 }

 #define copy_to_user(to,from,n)                      \
-     (__builtin_constant_p(n) ?                \
-      __constant_copy_to_user((to),(from),(n)) :     \
-      __generic_copy_to_user((to),(from),(n)))
+      __generic_copy_to_user((to),(from),(n))

 #define copy_from_user(to,from,n)              \
-     (__builtin_constant_p(n) ?                \
-      __constant_copy_from_user((to),(from),(n)) :   \
-      __generic_copy_from_user((to),(from),(n)))
+      __generic_copy_from_user((to),(from),(n))

 #define __copy_to_user(to,from,n)              \
-     (__builtin_constant_p(n) ?                \
-      __constant_copy_to_user_nocheck((to),(from),(n)) :   \
-      __generic_copy_to_user_nocheck((to),(from),(n)))
+      __generic_copy_to_user_nocheck((to),(from),(n))

 #define __copy_from_user(to,from,n)                  \
-     (__builtin_constant_p(n) ?                \
-      __constant_copy_from_user_nocheck((to),(from),(n)) : \
-      __generic_copy_from_user_nocheck((to),(from),(n)))
+      __generic_copy_from_user_nocheck((to),(from),(n))

 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);



