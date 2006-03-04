Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWCDXVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWCDXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCDXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 18:21:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6930 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751781AbWCDXVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 18:21:24 -0500
Date: Sun, 5 Mar 2006 00:21:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: kbuild: kill false positives from section mismatch warnings for powerpc
Message-ID: <20060304232110.GA9987@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just pushed following patch out to kbuild.git
It made ppc64 happy here.

For an allmodconfig for ppc64 we are down at 48 warnings, excluding
fixes applied in -mm so it goes in the right direction.

	Sam

diff-tree 9209aed0726c77ad13b8d83e73a3cf9f59a8c2b2 (from 62070fa42c4ac23d1d71146a4c14702302b80245)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Mar 5 00:16:26 2006 +0100

    kbuild: kill false positives from section mismatch warnings for powerpc
    
    Building an allmodconfig kernel for ppc64 revealed a number of false
    positives - originally reported by Andrew Morton.
    This patch removes most if not all false positives for ppc64:
    
    Section .opd
    The .opd section contains function descriptors at least for ppc64.
    So ignore it for .init.text (was ignored for .exit.text).
    See description of function descriptors here:
    http://www.linuxbase.org/spec/ELF/ppc64/PPC-elf64abi-1.7.html
    
    Section .toc1
    ppc64 places some static variables in .toc1 - ignore the.
    
    Section __bug_tabe
    BUG() and friends uses __bug_table. Ignore warnings from that section.
    
    Module parameters are placed in .data.rel for ppc64, for adjust pattern to
    match on section named .data*
    
    Tested with gcc: 3.4.0 and binutils 2.15.90.0.3
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5de3c63..c4dc1d7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -481,11 +481,11 @@ static int strrcmp(const char *s, const 
  *   then this is legal despite the warning generated.
  *   We cannot see value of permissions here, so just ignore
  *   this pattern.
  *   The pattern is identified by:
  *   tosec   = .init.data
- *   fromsec = .data
+ *   fromsec = .data*
  *   atsym   =__param*
  *
  * Pattern 2:
  *   Many drivers utilise a *_driver container with references to
  *   add, remove, probe functions etc.
@@ -510,11 +510,11 @@ static int secref_whitelist(const char *
 	};
 
 	/* Check for pattern 1 */
 	if (strcmp(tosec, ".init.data") != 0)
 		f1 = 0;
-	if (strcmp(fromsec, ".data") != 0)
+	if (strncmp(fromsec, ".data", strlen(".data")) != 0)
 		f1 = 0;
 	if (strncmp(atsym, "__param", strlen("__param")) != 0)
 		f1 = 0;
 
 	if (f1)
@@ -741,13 +741,16 @@ static int init_section_ref_ok(const cha
 {
 	const char **s;
 	/* Absolute section names */
 	const char *namelist1[] = {
 		".init",
+		".opd",   /* see comment [OPD] at exit_section_ref_ok() */
+		".toc1",  /* used by ppc64 */
 		".stab",
 		".rodata",
 		".text.lock",
+		"__bug_table", /* used by powerpc for BUG() */
 		".pci_fixup_header",
 		".pci_fixup_final",
 		".pdr",
 		"__param",
 		NULL
@@ -810,12 +813,14 @@ static int exit_section_ref_ok(const cha
 	const char *namelist1[] = {
 		".exit.text",
 		".exit.data",
 		".init.text",
 		".opd", /* See comment [OPD] */
+		".toc1",  /* used by ppc64 */
 		".altinstructions",
 		".pdr",
+		"__bug_table", /* used by powerpc for BUG() */
 		".exitcall.exit",
 		".eh_frame",
 		".stab",
 		NULL
 	};
