Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWGBSYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWGBSYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWGBSYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:24:38 -0400
Received: from xenotime.net ([66.160.160.81]:47848 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964852AbWGBSYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:24:37 -0400
Date: Sun, 2 Jul 2006 11:27:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: ralf@linux-mips.org, akpm@osdl.org, erik_frederiksen@pmc-sierra.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] consistently use MAX_ERRNO in __syscall_return
Message-Id: <20060702112722.74b5adff.rdunlap@xenotime.net>
In-Reply-To: <44A6F5E3.8000300@zytor.com>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
	<20060628140825.692f31be.rdunlap@xenotime.net>
	<20060629181013.GA18777@linux-mips.org>
	<20060701114409.ed320be0.rdunlap@xenotime.net>
	<44A6F5E3.8000300@zytor.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 15:23:31 -0700 H. Peter Anvin wrote:

> > Are changes also needed in asm-*/unistd.h::syscall_return() macros?
> > or is syscall_return() just not used?
> > 
> > e.g.,
> > arm26 uses -125 to detect error
> > arm uses -129 to detect error
> > frv uses -4095 to detect error
> > i386 uses -129
> > h8300, m32r, s390, sh64, v850 use -125
> > m68k[nommu] uses -125
> > sh uses -124
> > x86_64 uses -127
> > 
> 
> ... and they're pretty much all wrong (in some cases, they're actually 
> less than actual errno values on that architecture!)
> 
> It pretty much works because they're not used.  They should either be 
> fixed or removed.

From: Randy Dunlap <rdunlap@xenotime.net>

Consistently use MAX_ERRNO when checking for errors
in __syscall_return().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/asm-arm/unistd.h       |    3 ++-
 include/asm-arm26/unistd.h     |    3 ++-
 include/asm-frv/unistd.h       |    3 ++-
 include/asm-h8300/unistd.h     |    6 +++---
 include/asm-i386/unistd.h      |    5 +++--
 include/asm-m32r/unistd.h      |    5 +++--
 include/asm-m68k/unistd.h      |    5 +++--
 include/asm-m68knommu/unistd.h |    5 +++--
 include/asm-s390/unistd.h      |    4 +++-
 include/asm-sh/unistd.h        |    7 +++++--
 include/asm-sh64/unistd.h      |    6 ++++--
 include/asm-v850/unistd.h      |    5 +++--
 include/asm-x86_64/unistd.h    |    5 +++--
 13 files changed, 39 insertions(+), 23 deletions(-)

--- linux-2617-g20.orig/include/asm-arm/unistd.h
+++ linux-2617-g20/include/asm-arm/unistd.h
@@ -377,6 +377,7 @@
 #endif
 
 #ifdef __KERNEL__
+#include <linux/err.h>
 #include <linux/linkage.h>
 
 #define __sys2(x) #x
@@ -396,7 +397,7 @@
 
 #define __syscall_return(type, res)					\
 do {									\
-	if ((unsigned long)(res) >= (unsigned long)(-129)) {		\
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) {	\
 		errno = -(res);						\
 		res = -1;						\
 	}								\
--- linux-2617-g20.orig/include/asm-arm26/unistd.h
+++ linux-2617-g20/include/asm-arm26/unistd.h
@@ -311,6 +311,7 @@
 #define __ARM_NR_usr26			(__ARM_NR_BASE+3)
 
 #ifdef __KERNEL__
+#include <linux/err.h>
 #include <linux/linkage.h>
 
 #define __sys2(x) #x
@@ -322,7 +323,7 @@
 
 #define __syscall_return(type, res)					\
 do {									\
-	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
+	if ((unsigned long)(res) >= (unsigned long)-MAX_ERRNO) {	\
 		errno = -(res);						\
 		res = -1;						\
 	}								\
--- linux-2617-g20.orig/include/asm-frv/unistd.h
+++ linux-2617-g20/include/asm-frv/unistd.h
@@ -320,6 +320,7 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls 310
+#include <linux/err.h>
 
 /*
  * process the return value of a syscall, consigning it to one of two possible fates
@@ -329,7 +330,7 @@
 #define __syscall_return(type, res)					\
 do {									\
         unsigned long __sr2 = (res);					\
-	if (__builtin_expect(__sr2 >= (unsigned long)(-4095), 0)) {	\
+	if (__builtin_expect(__sr2 >= (unsigned long)(-MAX_ERRNO), 0)) { \
 		errno = (-__sr2);					\
 		__sr2 = ~0UL;						\
 	}								\
--- linux-2617-g20.orig/include/asm-h8300/unistd.h
+++ linux-2617-g20/include/asm-h8300/unistd.h
@@ -295,14 +295,14 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls 289
+#include <linux/err.h>
 
-
-/* user-visible error numbers are in the range -1 - -122: see
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO: see
    <asm-m68k/errno.h> */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 	/* avoid using res which is declared to be in register d0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--- linux-2617-g20.orig/include/asm-i386/unistd.h
+++ linux-2617-g20/include/asm-i386/unistd.h
@@ -327,14 +327,15 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls 318
+#include <linux/err.h>
 
 /*
- * user-visible error numbers are in the range -1 - -128: see
+ * user-visible error numbers are in the range -1 - -MAX_ERRNO: see
  * <asm-i386/errno.h>
  */
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 		errno = -(res); \
 		res = -1; \
 	} \
--- linux-2617-g20.orig/include/asm-m32r/unistd.h
+++ linux-2617-g20/include/asm-m32r/unistd.h
@@ -298,14 +298,15 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls 285
+#include <linux/err.h>
 
-/* user-visible error numbers are in the range -1 - -124: see
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO: see
  * <asm-m32r/errno.h>
  */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-(124 + 1))) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 	/* Avoid using "res" which is declared to be in register r0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--- linux-2617-g20.orig/include/asm-m68k/unistd.h
+++ linux-2617-g20/include/asm-m68k/unistd.h
@@ -288,13 +288,14 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls		282
+#include <linux/err.h>
 
-/* user-visible error numbers are in the range -1 - -124: see
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO: see
    <asm-m68k/errno.h> */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 	/* avoid using res which is declared to be in register d0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--- linux-2617-g20.orig/include/asm-m68knommu/unistd.h
+++ linux-2617-g20/include/asm-m68knommu/unistd.h
@@ -289,13 +289,14 @@
 #ifdef __KERNEL__
 
 #define NR_syscalls		282
+#include <linux/err.h>
 
-/* user-visible error numbers are in the range -1 - -122: see
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO: see
    <asm-m68k/errno.h> */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 	/* avoid using res which is declared to be in register d0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--- linux-2617-g20.orig/include/asm-s390/unistd.h
+++ linux-2617-g20/include/asm-s390/unistd.h
@@ -394,9 +394,11 @@
 
 #ifdef __KERNEL__
 
+#include <linux/err.h>
+
 #define __syscall_return(type, res)			     \
 do {							     \
-	if ((unsigned long)(res) >= (unsigned long)(-4095)) {\
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 		errno = -(res);				     \
 		res = -1;				     \
 	}						     \
--- linux-2617-g20.orig/include/asm-sh64/unistd.h
+++ linux-2617-g20/include/asm-sh64/unistd.h
@@ -347,8 +347,10 @@
 #ifdef __KERNEL__ 
 
 #define NR_syscalls 321
+#include <linux/err.h>
 
-/* user-visible error numbers are in the range -1 - -125: see <asm-sh64/errno.h> */
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO:
+ * see <asm-sh64/errno.h> */
 
 #define __syscall_return(type, res) \
 do { \
@@ -358,7 +360,7 @@ do { \
 	**       life easier in the system call epilogue (see entry.S)      \
 	*/								    \
         register unsigned long __sr2 __asm__ ("r2") = res;		    \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) {	    \
 		errno = -(res);						    \
 		__sr2 = -1; 						    \
 	} \
--- linux-2617-g20.orig/include/asm-sh/unistd.h
+++ linux-2617-g20/include/asm-sh/unistd.h
@@ -306,11 +306,14 @@
 
 #ifdef __KERNEL__
 
-/* user-visible error numbers are in the range -1 - -124: see <asm-sh/errno.h> */
+#include <linux/err.h>
+
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO:
+ * see <asm-sh/errno.h> */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-124)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 	/* Avoid using "res" which is declared to be in register r0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \
--- linux-2617-g20.orig/include/asm-v850/unistd.h
+++ linux-2617-g20/include/asm-v850/unistd.h
@@ -238,12 +238,13 @@
 #ifdef __KERNEL__
 
 #include <asm/clinkage.h>
+#include <linux/err.h>
 
 #define __syscall_return(type, res)					      \
   do {									      \
-	  /* user-visible error numbers are in the range -1 - -124:	      \
+	  /* user-visible error numbers are in the range -1 - -MAX_ERRNO:      \
 	     see <asm-v850/errno.h> */					      \
-	  if (__builtin_expect ((unsigned long)(res) >= (unsigned long)(-125), 0)) { \
+	  if (__builtin_expect ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO), 0)) { \
 		  errno = -(res);					      \
 		  res = -1;						      \
 	  }								      \
--- linux-2617-g20.orig/include/asm-x86_64/unistd.h
+++ linux-2617-g20/include/asm-x86_64/unistd.h
@@ -623,16 +623,17 @@ __SYSCALL(__NR_move_pages, sys_move_page
 #ifdef __KERNEL__
 
 #define __NR_syscall_max __NR_move_pages
+#include <linux/err.h>
 
 #ifndef __NO_STUBS
 
-/* user-visible error numbers are in the range -1 - -4095 */
+/* user-visible error numbers are in the range -1 - -MAX_ERRNO */
 
 #define __syscall_clobber "r11","rcx","memory" 
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-127)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-MAX_ERRNO)) { \
 		errno = -(res); \
 		res = -1; \
 	} \


---
