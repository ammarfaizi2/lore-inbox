Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVBTOdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVBTOdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVBTOdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:33:16 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:29947 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261830AbVBTOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:33:00 -0500
Date: Sun, 20 Feb 2005 15:24:56 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.58.0502201522450.951@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/Kconfig  |    2 +-
 drivers/ide/ide-io.c |    5 +++--
 drivers/ide/ide.c    |    4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)

through these ChangeSets:

<ben-linux@fluff.org> (05/02/20 1.2130)
   [ide] Kconfig for VR1000 machine driver selection

   Fix the use of CONFIG_MACH_VR1000, which was missing an
   trailing zero from the configuration variable, so never
   being shown if only the VR1000 was selected

   Signed-off-by: Ben Dooks <ben-linux@fluff.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<mikukkon@gmail.com> (05/02/20 1.2129)
   [ide] small compile fix to ide.c with !CONFIG_PCI

   Small patch to fix following warning with CONFIG_IDE && !CONFIG_PCI:

     CC	drivers/ide/ide.o
   drivers/ide/ide.c: In function 'ide_system_bus_speed':
   drivers/ide/ide.c:338: warning: unused variable 'pci_default'

   I decided to save some bytes by #ifdef:ing the struct in question.
   CC:ing Hanna because she did the change (and just to say hi ;-).

   Signed-off-by: Mika Kukkonen <mikukkon@gmail.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/02/19 1.2128)
   [ide] fix ide_get_error_location() for LBA28

   Higher bits (16-23) of the address were ignored.

   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2005-02-20 15:08:56 +01:00
+++ b/drivers/ide/Kconfig	2005-02-20 15:08:56 +01:00
@@ -812,7 +812,7 @@

 config BLK_DEV_IDE_BAST
 	tristate "Simtec BAST / Thorcom VR1000 IDE support"
-	depends on ARM && (ARCH_BAST || MACH_VR100)
+	depends on ARM && (ARCH_BAST || MACH_VR1000)
 	help
 	  Say Y here if you want to support the onboard IDE channels on the
 	  Simtec BAST or the Thorcom VR1000
diff -Nru a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2005-02-20 15:08:56 +01:00
+++ b/drivers/ide/ide-io.c	2005-02-20 15:08:56 +01:00
@@ -238,9 +238,10 @@
 		high = ide_read_24(drive);
 	} else {
 		u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
-		if (cur & 0x40)
+		if (cur & 0x40) {
+			high = cur & 0xf;
 			low = (hcyl << 16) | (lcyl << 8) | sect;
-		else {
+		} else {
 			low = hcyl * drive->head * drive->sect;
 			low += lcyl * drive->sect;
 			low += sect - 1;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-02-20 15:08:56 +01:00
+++ b/drivers/ide/ide.c	2005-02-20 15:08:56 +01:00
@@ -335,10 +335,14 @@

 static int ide_system_bus_speed(void)
 {
+#ifdef CONFIG_PCI
 	static struct pci_device_id pci_default[] = {
 		{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
 		{ }
 	};
+#else
+#define pci_default 0
+#endif /* CONFIG_PCI */

 	if (!system_bus_speed) {
 		if (idebus_parameter) {
