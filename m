Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWJJRT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWJJRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWJJRQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:16:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:55177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964819AbWJJRPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:39 -0400
Date: Tue, 10 Oct 2006 10:14:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Michael-Luke Jones <mlj28@cam.ac.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/19] Backport: Old IDE, fix SATA detection for cabling
Message-ID: <20061010171447.GG6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="backport-old-ide-fix-sata-detection-for-cabling.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Michael-Luke Jones <mlj28@cam.ac.uk>

This patch is identical to that introduced in
1a1276e7b6cba549553285f74e87f702bfff6fac to the Linus' 2.6 development tree 
by Alan Cox.

'This is based on the proposed patches flying around but also checks that
the device in question is new enough to have word 93 rather thanb blindly
assuming word 93 == 0 means SATA (see ATA-5, ATA-7)' -- Alan Cox

Required for my SATA drive on an Asus Pundit-R to operate above 33MBps.
 
Signed-off-by: Michael-Luke Jones <mlj28@cam.ac.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/ide-iops.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.17.13.orig/drivers/ide/ide-iops.c
+++ linux-2.6.17.13/drivers/ide/ide-iops.c
@@ -597,6 +597,10 @@ u8 eighty_ninty_three (ide_drive_t *driv
 {
 	if(HWIF(drive)->udma_four == 0)
 		return 0;
+
+    /* Check for SATA but only if we are ATA5 or higher */
+    if (drive->id->hw_config == 0 && (drive->id->major_rev_num & 0x7FE0))
+        return 1;
 	if (!(drive->id->hw_config & 0x6000))
 		return 0;
 #ifndef CONFIG_IDEDMA_IVB

--
