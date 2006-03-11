Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWCKP5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWCKP5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 10:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWCKP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 10:57:45 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:58921 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751031AbWCKP5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 10:57:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XDveVdJCrrVT1TOrGxHzYFejZ3fhiEbG4DImKXL0tkWbQYtX56ENP42VXfYeQbzVVT7JN+J1NeKr+Jgq/8zyuRr86JfpU0xOk/fusKgb7BnS+0Y+070QK/05+2FKML1FeXgopU5RwjEXSwJFknbW4cWNCJZM9EvKMBnh0W2SYek=
Date: Sun, 12 Mar 2006 00:57:39 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morotn <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: [PATCH] libata: fix missing classes[] initialization in ata_bus_probe()
Message-ID: <20060311155739.GA23806@htj.dyndns.org>
References: <20060307021929.754329c9.akpm@osdl.org> <E1FI5tQ-0002kx-00@decibel.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FI5tQ-0002kx-00@decibel.fi.muni.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ata_bus_probe() didn't initialize classes[] properly with
ATA_DEV_UNKNOWN.  As ->probe_reset() is allowed to leave @classes
alone when no device is present, this results in garbage class values.
ATM, the only affected driver is ata_piix.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>

---

Jiri, thanks for reporting this.  The offending change has been there
for some time but it's the first time I see it.  Probably because my
garbage was never ATA_DEV_ATA or ATA_DEV_ATAPI.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5dbcf0c..d7f9f1a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1237,6 +1237,9 @@ static int ata_bus_probe(struct ata_port
 
 	/* reset */
 	if (ap->ops->probe_reset) {
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			classes[i] = ATA_DEV_UNKNOWN;
+
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc) {
 			printk("ata%u: reset failed (errno=%d)\n", ap->id, rc);
