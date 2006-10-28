Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWJ1XHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWJ1XHd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 19:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWJ1XHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 19:07:33 -0400
Received: from quickstop.soohrt.org ([85.131.246.152]:12996 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S932113AbWJ1XHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 19:07:32 -0400
Date: Sun, 29 Oct 2006 01:07:30 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>,
       Sam Ravnborg <sam@ravnborg.org>, jpdenheijer@gmail.com,
       linux-kernel@vger.kernel.org, dsd@gentoo.org, draconx@gmail.com,
       kernel@gentoo.org
Subject: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061028230730.GA28966@quickstop.soohrt.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>,
	jpdenheijer@gmail.com, linux-kernel@vger.kernel.org, dsd@gentoo.org,
	draconx@gmail.com, kernel@gentoo.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the kbuild-dont-put-temp-files-in-the-source-tree.patch (-mm patches) is
implemented faultily and fails in its intention to put temporary files
in $TMPDIR (or /tmp by default).

This is the code as it results from the patch:

ASTMP = $(shell mktemp ${TMPDIR:-/tmp}/asXXXXXX)
as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o $ASTMP ; \
 		   then echo "$(2)"; else echo "$(3)"; fi; \
	           rm -f $ASTMP)

1) $ needs to be escaped in the shell function call, otherwise make
   tries to substitute with a (in this case not existing) make variable
   with this name.

2) Makefile variable names need to be put in parentheses; $ASTMP is
   being interpreted as $(A)STMP, resulting in as-instr writing to a file
   named after whatever is in $(A), followed by "STMP".

3) ld-option also writes to a temporary file and needs the same
   treatment.

Please consider using the corrected patch below instead. Alternatively,
we could also simply use -o /dev/null, as we are not interested in the
output anyways. Daniel Drake already suggested this in a LKML post
(message-id 452F9602.1050906@gentoo.org).

It would also be nice if this would make it into the mainline kernel
before 2.6.19 gets released; this would help avoiding the sandbox
violation problems on Gentoo Linux [1] [2].

Kind regards,
 Horst Schirmeier

[1] http://bugs.gentoo.org/show_bug.cgi?id=149307
[2] LKML Message-ID: <451ABE0E.2030904@web.de>

---
http://bugzilla.kernel.org/show_bug.cgi?id=7261 berates us for putting a
temporary file into the kernel source tree.  Use mktemp instead.

Cc: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: jpdenheijer@gmail.com,
Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
---

 Kbuild.include |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- linux-mm/scripts/Kbuild.include.orig	2006-10-29 00:39:35.000000000 +0200
+++ linux-mm/scripts/Kbuild.include	2006-10-29 00:41:43.000000000 +0200
@@ -66,9 +66,10 @@ as-option = $(shell if $(CC) $(CFLAGS) $
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
 
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
+ASTMP = $(shell mktemp $${TMPDIR:-/tmp}/asXXXXXX)
+as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o $(ASTMP) ; \
 		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+	           rm -f $(ASTMP))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
@@ -97,10 +98,11 @@ cc-ifversion = $(shell if [ $(call cc-ve
 
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
+LDTMP = $(shell mktemp $${TMPDIR:-/tmp}/ldXXXXXX)
 ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
+			     -nostdlib -o $(LDTMP) -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+	     rm -f $(LDTMP))
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
