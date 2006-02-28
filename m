Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWB1Dgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWB1Dgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWB1Dgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:36:50 -0500
Received: from mail.dvmed.net ([216.237.124.58]:55525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932342AbWB1Dgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:36:49 -0500
Message-ID: <4403C546.7030702@pobox.com>
Date: Mon, 27 Feb 2006 22:36:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Tejun Heo <htejun@gmail.com>, Mark Lord <lkml@rtr.ca>,
       David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org> <4403B04F.5090405@pobox.com> <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602271813120.22647@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040501080200000803040404"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501080200000803040404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 27 Feb 2006, Jeff Garzik wrote:
> 
>>I've had this waiting in the wings, in fact...  [see attached]
> 
> 
> I really hate having a _global_ variable called "fua". That's just bad 
> taste. I would suggest calling it "atapi_forced_unit_attention_enabled", 
> but maybe that is going a bit overboard. It's definitely better than just 
> "fua", though.

Here's the cleaner namespace version...

	Jeff




--------------040501080200000803040404
Content-Type: text/plain;
 name="libata.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.txt"

Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    4 ++++
 drivers/scsi/libata-scsi.c |    2 ++
 drivers/scsi/libata.h      |    1 +
 3 files changed, 7 insertions(+)

Jeff Garzik:
      [libata] Disable FUA

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5f1d758..4f91b0d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -82,6 +82,10 @@ int atapi_enabled = 0;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int libata_fua = 0;
+module_param_named(fua, libata_fua, int, 0444);
+MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 07b1e7c..59503c9 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1708,6 +1708,8 @@ static int ata_dev_supports_fua(u16 *id)
 {
 	unsigned char model[41], fw[9];
 
+	if (!libata_fua)
+		return 0;
 	if (!ata_id_has_fua(id))
 		return 0;
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e03ce48..fddaf47 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -41,6 +41,7 @@ struct ata_scsi_args {
 
 /* libata-core.c */
 extern int atapi_enabled;
+extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);

--------------040501080200000803040404--
