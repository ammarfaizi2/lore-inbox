Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUATTtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUATTtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:49:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:53256 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265694AbUATTqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:46:55 -0500
Date: Tue, 20 Jan 2004 20:50:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: Improve warnings related to select
Message-ID: <20040120195024.GA14417@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Roman.

Use the official keyword 'select' when kconfig reports wrong usage.
Be more specific when wrong usage is encountered.

Other warnings from kconfig could use same treatment, but kept this minimal for now.

	Sam

===== scripts/kconfig/menu.c 1.11 vs edited =====
--- 1.11/scripts/kconfig/menu.c	Wed Jun  4 23:55:02 2003
+++ edited/scripts/kconfig/menu.c	Tue Jan 20 20:33:12 2004
@@ -275,10 +275,19 @@
 				break;
 			case P_SELECT:
 				sym2 = prop_get_symbol(prop);
-				if ((sym->type != S_BOOLEAN && sym->type != S_TRISTATE) ||
-				    (sym2->type != S_BOOLEAN && sym2->type != S_TRISTATE))
-					fprintf(stderr, "%s:%d:warning: enable is only allowed with boolean and tristate symbols\n",
-						prop->file->name, prop->lineno);
+				if (sym->type != S_BOOLEAN && sym->type != S_TRISTATE)
+					fprintf(stderr, "%s:%d:warning: config symbol '%s' uses select, "
+					                "but is not boolean or tristate\n",
+						prop->file->name, prop->lineno, sym->name);
+				else if (sym2->type == S_UNKNOWN)
+					fprintf(stderr, "%s:%d:warning: 'select' used by config symbol '%s' "
+							"refer to undefined symbol '%s'\n",
+						prop->file->name, prop->lineno, sym->name, sym2->name);
+				else if (sym2->type != S_BOOLEAN && sym2->type != S_TRISTATE)
+					fprintf(stderr, "%s:%d:warning: '%s' has wrong type."
+					                " 'select' only accept arguments of "
+					                "boolean and tristate type.\n",
+						prop->file->name, prop->lineno, sym2->name);
 				break;
 			case P_RANGE:
 				if (sym->type != S_INT && sym->type != S_HEX)
