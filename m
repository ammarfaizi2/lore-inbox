Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUG0Wr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUG0Wr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUG0Wr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:47:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7557 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266682AbUG0WrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:47:13 -0400
Date: Tue, 27 Jul 2004 18:46:29 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: Fix ide probe double detection
Message-ID: <20040727224629.GA17147@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices don't decode master/slave - notably PCMCIA adapters. 
Unfortunately for us some also do, which makes it hard to guess if we
should probe the slave.

This patch fixes the problem by probing the slave and then using the model
and serial information to spot undecoded pairs. An additional check is done
to catch pairs of pre ATA devices just in case.

Alan


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/ide/ide-probe.c 2.6.7-ac/drivers/ide/ide-probe.c
--- linux-2.6.7/drivers/ide/ide-probe.c	2004-06-16 21:11:35.000000000 +0100
+++ 2.6.7-ac/drivers/ide/ide-probe.c	2004-06-16 21:19:28.000000000 +0100
@@ -749,6 +749,16 @@
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
+		if (drive->present && hwif->present && unit == 1)
+		{
+			if(strcmp(hwif->drives[0].id->model, drive->id->model) == 0 &&
+			   strcmp(drive->id->model, "UNKNOWN") && /* Don't do this for non ATA or for noprobe */
+			   strncmp(hwif->drives[0].id->serial_no, drive->id->serial_no, 20) == 0)
+			{
+				printk(KERN_WARNING "ide-probe: ignoring undecoded slave\n");
+				drive->present = 0;
+			}
+		}
 		if (drive->present && !hwif->present) {
 			hwif->present = 1;
 			if (hwif->chipset != ide_4drives ||
