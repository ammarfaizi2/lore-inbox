Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTAJQaI>; Fri, 10 Jan 2003 11:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTAJQaH>; Fri, 10 Jan 2003 11:30:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55186
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265306AbTAJQ2k>; Fri, 10 Jan 2003 11:28:40 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: fverscheure@wanadoo.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20030110095558.E144CFF11@postfix4-1.free.fr>
References: <20030110095558.E144CFF11@postfix4-1.free.fr>
Content-Type: multipart/mixed; boundary="=-8nnSqFSOEC189JFaCg8A"
Organization: 
Message-Id: <1042219407.31848.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 17:23:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8nnSqFSOEC189JFaCg8A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-01-10 at 09:54, Francis Verscheure wrote:
> And by the way how are powered off the IDE drives ?
> Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
> drive with cache enabled or you will enjoy lost data.

We always issue standby or sleep commands to a drive before powering off which means
the cache flush thing should never have been an issue.

Having been over the other stuff here is a fairly paranoid first cut. Marcelo
please *don't* apply this yet, I'd like an Andre review of it and some testing
first.


--=-8nnSqFSOEC189JFaCg8A
Content-Disposition: inline; filename=a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=a1; charset=UTF-8

--- ../linux.21pre3/drivers/ide/ide-disk.c	2003-01-07 14:03:08.000000000 +0=
000
+++ drivers/ide/ide-disk.c	2003-01-10 17:15:02.000000000 +0000
@@ -38,9 +38,11 @@
  * Version 1.15		convert all calls to ide_raw_taskfile
  *				since args will return register content.
  * Version 1.16		added suspend-resume-checkpower
+ * Version 1.17		do flush on standy, do flush on ATA < ATA6
+ *			fix wcache setup.
  */
=20
-#define IDEDISK_VERSION	"1.16"
+#define IDEDISK_VERSION	"1.17"
=20
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
=20
@@ -67,7 +69,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
=20
-/* FIXME: soem day we shouldnt need to look in here! */
+/* FIXME: some day we shouldnt need to look in here! */
=20
 #include "legacy/pdc4030.h"
=20
@@ -716,6 +718,7 @@
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage =3D=3D 1) {
 		ide_task_t args;
+		int cf;
 		memset(&args, 0, sizeof(ide_task_t));
 		args.tfRegister[IDE_COMMAND_OFFSET] =3D WIN_DOORLOCK;
 		args.command_type =3D ide_cmd_type_parser(&args);
@@ -727,12 +730,40 @@
 		 */
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking =3D 0;
+		drive->wcache =3D 0;
+		/* Cache enabled ? */
+		if (drive->id->csfo & 1)
+			drive->wcache =3D 1;
+		/* Cache command set available ? */
+		if (drive->id->cfs_enable_1 & (1<<5))
+			drive->wcache =3D 1;
+		/* ATA6 cache extended commands */
+		cf =3D drive->id->command_set_2 >> 24;
+		if((cf & 0xC0) =3D=3D 0x40 && (cf & 0x30) !=3D 0)
+			drive->wcache =3D 1;
 	}
 	return 0;
 }
=20
 static int do_idedisk_flushcache(ide_drive_t *drive);
=20
+static int ide_cacheflush_p(ide_drive_t *drive)
+{
+	if(drive->wcache)
+	{
+		printk(KERN_INFO "ide: performing cache flush.\n");
+		if (do_idedisk_flushcache(drive))
+		{
+			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
+				drive->name);
+			return -EIO;
+		}
+		return 1;
+	}
+	printk(KERN_INFO "ide: no cache flush required.\n");
+	return 0;
+}
+
 static void idedisk_release (struct inode *inode, struct file *filp, ide_d=
rive_t *drive)
 {
 	if (drive->removable && !drive->usage) {
@@ -744,10 +775,7 @@
 		if (drive->doorlocking && ide_raw_taskfile(drive, &args, NULL))
 			drive->doorlocking =3D 0;
 	}
-	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (do_idedisk_flushcache(drive))
-			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-				drive->name);
+	ide_cacheflush_p(drive);
 	MOD_DEC_USE_COUNT;
 }
=20
@@ -1435,7 +1463,7 @@
 {
 	if (drive->suspend_reset)
 		return 1;
-
+	ide_cacheflush_p(drive);
 	return call_idedisk_suspend(drive, 0);
 }
=20
@@ -1679,10 +1707,7 @@
=20
 static int idedisk_cleanup(ide_drive_t *drive)
 {
-	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
-		if (do_idedisk_flushcache(drive))
-			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
-				drive->name);
+	ide_cacheflush_p(drive);
 	return ide_unregister_subdriver(drive);
 }
=20

--=-8nnSqFSOEC189JFaCg8A--
