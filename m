Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275600AbTHQGQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHQGN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:13:56 -0400
Received: from codepoet.org ([166.70.99.138]:54671 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275029AbTHQGNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:13:19 -0400
Date: Sun, 17 Aug 2003 00:13:21 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061321.GD17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes all cases where ide-disk displays MB to use
consistant logic, and properly use the do_div() macro rather than
strange non-obvious numerical sequences doing a similar task,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- linux/drivers/ide/ide-disk.c.orig	2003-08-16 19:52:24.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-16 20:42:04.000000000 -0600
@@ -69,6 +69,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 /* FIXME: some day we shouldnt need to look in here! */
 
@@ -1131,6 +1132,13 @@
 
 #endif /* CONFIG_IDEDISK_STROKE */
 
+static unsigned long long sectors_to_MB(unsigned long long n)
+{
+	n <<= 9;		/* make it bytes */
+	do_div(n, 1000000);	/* make it MB */
+	return n;
+}
+
 /*
  * Tests if the drive supports Host Protected Area feature.
  * Returns true if supported, false otherwise.
@@ -1231,7 +1239,7 @@
 	}
 }
 
-static unsigned long idedisk_capacity (ide_drive_t *drive)
+static u64 idedisk_capacity (ide_drive_t *drive)
 {
 	if (drive->id->cfs_enable_2 & 0x0400)
 		return (drive->capacity48 - drive->sect0);
@@ -1616,7 +1624,7 @@
 	int i;
 	
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity;
+	unsigned long long capacity;
 
 	idedisk_add_settings(drive);
 
@@ -1683,14 +1691,23 @@
 	 * by correcting bios_cyls:
 	 */
 	capacity = idedisk_capacity (drive);
-	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
-	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
-		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
-	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
-
-	/* Give size in megabytes (MB), not mebibytes (MiB). */
-	/* We compute the exact rounded value, avoiding overflow. */
-	printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+	if (!drive->forced_geom && drive->bios_sect && drive->bios_head) {
+		unsigned int cap0 = capacity;	/* truncate to 32 bits */
+		unsigned int cylsz, cyl;
+
+		if (cap0 != capacity)
+			drive->bios_cyl = 65535;
+		else {
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = cap0 / cylsz;
+			if (cyl > 65535)
+				cyl = 65535;
+			if (cyl > drive->bios_cyl)
+				drive->bios_cyl = cyl;
+		}
+	}
+	printk(KERN_INFO "%s: %llu sectors (%llu MB)",
+			 drive->name, capacity, sectors_to_MB(capacity));
 
 	/* Only print cache size when it was specified */
 	if (id->buf_size)
