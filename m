Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWFBRhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWFBRhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBRhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:37:34 -0400
Received: from mail.linicks.net ([217.204.244.146]:29362 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751333AbWFBRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:37:33 -0400
From: Nick Warne <nick@linicks.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] 2.6.16.18 scripts/kconfig/mconf.c
Date: Fri, 2 Jun 2006 18:37:06 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200606010628.08966.nick@linicks.net> <Pine.LNX.4.64.0606021608110.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606021608110.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021837.06428.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 15:17, Roman Zippel wrote:
> Hi,

> Only choice symbols currently have no name, but there are otherwise normal
> symbols, so there is need to just return here. This should look more like:
>
> 	if (sym->name)
> 		str_printf(r, "Symbol: %s", sym->name);
> 	else if (sym_is_choice(sym))
> 		str_printf(r, "Choice:");
> 	else
> 		str_printf(r, "Weird symbol:");
> 	str_printf(r, "[=%s]\n", sym_get_string_value(sym));
>
> That looks a little misformated, anyway, this should just be:
>
> 	if (sym->name)
> 		str_printf(&help, "CONFIG_%s:\n\n", sym->name);
>
> 	str_append(&help, sym->help ? _(sym->help) : nohelp_text);
> 	str_append(&help, "\n");
> 	get_symbol_str(&help, sym);
> 	show_helptext(menu_get_prompt(menu), str_get(&help));
> 	str_free(&help);
>
> bye, Roman

Hi Roman,

I see, thanks - that works good, but one little thing - menu expanders now 
produce a funny line at the end e.g. from 'Processor type and features -> 
memory model' help, the last line:

  Choice:[=y]
    Prompt: Memory model
    Defined at mm/Kconfig:5
    Depends on: SELECT_MEMORY_MODEL
         -> Processor type and features
       Selected by: SELECT_MEMORY_MODEL && m

I don't know what '&& m' means and it isn't selected by anything; I think it 
is bogus... so I have added a line to stop the 'selected by' being used if 
the 'help' option is on a 'menu expander -->'

Nick



signed-off-by: Nick Warne <nick@linicks.net>


--- linux-current/scripts/kconfig/mconf.cORIG	2006-05-30 18:58:59.000000000 
+0100
+++ linux-current/scripts/kconfig/mconf.c	2006-06-02 18:19:35.000000000 +0100
@@ -402,8 +402,13 @@
 	bool hit;
 	struct property *prop;
 
-	str_printf(r, "Symbol: %s [=%s]\n", sym->name,
-	                               sym_get_string_value(sym));
+        if (sym->name)
+                str_printf(r, "Symbol: %s", sym->name);
+        else if (sym_is_choice(sym))
+                str_printf(r, "Choice:");
+        else
+                str_printf(r, "Weird symbol:");
+        str_printf(r, "[=%s]\n", sym_get_string_value(sym));
 	for_all_prompts(sym, prop)
 		get_prompt_str(r, prop);
 	hit = false;
@@ -417,7 +422,7 @@
 	}
 	if (hit)
 		str_append(r, "\n");
-	if (sym->rev_dep.expr) {
+	if (sym->rev_dep.expr && !sym_is_choice(sym)) {
 		str_append(r, "  Selected by: ");
 		expr_gstr_print(sym->rev_dep.expr, r);
 		str_append(r, "\n");
@@ -849,19 +854,15 @@
 	struct gstr help = str_new();
 	struct symbol *sym = menu->sym;
 
-	if (sym->help)
-	{
-		if (sym->name) {
-			str_printf(&help, "CONFIG_%s:\n\n", sym->name);
-			str_append(&help, _(sym->help));
-			str_append(&help, "\n");
-		}
-	} else {
-		str_append(&help, nohelp_text);
-	}
-	get_symbol_str(&help, sym);
-	show_helptext(menu_get_prompt(menu), str_get(&help));
-	str_free(&help);
+        if (sym->name)
+                str_printf(&help, "CONFIG_%s:\n\n", sym->name);
+
+        str_append(&help, sym->help ? _(sym->help) : nohelp_text);
+        str_append(&help, "\n");
+        get_symbol_str(&help, sym);
+        show_helptext(menu_get_prompt(menu), str_get(&help));
+        str_free(&help);
+
 }
 
 static void show_file(const char *filename, const char *title, int r, int c)



-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
