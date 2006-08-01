Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWHALMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWHALMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWHALGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56796 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932627AbWHALF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:27 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 8/33] kallsyms.c: Generate relocatable symbols.
Date: Tue,  1 Aug 2006 05:03:23 -0600
Message-Id: <11544302331578-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print the addresses of non-absolute symbols relative to _text
so that ld will generate relocations.  Allowing a relocatable
kernel to relocate them.  We can't actually use the symbol names
because kallsyms includes static symbols that are not exported
from their object files.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 scripts/kallsyms.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 22d281c..4c1ad0a 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -43,7 +43,7 @@ struct sym_entry {
 
 static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
-static unsigned long long _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
+static unsigned long long _text, _stext, _etext, _sinittext, _einittext, _sextratext, _eextratext;
 static int all_symbols = 0;
 static char symbol_prefix_char = '\0';
 
@@ -91,7 +91,9 @@ static int read_symbol(FILE *in, struct 
 		sym++;
 
 	/* Ignore most absolute/undefined (?) symbols. */
-	if (strcmp(sym, "_stext") == 0)
+	if (strcmp(sym, "_text") == 0)
+		_text = s->addr;
+	else if (strcmp(sym, "_stext") == 0)
 		_stext = s->addr;
 	else if (strcmp(sym, "_etext") == 0)
 		_etext = s->addr;
@@ -265,9 +267,21 @@ static void write_src(void)
 
 	printf(".data\n");
 
+	/* Provide proper symbols relocatability by their '_text'
+	 * relativeness.  The symbol names cannot be used to construct
+	 * normal symbol references as the list of symbols contains
+	 * symbols that are declared static and are private to their
+	 * .o files.  This prevents .tmp_kallsyms.o or any other
+	 * object from referencing them.
+	 */
 	output_label("kallsyms_addresses");
 	for (i = 0; i < table_cnt; i++) {
-		printf("\tPTR\t%#llx\n", table[i].addr);
+		if (toupper(table[i].sym[0]) != 'A') {
+			printf("\tPTR\t_text + %#llx\n",
+				table[i].addr - _text);
+		} else {
+			printf("\tPTR\t%#llx\n", table[i].addr);
+		}
 	}
 	printf("\n");
 
-- 
1.4.2.rc2.g5209e

