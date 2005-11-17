Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKQJlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKQJlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKQJlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:41:46 -0500
Received: from out002.iad.hostedmail.net ([209.225.56.24]:64047 "EHLO
	out002a.iad.hostedmail.net") by vger.kernel.org with ESMTP
	id S1750714AbVKQJlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:41:45 -0500
Message-ID: <437C50FA.20101@qlusters.com>
Date: Thu, 17 Nov 2005 11:44:26 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Constantine Gavrilov <constg@qlusters.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: gcc optimizer miscompiles code with sigaddset on i386 if sig
 arg is const  -- PATCH proposed
References: <437B97D0.2040803@qlusters.com> <437C2F08.50801@qlusters.com>
In-Reply-To: <437C2F08.50801@qlusters.com>
Content-Type: multipart/mixed;
 boundary="------------030407070809010600000502"
X-OriginalArrivalTime: 17 Nov 2005 09:41:45.0280 (UTC) FILETIME=[1F7D8C00:01C5EB5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407070809010600000502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Constantine Gavrilov wrote:

> I have run into problem using sigaddset() with constant signal 
> argument in kernel code.
> .................


According to jakub@xxxxxxxx <mailto:jakub@redhat.com>, gcc maintainer at RedHat, it is a pure kernel bug
and not a gcc problem.  I have reworked the patch but kept the constant case optimization.

A quote form Jakub to make the issue clear:

That's just buggy testcase.
You need either
__asm__("btsl %1,%0" : "+m"(*set) : "Ir"(_sig-1) : "cc");
or
__asm__("btsl %1,%0" : "=m"(*set) : "Ir"(_sig-1), "m"(*set) : "cc");
because the btsl instruction doesn't just set the memory to some value, but
needs to read its previous content as well.  If you don't tell that fact to GCC,
GCC is of course free to optimize as if the asm was just setting the value
and not depended on the previous value.

Attached please find a new patch.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


--------------030407070809010600000502
Content-Type: text/plain;
 name="sigset_ops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigset_ops.patch"

--- signal.h.orig	Thu Nov 17 08:47:14 2005
+++ signal.h	Thu Nov 17 11:19:55 2005
@@ -186,14 +186,37 @@
 
 #define __HAVE_ARCH_SIG_BITOPS
 
-static __inline__ void sigaddset(sigset_t *set, int _sig)
+#define sigaddset(set,sig)                 \
+	(__builtin_constant_p(sig) ?       \
+	__const_sigaddset((set),(sig)) :   \
+	__gen_sigaddset((set),(sig)))
+
+static __inline__ void __gen_sigaddset(sigset_t *set, int _sig)
+{
+	__asm__("btsl %1,%0" : "+m"(*set) : "Ir"(_sig - 1) : "cc");
+}
+
+static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
+{
+	unsigned long sig = _sig - 1;
+	set->sig[sig / _NSIG_BPW] |= 1 << (sig % _NSIG_BPW);
+}
+
+#define sigdelset(set,sig)                 \
+	(__builtin_constant_p(sig) ?       \
+	__const_sigdelset((set),(sig)) :   \
+	__gen_sigdelset((set),(sig)))
+
+
+static __inline__ void __gen_sigdelset(sigset_t *set, int _sig)
 {
-	__asm__("btsl %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
+	__asm__("btrl %1,%0" : "+m"(*set) : "Ir"(_sig - 1) : "cc");
 }
 
-static __inline__ void sigdelset(sigset_t *set, int _sig)
+static __inline__ void __const_sigaddset(sigset_t *set, int _sig)
 {
-	__asm__("btrl %1,%0" : "=m"(*set) : "Ir"(_sig - 1) : "cc");
+	unsigned long sig = _sig - 1;
+	set->sig[sig / _NSIG_BPW] &= ~(1 << (sig % _NSIG_BPW));
 }
 
 static __inline__ int __const_sigismember(sigset_t *set, int _sig)

--------------030407070809010600000502--
