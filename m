Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263695AbTCUSNV>; Fri, 21 Mar 2003 13:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263692AbTCUSMi>; Fri, 21 Mar 2003 13:12:38 -0500
Received: from [128.2.206.88] ([128.2.206.88]:36833 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S263686AbTCUSLk>; Fri, 21 Mar 2003 13:11:40 -0500
Date: Fri, 21 Mar 2003 13:22:30 -0500
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: USB harddrive not working (2.4, 2.5)
Message-ID: <20030321182230.GA25297@delft.aura.cs.cmu.edu>
Mail-Followup-To: Andrey Panin <pazke@orbita1.ru>,
	linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
References: <20030319102117.GA689@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319102117.GA689@pazke>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 01:21:17PM +0300, Andrey Panin wrote:
> Hi,
> 
> ISD200 based hard drive bay doesn't work with 2.4 & 2.5, 
> can someone assist me with it?

This looks like the same problem I was seeing with my Archos. The
initial probes for ATA devices fail and the driver falls back to
'transparent scsi mode', where it passes everything along unchanged.
Probably works fine when an ATAPI device is attached, but not with my
drive.

> usb-storage:    isd200_action(ENUM,0xa0)
> usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 1 L 0 F 0 CL 0
> usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
> usb-storage: Status code 0; transferred 31/31
> usb-storage: -- transfer complete
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
> usb-storage: Status code -32; transferred 0/13

The isd200 driver is not correctly initializing the srb.cmd_len field,
which is the main reason why things fail. I also noticed that the
usb_stor_bulk functions are interpreting the ATA commands as if they
were scsi, so the packet was sent to the wrong lun, but that might not
really matter much.

Here is a patch agains 2.5.64 that fixes both of these problems for me.
It will probably apply to 2.5.65 as well.

Jan


--- drivers/usb/storage/isd200.c.orig	2003-02-10 15:51:05.000000000 -0500
+++ drivers/usb/storage/isd200.c	2003-03-16 14:24:12.000000000 -0500
@@ -405,11 +405,14 @@
 {
 	union ata_cdb ata;
 	struct scsi_cmnd srb;
+	struct scsi_device srb_dev;
 	struct isd200_info *info = (struct isd200_info *)us->extra;
 	int status;
 
 	memset(&ata, 0, sizeof(ata));
 	memset(&srb, 0, sizeof(srb));
+	memset(&srb_dev, 0, sizeof(srb_dev));
+	srb.device = &srb_dev;
 
 	ata.generic.SignatureByte0 = info->ConfigData.ATAMajorCommand;
 	ata.generic.SignatureByte1 = info->ConfigData.ATAMinorCommand;
@@ -479,6 +482,7 @@
 	}
 
 	memcpy(srb.cmnd, &ata, sizeof(ata.generic));
+	srb.cmd_len = sizeof(ata.generic);
 	status = usb_stor_Bulk_transport(&srb, us);
 	if (status == USB_STOR_TRANSPORT_GOOD)
 		status = ISD200_GOOD;
@@ -538,6 +542,7 @@
 	/* send the command to the transport layer */
 	srb->resid = 0;
 	memcpy(srb->cmnd, ataCdb, sizeof(ataCdb->generic));
+	srb->cmd_len = sizeof(ataCdb->generic);
 	transferStatus = usb_stor_Bulk_transport(srb, us);
 
 	/* if the command gets aborted by the higher layers, we need to
--- drivers/usb/storage/transport.c.orig	2003-02-25 23:27:18.000000000 -0500
+++ drivers/usb/storage/transport.c	2003-03-16 13:42:22.000000000 -0500
@@ -893,7 +893,7 @@
 	bcb.DataTransferLength = cpu_to_le32(transfer_length);
 	bcb.Flags = srb->sc_data_direction == SCSI_DATA_READ ? 1 << 7 : 0;
 	bcb.Tag = srb->serial_number;
-	bcb.Lun = srb->cmnd[1] >> 5;
+	bcb.Lun = srb->device->lun;
 	if (us->flags & US_FL_SCM_MULT_TARG)
 		bcb.Lun |= srb->device->id << 4;
 	bcb.Length = srb->cmd_len;

