Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUCCAYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUCCAYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:24:43 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:10250 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S262262AbUCCAYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:24:36 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 2 Mar 2004 18:23:39 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile kernel with GCC-3.5 and without regparm
Message-ID: <20040303002339.GA20651@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I tried to build the kernel with my CVS GCC-3.5 compiler today, and had
all sorts of failures about prototypes not matching. My configuration
had not selected the 'CONFIG_REGPARM' option, so the new '-mregparm=3'
flag wasn't passed to the compiler. That's fine, but the problem is the
FASTCALL macro is unconditionally defined to add an regparm(3)
attribute, making the compiler quite confused. The following small patch
conditionally defines FASTCALL, and allowed my compilation to succeed
either with or without the CONFIG_REGPARM conditional being defined.

I tested this patch by configuring a kernel without the CONFIG_REGPARM
flag, then started the build. Once the build got through building a
couple of files in 'arch/i386/kernel' that had failed previously, I
stopped the build. A cleanup and reconfiguration with the CONFIG_REGPARM
conditional followed, and a new build began. Again, the files in the
same directory compiled fine, so things looked good. I then tried to
build with CONFIG_REGPARM defined and setting CC and HOSTCC to use
my gcc-2.95 compiler, and the files in that directory compiled again
successfully once more.

If this patch is deemed correct, a similar patch for 'asm-um' is
likely necessary as well.

Art Haas

===== include/asm-i386/linkage.h 1.2 vs edited =====
--- 1.2/include/asm-i386/linkage.h	Sun Aug  4 00:44:49 2002
+++ edited/include/asm-i386/linkage.h	Tue Mar  2 17:59:59 2004
@@ -2,7 +2,9 @@
 #define __ASM_LINKAGE_H
 
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
+#ifdef CONFIG_REGPARM
 #define FASTCALL(x)	x __attribute__((regparm(3)))
+#endif
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
