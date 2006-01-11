Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbWAKGpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWAKGpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWAKGpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:45:33 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:36005 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932651AbWAKGpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:45:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: rusty@rustcorp.com.au
Subject: Subject: Fix processing of obsolete-style setup options
Date: Wed, 11 Jan 2006 01:45:29 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601110145.29776.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel init code checks for presence of obsolete-style
kernel parameters it gets confused if parameters have common
prefix, such as "nousb" and "nousbstorage". Make sure that
we compare entire names, not just common prefixes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 init/main.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

Index: work/init/main.c
===================================================================
--- work.orig/init/main.c
+++ work/init/main.c
@@ -158,24 +158,22 @@ static const char *panic_later, *panic_p
 
 extern struct obs_kernel_param __setup_start[], __setup_end[];
 
-static int __init obsolete_checksetup(char *line)
+static int __init obsolete_checksetup(char *line, int len)
 {
 	struct obs_kernel_param *p;
 
 	p = __setup_start;
 	do {
-		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (!strncmp(line, p->str, len) && len == strlen(p->str)) {
 			if (p->early) {
-				/* Already done in parse_early_param?  (Needs
-				 * exact match on param part) */
-				if (line[n] == '\0' || line[n] == '=')
-					return 1;
+				/* Already done in parse_early_param? */
+				return 1;
 			} else if (!p->setup_func) {
-				printk(KERN_WARNING "Parameter %s is obsolete,"
-				       " ignored\n", p->str);
+				printk(KERN_WARNING
+					"Parameter %s is obsolete, ignored\n",
+					p->str);
 				return 1;
-			} else if (p->setup_func(line + n))
+			} else if (p->setup_func(line + len))
 				return 1;
 		}
 		p++;
@@ -224,21 +222,25 @@ __setup("loglevel=", loglevel);
  */
 static int __init unknown_bootoption(char *param, char *val)
 {
+	int len = strlen(param);
+
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
 		/* param=val or param="val"? */
-		if (val == param+strlen(param)+1)
+		if (val == param + len + 1) {
 			val[-1] = '=';
-		else if (val == param+strlen(param)+2) {
+			len++;
+		} else if (val == param + len + 2) {
 			val[-2] = '=';
-			memmove(val-1, val, strlen(val)+1);
+			memmove(val - 1, val, strlen(val) + 1);
 			val--;
+			len++;
 		} else
 			BUG();
 	}
 
 	/* Handle obsolete-style parameters */
-	if (obsolete_checksetup(param))
+	if (obsolete_checksetup(param, len))
 		return 0;
 
 	/*
