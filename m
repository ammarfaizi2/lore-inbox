Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUFPUzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUFPUzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUFPUzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:55:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264815AbUFPUyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:54:54 -0400
Date: Wed, 16 Jun 2004 16:54:37 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: A possible approach to the IDE shadow problem
Message-ID: <20040616205437.GA9907@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some IDE devices don't decode master/slave (notably PCMCIA CF stuff), other
stuff has flash and disk mixed. Either assumption is broken so the kernel
sometimes double detects devices like microdrives. 

It occurred to me there may be a very easy way to fix this, so this patch
is for comment [Linus don't apply it yet 8)]


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/ide/ide-probe.c 2.6.7-ac/drivers/ide/ide-probe.c
--- linux-2.6.7/drivers/ide/ide-probe.c	2004-06-16 21:11:35.907453312 +0100
+++ 2.6.7-ac/drivers/ide/ide-probe.c	2004-06-16 21:19:28.422620088 +0100
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
