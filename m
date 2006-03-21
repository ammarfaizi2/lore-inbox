Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWCUQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWCUQZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWCUQV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29964 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030277AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 30/46] kbuild: kill false positives from section mismatch warnings for powerpc
In-Reply-To: <11429580563392-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580562637-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

---

 scripts/mod/modpost.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

9209aed0726c77ad13b8d83e73a3cf9f59a8c2b2
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5de3c63..c4dc1d7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -483,7 +483,7 @@ static int strrcmp(const char *s, const 
  *   this pattern.
  *   The pattern is identified by:
  *   tosec   = .init.data
- *   fromsec = .data
+ *   fromsec = .data*
  *   atsym   =__param*
  *
  * Pattern 2:
@@ -512,7 +512,7 @@ static int secref_whitelist(const char *
 	/* Check for pattern 1 */
 	if (strcmp(tosec, ".init.data") != 0)
 		f1 = 0;
-	if (strcmp(fromsec, ".data") != 0)
+	if (strncmp(fromsec, ".data", strlen(".data")) != 0)
 		f1 = 0;
 	if (strncmp(atsym, "__param", strlen("__param")) != 0)
 		f1 = 0;
@@ -743,9 +743,12 @@ static int init_section_ref_ok(const cha
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
@@ -812,8 +815,10 @@ static int exit_section_ref_ok(const cha
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
-- 
1.0.GIT


