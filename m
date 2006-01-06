Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWAFKp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWAFKp2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWAFKp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932201AbWAFKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:27 -0500
Subject: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:38:34 +0100
Message-Id: <1136543914.2940.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: allow gcc4 to optimize unit-at-a-time


From: Ingo Molnar <mingo@elte.hu>

allow gcc4 compilers to optimize unit-at-a-time. 

This flag enables gcc to "see" the entire C file before making optimisation
decisions such as inline, which results in gcc making better decisions. One
of the immediate effects of this is that static functions that are used only
once now get inlined.

gcc 3.4 has this flag as well, however gcc 3.x have a problem with inlining
and stacks and as a result, enabling this flag there would cause excessive
and unacceptable stack use. This problem is fixed in the gcc 4.x series. 
The x86-64 architecture already enables this feature so it's well tested 
already.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 arch/i386/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.15/arch/i386/Makefile
===================================================================
--- linux-2.6.15.orig/arch/i386/Makefile
+++ linux-2.6.15/arch/i386/Makefile
@@ -42,9 +42,9 @@ include $(srctree)/arch/i386/Makefile.cp
 GCC_VERSION			:= $(call cc-version)
 cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
 
-# Disable unit-at-a-time mode, it makes gcc use a lot more stack
-# due to the lack of sharing of stacklots.
-CFLAGS += $(call cc-option,-fno-unit-at-a-time)
+# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
+# a lot more stack due to the lack of sharing of stacklots:
+CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
 
 CFLAGS += $(cflags-y)
 


