Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbTBRSCD>; Tue, 18 Feb 2003 13:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267967AbTBRR7u>; Tue, 18 Feb 2003 12:59:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267966AbTBRR7Z>; Tue, 18 Feb 2003 12:59:25 -0500
Subject: PATCH: add new settings locks to ide-proc
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:09:47 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCBf-00068Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-proc.c linux-2.5.61-ac2/drivers/ide/ide-proc.c
--- linux-2.5.61/drivers/ide/ide-proc.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-proc.c	2003-02-18 18:06:17.000000000 +0000
@@ -434,6 +454,7 @@
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
 
+	down(&ide_setting_sem);
 	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
 	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
 	while(setting) {
@@ -453,6 +474,7 @@
 		setting = setting->next;
 	}
 	len = out - page;
+	up(&ide_setting_sem);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -521,12 +543,17 @@
 				--n;
 				++p;
 			}
+			
+			down(&ide_setting_sem);
 			setting = ide_find_setting_by_name(drive, name);
 			if (!setting)
+			{
+				up(&ide_setting_sem);
 				goto parse_error;
-
+			}
 			if (for_real)
 				ide_write_setting(drive, setting, val * setting->div_factor / setting->mul_factor);
+			up(&ide_setting_sem);
 		}
 	} while (!for_real++);
 	return count;
