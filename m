Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUHSNHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUHSNHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUHSNHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:07:55 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:7926 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S261857AbUHSNHk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:07:40 -0400
Message-ID: <4124A582.4060300@ttnet.net.tr>
Date: Thu, 19 Aug 2004 16:05:06 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] another gcc-3.4 lvalue fix (i2c-proc)
Content-Type: multipart/mixed;
	boundary="------------000202020103030807050103"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202020103030807050103
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Taken from i2c-2.8.x. Please review and apply to 2.4.28.
This hunk was missed in the patch posted at
http://marc.theaimsgroup.com/?l=linux-kernel&m=109182440417014&w=2 .

Ozkan Sezer

--------------000202020103030807050103
Content-Type: text/plain;
	name="gcc34_i2c-proc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_i2c-proc.diff"

--- 28p1/drivers/i2c/i2c-proc.c~	2004-02-18 15:36:31.000000000 +0200
+++ 28p1/drivers/i2c/i2c-proc.c	2004-08-19 15:38:29.000000000 +0300
@@ -198,19 +198,19 @@
 
 void i2c_deregister_entry(int id)
 {
-	ctl_table *table;
-	char *temp;
 	id -= 256;
+
 	if (i2c_entries[id]) {
-		table = i2c_entries[id]->ctl_table;
-		unregister_sysctl_table(i2c_entries[id]);
-		/* 2-step kfree needed to keep gcc happy about const points */
-		(const char *) temp = table[4].procname;
-		kfree(temp);
-		kfree(table);
-		i2c_entries[id] = NULL;
-		i2c_clients[id] = NULL;
+		struct ctl_table_header *hdr = i2c_entries[id];
+		struct ctl_table *tbl = hdr->ctl_table;
+
+		unregister_sysctl_table(hdr);
+		kfree(tbl->child->child->procname);
+		kfree(tbl); /* actually the whole anonymous struct */
 	}
+
+	i2c_entries[id] = NULL;
+	i2c_clients[id] = NULL;
 }
 
 /* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 

--------------000202020103030807050103--
