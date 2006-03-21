Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWCUQ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWCUQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWCUQVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31244 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932428AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 22/46] kbuild: do not warn when unwind sections references .init/.exit sections
In-Reply-To: <11429580554104-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580553825-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton reported a number of false positives for ia64 - like these:
WARNING: drivers/acpi/button.o - Section mismatch: reference to .init.text: from .IA_64.unwind.init.text after '' (at offset 0x0)
WARNING: drivers/acpi/button.o - Section mismatch: reference to .exit.text: from .IA_64.unwind.exit.text after '' (at offset 0x0)
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.text: from .IA_64.unwind after '' (at offset 0x1e8)

They are all false positives - or at least the .c code looks OK.
It is not known why sometimes a section name is appended and sometimes not.

Fix is to accept references from all sections that includes "unwind." in the name.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

6e10133fa4b2366e8ef18bc2ce34afe727b1c4ba
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5b076ef..7f25354 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -671,13 +671,21 @@ static int init_section_ref_ok(const cha
 		".debug",
 		NULL
 	};
-	
+	/* part of section name */
+	const char *namelist3 [] = {
+		".unwind",  /* sample: IA_64.unwind.init.text */
+		NULL
+	};
+
 	for (s = namelist1; *s; s++)
 		if (strcmp(*s, name) == 0)
 			return 1;
 	for (s = namelist2; *s; s++)	
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
+	for (s = namelist3; *s; s++)	
+		if (strstr(*s, name) != NULL)
+			return 1;
 	return 0;
 }
 
@@ -727,6 +735,11 @@ static int exit_section_ref_ok(const cha
 		".debug",
 		NULL
 	};
+	/* part of section name */
+	const char *namelist3 [] = {
+		".unwind",  /* Sample: IA_64.unwind.exit.text */
+		NULL
+	};
 	
 	for (s = namelist1; *s; s++)
 		if (strcmp(*s, name) == 0)
@@ -734,6 +747,9 @@ static int exit_section_ref_ok(const cha
 	for (s = namelist2; *s; s++)	
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
+	for (s = namelist3; *s; s++)	
+		if (strstr(*s, name) != NULL)
+			return 1;
 	return 0;
 }
 
-- 
1.0.GIT


