Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRD1Hk3>; Sat, 28 Apr 2001 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRD1HkT>; Sat, 28 Apr 2001 03:40:19 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:13984 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S132352AbRD1HkN>; Sat, 28 Apr 2001 03:40:13 -0400
Date: Sat, 28 Apr 2001 09:39:43 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] buz.c compilation problem (missing macro) in 2.4.4
Message-ID: <20010428093943.A17724@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.4 returns this error when compiling the buz module, the macro
MALLOC_MAXSIZE is missing:

[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes
-O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686
-DMODULE   -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
[...]

This error was also present in 2.4.3 (forgot to report it :) ).
Some patch seems to have changed the original name of this macro
(MAX_KMALLOC_MEM) into KMALLOC_MAXSIZE, but the define of this macro
(#define MAX_KMALLOC_MEM (512*1024)) was removed...
This value (512 kb) is wrong anyway, according to Dr. Rainer Johanni (the
original maintainer). He recommends to make it 128 kb, which was originally
the value in his driver.

So the proper patch would be as simple as:

*** buz.c-old   Sat Apr 28 09:16:24 2001
--- buz.c       Sat Apr 28 09:16:57 2001
***************
*** 97,102 ****
--- 97,103 ----
  #define MINOR_VERSION 0               /* driver minor version */

  #define BUZ_NAME      "Iomega BUZ V-1.0"      /* name of the driver */
+ #define KMALLOC_MAXSIZE (128*1024)

  #define DEBUG(x)              /* Debug driver */
  #define IDEBUG(x)             /* Debug interrupt handler */

Although this driver will probably be replaced by the new one from Serguei
Miridonov sooner or later, imho it's best to fix this for the time being...

--
Ronald Bultje

