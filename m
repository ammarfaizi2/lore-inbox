Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUDUAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUDUAjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDUAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:39:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51585 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263881AbUDUAjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:39:03 -0400
Date: Tue, 20 Apr 2004 20:39:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4] fix module load with gcc3.3.3
Message-ID: <Pine.LNX.4.58.0404201957340.2252@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had trouble loading modules compiled with gcc3.3.3 because static unused
variables were being discarded. Patch is against 2.4-bk

<before>
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00002400  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .rodata.str1.4 000001dc  00000000  00000000  00002434  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 __ksymtab     00000038  00000000  00000000  00002610  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  3 .kstrtab      000000ac  00000000  00000000  00002648  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .data         00000154  00000000  00000000  000026f4  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  5 .bss          00000000  00000000  00000000  00002848  2**0
                  ALLOC
  6 .comment      0000004a  00000000  00000000  00002848  2**0
                  CONTENTS, READONLY
  7 .note.GNU-stack 00000000  00000000  00000000  00002892  2**0
                  CONTENTS, READONLY

<after>
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00002400  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .modinfo      00000064  00000000  00000000  00002434  2**2 <===
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .rodata.str1.4 000001dc  00000000  00000000  00002498  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 __ksymtab     00000038  00000000  00000000  00002674  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  4 .kstrtab      000000ac  00000000  00000000  000026ac  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .data         00000154  00000000  00000000  00002758  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  6 .bss          00000000  00000000  00000000  000028ac  2**0
                  ALLOC
  7 .comment      0000004a  00000000  00000000  000028ac  2**0
                  CONTENTS, READONLY
  8 .note.GNU-stack 00000000  00000000  00000000  000028f6  2**0
                  CONTENTS, READONLY

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Tue Apr 20 19:56:39 2004
+++ b/include/linux/module.h	Tue Apr 20 19:56:39 2004
@@ -8,6 +8,7 @@
 #define _LINUX_MODULE_H

 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>

@@ -284,7 +285,7 @@
  */

 #define MODULE_LICENSE(license) 	\
-static const char __module_license[] __attribute__((section(".modinfo"))) =   \
+static const char __module_license[] __attribute_used__ __attribute__((section(".modinfo"))) =   \
 "license=" license

 /* Define the module variable, and usage macros.  */
@@ -296,10 +297,10 @@
 #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)

 #include <linux/version.h>
-static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
+static const char __module_kernel_version[] __attribute_used__ __attribute__((section(".modinfo"))) =
 "kernel_version=" UTS_RELEASE;
 #ifdef MODVERSIONS
-static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
+static const char __module_using_checksums[] __attribute_used__ __attribute__((section(".modinfo"))) =
 "using_checksums=1";
 #endif

