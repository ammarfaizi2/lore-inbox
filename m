Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266941AbUBQX2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266927AbUBQX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:28:47 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26082 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266913AbUBQX23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:28:29 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Jackson <jerj@coplanar.net>
Subject: Re: 2.4.23 IDE hang on boot with two single-channel controllers
Date: Wed, 18 Feb 2004 00:34:44 +0100
User-Agent: KMail/1.5.3
References: <401538C6.5030609@coplanar.net>
In-Reply-To: <401538C6.5030609@coplanar.net>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org,
       linux-ide <linux-ide@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402180034.44917.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I've just found it in my mail-archive :-). ]

On Monday 26 of January 2004 16:56, Jeremy Jackson wrote:
> Hi,

Hi,

> (watch crossposting when replying all)
>
> I'm hoping to reach the maintainer of the Linux IDE driver for the
> Compaq TriFlex controller.  I have a problem with this driver when used
> with a Compaq Armada 7730MT while docked in the base station.
>
> The driver appears to only support one triflex controller, due to a
> missing check (that other chipset drivers have) that should prevent it
> from registering a /proc interface more than once.  The result is that
> it hangs on boot in proc_ide_create() in an infinite loop.

Please send outputs of 'lspci' and 'dmesg' commands.

> triflex.c:
>
> static unsigned int __init init_chipset_triflex(struct pci_dev *dev,
>                  const char *name)
> {
> #ifdef CONFIG_PROC_FS
>          ide_pci_register_host_proc(&triflex_proc);
> #endif
>          return 0;
> }
>
> It also appears that triflex_get_info() doesn't support more that one
> controller.

Yep, that's true.

> I won't go into more detail until I can establish who might care :)

I might care ;-).

Does this patch fixes hang?
Does 'cat /proc/ide/triflex' produce sane output?

Cheers,
--bart

 linux-2.4.23-root/drivers/ide/pci/triflex.c |   41 +++++++++++++++++++---------
 linux-2.4.23-root/drivers/ide/pci/triflex.h |    5 ++-
 2 files changed, 32 insertions(+), 14 deletions(-)

diff -puN drivers/ide/pci/triflex.c~ide_triflex_proc_fix drivers/ide/pci/triflex.c
--- linux-2.4.23/drivers/ide/pci/triflex.c~ide_triflex_proc_fix	2004-02-17 23:40:34.324345576 +0100
+++ linux-2.4.23-root/drivers/ide/pci/triflex.c	2004-02-18 00:22:53.578320296 +0100
@@ -44,15 +44,17 @@
 #include "ide_modes.h"
 #include "triflex.h"
 
-static struct pci_dev *triflex_dev;
+#ifdef CONFIG_PROC_FS
+static u8 triflex_proc;
 
-static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
-{
-	char *p = buf;
-	int len;
+#define TRIFLEX_MAX_DEVS	2
+static struct pci_dev *triflex_devs[TRIFLEX_MAX_DEVS];
+static unsigned int n_triflex_devs;
 
-	struct pci_dev *dev	= triflex_dev;
+static int triflex_info(char *buffer, struct pci_dev *dev)
+{
 	unsigned long bibma = pci_resource_start(dev, 4);
+	char *p = buffer;
 	u8  c0 = 0, c1 = 0;
 	u32 pri_timing, sec_timing;
 
@@ -87,11 +89,23 @@ static int triflex_get_info(char *buf, c
 	p += sprintf(p, "DMA\n");
 	p += sprintf(p, "PIO\n");
 
+	return p - buffer;
+}
+
+static int triflex_get_info(char *buf, char **addr, off_t offset, int count)
+{
+	char *p = buf;
+	unsigned int i, len;
+
+	for (i = 0; i < n_triflex_devs; i++)
+		buf += triflex_info(buf, triflex_devs[i]);
+
 	len = (p - buf) - offset;
 	*addr = buf + offset;
-	
+
 	return len > count ? count : len;
 }
+#endif
 
 static int triflex_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
@@ -211,9 +225,13 @@ static unsigned int __init init_chipset_
 		const char *name) 
 {
 #ifdef CONFIG_PROC_FS
-	ide_pci_register_host_proc(&triflex_proc);
+	triflex_devs[n_triflex_devs++] = dev;
+	if (!triflex_proc) {
+		triflex_proc = 1;
+		ide_pci_register_host_proc(&triflex_procs);
+	}
 #endif
-	return 0;	
+	return 0;
 }
 
 static int __devinit triflex_init_one(struct pci_dev *dev, 
@@ -222,11 +240,10 @@ static int __devinit triflex_init_one(st
 	ide_pci_device_t *d = &triflex_devices[id->driver_data];
 	if (dev->device != d->device)
 		BUG();
-	
+
 	ide_setup_pci_device(dev, d);
-	triflex_dev = dev;
 	MOD_INC_USE_COUNT;
-	
+
 	return 0;
 }
 
diff -puN drivers/ide/pci/triflex.h~ide_triflex_proc_fix drivers/ide/pci/triflex.h
--- linux-2.4.23/drivers/ide/pci/triflex.h~ide_triflex_proc_fix	2004-02-17 23:58:11.698600256 +0100
+++ linux-2.4.23-root/drivers/ide/pci/triflex.h	2004-02-18 00:27:28.152578664 +0100
@@ -14,7 +14,6 @@
 
 static unsigned int __devinit init_chipset_triflex(struct pci_dev *, const char *);
 static void init_hwif_triflex(ide_hwif_t *);
-static int triflex_get_info(char *, char **, off_t, int);
 
 static ide_pci_device_t triflex_devices[] __devinitdata = {
 	{
@@ -34,7 +33,9 @@ static ide_pci_device_t triflex_devices[
 };
 
 #ifdef CONFIG_PROC_FS
-static ide_pci_host_proc_t triflex_proc __initdata = {
+static int triflex_get_info(char *, char **, off_t, int);
+
+static ide_pci_host_proc_t triflex_procs __initdata = {
 	.name		= "triflex",
 	.set		= 1,
 	.get_info 	= triflex_get_info,

_

