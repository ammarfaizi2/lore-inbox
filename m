Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVHJKcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVHJKcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVHJKcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:32:54 -0400
Received: from relay.rost.ru ([80.254.111.11]:14485 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932558AbVHJKcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:32:53 -0400
Subject: [PATCH 2/5] 2.6.13-rc5-mm1, make dmi_string() behave like strdup()
In-Reply-To: <11236699682765@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 10 Aug 2005 14:32:51 +0400
Message-Id: <11236699713656@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes dmi_string() function to allocate string copy by itself,
to avoid code duplication in the next patch.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-06-14 23:31:39.000000000 +0400
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c	2005-06-14 23:31:51.000000000 +0400
@@ -16,15 +16,25 @@ struct dmi_header {
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
 	u8 *bp = ((u8 *) dm) + dm->length;
+	char *str = "";
 
-	if (!s)
-		return "";
-	s--;
-	while (s > 0 && *bp) {
-		bp += strlen(bp) + 1;
+	if (s) {
 		s--;
-	}
-	return bp;
+		while (s > 0 && *bp) {
+			bp += strlen(bp) + 1;
+			s--;
+		}
+
+		if (*bp != 0) {
+			str = alloc_bootmem(strlen(bp) + 1);
+			if (str != NULL)
+				strcpy(str, bp);
+			else
+				printk(KERN_ERR "dmi_string: out of memory.\n");
+		}
+ 	}
+
+	return str;
 }
 
 /*
@@ -84,19 +94,16 @@ static char *dmi_ident[DMI_STRING_MAX];
  */
 static void __init dmi_save_ident(struct dmi_header *dm, int slot, int string)
 {
-	char *d = (char*)dm;
-	char *p = dmi_string(dm, d[string]);
+	char *p, *d = (char*) dm;
 
-	if (p == NULL || *p == 0)
-		return;
 	if (dmi_ident[slot])
 		return;
 
-	dmi_ident[slot] = alloc_bootmem(strlen(p) + 1);
-	if(dmi_ident[slot])
-		strcpy(dmi_ident[slot], p);
-	else
-		printk(KERN_ERR "dmi_save_ident: out of memory.\n");
+	p = dmi_string(dm, d[string]);
+	if (p == NULL)
+		return;
+
+	dmi_ident[slot] = p;
 }
 
 /*

