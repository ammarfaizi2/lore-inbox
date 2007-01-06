Return-Path: <linux-kernel-owner+w=401wt.eu-S1751104AbXAFC2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbXAFC2k (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXAFC2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47936 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbXAFC1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:51 -0500
Message-Id: <20070106023111.020959000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:05 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       zippel@linux-m68k.org, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>,
       <jpdenheijer@gmail.com>, Horst Schirmeier <horst@schirmeier.com>
Subject: [patch 12/50] kbuild: dont put temp files in source
Content-Disposition: inline; filename=kbuild-don-t-put-temp-files-in-source.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Roman Zippel <zippel@linux-m68k.org>

The as-instr/ld-option need to create temporary files, but create them in the
output directory, when compiling external modules.  Reformat them a bit and
use $(CC) instead of $(AS) as the former is used by kbuild to assemble files.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: <jpdenheijer@gmail.com>
Cc: Horst Schirmeier <horst@schirmeier.com>
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
It fixes building of external modules in a sandboxed environment.
http://bugs.gentoo.org/149307

 scripts/Kbuild.include |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- linux-2.6.19.1.orig/scripts/Kbuild.include
+++ linux-2.6.19.1/scripts/Kbuild.include
@@ -56,6 +56,9 @@ endef
 # gcc support functions
 # See documentation in Documentation/kbuild/makefiles.txt
 
+# output directory for tests below
+TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
+
 # as-option
 # Usage: cflags-y += $(call as-option, -Wa$(comma)-isa=foo,)
 
@@ -66,9 +69,11 @@ as-option = $(shell if $(CC) $(CFLAGS) $
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
 
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
-		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+as-instr = $(shell if echo -e "$(1)" | \
+		      $(CC) $(AFLAGS) -c -xassembler - \
+			    -o $(TMPOUT)astest$$$$.out > /dev/null 2>&1; \
+		   then rm $(TMPOUT)astest$$$$.out; echo "$(2)"; \
+		   else echo "$(3)"; fi)
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
@@ -97,10 +102,10 @@ cc-ifversion = $(shell if [ $(call cc-ve
 
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
-ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+ld-option = $(shell if $(CC) $(1) -nostdlib -xc /dev/null \
+			     -o $(TMPOUT)ldtest$$$$.out > /dev/null 2>&1; \
+             then rm $(TMPOUT)ldtest$$$$.out; echo "$(1)"; \
+             else echo "$(2)"; fi)
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=

--
