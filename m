Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWFAF2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWFAF2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFAF2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:28:11 -0400
Received: from mail.linicks.net ([217.204.244.146]:2723 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965071AbWFAF2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:28:10 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.16.18 scripts/kconfig/mconf.c
Date: Thu, 1 Jun 2006 06:28:08 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606010628.08966.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed some options using 'make menuconfig help' produced nonsense results, 
e.g. going into 'Processor types and features' and then selecting 'help' 
option on 'Timer frequency' produces:


   Symbol: (null) [=y]
     Prompt: Timer frequency
     Defined at kernel/Kconfig.hz:5
     Location:
       -> Processor type and features
     Selected by: m


This attempted patch fixes this explaining there is no help 
for menu expander, or if there is just prints the relevant help message alone, 
otherwise the 'top level menu help' dialogue gets printed as normal.

I think the get_symbol_str(&help, sym); could be moved into the 'if 
(sym->name)' test, but there are too many options to check and change, so it 
seems a good idea to leave in where is and just return if !sym->name.

Nick


--- linux-current/scripts/kconfig/mconf.cORIG	2006-05-30 18:58:59.000000000 
+0100
+++ linux-current/scripts/kconfig/mconf.c	2006-05-30 19:10:29.000000000 +0100
@@ -402,6 +402,9 @@
 	bool hit;
 	struct property *prop;
 
+	if (!sym->name)
+		return;
+
 	str_printf(r, "Symbol: %s [=%s]\n", sym->name,
 	                               sym_get_string_value(sym));
 	for_all_prompts(sym, prop)
@@ -853,15 +856,17 @@
 	{
 		if (sym->name) {
 			str_printf(&help, "CONFIG_%s:\n\n", sym->name);
-			str_append(&help, _(sym->help));
-			str_append(&help, "\n");
 		}
-	} else {
-		str_append(&help, nohelp_text);
-	}
+	str_append(&help, _(sym->help));
+	str_append(&help, "\n");
 	get_symbol_str(&help, sym);
 	show_helptext(menu_get_prompt(menu), str_get(&help));
 	str_free(&help);
+	} else {
+		str_append(&help, nohelp_text);
+		show_helptext(menu_get_prompt(menu), str_get(&help));
+		str_free(&help);
+	}
 }
 
 static void show_file(const char *filename, const char *title, int r, int c)



-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
