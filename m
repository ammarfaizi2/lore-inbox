Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267963AbTBRR7m>; Tue, 18 Feb 2003 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267967AbTBRR7Y>; Tue, 18 Feb 2003 12:59:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267963AbTBRR6i>; Tue, 18 Feb 2003 12:58:38 -0500
Subject: PATCH: ide-proc - fix crash on identify
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:08:59 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCAt-00068R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot do an identify on a drive with no driver loaded. The kernel
has a ton of half backed "if no driver" cases but they dont cover all
cases and its a mess.

For now we rely on the probe time identify unless a driver is loaded. A 
proper fix (an 'ide-unassigned' driver) will follow later

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-proc.c linux-2.5.61-ac2/drivers/ide/ide-proc.c
--- linux-2.5.61/drivers/ide/ide-proc.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-proc.c	2003-02-18 18:06:17.000000000 +0000
@@ -407,20 +407,40 @@
 {
 	ide_drive_t	*drive = (ide_drive_t *)data;
 	int		len = 0, i = 0;
+	int		err = 0;
 
-	if (drive && !taskfile_lib_get_identify(drive, page)) {
+	len = sprintf(page, "\n");
+	
+	if (drive)
+	{
 		unsigned short *val = (unsigned short *) page;
-		char *out = ((char *)val) + (SECTOR_WORDS * 4);
-		page = out;
-		do {
-			out += sprintf(out, "%04x%c",
-				le16_to_cpu(*val), (++i & 7) ? ' ' : '\n');
-			val += 1;
-		} while (i < (SECTOR_WORDS * 2));
-		len = out - page;
+		
+		/*
+		 *	The current code can't handle a driverless
+		 *	identify query taskfile. Now the right fix is
+		 *	to add a 'default' driver but that is a bit
+		 *	more work. 
+		 *
+		 *	FIXME: this has to be fixed for hotswap devices
+		 */
+		 
+		if(DRIVER(drive))
+			err = taskfile_lib_get_identify(drive, page);
+		else	/* This relies on the ID changes */
+			val = (unsigned short *)drive->id;
+
+		if(!err)
+		{						
+			char *out = ((char *)page) + (SECTOR_WORDS * 4);
+			page = out;
+			do {
+				out += sprintf(out, "%04x%c",
+					le16_to_cpu(*val), (++i & 7) ? ' ' : '\n');
+				val += 1;
+			} while (i < (SECTOR_WORDS * 2));
+			len = out - page;
+		}
 	}
-	else
-		len = sprintf(page, "\n");
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
