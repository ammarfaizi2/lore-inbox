Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVKGLxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVKGLxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVKGLxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:53:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:63980 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751349AbVKGLxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:53:44 -0500
Date: Mon, 7 Nov 2005 12:53:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] kconfig: fix restart for choice symbols
In-Reply-To: <20051104220547.2e5686dc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511071246520.12843@scrub.home>
References: <Pine.LNX.4.61.0511031606240.2497@scrub.home>
 <20051104220547.2e5686dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Nov 2005, Andrew Morton wrote:

> This makes `make allmodconfig' go into an infinite loop.

Sorry, about that, here is an updated version.

bye, Roman


The restart check whether new symbols became visible, didn't always
work for choice symbols. Even if a choice symbol itself isn't changable, 
the childs are. This also requires to update the new status of all choice 
values, once one of them is set.


Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/Makefile |    7 +++++--
 scripts/kconfig/conf.c   |    7 +++----
 scripts/kconfig/symbol.c |   11 +++++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

Index: linux-2.6/scripts/kconfig/conf.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/conf.c	2005-11-05 13:38:55.000000000 +0100
+++ linux-2.6/scripts/kconfig/conf.c	2005-11-06 16:11:19.000000000 +0100
@@ -467,15 +467,14 @@ static void check_conf(struct menu *menu
 		return;
 
 	sym = menu->sym;
-	if (sym) {
-		if (sym_is_changable(sym) && !sym_has_value(sym)) {
+	if (sym && !sym_has_value(sym)) {
+		if (sym_is_changable(sym) ||
+		    (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)) {
 			if (!conf_cnt++)
 				printf(_("*\n* Restart config...\n*\n"));
 			rootEntry = menu_get_parent_menu(menu);
 			conf(rootEntry);
 		}
-		if (sym_is_choice(sym) && sym_get_tristate_value(sym) != mod)
-			return;
 	}
 
 	for (child = menu->list; child; child = child->next)
Index: linux-2.6/scripts/kconfig/symbol.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/symbol.c	2005-11-06 00:27:30.000000000 +0100
+++ linux-2.6/scripts/kconfig/symbol.c	2005-11-06 17:43:22.000000000 +0100
@@ -380,11 +380,22 @@ bool sym_set_tristate_value(struct symbo
 		sym->flags &= ~SYMBOL_NEW;
 		sym_set_changed(sym);
 	}
+	/*
+	 * setting a choice value also resets the new flag of the choice
+	 * symbol and all other choice values.
+	 */
 	if (sym_is_choice_value(sym) && val == yes) {
 		struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
+		struct property *prop;
+		struct expr *e;
 
 		cs->user.val = sym;
 		cs->flags &= ~SYMBOL_NEW;
+		prop = sym_get_choice_prop(cs);
+		for (e = prop->expr; e; e = e->left.expr) {
+			if (e->right.sym->visible != no)
+				e->right.sym->flags &= ~SYMBOL_NEW;
+		}
 	}
 
 	sym->user.tri = val;
