Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVLMIdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVLMIdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVLMIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:32:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:37763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932549AbVLMIYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:24:46 -0500
Date: Tue, 13 Dec 2005 00:23:44 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com
Subject: [patch 21/26] [libata] locking rewrite (== fix)
Message-ID: <20051213082344.GV5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="locking-rewrite.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jeff Garzik <jgarzik@pobox.com>

[libata] locking rewrite (== fix)

A lot of power packed into a little patch.

This change eliminates the sharing between our controller-wide spinlock
and the SCSI core's Scsi_Host lock.  As the locking in libata was
already highly compartmentalized, always referencing our own lock, and
never scsi_host::host_lock.

As a side effect, this change eliminates a deadlock from calling
scsi_finish_command() while inside our spinlock.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/libata-core.c |    2 --
 drivers/scsi/libata-scsi.c |    9 ++++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.14.3.orig/drivers/scsi/libata-core.c
+++ linux-2.6.14.3/drivers/scsi/libata-core.c
@@ -3916,8 +3916,6 @@ static void ata_host_init(struct ata_por
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 
-	scsi_assign_lock(host, &host_set->lock);
-
 	ap->flags = ATA_FLAG_PORT_DISABLED;
 	ap->id = host->unique_id;
 	ap->host = host;
--- linux-2.6.14.3.orig/drivers/scsi/libata-scsi.c
+++ linux-2.6.14.3/drivers/scsi/libata-scsi.c
@@ -39,6 +39,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <asm/uaccess.h>
 
@@ -1565,8 +1566,12 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	struct ata_port *ap;
 	struct ata_device *dev;
 	struct scsi_device *scsidev = cmd->device;
+	struct Scsi_Host *shost = scsidev->host;
 
-	ap = (struct ata_port *) &scsidev->host->hostdata[0];
+	ap = (struct ata_port *) &shost->hostdata[0];
+
+	spin_unlock(shost->host_lock);
+	spin_lock(&ap->host_set->lock);
 
 	ata_scsi_dump_cdb(ap, cmd);
 
@@ -1589,6 +1594,8 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
+	spin_unlock(&ap->host_set->lock);
+	spin_lock(shost->host_lock);
 	return 0;
 }
 

--
