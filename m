Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWGKEmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWGKEmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWGKEmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:42:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:34123 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965149AbWGKEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:42:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Azp5vSuuYHVV/kP+v0gmHyAnfIt0A9N30UAbqfFeqrdOFxQ0xW5ePDi4P2jmAfKNpEKnBFZMb+nx7JPWGus9MMkhAgQ352g55H42edtoDu2LMVqYB4le4YcH3pyotGhwWjR3ds/sE0UoGKeMoIlOwxqV4CQmrkYsYqvLnkQF624=
Message-ID: <489ecd0c0607102142n15aa350t4f12c1a368c6183a@mail.gmail.com>
Date: Tue, 11 Jul 2006 12:42:15 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Getz, Robin" <Robin.getz@analog.com>
Subject: [RFC] Add L1 symbol section supporting in kallsyms.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   We are maintaining linux kernel for the ADI Blackfin CPU which has
L1 text and data rams. To make use of the L1 memory we add a new text
section call text_l1.  So kallsyms.c need to be modified to search the
new section and generate the right Sysmap.map.

  Currently we add the section support directly.  Or do it in a more
common way for future extending? Any comments? Thanks!


Index: git/linux-2.6/scripts/kallsyms.c
===================================================================
--- git.orig/linux-2.6/scripts/kallsyms.c
+++ git/linux-2.6/scripts/kallsyms.c
@@ -12,6 +12,8 @@
  * (25/Aug/2004) Paulo Marques <pmarques@grupopie.com>
  *      Changed the compression method from stem compression to "table lookup"
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
@@ -166,7 +173,8 @@ static int symbol_valid(struct sym_entry
        if (!all_symbols) {
                if ((s->addr < _stext || s->addr > _etext)
                    && (s->addr < _sinittext || s->addr > _einittext)
-                   && (s->addr < _sextratext || s->addr > _eextratext))
+                   && (s->addr < _sextratext || s->addr > _eextratext)
+                   && (s->addr < _stext_l1 || s->addr > _etext_l1))
                        return 0;
                /* Corner case.  Discard any symbols with the same value as
                 * _etext _einittext or _eextratext; they can move between pass

-- 
Best regards,
Luke Yang
luke.adi@gmail.com
