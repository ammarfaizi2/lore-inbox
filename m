Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUFGJgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUFGJgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUFGJge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:36:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21709 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264373AbUFGJg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:36:29 -0400
Date: Mon, 7 Jun 2004 11:36:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040607093622.GG13836@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <200406070906.46392.kernel@kolivas.org> <20040607072414.GC13836@suse.de> <200406071918.16166.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406071918.16166.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2004, Con Kolivas wrote:
> On Mon, 7 Jun 2004 17:24, Jens Axboe wrote:
> > On Mon, Jun 07 2004, Con Kolivas wrote:
> > > hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
> > > Error } hdd: status error: error=0x20LastFailedSense 0x02
> > > hdd: drive not ready for command
> > > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > > hdd: status error: error=0x00
> > > ..etc
> > Con, please try with this debug patch.
> 
> Here is the output:
> hdd: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
>  hda: hda1 hda2 < hda5 hda6 hda7 >
> hdb: max request size: 1024KiB
> hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
>  hdb: hdb2 < hdb5 hdb6 hdb7 >
> ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
> ide-cd: queueing cdb: 5a 00 03 00 00 00 00 00 10 00 00 00
> ide-cd: queueing cdb: 5a 00 2c 00 00 00 00 00 10 00 00 00
> ide-cd: queueing cdb: 46 00 00 20 00 00 00 00 18 00 00 00
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> ide-cd: queueing cdb: 00 00 00 00 00 00 00 00 00 00 00 00
> ide-cd: queueing cdb: 25 00 00 00 00 00 00 00 00 00 00 00
> ide-cd: queueing cdb: 43 02 00 00 00 00 00 00 04 00 00 00
> ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
> ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
> hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hdd: status error: error=0x20LastFailedSense 0x02
> hdd: drive not ready for command

Hmm, that is GET_CONFIGURATION with CDF_MRW as the feature - that must
have gone away if you disabled cdrom_is_mrw in ide-cd like I suggested,
did you botch that test?

Can you check if this changes the behaviour for you (should apply on -bk
as well):

--- linux-2.6.7-rc2-mm2/drivers/cdrom/cdrom.c~	2004-06-03 22:21:51.000000000 +0200
+++ linux-2.6.7-rc2-mm2/drivers/cdrom/cdrom.c	2004-06-07 11:34:49.443151026 +0200
@@ -505,14 +505,34 @@
 {
 	struct packet_command cgc;
 	struct mrw_feature_desc *mfd;
-	unsigned char buffer[16];
-	int ret;
+	struct feature_header *fh;
+	unsigned char buffer[32];
+	int ret, real_len;
 
-	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
+	init_cdrom_command(&cgc, buffer, 8, CGC_DATA_READ);
+
+	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
+	cgc.cmd[3] = CDF_MRW;
+	cgc.cmd[8] = 8;
+	cgc.quiet = 1;
+
+	/*
+	 * probe length/existance first
+	 */
+	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+		return ret;
+
+	fh = (struct feature_header *) buffer;
+
+	if (!be32_to_cpu(fh->data_len))
+		return 1;
+
+	real_len = 4 + be32_to_cpu(fh->data_len);
+	init_cdrom_command(&cgc, buffer, real_len, CGC_DATA_READ);
 
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[3] = CDF_MRW;
-	cgc.cmd[8] = sizeof(buffer);
+	cgc.cmd[8] = real_len;
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))

-- 
Jens Axboe

