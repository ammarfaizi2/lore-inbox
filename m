Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTDWXs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTDWXs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:48:58 -0400
Received: from pheriche.sun.com ([192.18.98.34]:57245 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id S264321AbTDWXs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:48:56 -0400
Message-ID: <3EA7298E.7050600@sun.com>
Date: Wed, 23 Apr 2003 17:02:22 -0700
From: Duncan Laurie <duncan@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en-us
MIME-Version: 1.0
To: Olivier Bornet <Olivier.Bornet@puck.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4
 in impossible state)
References: <20030423212713.GD21689@puck.ch>
In-Reply-To: <20030423212713.GD21689@puck.ch>
Content-Type: multipart/mixed;
 boundary="------------060509010501060201090008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509010501060201090008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Olivier Bornet wrote:
> Hello,
> 
> I'm trying to install Debian on 4 RaQ550 with each 2 80GB disks. All
> seems OK with 3 of RaQ, but with one, it crash when I put the two disks
> in a RAID1 meta device. In fact, it as crash at about 6% before the 70GB
> partition is fully synchronized.
> 

Hi Olivier,

There is an interaction problem between the Serverworks IDE controller
and some Seagate BlockPoint drives.  They aren't handling the bus
throttling correctly on ATA bus writes and are sometimes overflowing
their FIFOs.

The CSB5 in UDMA mode 5 sends 3 words after the drive de-asserts
DDMARDY- (per ATA spec section 9.14.3.2) but these drives sometimes
have problems when the three extra words are sent and overflows its
FIFO.  Other IDE controllers only send 2 extra words and don't cause
this to happen.

The only work around we have found is to limit these drives to ATA
mode 4.  Supposedly newer Seagate firmware for these drives will report
only UDMA mode 4 capable, but for earlier drives (like those probably
found in your raq550) try this patch against 2.4.20.

-duncan

--------------060509010501060201090008
Content-Type: text/plain;
 name="serverworks.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serverworks.c.diff"

--- serverworks.c	2002-08-02 17:39:44.000000000 -0700
+++ /home/duncan/cvs/linux-2.4/drivers/ide/serverworks.c	2003-04-23 16:37:45.000000000 -0700
@@ -100,6 +100,12 @@
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
+const char *bad_ata100[] = {
+	"ST340016A",
+	"ST380021A",
+	NULL
+};
+
 static struct pci_dev *bmide_dev;
 static byte svwks_revision = 0;
 
@@ -107,6 +113,14 @@
 extern int (*svwks_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 extern char *ide_media_verbose(ide_drive_t *);
 
+static int check_in_drive_lists (ide_drive_t *drive, const char **list)
+{
+	while (*list)
+		if (!strcmp(*list++, drive->id->model))
+			return 1;
+	return 0;
+}
+
 static int svwks_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p = buffer;
@@ -420,7 +434,8 @@
 	int ultra100 	= (ultra66 && svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 1 : 0;
 	byte speed;
 
-	if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
+	if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100) &&
+	    !check_in_drive_lists(drive, bad_ata100)) {
 		speed = XFER_UDMA_5;
 	} else if (id->dma_ultra & 0x0010) {
 		speed = ((udma_66) && (ultra66)) ? XFER_UDMA_4 : XFER_UDMA_2;

--------------060509010501060201090008--

