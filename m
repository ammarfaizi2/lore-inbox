Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVEJPUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVEJPUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVEJPTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:19:06 -0400
Received: from schlund.terranet.ro ([80.96.218.84]:41278 "EHLO
	dizzywork.schlund.ro") by vger.kernel.org with ESMTP
	id S261673AbVEJPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:14:24 -0400
Message-ID: <4280CFD1.5010108@schlund.ro>
Date: Tue, 10 May 2005 18:14:25 +0300
From: Mihai Rusu <dizzy@schlund.ro>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@novell.com>
Subject: [RFC][PATCH 2.4 3/4] inotify 0.22 2.4.x backport - atomic_inc_return
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030607070104090802000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607070104090802000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Backported atomic_inc_return() from 2.6.11 for x86. Needed by inotify.c.
I have not backported for other architectures as I don't have access to
such devices and I could not test. It should be easy to do that tho.
This also means that this inotify backport currently only works for x86.

-- 
Mihai Rusu
Linux System Development

Schlund + Partner AG   Tel         : +40-21-231-2544
Str Mircea Eliade 18   EMail       : dizzy@schlund.ro
Sect 1, Bucuresti
71295, Romania



--------------030607070104090802000902
Content-Type: text/x-patch;
 name="03_atomic_inc_return-x86-2.4.30.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03_atomic_inc_return-x86-2.4.30.patch"


 atomic.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)


diff -uNr linux-2.4.30.orig/include/asm-i386/atomic.h linux-2.4.30/include/asm-i386/atomic.h
--- linux-2.4.30.orig/include/asm-i386/atomic.h	2001-11-22 21:46:18.000000000 +0200
+++ linux-2.4.30/include/asm-i386/atomic.h	2005-05-09 11:58:56.000000000 +0300
@@ -186,6 +186,40 @@
 	return c;
 }
 
+/**
+ * atomic_add_return - add and return
+ * @v: pointer of type atomic_t
+ * @i: integer value to add
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ int atomic_add_return(int i, atomic_t *v)
+{
+        int __i;
+#ifdef CONFIG_M386
+        if(unlikely(boot_cpu_data.x86==3))
+                goto no_xadd;
+#endif
+        /* Modern 486+ processor */
+        __i = i;
+        __asm__ __volatile__(
+                LOCK "xaddl %0, %1;"
+                :"=r"(i)
+                :"m"(v->counter), "0"(i));
+        return i + __i;
+
+#ifdef CONFIG_M386
+no_xadd: /* Legacy 386 processor */
+        local_irq_disable();
+        __i = atomic_read(v);
+        atomic_set(v, i + __i);
+        local_irq_enable();
+        return i + __i;
+#endif
+}
+
+#define atomic_inc_return(v)  (atomic_add_return(1,v))
+
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \



--------------030607070104090802000902--
