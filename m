Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272123AbTG2Uog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272124AbTG2Uof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:44:35 -0400
Received: from waste.org ([209.173.204.2]:32657 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272123AbTG2Uo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:44:26 -0400
Date: Tue, 29 Jul 2003 15:44:19 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] automate patch names in kernel versions
Message-ID: <20030729204419.GE6049@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps times have changed enough that I can revive this idea from a
few years ago:

http://groups.google.com/groups?q=patchname+oxymoron&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1

<quote year=1999>
This four-line patch provides a means for listing what patches have
been built into a kernel. This will help track non-standard kernel
versions, such as those released by Redhat, or Alan's ac series, etc.
more easily.

With this patch in place, each new patch can include a file of the
form "patchname.[identifier]" in the top level source directory and
[identifier] will then be added to the kernel version string. For
instance, Alan's ac patches could include a file named patchdesc.ac2
(containing a change log, perhaps), and the resulting kernel would be
identified as 2.2.0-pre6+ac2, both at boot and by uname.

This may prove especially useful for tracking problems with kernels
built by distribution packagers and problems reported by automated
tools.
</quote>

The patch now appends patches as -name rather than +name to avoid
issues that might exist with packaging tools and scripts.

diff -urN -x genksyms -x '*.ver' -x '.patch*' -x '*.orig' orig/Makefile patched/Makefile
--- orig/Makefile	2003-07-29 13:31:50.000000000 -0500
+++ patched/Makefile	2003-07-29 15:25:36.000000000 -0500
@@ -25,7 +25,10 @@
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+PATCHES=$(shell find -maxdepth 1 -name 'patchdesc.*[^~]' -printf '+%f' | \
+	sed -e 's/+patchdesc\./-/g')
+KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(PATCHES)
+
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
@@ -504,7 +507,7 @@
 	)
 endef
 
-include/linux/version.h: Makefile
+include/linux/version.h: Makefile patchdesc.*
 	$(call filechk,version.h)
 
 # ---------------------------------------------------------------------------


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
