Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbTIEAry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTIEAry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:47:54 -0400
Received: from zero.aec.at ([193.170.194.10]:8206 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261652AbTIEArw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:47:52 -0400
Date: Fri, 5 Sep 2003 02:47:10 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org, akpm@osdl.org, rth@redhat.com,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905004710.GA31000@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

gcc 3.4 current has switched to default -fno-unit-at-a-time mode for -O2. 
The 3.3-Hammer branch compiler used in some distributions also does this.

Unfortunately the kernel doesn't compile with unit-at-a-time currently,
it cannot tolerate the reordering of functions in relation to inline
assembly.

This patch just turns it off when gcc supports the option.

I only did it for i386 for now. The problem is actually not i386 specific
(other architectures break too), so it may make sense to move the check_gcc 
stuff into the main Makefile and do it for everybody.

-Andi

--- linux-2.6.0test4-work/arch/i386/Makefile-o	2003-08-23 13:03:08.000000000 +0200
+++ linux-2.6.0test4-work/arch/i386/Makefile	2003-09-05 02:14:07.000000000 +0200
@@ -26,6 +26,10 @@
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
+# gcc 3.4/3.3-hammer support -funit-at-a-time mode, but the Kernel is not ready
+# for it yet
+CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
+
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
 cflags-$(CONFIG_M386)		+= -march=i386
