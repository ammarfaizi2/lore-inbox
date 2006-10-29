Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWJ2MJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWJ2MJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 07:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWJ2MJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 07:09:01 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:5551 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S932294AbWJ2MJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 07:09:00 -0500
Date: Sun, 29 Oct 2006 13:08:58 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       Sam Ravnborg <sam@ravnborg.org>, jpdenheijer@gmail.com,
       linux-kernel@vger.kernel.org, dsd@gentoo.org, draconx@gmail.com,
       kernel@gentoo.org
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Message-ID: <20061029120858.GB3491@quickstop.soohrt.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>,
	jpdenheijer@gmail.com, linux-kernel@vger.kernel.org, dsd@gentoo.org,
	draconx@gmail.com, kernel@gentoo.org
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281907.20673.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Andi Kleen wrote:
> On Saturday 28 October 2006 16:07, Horst Schirmeier wrote:
> > Hello,
> >
> > the kbuild-dont-put-temp-files-in-the-source-tree.patch (-mm patches) is
> > implemented faultily and fails in its intention to put temporary files
> > in $TMPDIR (or /tmp by default).
> >
> > This is the code as it results from the patch:
> >
> > ASTMP = $(shell mktemp ${TMPDIR:-/tmp}/asXXXXXX)
> 
> I'm still against mktemp. It eats random entropy and
> temporary files should be in the objdir, not in /tmp

TBH, I don't see the necessity of temporary files at all in this case,
but I assumed there must be a reason for them as the change already made
it into the -mm tree.

Why not use -o /dev/null, as Daniel Drake already suggested in [1]? In
both as-instr and ld-option, the tmp file is being deleted
unconditionally right after its creation anyways.

The attached patch is adapted from the patches proposed in [2], redone
as a replacement for
kbuild-dont-put-temp-files-in-the-source-tree.patch. Comments?

Kind regards,
 Horst

[1] LKML Message-ID: <452F9602.1050906@gentoo.org>
[2] http://bugs.gentoo.org/show_bug.cgi?id=149307

---
Do not write temporary files in as-instr and ld-option but write to
/dev/null, as the output is not being used anyways.

Cc: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: jpdenheijer@gmail.com
Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
---

 Kbuild.include |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- linux-mm/scripts/Kbuild.include.orig	2006-10-29 00:39:35.000000000 +0200
+++ linux-mm/scripts/Kbuild.include	2006-10-29 12:56:39.000000000 +0100
@@ -66,9 +66,8 @@ as-option = $(shell if $(CC) $(CFLAGS) $
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
 
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
-		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o /dev/null ; \
+		   then echo "$(2)"; else echo "$(3)"; fi)
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
@@ -98,9 +97,8 @@ cc-ifversion = $(shell if [ $(call cc-ve
 # ld-option
 # Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
 ld-option = $(shell if $(CC) $(1) \
-			     -nostdlib -o ldtest$$$$.out -xc /dev/null \
-             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi; \
-	     rm -f ldtest$$$$.out)
+			     -nostdlib -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
 
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
