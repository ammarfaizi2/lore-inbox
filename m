Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUEHLeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUEHLeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUEHLeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:34:15 -0400
Received: from [213.133.118.2] ([213.133.118.2]:8663 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262906AbUEHLdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:33:40 -0400
Message-ID: <409CC59B.3020500@shadowconnect.com>
Date: Sat, 08 May 2004 13:33:47 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040505
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] to fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct
Content-Type: multipart/mixed;
 boundary="------------060403080504060806080704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403080504060806080704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the patch fixes a bug in the i2o_proc.c module, where the kernel panics, 
if you access /proc/i2o/iop0/lct and read more then 1024 bytes of it.

The problem was, that no paging was implemented by the function. This is 
now solved.

If you have any questions, pleese feel free to contact me.

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------060403080504060806080704
Content-Type: text/x-patch;
 name="i2o_proc-lct-access-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_proc-lct-access-bugfix.patch"

--- a/drivers/message/i2o/i2o_proc.c	2004-04-04 05:37:25.000000000 +0200
+++ b/drivers/message/i2o/i2o_proc.c	2004-05-07 03:33:45.136253576 +0200
@@ -406,13 +406,15 @@
 	return len;
 }
 
-int i2o_proc_read_lct(char *buf, char **start, off_t offset, int len,
+int i2o_proc_read_lct(char *page, char **start, off_t off, int count,
 	int *eof, void *data)
 {
 	struct i2o_controller *c = (struct i2o_controller*)data;
 	i2o_lct *lct = (i2o_lct *)c->lct;
 	int entries;
 	int i;
+	int len;
+	char *buf;
 
 #define BUS_TABLE_SIZE 3
 	static char *bus_ports[] =
@@ -422,11 +424,13 @@
 		"Fibre Channel Bus"
 	};
 
-	spin_lock(&i2o_proc_lock);
-	len = 0;
-
 	entries = (lct->table_size - 3)/9;
 
+	buf = kmalloc(entries * 300 + 100, GFP_KERNEL);
+	if(!buf)
+		return -ENOMEM;
+	len = 0;
+
 	len += sprintf(buf, "LCT contains %d %s\n", entries,
 						entries == 1 ? "entry" : "entries");
 	if(lct->boot_tid)	
@@ -538,7 +542,20 @@
 				lct->lct_entry[i].device_flags);
 	}
 
-	spin_unlock(&i2o_proc_lock);
+	*start = page;
+
+	if(off > len) {
+		*eof = 1;
+		len = 0;
+	} else {
+		len -= off;
+		if(len <= count)
+			*eof = 1;
+		else
+			len = count;
+	}
+	strncpy(page, buf + off, len);
+	kfree(buf);
 	return len;
 }
 

--------------060403080504060806080704--
