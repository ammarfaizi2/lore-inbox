Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTJ1POX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTJ1POX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:14:23 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:16850 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263998AbTJ1POG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:14:06 -0500
Subject: Re: 2.6.0-test9: selinux compile error with "make O=..."
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031027184217.GA1718@mars.ravnborg.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
	 <20031026002209.GD23291@fs.tum.de> <20031026094923.GA925@mars.ravnborg.org>
	 <1067262042.18818.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20031027184217.GA1718@mars.ravnborg.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1067353800.24864.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Oct 2003 10:10:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 13:42, Sam Ravnborg wrote:
> If the usage of -include is fixed then from a kbuild perspective there
> is no problem.

This patch against 2.6.0-test9 removes the use of -include and removes
the global.h file, adding appropriate individual #includes to the
various files in the security/selinux/ss subdirectory.  This fixes
selinux for make O=... builds.  As this is non-critical, I expect that
it won't go in until after 2.6.0, so I'll just plan on submitting it to
Andrew Morton after 2.6.0 rather than bothering him with it now.

 security/selinux/ss/Makefile   |    3 +--
 security/selinux/ss/avtab.c    |    4 ++++
 security/selinux/ss/ebitmap.c  |    3 +++
 security/selinux/ss/global.h   |   18 ------------------
 security/selinux/ss/hashtab.c  |    3 +++
 security/selinux/ss/mls.c      |    4 ++++
 security/selinux/ss/policydb.c |    5 +++++
 security/selinux/ss/services.c |   11 +++++++++++
 security/selinux/ss/sidtab.c   |    6 ++++++
 security/selinux/ss/symtab.c   |    4 ++++
 10 files changed, 41 insertions(+), 20 deletions(-)

Index: linux-2.6/security/selinux/ss/Makefile
diff -u linux-2.6/security/selinux/ss/Makefile:1.1.1.1 linux-2.6/security/selinux/ss/Makefile:1.6
--- linux-2.6/security/selinux/ss/Makefile:1.1.1.1	Tue Aug 12 09:05:06 2003
+++ linux-2.6/security/selinux/ss/Makefile	Tue Oct 28 09:08:27 2003
@@ -2,8 +2,7 @@
 # Makefile for building the SELinux security server as part of the kernel tree.
 #
 
-EXTRA_CFLAGS += -Isecurity/selinux/include -include security/selinux/ss/global.h
-
+EXTRA_CFLAGS += -Isecurity/selinux/include 
 obj-y := ss.o
 
 ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
Index: linux-2.6/security/selinux/ss/avtab.c
diff -u linux-2.6/security/selinux/ss/avtab.c:1.1.1.2 linux-2.6/security/selinux/ss/avtab.c:1.15
--- linux-2.6/security/selinux/ss/avtab.c:1.1.1.2	Tue Sep  9 08:50:50 2003
+++ linux-2.6/security/selinux/ss/avtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/errno.h>
 #include "avtab.h"
 #include "policydb.h"
 
Index: linux-2.6/security/selinux/ss/ebitmap.c
diff -u linux-2.6/security/selinux/ss/ebitmap.c:1.1.1.2 linux-2.6/security/selinux/ss/ebitmap.c:1.13
--- linux-2.6/security/selinux/ss/ebitmap.c:1.1.1.2	Tue Sep  9 08:50:50 2003
+++ linux-2.6/security/selinux/ss/ebitmap.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,9 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
 #include "ebitmap.h"
 #include "policydb.h"
 
Index: linux-2.6/security/selinux/ss/global.h
diff -u linux-2.6/security/selinux/ss/global.h:1.1.1.3 linux-2.6/security/selinux/ss/global.h:removed
--- linux-2.6/security/selinux/ss/global.h:1.1.1.3	Tue Sep  9 08:50:51 2003
+++ linux-2.6/security/selinux/ss/global.h	Tue Oct 28 09:13:31 2003
@@ -1,18 +0,0 @@
-#ifndef _SS_GLOBAL_H_
-#define _SS_GLOBAL_H_
-
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/in.h>
-#include <linux/spinlock.h>
-#include <linux/sched.h>
-#include <linux/vmalloc.h>
-
-#include "flask.h"
-#include "avc.h"
-#include "avc_ss.h"
-#include "security.h"
-
-#endif /* _SS_GLOBAL_H_ */
Index: linux-2.6/security/selinux/ss/hashtab.c
diff -u linux-2.6/security/selinux/ss/hashtab.c:1.1.1.1 linux-2.6/security/selinux/ss/hashtab.c:1.7
--- linux-2.6/security/selinux/ss/hashtab.c:1.1.1.1	Tue Aug 12 09:05:08 2003
+++ linux-2.6/security/selinux/ss/hashtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,9 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
 #include "hashtab.h"
 
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, void *key),
Index: linux-2.6/security/selinux/ss/mls.c
diff -u linux-2.6/security/selinux/ss/mls.c:1.1.1.2 linux-2.6/security/selinux/ss/mls.c:1.18
--- linux-2.6/security/selinux/ss/mls.c:1.1.1.2	Mon Sep 29 09:14:40 2003
+++ linux-2.6/security/selinux/ss/mls.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include "mls.h"
 #include "policydb.h"
 #include "services.h"
Index: linux-2.6/security/selinux/ss/policydb.c
diff -u linux-2.6/security/selinux/ss/policydb.c:1.1.1.4 linux-2.6/security/selinux/ss/policydb.c:1.26
--- linux-2.6/security/selinux/ss/policydb.c:1.1.1.4	Mon Sep 29 09:14:41 2003
+++ linux-2.6/security/selinux/ss/policydb.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,11 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include "security.h"
 #include "policydb.h"
 #include "mls.h"
 
Index: linux-2.6/security/selinux/ss/services.c
diff -u linux-2.6/security/selinux/ss/services.c:1.1.1.2 linux-2.6/security/selinux/ss/services.c:1.30
--- linux-2.6/security/selinux/ss/services.c:1.1.1.2	Thu Oct  9 08:48:31 2003
+++ linux-2.6/security/selinux/ss/services.c	Tue Oct 28 09:08:27 2003
@@ -10,6 +10,17 @@
  *	it under the terms of the GNU General Public License version 2,
  *      as published by the Free Software Foundation.
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/in.h>
+#include <asm/semaphore.h>
+#include "flask.h"
+#include "avc.h"
+#include "avc_ss.h"
+#include "security.h"
 #include "context.h"
 #include "policydb.h"
 #include "sidtab.h"
Index: linux-2.6/security/selinux/ss/sidtab.c
diff -u linux-2.6/security/selinux/ss/sidtab.c:1.1.1.1 linux-2.6/security/selinux/ss/sidtab.c:1.13
--- linux-2.6/security/selinux/ss/sidtab.c:1.1.1.1	Tue Aug 12 09:05:07 2003
+++ linux-2.6/security/selinux/ss/sidtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,12 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include "flask.h"
+#include "security.h"
 #include "sidtab.h"
 
 #define SIDTAB_HASH(sid) \
Index: linux-2.6/security/selinux/ss/symtab.c
diff -u linux-2.6/security/selinux/ss/symtab.c:1.1.1.1 linux-2.6/security/selinux/ss/symtab.c:1.5
--- linux-2.6/security/selinux/ss/symtab.c:1.1.1.1	Tue Aug 12 09:05:08 2003
+++ linux-2.6/security/selinux/ss/symtab.c	Tue Oct 28 09:08:27 2003
@@ -3,6 +3,10 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include "symtab.h"
 
 static unsigned int symhash(struct hashtab *h, void *key)


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

