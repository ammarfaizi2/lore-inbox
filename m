Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTAIT6P>; Thu, 9 Jan 2003 14:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTAIT6P>; Thu, 9 Jan 2003 14:58:15 -0500
Received: from splat.lanl.gov ([128.165.17.254]:60803 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S267974AbTAIT6J>; Thu, 9 Jan 2003 14:58:09 -0500
Date: Thu, 9 Jan 2003 13:06:46 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] checksum.h header fixes for 2.4
Message-ID: <20030109200646.GG3329@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All-

I'm making a loadable module that will send IP packets; and need to do IP
checksums. Unfortunately a simple #include of checksum.h fails because that
file does not itself include the headers required to compile correctly.
Several of the arch-specific files are this way.

* Some files use VERIFY_READ, VERIFY_WRITE, access_ok from uaccess.h but do
not include uaccess.h

* Some files have an IPv6 checksum with struct in6_addr, but do not include
linux/in6.h. x86_64 just defines the structure instead of including the
file. Either way works, but it's inconsistent. I've moved them all to the
#include, but they could all go to the struct in6_addr way too.

These need both linux/in6.h, and uaccess.h
    File name             VERIFY_  in6_addr |  headers
    asm-i386/checksum.h      Y        Y     |    -
    asm-sh/checksum.h        Y        Y     |  config

These need just linux/in6.h
    File name             VERIFY_  in6_addr |  headers
    asm-mips/checksum.h      N        Y     |  uaccess
    asm-mips64/checksum.h    N        Y     |  uaccess
    asm-alpha/checksum.h     N        Y     |    - 
    asm-arm/checksum.h       N        Y     |    - 
    asm-m68k/checksum.h      N        Y     |    - 
    asm-parisc/checksum.h    N        Y     |    - 
    asm-x86_64/checksum.h    N        Y     |  uaccess/compiler/byteorder

The remainder are fine:
    File name             VERIFY_  in6_addr |  headers
    asm-sparc/checksum.h     Y        Y     |  uaccess/in6/cprefix
    asm-sparc64/checksum.h   N        Y     |  uaccess/in6
    asm-s390/checksum.h      N        N     |  uaccess
    asm-s390x/checksum.h     N        N     |  uaccess
    asm-cris/checksum.h      N        N     |    -
    asm-ia64/checksum.h      N        N     |    -
    asm-ppc/checksum.h       N        N     |    -
    asm-ppc64/checksum.h     N        N     |    -

--------------------------------------------------------------------------------
--- linux/include/asm-i386/checksum.h.bak	2003-01-09 12:26:05.000000000 -0700
+++ linux/include/asm-i386/checksum.h	2003-01-09 12:52:01.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef _I386_CHECKSUM_H
 #define _I386_CHECKSUM_H
 
+#include <linux/in6.h>
+#include <asm/uaccess.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
--- linux/include/asm-sh/checksum.h.bak	2003-01-09 12:26:11.000000000 -0700
+++ linux/include/asm-sh/checksum.h	2003-01-09 12:52:02.000000000 -0700
@@ -1,6 +1,9 @@
 #ifndef __ASM_SH_CHECKSUM_H
 #define __ASM_SH_CHECKSUM_H
 
+#include <linux/in6.h>
+#include <asm/uaccess.h>
+
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
--- linux/include/asm-mips/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-mips/checksum.h	2003-01-09 12:52:02.000000000 -0700
@@ -8,6 +8,7 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
+#include <linux/in6.h>
 #include <asm/uaccess.h>
 
 /*
--- linux/include/asm-mips64/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-mips64/checksum.h	2003-01-09 12:52:02.000000000 -0700
@@ -11,6 +11,7 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
+#include <linux/in6.h>
 #include <asm/uaccess.h>
 
 /*
--- linux/include/asm-alpha/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-alpha/checksum.h	2003-01-09 12:52:03.000000000 -0700
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_CHECKSUM_H
 #define _ALPHA_CHECKSUM_H
 
+#include <linux/in6.h>
 
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
--- linux/include/asm-arm/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-arm/checksum.h	2003-01-09 12:52:03.000000000 -0700
@@ -9,6 +9,8 @@
 #ifndef __ASM_ARM_CHECKSUM_H
 #define __ASM_ARM_CHECKSUM_H
 
+#include <linux/in6.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
--- linux/include/asm-m68k/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-m68k/checksum.h	2003-01-09 12:52:03.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef _M68K_CHECKSUM_H
 #define _M68K_CHECKSUM_H
 
+#include <linux/in6.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
--- linux/include/asm-parisc/checksum.h.bak	2003-01-09 12:50:34.000000000 -0700
+++ linux/include/asm-parisc/checksum.h	2003-01-09 12:52:04.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef _PARISC_CHECKSUM_H
 #define _PARISC_CHECKSUM_H
 
+#include <linux/in6.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
--- ./linux/include/asm-x86_64/checksum.h.bak    2003-01-09 12:50:34.000000000 -0700
+++ ./linux/include/asm-x86_64/checksum.h        2003-01-09 12:59:58.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef _X86_64_CHECKSUM_H
 #define _X86_64_CHECKSUM_H
 
+#include <linux/in6.h>
+
 /* 
  * Checksums for x86-64 
  * Copyright 2002 by Andi Kleen, SuSE Labs 
@@ -171,9 +173,6 @@
  * into UDP/TCP packets and contains some link layer information.
  * Returns the unfolded 32bit checksum.
  */
-
-struct in6_addr;
-
 #define _HAVE_ARCH_IPV6_CSUM 1
 extern unsigned short 
 csum_ipv6_magic(struct in6_addr *saddr, struct in6_addr *daddr,
--------------------------------------------------------------------------------

Marcelo, please apply.

-Eric

-- 
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------
