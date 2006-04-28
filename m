Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWD1AZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWD1AZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWD1AYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:24:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13526 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965158AbWD1AYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:24:36 -0400
Date: Thu, 27 Apr 2006 17:23:02 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/24] MIPS: R2 build fixes for gcc < 3.4.
Message-ID: <20060428002302.GW18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="MIPS-0002.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-mips/bitops.h    |   14 ++++++++++++--
 include/asm-mips/byteorder.h |    4 ++++
 include/asm-mips/interrupt.h |    8 ++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/include/asm-mips/bitops.h
+++ linux-2.6.16.11/include/asm-mips/bitops.h
@@ -654,7 +654,12 @@ static inline unsigned long fls(unsigned
 {
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_CPU_MIPS32
-	__asm__ ("clz %0, %1" : "=r" (word) : "r" (word));
+	__asm__ (
+	"	.set	mips32					\n"
+	"	clz	%0, %1					\n"
+	"	.set	mips0					\n"
+	: "=r" (word)
+	: "r" (word));
 
 	return 32 - word;
 #else
@@ -678,7 +683,12 @@ static inline unsigned long fls(unsigned
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_CPU_MIPS64
 
-	__asm__ ("dclz %0, %1" : "=r" (word) : "r" (word));
+	__asm__ (
+	"	.set	mips64					\n"
+	"	dclz	%0, %1					\n"
+	"	.set	mips0					\n"
+	: "=r" (word)
+	: "r" (word));
 
 	return 64 - word;
 #else
--- linux-2.6.16.11.orig/include/asm-mips/byteorder.h
+++ linux-2.6.16.11/include/asm-mips/byteorder.h
@@ -19,7 +19,9 @@
 static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__(
+	"	.set	mips32r2		\n"
 	"	wsbh	%0, %1			\n"
+	"	.set	mips0			\n"
 	: "=r" (x)
 	: "r" (x));
 
@@ -30,8 +32,10 @@ static __inline__ __attribute_const__ __
 static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__(
+	"	.set	mips32r2		\n"
 	"	wsbh	%0, %1			\n"
 	"	rotr	%0, %0, 16		\n"
+	"	.set	mips0			\n"
 	: "=r" (x)
 	: "r" (x));
 
--- linux-2.6.16.11.orig/include/asm-mips/interrupt.h
+++ linux-2.6.16.11/include/asm-mips/interrupt.h
@@ -20,7 +20,9 @@ __asm__ (
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	ei							\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	$1,$12						\n"
 	"	ori	$1,0x1f						\n"
@@ -63,7 +65,9 @@ __asm__ (
 	"	.set	push						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	di							\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	$1,$12						\n"
 	"	ori	$1,0x1f						\n"
@@ -103,8 +107,10 @@ __asm__ (
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	di	\\result					\n"
 	"	andi	\\result, 1					\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	\\result, $12					\n"
 	"	ori	$1, \\result, 0x1f				\n"
@@ -133,9 +139,11 @@ __asm__ (
 	 * Slow, but doesn't suffer from a relativly unlikely race
 	 * condition we're having since days 1.
 	 */
+	"	.set	mips32r2					\n"
 	"	beqz	\\flags, 1f					\n"
 	"	 di							\n"
 	"	ei							\n"
+	"	.set	mips0						\n"
 	"1:								\n"
 #elif defined(CONFIG_CPU_MIPSR2)
 	/*

--
