Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTFMQzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTFMQzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:55:43 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:931 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265335AbTFMQz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:55:29 -0400
Date: Fri, 13 Jun 2003 12:08:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: scsi_add_device() broken? (was Re: SBP2 hotplug doesn't update /proc/partitions)
Message-ID: <20030613160812.GA520@hopper.phunnypharm.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com> <3EDE870C.1EFA566C@digeo.com> <1054838369.1737.11.camel@torrey.et.myrio.com> <20030605175412.GF625@phunnypharm.org> <1054858724.3519.19.camel@torrey.et.myrio.com> <20030606025721.GJ625@phunnypharm.org> <1055446080.3480.291.camel@torrey.et.myrio.com> <20030612195243.GV4695@phunnypharm.org> <20030613024044.GA499@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613024044.GA499@hopper.phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
> ieee1394: sbp2: Query logins to SBP-2 device successful
> ieee1394: sbp2: Maximum concurrent logins supported: 1
> ieee1394: sbp2: Number of active logins: 0
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: sbp2: Node[02:1023]: Max speed [S400] - Max payload [2048]
>   Vendor: FireWire  Model:  1394 Disk Drive  Rev: G603
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
> sda: cache data unavailable
> sda: assuming drive cache: write through
>  sda: unknown partition table
> devfs_mk_dir: invalid argument.<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Here's the scenario. scsi_add_lun doesn't set sdp->devfs_name before
calling scsi_register_device(). Since scsi_register_device calls down to
things like sd_probe, which do try to use sdp->devfs_name, things fail.

Just an easy change, moving the sdp->devfs_name creation before calling
scsi_register_device(). Patch fixes this.

Index: linux-2.5/drivers/scsi/scsi_scan.c
===================================================================
--- linux-2.5/drivers/scsi/scsi_scan.c	(revision 10937)
+++ linux-2.5/drivers/scsi/scsi_scan.c	(working copy)
@@ -619,12 +619,12 @@
 	if (inq_result[7] & 0x10)
 		sdev->sdtr = 1;
 
-	scsi_device_register(sdev);
-
 	sprintf(sdev->devfs_name, "scsi/host%d/bus%d/target%d/lun%d",
 				sdev->host->host_no, sdev->channel,
 				sdev->id, sdev->lun);
 
+	scsi_device_register(sdev);
+
 	/*
 	 * End driverfs/devfs code.
 	 */

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
