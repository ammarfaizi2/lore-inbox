Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVDAUfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVDAUfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVDAUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:34:32 -0500
Received: from kanga.kvack.org ([66.96.29.28]:14774 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262873AbVDAUdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:33:14 -0500
Date: Fri, 1 Apr 2005 15:32:53 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [bktools patch] mailsplit: handle tabs in headers
Message-ID: <20050401203253.GA27961@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus et al,

The patch below fixes mailsplit to cope with non-' ' space characters 
in mail headers.  Some people seem to have mail clients that use tabs 
which would result in mailsplit omitting those headers from its 
substitutions.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

===== mailsplit.c 1.5 vs edited =====
--- 1.5/mailsplit.c	2002-10-09 15:52:37 -04:00
+++ edited/mailsplit.c	2005-04-01 15:26:54 -05:00
@@ -37,9 +37,9 @@
 	void (*fn)(const char *);
 	char value[HDRLEN];
 } header[] = {
-	{ "From: ", parse_from },
-	{ "Subject: " },
-	{ "Date: " }
+	{ "From:", parse_from },
+	{ "Subject:" },
+	{ "Date:" }
 };
 
 enum header_type { FROM, SUBJECT, DATE, NRHEADERS };
@@ -218,6 +218,12 @@
 			int len = strlen(name);
 			if (memcmp(buffer, name, len))
 				continue;
+			if (!isspace(buffer[len])) {
+				fprintf(stderr,
+					"malformed mail: no space after header\n");
+				continue;
+			}
+			len++;
 			strncpy(header[i].value, buffer+len, HDRLEN-1);
 			if (header[i].fn)
 				header[i].fn(header[i].value);
===== Makefile 1.7 vs edited =====
--- 1.7/Makefile	2003-05-25 22:56:42 -04:00
+++ edited/Makefile	2005-04-01 15:12:42 -05:00
@@ -1,5 +1,5 @@
 CC=gcc
-CFLAGS=-Wall -O2
+CFLAGS=-Wall -g
 HOME=$(shell echo $$HOME)
 
 PROGRAMS=mailsplit diffsplit mkfile bkr
