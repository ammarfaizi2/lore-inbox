Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVCJMPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVCJMPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVCJMPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:15:37 -0500
Received: from [195.23.16.24] ([195.23.16.24]:47272 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262540AbVCJMOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:14:37 -0500
Message-ID: <423039A6.5010301@grupopie.com>
Date: Thu, 10 Mar 2005 12:12:22 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308192900.GA16882@isilmar.linta.de> <20050308123554.669dd725.akpm@osdl.org> <20050308204521.GA17969@isilmar.linta.de> <422EF2B0.7070304@grupopie.com> <422F59A3.9010209@grupopie.com>
In-Reply-To: <422F59A3.9010209@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------010309020306030704030603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309020306030704030603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paulo Marques wrote:
> [...]
> A simple and robust way is to do the sampling on a list of symbols 
> sorted by symbol name. This way, even if the symbol positions that are 
> given to scripts/kallsyms change, the symbols sampled will be the same.
> 
> I'll do the patch to do this and send it ASAP.

Ok, here it is.

Dominik can you try the attached patch and see if it solves the problem?

It it does, I'll do a correct [PATCH] post later with all the 
signed-off-by and subject and stuff.

Please make sure you test with the same configuration that produces the 
error, because this is a pretty hard to hit bug. The needed conditions are:

  - 'nm' changes the order of 2 aliased symbols from the 1st to the 2nd pass
  - one of those symbols get sampled for token optimization. With your 
configuration the sampling was about 1 out of 12.
  - the difference in the name of those symbols makes the algorithm 
select different tokens. As 1024 symbols are used to produce the tokens, 
changing just one of these symbols can easily go unnoticed.
  - the difference in the tokens selected makes the size of the 
compressed data change, so that it goes above (or below) an alignment 
boundary. In your case it only changed 2 bytes in size, but it crossed a 
4 byte alignment boundary.

With your .config file but a different set of tools (gcc, binutils 
versions) I couldn't trigger the bug in my machine.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------010309020306030704030603
Content-Type: text/plain;
 name="kallpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallpatch"

--- ./scripts/kallsyms.c.orig	2005-03-10 11:00:26.000000000 +0000
+++ ./scripts/kallsyms.c	2005-03-10 11:11:50.000000000 +0000
@@ -499,11 +499,30 @@ static void forget_symbol(unsigned char 
 		forget_token(symbol + i, len - i);
 }
 
+/* sort the symbols by address->name so that even if aliased symbols 
+ * change position, or the symbols are not supplied in address order
+ * the algorithm will work nevertheless */
+
+static int sort_by_address_name(const void *a, const void *b)
+{
+	struct sym_entry *sa, *sb;
+
+	sa = (struct sym_entry *) a;
+	sb = (struct sym_entry *) b;
+
+	if (sa->addr != sb->addr)
+		return sa->addr - sb->addr;
+
+	return strcmp(sa->sym + 1, sb->sym + 1);
+}
+
 /* set all the symbol flags and do the initial token count */
 static void build_initial_tok_table(void)
 {
 	int i, use_it, valid;
 
+	qsort(table, cnt, sizeof(table[0]), sort_by_address_name);
+
 	valid = 0;
 	for (i = 0; i < cnt; i++) {
 		table[i].flags = 0;

--------------010309020306030704030603--
