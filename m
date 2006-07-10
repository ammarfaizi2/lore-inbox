Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWGJGgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWGJGgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWGJGgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:36:17 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:63118 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1161349AbWGJGgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:36:17 -0400
X-IronPort-AV: i="4.06,222,1149480000"; 
   d="scan'208"; a="6262481:sNHT21098959"
Message-Id: <6.1.1.1.0.20060710023042.01ec9eb0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 10 Jul 2006 02:36:15 -0400
To: sam@ravnborg.org
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: ./scripts/kallsyms.c question
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name
In-Reply-To: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam wrote:
>Keep the existing if/else - it is still readable.
>But please add a comment describing that it is blackfin that requires 
>these two odd sections.

OK - here you go...

-Robin

--- uClinux-dist/linux-2.6.x/scripts/kallsyms.c 2006/03/22 02:52:05     1.5
+++ uClinux-dist/linux-2.6.x/scripts/kallsyms.c 2006/07/10 06:25:40     1.6
@@ -12,6 +12,8 @@
   * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
   *      Changed the compression method from stem compression to "table 
lookup"
   *      compression
+ * (10/Jul/2006) Robin Getz <rgetz@blackfin.uclinux.org>
+ *      Add _stext_l1, _etext_l1 for the L1 memory section in Blackfin.
   *
   *      Table compression uses all the unused char codes on the symbols and
   *  maps these to the most used substrings (tokens). For instance, it might
@@ -44,6 +46,7 @@ struct sym_entry {
  static struct sym_entry *table;
  static unsigned int table_size, table_cnt;
  static unsigned long long _stext, _etext, _sinittext, _einittext, 
_sextratext, _eextratext;
+static unsigned long long _stext_l1, _etext_l1;
  static int all_symbols = 0;
  static char symbol_prefix_char = '\0';

@@ -103,6 +106,10 @@ static int read_symbol(FILE *in, struct
                 _sextratext = s->addr;
         else if (strcmp(sym, "_eextratext") == 0)
                 _eextratext = s->addr;
+       else if (strcmp(sym, "_stext_l1" ) == 0)
+               _stext_l1 = s->addr;
+       else if (strcmp(sym, "_etext_l1" ) == 0)
+               _etext_l1 = s->addr;
         else if (toupper(stype) == 'A')
         {
                 /* Keep these useful absolute symbols */
@@ -161,7 +168,8 @@ static int symbol_valid(struct sym_entry
         if (!all_symbols) {
                 if ((s->addr < _stext || s->addr > _etext)
                     && (s->addr < _sinittext || s->addr > _einittext)
-                   && (s->addr < _sextratext || s->addr > _eextratext))
+                   && (s->addr < _sextratext || s->addr > _eextratext)
+                   && (s->addr < _stext_l1 || s->addr > _etext_l1))
                         return 0;
                 /* Corner case.  Discard any symbols with the same value as
                  * _etext _einittext or _eextratext; they can move between 
pass


