Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132767AbRDVGIZ>; Sun, 22 Apr 2001 02:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135261AbRDVGIG>; Sun, 22 Apr 2001 02:08:06 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:27376 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S132767AbRDVGHq>; Sun, 22 Apr 2001 02:07:46 -0400
From: junio@siamese.dhis.twinsun.com
To: Manuel McLure <manuel@mclure.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>
	<20010421211722.C976@ulthar.internal.mclure.org>
Date: 21 Apr 2001 23:07:28 -0700
In-Reply-To: <20010421211722.C976@ulthar.internal.mclure.org>
Message-ID: <7vitjxcvrz.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MM" == Manuel McLure <manuel@mclure.org> writes:

MM> Something's wrong with this - it won't build with RH 7.1 kgcc
MM> (egcs-2.91.66):
    ...
MM> rwsem.o(.text+0x2ed): undefined reference to `__builtin_expect'
MM> /usr/src/linux-2.4.3-ac12/lib/lib.a(rwsem.o): In function
MM> `rwsem_up_write_wake':rwsem.o(.text+0x3c6): undefined reference to
MM> `__builtin_expect'
MM> make: *** [vmlinux] Error 1
MM> Sat Apr 21 20:35:37 PDT 2001

MM> ac12 builds OK with the standard RH 7.1 gcc (2.96), ac11 built fine with
MM> both the standard gcc and kgcc.

You need the following patch on i386.  I am not attaching any
diff for other architectures , since I do not know which version
of gcc on other architectures started implementing this feature.

If gcc 2.96 uniformly implements it, I'd rather move this
backward compatibility definition of __builtin_expect from
include/asm-$(arch)/compiler.h to include/asm-generic/
somewhere.

--- 2.4.3-ac12/include/asm-i386/compiler.h	Sat Apr 21 22:56:03 2001
+++ 2.4.3-ac12/include/asm-i386/compiler.h	Sat Apr 21 22:56:43 2001
@@ -0,0 +1,13 @@
+#ifndef __I386_COMPILER_H
+#define __I386_COMPILER_H 1
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
+   a mechanism by which the user can annotate likely branch directions and
+   expect the blocks to be reordered appropriately.  Define __builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __I386_COMPILER_H */


--- 2.4.3-ac12/include/asm-i386/semaphore.h	Sat Apr 21 22:55:38 2001
+++ 2.4.3-ac12/include/asm-i386/semaphore.h	Sat Apr 21 22:55:57 2001
@@ -38,6 +38,7 @@
 
 #include <asm/system.h>
 #include <asm/atomic.h>
+#include <asm/compiler.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
