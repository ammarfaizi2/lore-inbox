Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSF1Rj0>; Fri, 28 Jun 2002 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSF1RjZ>; Fri, 28 Jun 2002 13:39:25 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:40630 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S317471AbSF1RjY>; Fri, 28 Jun 2002 13:39:24 -0400
Message-ID: <3D1C9FD2.3060000@cox.net>
Date: Fri, 28 Jun 2002 10:41:38 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1a) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andre@linux-ide.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] patch to make ide-probe mark ide-floppy devices as removable
 and clean up drive type override code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch has been in wide use for months, but has not (yet) been integrated 
into the kernel. Patch is against 2.4.19-pre10-ac2, which has a 
different version of ide-probe.c than 2.4.19-rc1.

diff -X dontdiff -urN linux/drivers/ide/ide-probe.c 
linux-probe/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	Thu Jun  6 10:00:50 2002
+++ linux-probe/drivers/ide/ide-probe.c	Thu Jun  6 10:37:41 2002
@@ -130,31 +130,40 @@
  	 
	goto err_misc;
  		}
  #endif /* CONFIG_BLK_DEV_PDC4030 */
+ 
	/*
+ 
	 * Handle drive type overrides for "unusual" devices
+ 
	 */
  		switch (type) {
- 
		case ide_floppy:
- 
			if (!strstr(id->model, "CD-ROM")) {
- 
				if (!strstr(id->model, "oppy") &&
- 
				    !strstr(id->model, "poyp") &&
- 
				    !strstr(id->model, "ZIP"))
- 
					printk("cdrom or floppy?, assuming ");
- 
				if (drive->media != ide_cdrom) {
- 
					printk ("FLOPPY");
- 
					break;
- 
				}
- 
			}
+ 
	case ide_floppy:
+ 
		if (strstr(id->model, "CD-ROM")) {
+ 
			type = ide_cdrom;
+ 
			break;
+ 
		}
+ 
		if (!strstr(id->model, "oppy") &&
+ 
		    !strstr(id->model, "poyp") &&
+ 
		    !strstr(id->model, "ZIP"))
+ 
			printk("cdrom or floppy?, assuming ");
+ 
		if (drive->media == ide_cdrom)
  	 
		type = ide_cdrom;	/* Early cdrom models used zero */
- 
		case ide_cdrom:
- 
			drive->removable = 1;
+ 
		break;
  #ifdef CONFIG_PPC
+ 
	case ide_cdrom:
  	 
		/* kludge for Apple PowerBook internal zip */
- 
			if (!strstr(id->model, "CD-ROM") &&
- 
			    strstr(id->model, "ZIP")) {
- 
				printk ("FLOPPY");
- 
				type = ide_floppy;
- 
				break;
- 
			}
+ 
		if (!strstr(id->model, "CD-ROM") &&
+ 
		    strstr(id->model, "ZIP")) {
+ 
			type = ide_floppy;
+ 
			break;
+ 
		}
  #endif
+ 
	}
+ 
	switch (type) {
+ 	 
	case ide_floppy:
+ 	 
		printk ("FLOPPY");
+ 	 
		drive->removable = 1;
+ 	 
		break;
+ 	 
	case ide_cdrom:
  	 
		printk ("CD/DVD-ROM");
+ 	 
		drive->removable = 1;
  	 
		break;
  	 
	case ide_tape:
  	 
		printk ("TAPE");

