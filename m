Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269403AbUJLCXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269403AbUJLCXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUJLCXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 22:23:20 -0400
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:50936 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S269403AbUJLCXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 22:23:13 -0400
Message-ID: <416B4004.7050309@lic1.vsi.ru>
Date: Tue, 12 Oct 2004 06:23:00 +0400
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: superpunk <unixuser@mail.ru>, Sergey Kondratiev <serkon@box.vsi.ru>,
       semen@basdesign.ru
Subject: CD/DVD burn failed from non root user
Content-Type: multipart/mixed;
 boundary="------------050605000609020806070204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605000609020806070204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

On the kernel >=2.6.8 several SCSI ioctl's, using in cd/dvd burning 
programs permit only from root.
This patch - is a ugly workaround (remove using verify_command from 
devices/block/scsi-ioctl.c) for this problem.

Can to whom will it is useful.

And in general it would be quite good to solve this problem in a 
civilized way :)

-- 
Igor A. Valcov

--------------050605000609020806070204
Content-Type: text/plain;
 name="patch-2.6.8.1-burn-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.8.1-burn-fix.diff"

diff -Naur linux-2.6.8.1/drivers/block/scsi_ioctl.c linux-2.6.8.1-suid-fix/drivers/block/scsi_ioctl.c
--- linux-2.6.8.1/drivers/block/scsi_ioctl.c	2004-08-31 23:36:33.000000000 +0400
+++ linux-2.6.8.1-suid-fix/drivers/block/scsi_ioctl.c	2004-10-12 05:44:02.390289704 +0400
@@ -105,78 +105,6 @@
 	return put_user(1, p);
 }
 
-#define CMD_READ_SAFE	0x01
-#define CMD_WRITE_SAFE	0x02
-#define safe_for_read(cmd)	[cmd] = CMD_READ_SAFE
-#define safe_for_write(cmd)	[cmd] = CMD_WRITE_SAFE
-
-static int verify_command(struct file *file, unsigned char *cmd)
-{
-	static const unsigned char cmd_type[256] = {
-
-		/* Basic read-only commands */
-		safe_for_read(TEST_UNIT_READY),
-		safe_for_read(REQUEST_SENSE),
-		safe_for_read(READ_6),
-		safe_for_read(READ_10),
-		safe_for_read(READ_12),
-		safe_for_read(READ_16),
-		safe_for_read(READ_BUFFER),
-		safe_for_read(READ_LONG),
-		safe_for_read(INQUIRY),
-		safe_for_read(MODE_SENSE),
-		safe_for_read(MODE_SENSE_10),
-		safe_for_read(START_STOP),
-
-		/* Audio CD commands */
-		safe_for_read(GPCMD_PLAY_CD),
-		safe_for_read(GPCMD_PLAY_AUDIO_10),
-		safe_for_read(GPCMD_PLAY_AUDIO_MSF),
-		safe_for_read(GPCMD_PLAY_AUDIO_TI),
-
-		/* CD/DVD data reading */
-		safe_for_read(GPCMD_READ_CD),
-		safe_for_read(GPCMD_READ_CD_MSF),
-		safe_for_read(GPCMD_READ_DISC_INFO),
-		safe_for_read(GPCMD_READ_CDVD_CAPACITY),
-		safe_for_read(GPCMD_READ_DVD_STRUCTURE),
-		safe_for_read(GPCMD_READ_HEADER),
-		safe_for_read(GPCMD_READ_TRACK_RZONE_INFO),
-		safe_for_read(GPCMD_READ_SUBCHANNEL),
-		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
-		safe_for_read(GPCMD_REPORT_KEY),
-		safe_for_read(GPCMD_SCAN),
-
-		/* Basic writing commands */
-		safe_for_write(WRITE_6),
-		safe_for_write(WRITE_10),
-		safe_for_write(WRITE_VERIFY),
-		safe_for_write(WRITE_12),
-		safe_for_write(WRITE_VERIFY_12),
-		safe_for_write(WRITE_16),
-		safe_for_write(WRITE_BUFFER),
-		safe_for_write(WRITE_LONG),
-	};
-	unsigned char type = cmd_type[cmd[0]];
-
-	/* Anybody who can open the device can do a read-safe command */
-	if (type & CMD_READ_SAFE)
-		return 0;
-
-	/* Write-safe commands just require a writable open.. */
-	if (type & CMD_WRITE_SAFE) {
-		if (file->f_mode & FMODE_WRITE)
-			return 0;
-	}
-
-	/* And root can do any command.. */
-	if (capable(CAP_SYS_RAWIO))
-		return 0;
-
-	/* Otherwise fail it with an "Operation not permitted" */
-	return -EPERM;
-}
-
 static int sg_io(struct file *file, request_queue_t *q,
 		struct gendisk *bd_disk, struct sg_io_hdr *hdr)
 {
@@ -193,8 +121,6 @@
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (verify_command(file, cmd))
-		return -EPERM;
 
 	/*
 	 * we'll do that later
@@ -343,10 +269,6 @@
 	if (copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-	err = verify_command(file, rq->cmd);
-	if (err)
-		goto error;
-
 	switch (opcode) {
 		case SEND_DIAGNOSTIC:
 		case FORMAT_UNIT:
diff -Naur linux-2.6.8.1/Makefile linux-2.6.8.1-suid-fix/Makefile
--- linux-2.6.8.1/Makefile	2004-10-12 04:34:09.000000000 +0400
+++ linux-2.6.8.1-suid-fix/Makefile	2004-10-12 05:46:54.212168808 +0400
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 8
-EXTRAVERSION = .1
+EXTRAVERSION = .1-burn-fix
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*

--------------050605000609020806070204--
