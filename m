Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWDNVyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWDNVyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWDNVyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:54:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43023 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030192AbWDNVyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:54:24 -0400
Date: Fri, 14 Apr 2006 23:54:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [PATCH] kbuild: fix false section mismatch warnings
Message-ID: <20060414215413.GA24200@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Jenkins <darrenrjenkins@gmail.com> pointed out a
number of false positives where we referenced variables
from a _driver variable.
Fix it by check for that pattern and ignore it.

Randy.Dunlap <rdunlap@xenotime.net> pointed out a similar
set of warnings for a number of scsi drivers.
In scsi world they misname their variables *_template or
*_sht so add these to list of variables that may have references
to .init.text with no warning.

Randy.Dunlap <rdunlap@xenotime.net> also pointed out a scsi driver
with many references to .exit.text from .rodata. This is compiler
generated references and we already ignore these for .init.text, so
ignore them for .exit.text also.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Hi Linus. Please apply to 2.6.17-rc1
This fixes a number of false warnings - so we can concentrate on the
real ones.

	Sam

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7e8079a..cd00e9f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -492,17 +492,19 @@ static int strrcmp(const char *s, const 
  *   These functions may often be marked __init and we do not want to
  *   warn here.
  *   the pattern is identified by:
- *   tosec   = .init.text | .exit.text
+ *   tosec   = .init.text | .exit.text | .init.data
  *   fromsec = .data
- *   atsym = *_driver, *_ops, *_probe, *probe_one
+ *   atsym = *_driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
 static int secref_whitelist(const char *tosec, const char *fromsec,
-			  const char *atsym)
+			    const char *atsym)
 {
 	int f1 = 1, f2 = 1;
 	const char **s;
 	const char *pat2sym[] = {
 		"_driver",
+		"_template", /* scsi uses *_template a lot */
+		"_sht",      /* scsi also used *_sht to some extent */
 		"_ops",
 		"_probe",
 		"_probe_one",
@@ -522,7 +524,8 @@ static int secref_whitelist(const char *
 
 	/* Check for pattern 2 */
 	if ((strcmp(tosec, ".init.text") != 0) &&
-	    (strcmp(tosec, ".exit.text") != 0))
+	    (strcmp(tosec, ".exit.text") != 0) &&
+	    (strcmp(tosec, ".init.data") != 0))
 		f2 = 0;
 	if (strcmp(fromsec, ".data") != 0)
 		f2 = 0;
@@ -820,6 +823,7 @@ static int exit_section(const char *name
  * For our future {in}sanity, add a comment that this is the ppc .opd
  * section, not the ia64 .opd section.
  * ia64 .opd should not point to discarded sections.
+ * [.rodata] like for .init.text we ignore .rodata references -same reason
  **/
 static int exit_section_ref_ok(const char *name)
 {
@@ -829,6 +833,7 @@ static int exit_section_ref_ok(const cha
 		".exit.text",
 		".exit.data",
 		".init.text",
+		".rodata",
 		".opd", /* See comment [OPD] */
 		".toc1",  /* used by ppc64 */
 		".altinstructions",
