Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbXACATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbXACATw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbXACATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:19:52 -0500
Received: from web50105.mail.yahoo.com ([206.190.38.33]:32027 "HELO
	web50105.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770AbXACATv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:19:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=H724zVlRdkChsPrw4W11ecxqCpHrQbAdOmwUvfqobdfqJNj27gfQPBs78U/IhgIpi0RK5St5hpwTDqr1dcV98MrZp3oDG1HllQQ4uZDSEawSFMrxBdZ0KDzoGVFwOvi6Iw8MM6HYouPvjxXHwmD4TG5E+TXtfUowBd1FPnkv5a4=;
X-YMail-OSG: aKuHM5oVM1nIAb85hMA3iiWGjlPIN1LyNvNUyvjqnSWV7U9Q9S9jTkKJW0.XyXn22QEnrNCQgflOrZB4SB3gsQ6qsOC3CraU0vn9nYb1zy20vMp39gNzcgoEiTxg9FaqKEIe9lSQa6.BQmY-
Date: Tue, 2 Jan 2007 16:19:50 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 2/2] EDAC: e752x-byte-access-fix
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <888580.13795.qm@web50105.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Brian Pomerantz <bapper@mvista.com>

Source: MontaVista Software, Inc.
MR: 17525
Type: Defect Fix
Disposition: local
Description:
    The reading of the DRA registers should be a byte at a time (one
    register at a time) instead of 4 bytes at a time (four registers).
    Reading a dword at a time retrieves erronious information from all
    but the first register.  A change was made to read in each
    register in a loop prior to using the data in those registers.

Signed-off-by: Brian Pomerantz <bapper@mvista.com>
Signed-off-by: Dave Jiang <djiang@mvista.com>
Signed-off-by: Doug Thompson <norsk5@xmission.com>

 e752x_edac.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


Index: linux-2.6.18/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.18.orig/drivers/edac/e752x_edac.c
+++ linux-2.6.18/drivers/edac/e752x_edac.c
@@ -787,7 +787,12 @@ static void e752x_init_csrows(struct mem
 	u8 value;
 	u32 dra, drc, cumul_size;
 
-	pci_read_config_dword(pdev, E752X_DRA, &dra);
+	dra = 0;
+	for (index=0; index < 4; index++) {
+		u8 dra_reg;
+		pci_read_config_byte(pdev, E752X_DRA+index, &dra_reg);
+		dra |= dra_reg << (index * 8);
+	}
 	pci_read_config_dword(pdev, E752X_DRC, &drc);
 	drc_chan = dual_channel_active(ddrcsr);
 	drc_drbg = drc_chan + 1;  /* 128 in dual mode, 64 in single */

