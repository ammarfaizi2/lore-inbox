Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWDIP1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWDIP1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDIP1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:27:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30122 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750775AbWDIP1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:27:42 -0400
Date: Sun, 9 Apr 2006 17:27:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/19] kconfig: improve config load/save output
Message-ID: <Pine.LNX.4.64.0604091727330.23124@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During loading special case the first common case (.config), be silent
about it and otherwise mark it as a change that requires saving. Instead
output that the file has been changed.
IOW if conf does nothing (special), it's silent.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/confdata.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -98,20 +98,28 @@ int conf_read_simple(const char *name)
 		in = zconf_fopen(name);
 	} else {
 		const char **names = conf_confnames;
+		name = *names++;
+		if (!name)
+			return 1;
+		in = zconf_fopen(name);
+		if (in)
+			goto load;
+		sym_change_count++;
 		while ((name = *names++)) {
 			name = conf_expand_value(name);
 			in = zconf_fopen(name);
 			if (in) {
 				printf(_("#\n"
-				         "# using defaults found in %s\n"
-				         "#\n"), name);
-				break;
+					 "# using defaults found in %s\n"
+					 "#\n"), name);
+				goto load;
 			}
 		}
 	}
 	if (!in)
 		return 1;
 
+load:
 	conf_filename = name;
 	conf_lineno = 0;
 	conf_warnings = 0;
@@ -275,6 +283,8 @@ int conf_read(const char *name)
 	struct expr *e;
 	int i;
 
+	sym_change_count = 0;
+
 	if (conf_read_simple(name))
 		return 1;
 
@@ -325,7 +335,7 @@ int conf_read(const char *name)
 				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
 	}
 
-	sym_change_count = conf_warnings || conf_unsaved;
+	sym_change_count += conf_warnings || conf_unsaved;
 
 	return 0;
 }
@@ -524,6 +534,10 @@ int conf_write(const char *name)
 	if (rename(newname, tmpname))
 		return 1;
 
+	printf(_("#\n"
+		 "# configuration written to %s\n"
+		 "#\n"), tmpname);
+
 	sym_change_count = 0;
 
 	return 0;
