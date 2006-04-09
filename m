Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWDIPbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWDIPbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDIPbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:31:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37546 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750795AbWDIPa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:30:59 -0400
Date: Sun, 9 Apr 2006 17:30:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 18/19] kconfig: warn about leading whitespace for menu prompts
Message-ID: <Pine.LNX.4.64.0604091730430.23186@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kconfig does its own indentation of menu prompts, so warn about and
ignore leading whitespace.
Remove also a few unnecessary newlines after other warning prints.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/menu.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6-git/scripts/kconfig/menu.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/menu.c
+++ linux-2.6-git/scripts/kconfig/menu.c
@@ -114,7 +114,7 @@ void menu_set_type(int type)
 		sym->type = type;
 		return;
 	}
-	menu_warn(current_entry, "type of '%s' redefined from '%s' to '%s'\n",
+	menu_warn(current_entry, "type of '%s' redefined from '%s' to '%s'",
 	    sym->name ? sym->name : "<choice>",
 	    sym_type_name(sym->type), sym_type_name(type));
 }
@@ -124,15 +124,20 @@ struct property *menu_add_prop(enum prop
 	struct property *prop = prop_alloc(type, current_entry->sym);
 
 	prop->menu = current_entry;
-	prop->text = prompt;
 	prop->expr = expr;
 	prop->visible.expr = menu_check_dep(dep);
 
 	if (prompt) {
+		if (isspace(*prompt)) {
+			prop_warn(prop, "leading whitespace ignored");
+			while (isspace(*prompt))
+				prompt++;
+		}
 		if (current_entry->prompt)
-			menu_warn(current_entry, "prompt redefined\n");
+			prop_warn(prop, "prompt redefined");
 		current_entry->prompt = prop;
 	}
+	prop->text = prompt;
 
 	return prop;
 }
@@ -343,11 +348,10 @@ void menu_finalize(struct menu *parent)
 
 	if (sym && !(sym->flags & SYMBOL_WARNED)) {
 		if (sym->type == S_UNKNOWN)
-			menu_warn(parent, "config symbol defined "
-			    "without type\n");
+			menu_warn(parent, "config symbol defined without type");
 
 		if (sym_is_choice(sym) && !parent->prompt)
-			menu_warn(parent, "choice must have a prompt\n");
+			menu_warn(parent, "choice must have a prompt");
 
 		/* Check properties connected to this symbol */
 		sym_check_prop(sym);
