Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTLRTju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTLRTjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:39:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37551 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265302AbTLRTjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:39:00 -0500
Date: Thu, 18 Dec 2003 20:38:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Milos Prudek <milos.prudek@tiscali.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031218193858.GL2069@suse.de>
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de> <20031218114000.GB2069@suse.de> <3FE200CA.2080705@tiscali.cz> <20031218193414.GJ2069@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218193414.GJ2069@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18 2003, Jens Axboe wrote:
> On Thu, Dec 18 2003, Milos Prudek wrote:
> > 
> > >Here's a patch, it's received a little testing. Let me know if it works
> > >for you. I'm also attaching a slightly updated cdmrw tool.
> > 
> > Patch applied successfully. Compilation failed. This is with the default 
> > kernel config (2.6.0 config as shipped). The only change was changing 
> > reiserfs from Module to built-in, and removing all other filesystems 
> > except ext2 and reiserfs.
> > 
> > Here's the error:
> > 
> >   CC [M]  drivers/scsi/sr.o
> > drivers/scsi/sr.c:112: error: `CDC_MRW_R' undeclared here (not in a 
> > function)
> > drivers/scsi/sr.c:112: error: initializer element is not constant
> > drivers/scsi/sr.c:112: error: (near initialization for `sr_dops.capability')
> > drivers/scsi/sr.c: In function `get_capabilities':
> > drivers/scsi/sr.c:770: error: `scsi_CDs' undeclared (first use in this 
> > function)
> > drivers/scsi/sr.c:770: error: (Each undeclared identifier is reported 
> > only once
> > drivers/scsi/sr.c:770: error: for each function it appears in.)
> > drivers/scsi/sr.c:770: error: `i' undeclared (first use in this function)
> > drivers/scsi/sr.c:770: error: `mrw_write' undeclared (first use in this 
> > function)
> > drivers/scsi/sr.c:696: warning: unused variable `mwr_write'
> > make[2]: *** [drivers/scsi/sr.o] Error 1
> > make[1]: *** [drivers/scsi] Error 2
> > make: *** [drivers] Error 2
> 
> Rats, I forgot to test sr. You probably don't have a SCSI mt rainier
> drive (I doubt one was ever made), so just disable SCSI CD-ROM support.
> I'll be sure to fix this up, thanks.

Or apply this incremental patch.

--- drivers/scsi/sr.c~	2003-12-18 20:37:57.217540154 +0100
+++ drivers/scsi/sr.c	2003-12-18 20:36:57.336012105 +0100
@@ -68,7 +68,7 @@
 	 CDC_SELECT_DISC|CDC_MULTI_SESSION|CDC_MCN|CDC_MEDIA_CHANGED| \
 	 CDC_PLAY_AUDIO|CDC_RESET|CDC_IOCTLS|CDC_DRIVE_STATUS| \
 	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_DVD_RAM|CDC_GENERIC_PACKET| \
-	 CDC_MRW|CDC_MRW_R|CDC_RAM)
+	 CDC_MRW|CDC_MRW_W|CDC_RAM)
 
 static int sr_probe(struct device *);
 static int sr_remove(struct device *);
@@ -693,7 +693,7 @@
 static void get_capabilities(struct scsi_cd *cd)
 {
 	unsigned char *buffer;
-	int rc, n, mwr_write = 0, mrw = 1;
+	int rc, n, mrw_write = 0, mrw = 1;
 	struct scsi_mode_data data;
 	struct scsi_request *SRpnt;
 	unsigned char cmd[MAX_COMMAND_SIZE];
@@ -767,13 +767,13 @@
 		return;
 	}
 
-	if (cdrom_is_mrw(&scsi_CDs[i].cdi, &mrw_write)) {
+	if (cdrom_is_mrw(&cd->cdi, &mrw_write)) {
 		mrw = 0;
-		scsi_CDs[i].cdi.mask |= CDC_MRW;
-		scsi_CDs[i].cdi.mask |= CDC_MRW_W;
+		cd->cdi.mask |= CDC_MRW;
+		cd->cdi.mask |= CDC_MRW_W;
 	}
 	if (!mrw_write)
-		scsi_CDs[i].cdi.mask |= CDC_MRW_W;
+		cd->cdi.mask |= CDC_MRW_W;
 
 	n = data.header_length + data.block_descriptor_length;
 	cd->cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
@@ -825,8 +825,8 @@
 	/*
 	 * if DVD-RAM of MRW-W, we are randomly writeable
 	 */
-	if ((scsi_CDs[i].cdi.mask & (CDC_DVD_RAM | CDC_MRW_W)) != (CDC_DVD_RAM | CDC_MRW_W))
-		scsi_CDs[i].device->writeable = 1;
+	if ((cd->cdi.mask & (CDC_DVD_RAM | CDC_MRW_W)) != (CDC_DVD_RAM | CDC_MRW_W))
+		cd->device->writeable = 1;
 
 	scsi_release_request(SRpnt);
 	kfree(buffer);

-- 
Jens Axboe

