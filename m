Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVINGpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVINGpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVINGpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:45:15 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:7008 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965050AbVINGpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:45:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HAq9PhfqX04T8otwOG+Vji1mRQQFaiesJYkNaGs6t7rahX0CkUv/ePjfn9ss+DAhWSTLE/BI+JOYNwRvjmvOtGEh9f1XvElzV4rea6x694SZYZcwcCMTRGKhPR3G0t+iG5TFwNMJ3GL+PRJLPnWnhcZn3W35FE5F2AUVbMA/soA=
Message-ID: <cb57165a0509132345419655fe@mail.gmail.com>
Date: Tue, 13 Sep 2005 23:45:10 -0700
From: Lee Nicks <allinux@gmail.com>
Reply-To: allinux@gmail.com
To: "akpm@osdl.org" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RESEND [PATCH 2.6.14-rc1] ppc: prevent GCC 4 from generating AltiVec instructions in kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on how GCC is built, GCC 4 may generate altivec instructions
without user explicitly requesting vector operations in the code.
Although this is a performance booster for user applications, it is a
problem for kernel.
This patch explicitly instruct GCC to NOT generate altivec
instructions while building the kernel.
Here are some test cases I ran.
(1) build gcc 4.0.1 with '--with-cpu=7450 --enable-altivec
--enable-cxx-flags=-mcpu=7450', and use this gcc to build kernel
WITHOUT this kernel patch. Kernel fail to boot up on a 7450 board
because of altivec instructions in kernel.
(2) build gcc 4.0.1 with "--with-cpu=7450 --enable-altivec
--enable-cxx-flags=-mcpu=7450", and use this gcc to build kernel WITH
this kernel patch. Kernel boot up on a 7450 board without any problem.
(3) build gcc 4.0.1 with "--with-cpu=750
--enable-cxx-flags=-mcpu=750", and use this gcc to build kernel with
or without this kernel patch. Kernel boot up on a 7450 board without
any problem.
This patch should also work with GCC 3 or even earlier GCC 2.95.3.
Please review it for inclusion.

Signed-off-by: Lee Nicks <allinux@gmail.com>
======================================

diff -ruN linux-2.6.14-rc1-original/arch/ppc/Makefile
linux-2.6.14-rc1/arch/ppc/Makefile
--- linux-2.6.14-rc1-original/arch/ppc/Makefile 2005-09-13
20:00:34.000000000 -0700
+++ linux-2.6.14-rc1/arch/ppc/Makefile  2005-09-13 20:09:36.000000000 -0700
@@ -26,6 +26,12 @@
 AFLAGS         += -Iarch/$(ARCH)
 CFLAGS         += -Iarch/$(ARCH) -msoft-float -pipe \
                -ffixed-r2 -mmultiple
+
+# No AltiVec instruction when building kernel
+CFLAGS          += $(call cc-option, -mno-altivec)
+
 CPP            = $(CC) -E $(CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE    += -Iarch/$(ARCH)/include
diff -ruN linux-2.6.14-rc1-original/arch/ppc64/Makefile
linux-2.6.14-rc1/arch/ppc64/Makefile
--- linux-2.6.14-rc1-original/arch/ppc64/Makefile       2005-09-13
20:00:36.000000000 -0700
+++ linux-2.6.14-rc1/arch/ppc64/Makefile        2005-09-13
20:08:41.000000000 -0700
@@ -75,6 +75,11 @@
        CFLAGS += $(call cc-option,-mtune=power4)
 endif

+# No AltiVec instruction when building kernel
+CFLAGS          += $(call cc-option, -mno-altivec)
+
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
