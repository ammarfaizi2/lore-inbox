Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbSI3QqQ>; Mon, 30 Sep 2002 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSI3QqQ>; Mon, 30 Sep 2002 12:46:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9723 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262329AbSI3QqJ>;
	Mon, 30 Sep 2002 12:46:09 -0400
Subject: Copy patch for kernel 2.5.38
To: akpm@digeo.com, Hirokazu Takahashi <taka@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCD687C7E.7D759551-ON87256C40.0068B3E2@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 30 Sep 2002 11:51:22 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/30/2002 10:51:21 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is the patch that adds an unrolled loop copy using
integer registers.I posted this patch in June 2002 and I received
some suggestions at that time. As a result I changed the inline
code to subroutines. The generic_copy_to_user and
generic_copy_from_user call these new routines if the src and
dst addresses are not aligned on an 8-byte boundary.

I also used Hirokazu Takahashi's csum patch along with the copy
patch (called as patch2 below) which would use the new copy routine
at the send side also. For the first case where I didn't
use csum patch, the send side used csum_partial_copy_generic.

Since kernel 2.5.38 does not compile for a UNI processor, I ran the test
on SMP with maxcpus set to 1.

Two 996 MHz Pentium III 2-way systems with 4 gig memory/256KB L2 cache
are used. Each system has oneIntel Gigabit Ethernet network card.
2.5.38 kernel from www.kernel.org was used without highmem support.
Intel e1000 driver (the one in the kernel) is used
Napi is not enabled, however I ran the tests with and without TSO.

The TCP_STREAM test was run with TCP-NO Deay ON, 64k socket buffer
size and with a mtu size of 1500. The rest of tcp parameters used are
default values.


Only copypatch is used:
-----------------------

       2.5.38        2.5.38+patch   -- % improvement using patch --
 msg   Throughput    Throughput                   Sender   Receiver
 size  10^6bits/s    10^6bits/s     Throughput      CPU         CPU

  512      507.7      538.2           6.0 %     -6.4 %      0.0 %
 1024      566.3      584.8           3.3 %    -16.5 %      1.7 %
 2048      503.7      595.8          18.3 %    -14.9 %    -21.3 %
 4096      578.5      600.3           3.8 %    -19.7 %     -0.5 %
 8192      624.7      700.9          12.2 %    - 2.2 %     -1.4 %
16384      593.5      632.9           6.6 %      0.9 %     -6.7 %
32768      659.9      584.9         -11.4 %      7.0 %     11.4 %
65536      655.8      697.7           6.4 %     -1.0 %      0.5 %


I used Hirokazu Takahashi's csumpartial_fix patch which is available at
ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va-csumpartial-fix-2.5.36.patch
.
The patch applies on 2.5.38 cleanly. With this patch, checksum is done
by the hardware and the new copyroutine is used at the sender side.

copypatch + csumpatch are used:
-------------------------------

       2.5.38        2.5.38+patch2  -- % improvement using patch --
 msg   Throughput    Throughput                   Sender   Receiver
 size  10^6bits/s    10^6bits/s     Throughput      CPU         CPU

  512      507.7      543.0           7.0 %      -5.5 %      0.0 %
 1024      566.3      587.0           3.7 %     -17.8 %      1.5 %
 2048      503.7      577.2          14.6 %     -19.6 %    -11.0 %
 4096      578.5      561.0          -3.0 %      -2.0 %      4.8 %
 8192      624.7      624.2          -0.1 %      11.4 %     10.3 %
16384      593.5      611.0           2.9%       20.5 %     -0.4 %
32768      659.9      628.3          -4.8%       27.6 %      7.8 %
65536      655.8      699.6           6.7 %      19.0 %      2.5 %

Since I saw an interrupt pause problem with 2.5.38 running netperf3,
I disabled TSO and ran the same tests with the same configuration
except for TSO and the results from this tests are as follows:


        NO_TSO         NO_TSO
       2.5.38        2.5.38+patch   -- % improvement using patch --
 msg   Throughput    Throughput                   Sender   Receiver
 size  10^6bits/s    10^6bits/s     Throughput      CPU      CPU

  512      497.9      546.3           9.7 %      -6.3 %     0.0 %
 1024      550.5      603.4           9.6 %      -7.5 %     0.0 %
 2048      586.9      649.4          10.6 %      -8.0%      0.0 %
 4096      620.5      690.4          11.3 %     -11.6%      0.0 %
 8192      647.6      726.8          12.2 %     -16.5%      0.0 %
16384      669.1      756.3          13.0 %     -14.8%      0.0 %
32768      650.9      734.3          12.8 %     -13.4%      0.0 %
65536      626.9      701.8          11.9 %     -12.9%      0.1 %


copypatch + csumpatch are used:
-------------------------------

       NO_TSO          NO_TSO
       2.5.38        2.5.38+patch2  -- % improvement using patch --
 msg   Throughput    Throughput                   Sender   Receiver
 size  10^6bits/s    10^6bits/s     Throughput      CPU         CPU

  512      497.9      540.1           8.5%       -5.5 %      0.0 %
 1024      550.5      601.2           9.2 %      -4.9 %      0.0 %
 2048      586.9      647.6          10.3 %      -4.7 %      0.0 %
 4096      620.5      690.9          11.3 %      -0.8 %      0.0 %
 8192      647.6      738.3          14.0 %      -7.4 %      0.0 %
16384      669.1      763.5          14.1 %      -5.3 %      0.0 %
32768      650.9      733.7          12.7 %      -3.1 %      0.0 %
65536      626.9      712.8          13.7 %      -2.9 %      0.5 %


In the non tso case, the throughput improved for all the message sizes,
and sender side CPU utilization is improved with the csum patch.
I did not see the interrupt pause problem when I disabled TSO in
2.5.38 kernel.




The updated copy patch for 2.5.38 is given here:

diff -Naurb linux-2538/arch/i386/lib/usercopy.c
linux-2538copy/arch/i386/lib/usercopy.c
--- linux-2538/arch/i386/lib/usercopy.c   Tue Sep 24 08:25:56 2002
+++ linux-2538copy/arch/i386/lib/usercopy.c     Mon Sep 30 10:53:39 2002
@@ -45,8 +45,12 @@
 __generic_copy_to_user(void *to, const void *from, unsigned long n)
 {
      prefetch(from);
-     if (access_ok(VERIFY_WRITE, to, n))
+     if (access_ok(VERIFY_WRITE, to, n)){
+       if ((n < 64) || ((((int)from | (int)to) & 0x00000007)==0))
            __copy_user(to,from,n);
+       else
+         n=__copy_user_int(to,from,n);
+     }
      return n;
 }

@@ -54,9 +58,13 @@
 __generic_copy_from_user(void *to, const void *from, unsigned long n)
 {
      prefetchw(to);
-     if (access_ok(VERIFY_READ, from, n))
+     if (access_ok(VERIFY_READ, from, n)){
+       if ((n < 64) || ((((int)from | (int)to) & 0x00000007)==0))
            __copy_user_zeroing(to,from,n);
      else
+         n=__copy_user_zeroing_int(to,from,n);
+     }
+     else
            memset(to, 0, n);
      return n;
 }
@@ -188,3 +196,191 @@
            :"cc");
      return res & mask;
 }
+
+
+/*
+ * Copy To/From Userspace
+ */
+
+/* Generic arbitrary sized copy.  */
+unsigned long  __copy_user_int(void *to, const void *from,unsigned long
size){
+  int d0, d1;
+  __asm__ __volatile__(
+                  "       .align 2,0x90\n"
+                  "0:     movl 32(%4), %%eax\n"
+                  "       cmpl $67, %0\n"
+                  "       jbe 1f\n"
+                  "       movl 64(%4), %%eax\n"
+                  "       .align 2,0x90\n"
+                  "1:     movl 0(%4), %%eax\n"
+                  "       movl 4(%4), %%edx\n"
+                  "2:     movl %%eax, 0(%3)\n"
+                  "21:    movl %%edx, 4(%3)\n"
+                  "       movl 8(%4), %%eax\n"
+                  "       movl 12(%4),%%edx\n"
+                  "3:     movl %%eax, 8(%3)\n"
+                  "31:    movl %%edx, 12(%3)\n"
+                  "       movl 16(%4), %%eax\n"
+                  "       movl 20(%4), %%edx\n"
+                  "4:     movl %%eax, 16(%3)\n"
+                  "41:    movl %%edx, 20(%3)\n"
+                  "       movl 24(%4), %%eax\n"
+                  "       movl 28(%4), %%edx\n"
+                  "10:    movl %%eax, 24(%3)\n"
+                  "51:    movl %%edx, 28(%3)\n"
+                  "       movl 32(%4), %%eax\n"
+                  "       movl 36(%4), %%edx\n"
+                  "11:    movl %%eax, 32(%3)\n"
+                  "61:    movl %%edx, 36(%3)\n"
+                  "       movl 40(%4), %%eax\n"
+                  "       movl 44(%4), %%edx\n"
+                  "12:    movl %%eax, 40(%3)\n"
+                  "71:    movl %%edx, 44(%3)\n"
+                  "       movl 48(%4), %%eax\n"
+                  "       movl 52(%4), %%edx\n"
+                  "13:    movl %%eax, 48(%3)\n"
+                  "81:    movl %%edx, 52(%3)\n"
+                  "       movl 56(%4), %%eax\n"
+                  "       movl 60(%4), %%edx\n"
+                  "14:    movl %%eax, 56(%3)\n"
+                  "91:    movl %%edx, 60(%3)\n"
+                  "       addl $-64, %0\n"
+                  "       addl $64, %4\n"
+                  "       addl $64, %3\n"
+                  "       cmpl $63, %0\n"
+                  "       ja  0b\n"
+                  "5:     movl  %0, %%eax\n"
+                  "       shrl  $2, %0\n"
+                  "       andl  $3, %%eax\n"
+                  "       cld\n"
+                  "6:     rep; movsl\n"
+                  "       movl %%eax, %0\n"
+                  "7:     rep; movsb\n"
+                  "8:\n"
+                  ".section .fixup,\"ax\"\n"
+                  "9:     lea 0(%%eax,%0,4),%0\n"
+                  "       jmp 8b\n"
+                  "15:    movl %6, %0\n"
+                  "       jmp 8b\n"
+                  ".previous\n"
+                  ".section __ex_table,\"a\"\n"
+                  "       .align 4\n"
+                  "       .long 2b,15b\n"
+                  "       .long 21b,15b\n"
+                  "       .long 3b,15b\n"
+                  "       .long 31b,15b\n"
+                  "       .long 4b,15b\n"
+                  "       .long 41b,15b\n"
+                  "       .long 10b,15b\n"
+                  "       .long 51b,15b\n"
+                  "       .long 11b,15b\n"
+                  "       .long 61b,15b\n"
+                  "       .long 12b,15b\n"
+                  "       .long 71b,15b\n"
+                  "       .long 13b,15b\n"
+                  "       .long 81b,15b\n"
+                  "       .long 14b,15b\n"
+                  "       .long 91b,15b\n"
+                  "       .long 6b,9b\n"
+                  "       .long 7b,8b\n"
+                  ".previous"
+                  : "=&c"(size), "=&D" (d0), "=&S" (d1)
+                  :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)
+                  : "eax", "edx", "memory");
+  return size;
+}
+
+unsigned long  __copy_user_zeroing_int(void *to,const void *from, unsigned
long size){
+  int d0, d1;
+  __asm__ __volatile__(
+                  "        .align 2,0x90\n"
+                  "0:      movl 32(%4), %%eax\n"
+                  "        cmpl $67, %0\n"
+                  "        jbe 2f\n"
+                  "1:      movl 64(%4), %%eax\n"
+                  "        .align 2,0x90\n"
+                  "2:      movl 0(%4), %%eax\n"
+                  "21:     movl 4(%4), %%edx\n"
+                  "        movl %%eax, 0(%3)\n"
+                  "        movl %%edx, 4(%3)\n"
+                  "3:      movl 8(%4), %%eax\n"
+                  "31:     movl 12(%4),%%edx\n"
+                  "        movl %%eax, 8(%3)\n"
+                  "        movl %%edx, 12(%3)\n"
+                  "4:      movl 16(%4), %%eax\n"
+                  "41:     movl 20(%4), %%edx\n"
+                  "        movl %%eax, 16(%3)\n"
+                  "        movl %%edx, 20(%3)\n"
+                  "10:     movl 24(%4), %%eax\n"
+                  "51:     movl 28(%4), %%edx\n"
+                  "        movl %%eax, 24(%3)\n"
+                  "        movl %%edx, 28(%3)\n"
+                  "11:     movl 32(%4), %%eax\n"
+                  "61:     movl 36(%4), %%edx\n"
+                  "        movl %%eax, 32(%3)\n"
+                  "        movl %%edx, 36(%3)\n"
+                  "12:     movl 40(%4), %%eax\n"
+                  "71:     movl 44(%4), %%edx\n"
+                  "        movl %%eax, 40(%3)\n"
+                  "        movl %%edx, 44(%3)\n"
+                  "13:     movl 48(%4), %%eax\n"
+                  "81:     movl 52(%4), %%edx\n"
+                  "        movl %%eax, 48(%3)\n"
+                  "        movl %%edx, 52(%3)\n"
+                  "14:     movl 56(%4), %%eax\n"
+                  "91:     movl 60(%4), %%edx\n"
+                  "        movl %%eax, 56(%3)\n"
+                  "        movl %%edx, 60(%3)\n"
+                  "        addl $-64, %0\n"
+                  "        addl $64, %4\n"
+                  "        addl $64, %3\n"
+                  "        cmpl $63, %0\n"
+                  "        ja  0b\n"
+                  "5:      movl  %0, %%eax\n"
+                  "        shrl  $2, %0\n"
+                  "        andl $3, %%eax\n"
+                  "        cld\n"
+                  "6:      rep; movsl\n"
+                  "        movl %%eax,%0\n"
+                  "7:      rep; movsb\n"
+                  "8:\n"
+                  ".section .fixup,\"ax\"\n"
+                  "9:      lea 0(%%eax,%0,4),%0\n"
+                  "16:     pushl %0\n"
+                  "        pushl %%eax\n"
+                  "        xorl %%eax,%%eax\n"
+                  "        rep; stosb\n"
+                  "        popl %%eax\n"
+                  "        popl %0\n"
+                  "        jmp 8b\n"
+                  "15:     movl %6, %0\n"
+                  "        jmp 8b\n"
+                  ".previous\n"
+                  ".section __ex_table,\"a\"\n"
+                  "    .align 4\n"
+                  "    .long 0b,16b\n"
+                  "    .long 1b,16b\n"
+                  "    .long 2b,16b\n"
+                  "    .long 21b,16b\n"
+                  "    .long 3b,16b\n"
+                  "    .long 31b,16b\n"
+                  "    .long 4b,16b\n"
+                  "    .long 41b,16b\n"
+                  "    .long 10b,16b\n"
+                  "    .long 51b,16b\n"
+                  "    .long 11b,16b\n"
+                  "    .long 61b,16b\n"
+                  "    .long 12b,16b\n"
+                  "    .long 71b,16b\n"
+                  "    .long 13b,16b\n"
+                  "    .long 81b,16b\n"
+                  "    .long 14b,16b\n"
+                  "    .long 91b,16b\n"
+                  "    .long 6b,9b\n"
+                  "        .long 7b,16b\n"
+                  ".previous"
+                  : "=&c"(size), "=&D" (d0), "=&S" (d1)
+                  :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)
+                  : "eax", "edx", "memory");
+  return size;
+}
diff -Naurb linux-2538/include/asm-i386/uaccess.h
linux-2538copy/include/asm-i386/uaccess.h
--- linux-2538/include/asm-i386/uaccess.h Thu Sep 26 16:27:47 2002
+++ linux-2538copy/include/asm-i386/uaccess.h   Fri Sep 27 16:10:14 2002
@@ -34,6 +34,8 @@
 #define segment_eq(a,b)      ((a).seg == (b).seg)

 extern int __verify_write(const void *, unsigned long);
+extern unsigned long __copy_user_int(void *to, const void *from, unsigned
long size);
+extern unsigned long __copy_user_zeroing_int(void *to, const void *from,
unsigned long size);

 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()
->addr_limit.seg))

@@ -309,14 +311,20 @@
 static inline unsigned long
 __generic_copy_from_user_nocheck(void *to, const void *from, unsigned long
n)
 {
+  if ((n < 64) || ((((int)from | (int)to) & 0x00000007)==0))
      __copy_user_zeroing(to,from,n);
+  else
+    n=__copy_user_zeroing_int(to,from,n);
      return n;
 }

 static inline unsigned long
 __generic_copy_to_user_nocheck(void *to, const void *from, unsigned long
n)
 {
+  if ((n < 64) || ((((int)from | (int)to) & 0x00000007)==0))
      __copy_user(to,from,n);
+  else
+    n=__copy_user_int(to,from,n);
      return n;
 }

@@ -578,24 +586,16 @@
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


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




