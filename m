Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbUKLESZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUKLESZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 23:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKLESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 23:18:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:28338 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262439AbUKLESR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 23:18:17 -0500
Message-ID: <41943931.4090008@osdl.org>
Date: Thu, 11 Nov 2004 20:16:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: yiding_wang@agilent.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, akpm <akpm@osdl.org>
Subject: [PATCH] handle quoted module parameters
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AED@wcosmb07.cos.agilent.com> <41943754.6090806@osdl.org>
In-Reply-To: <41943754.6090806@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050300090102040900040504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300090102040900040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a patch with better description.


Fix module parameter quote handling.
Module parameter strings (with spaces) are quoted like so:
"modprm=this test"
and not like this:
modprm="this test"

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  kernel/params.c |   15 ++++++++++++---
  1 files changed, 12 insertions(+), 3 deletions(-)


-- 
~Randy

--------------050300090102040900040504
Content-Type: text/x-patch;
 name="modprm_quoted.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprm_quoted.patch"


diff -Naurp ./kernel/params.c~modprm_quoted ./kernel/params.c
--- ./kernel/params.c~modprm_quoted	2004-11-11 15:13:26.000000000 -0800
+++ ./kernel/params.c	2004-11-11 19:42:36.714124784 -0800
@@ -77,10 +77,16 @@ static int parse_one(char *param,
 static char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0;
+	int in_quote = 0, quoted = 0;
+	char *next;
 
 	/* Chew any extra spaces */
 	while (*args == ' ') args++;
+	if (*args == '"') {
+		args++;
+		in_quote = 1;
+		quoted = 1;
+	}
 
 	for (i = 0; args[i]; i++) {
 		if (args[i] == ' ' && !in_quote)
@@ -106,13 +112,16 @@ static char *next_arg(char *args, char *
 			if (args[i-1] == '"')
 				args[i-1] = '\0';
 		}
+		if (quoted && args[i-1] == '"')
+			args[i-1] = '\0';
 	}
 
 	if (args[i]) {
 		args[i] = '\0';
-		return args + i + 1;
+		next = args + i + 1;
 	} else
-		return args + i;
+		next = args + i;
+	return next;
 }
 
 /* Args looks like "foo=bar,bar2 baz=fuz wiz". */

--------------050300090102040900040504--
