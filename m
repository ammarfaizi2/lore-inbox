Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759827AbWLEO1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759827AbWLEO1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759846AbWLEO1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:27:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:44887 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759827AbWLEO1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:27:41 -0500
Date: Tue, 5 Dec 2006 15:27:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Horst Schirmeier <horst@schirmeier.com>, jpdenheijer@gmail.com
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051516070.1868@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Andrew Morton wrote:

> kbuild-dont-put-temp-files-in-the-source-tree.patch
> actually-delete-the-as-instr-ld-option-tmp-file.patch

Andi had objections about the mktemp usage and I agree with him.
The proposed patch in bugzilla didn't have this and no further 
justification was given for why it's needed.
Below is a replacement patch with some improvements:
- kbuild doesn't use $(AS), so use $(CC)
- tmp dir needs only to be calculated once
- reformat a bit to keep it under 80 columns and to be more readable

bye, Roman

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 scripts/Kbuild.include |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Index: linux-2.6-git/scripts/Kbuild.include
===================================================================
--- linux-2.6-git.orig/scripts/Kbuild.include	2006-12-05 13:44:50.000000000 +0100
+++ linux-2.6-git/scripts/Kbuild.include	2006-12-05 15:09:09.000000000 +0100
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
