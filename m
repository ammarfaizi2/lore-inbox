Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264678AbSJOPcp>; Tue, 15 Oct 2002 11:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSJOPcp>; Tue, 15 Oct 2002 11:32:45 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:46740 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264678AbSJOPcl>; Tue, 15 Oct 2002 11:32:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: Linux Kernel <linux-kernel@vger.kernel.org>, kai@tp1.ruhr-uni-bochum.de
Subject: s390x build warnings from <linux/module.h>
Date: Tue, 15 Oct 2002 19:36:34 +0200
User-Agent: KMail/1.4.3
Organization: IBM Deutschland Entwicklung GmbH
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210151936.34119.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during 'make modules' on s390x, I see lots of warnings about 'ignoring 
changed section attributes for __ksymtab' that I have found to be the 
result of changeset 1.373.196.1, where Kai changed the defaults for module 
exports to 'no symbols exported'.

The problem is that there is a section '__ksymtab,"a"', while s390x 
requires it to be '__ksymtab,"aw"' because modules must be compiled with
'-fpic' here, unlike afaics all the other architectures.

The patch below is a workaround for the Problem and should be
correct on all architectures, but I'd prefer if there was a nicer
way to do that.

	Arnd <><

--- broken/include/linux/module.h      15 Oct 2002 07:55:01 -0000      1.8
+++ ugly/include/linux/module.h      15 Oct 2002 15:30:39 -0000
@@ -498,5 +498,9 @@
  * "export all symbols" to modutils)
  */
+#ifndef __PIC__
 __asm__(".section __ksymtab,\"a\"\n.previous");
+#else
+__asm__(".section __ksymtab,\"aw\"\n.previous");
+#endif
 #endif
 
