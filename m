Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbUKKQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUKKQQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUKKQQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:16:35 -0500
Received: from asplinux.ru ([195.133.213.194]:5128 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262268AbUKKQQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:16:21 -0500
Message-ID: <419390CC.9040805@sw.ru>
Date: Thu, 11 Nov 2004 19:18:20 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] 4/4GB: remove FIXADDR_TOP changing
Content-Type: multipart/mixed;
 boundary="------------010702060701070207090406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702060701070207090406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes VSYSCALL_BASE/FIXADDR_TOP relations problems
in 4gb split kernels (under some combinations of options/patches):
- if FIXADDR_TOP is changed, VSYSCALL_BASE in vsyscall.lds should be
   changed as well
- original 4gb split changes FIXADDR_TOP to be sure that stack
   is 2 pages aligned, but vsyscall.lds uses hardcoded constants inside.
   So we had /sbin/init loading problems due to ld-linux.so trying to
   access wrong addresses in VSYSCALL page.

The fix is the aligment of 4gb pages instead of alignment of FIXADDR_TOP

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

P.S. These 4GB split patches are against modified 2.6.8.1 kernel, but 
should be appliable to last Fedora kernels

--------------010702060701070207090406
Content-Type: text/plain;
 name="diff-arch-4gb-fixaddr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-fixaddr"

--- ./include/asm-i386/kmap_types.h.4gb-fix	2004-10-08 16:05:35.000000000 +0400
+++ ./include/asm-i386/kmap_types.h	2004-10-11 16:16:28.462098360 +0400
@@ -10,7 +10,8 @@ enum km_type {
 	 * the 4G/4G virtual stack must be THREAD_SIZE aligned on each cpu.
 	 */
 	KM_BOUNCE_READ,
-	KM_VSTACK_BASE,
+	__KM_VSTACK_BASE,
+	KM_VSTACK_BASE = __KM_VSTACK_BASE + (__KM_VSTACK_BASE % 2),
 	KM_VSTACK_TOP = KM_VSTACK_BASE + STACK_PAGE_COUNT-1,
 
 	KM_LDT_PAGE15,
@@ -29,7 +30,8 @@ enum km_type {
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
-	KM_TYPE_NR
+	__KM_TYPE_NR,
+	KM_TYPE_NR=__KM_TYPE_NR + (__KM_TYPE_NR % 2)
 };
 
 #endif
--- ./include/asm-i386/fixmap.h.4gb-fix	2004-10-11 15:55:38.000000000 +0400
+++ ./include/asm-i386/fixmap.h	2004-10-11 16:25:58.279472952 +0400
@@ -21,6 +21,8 @@
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
 
+#define __FIXADDR_TOP (0xfffff000UL)
+
 /*
  * Here we define all the compile-time 'special' virtual
  * addresses. The point is to have a constant address at
@@ -77,7 +79,10 @@ enum fixed_addresses {
 	FIX_CYCLONE_TIMER, /*cyclone timer register*/
 	FIX_VSTACK_HOLE_2,
 #endif 
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	/* reserved pte's for temporary kernel mappings */
+	__FIX_KMAP_BEGIN,
+	FIX_KMAP_BEGIN = __FIX_KMAP_BEGIN + (__FIX_KMAP_BEGIN & 1) +
+		((__FIXADDR_TOP >> PAGE_SHIFT) & 1),
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #ifdef CONFIG_ACPI_BOOT
 	FIX_ACPI_BEGIN,
@@ -118,7 +123,7 @@ extern void __set_fixmap (enum fixed_add
  * IMPORTANT: we have to align FIXADDR_TOP so that the virtual stack
  * is THREAD_SIZE aligned.
  */
-#define FIXADDR_TOP	(0xffffe000UL & ~(THREAD_SIZE-1))
+#define FIXADDR_TOP	__FIXADDR_TOP
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 

--------------010702060701070207090406--

