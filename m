Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTDYNUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTDYNUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:20:04 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:30903 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id S263146AbTDYNUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:20:02 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Fri, 25 Apr 2003 15:32:00 +0200 (MEST)
Message-Id: <200304251332.h3PDW0f22620@duna48.eth.ericsson.se>
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH] proc_file_read fix for 2.5.68
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a problem with method 0 of proc_file_read (when the whole
file is copied to the page).  The calculation of the final bytecount
is wrong, and hence smaller then page size reads will give a truncated
file.  2.4.20 is OK in this respect.

Miklos

--- linux-2.5.68/fs/proc/generic.c~	2003-03-05 04:29:55.000000000 +0100
+++ linux-2.5.68/fs/proc/generic.c	2003-04-25 15:00:02.000000000 +0200
@@ -136,11 +136,11 @@
 				       "proc_file_read: Apparent buffer overflow!\n");
 				n = PAGE_SIZE;
 			}
-			if (n > count)
-				n = count;
 			n -= *ppos;
 			if (n <= 0)
 				break;
+			if (n > count)
+				n = count;
 			start = page + *ppos;
 		} else if (start < page) {
 			if (n > PAGE_SIZE) {
