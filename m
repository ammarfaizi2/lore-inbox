Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUHMTmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUHMTmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUHMTjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:39:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21469 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267338AbUHMTiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:38:00 -0400
Message-ID: <411D1885.8060904@pobox.com>
Date: Fri, 13 Aug 2004 15:37:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Jones <pmjones@gmail.com>
CC: Kai Makisara <kai.makisara@kolumbus.fi>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com> <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local> <9ac707cb040813122522d4a71@mail.gmail.com>
In-Reply-To: <9ac707cb040813122522d4a71@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020809090500060500000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809090500060500000107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Peter Jones wrote:
> On Thu, 12 Aug 2004 22:22:36 +0300 (EEST), Kai Makisara
> <kai.makisara@kolumbus.fi> wrote:
> 
>>On Thu, 12 Aug 2004, Linus Torvalds wrote:
>>
>>>Let's see now:
>>>
>>>      brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
>>>
>>>would you put people you don't trust with your disk in the "disk" group?
>>>
>>
>>This protects disks in practice but SG_IO is currently supported by other
>>devices, at least SCSI tapes. It is reasonable in some organizations to
>>give r/w access to ordinary users so that they can read/write tapes. I
>>would be worried if this would enable the users, for instance, to mess up
>>the mode page contents of the drive or change the firmware.
> 
> 
> Sure, but for that we need command based filtering.

We have that now (sigh).  See attached patch, which is in BK...

A similar approach could be applied to tape as well.

Though in general I think command-based filtering is not scalable...  at 
the very least I would prefer a list loaded from userspace at boot.

	Jeff



--------------020809090500060500000107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# ChangeSet
#   2004/08/12 17:51:15-07:00 torvalds@ppc970.osdl.org 
#   Allow non-root users certain raw commands if they are deemed safe.
#   
#   We allow more commands if the disk was opened read-write.
# 
diff -Nru a/drivers/block/scsi_ioctl.c b/drivers/block/scsi_ioctl.c
--- a/drivers/block/scsi_ioctl.c	2004-08-13 15:35:28 -04:00
+++ b/drivers/block/scsi_ioctl.c	2004-08-13 15:35:28 -04:00
@@ -105,8 +105,80 @@
 	return put_user(1, p);
 }
 
-static int sg_io(request_queue_t *q, struct gendisk *bd_disk,
-		 struct sg_io_hdr *hdr)
+#define CMD_READ_SAFE	0x01
+#define CMD_WRITE_SAFE	0x02
+#define safe_for_read(cmd)	[cmd] = CMD_READ_SAFE
+#define safe_for_write(cmd)	[cmd] = CMD_WRITE_SAFE
+
+static int verify_command(struct file *file, unsigned char *cmd)
+{
+	static const unsigned char cmd_type[256] = {
+
+		/* Basic read-only commands */
+		safe_for_read(TEST_UNIT_READY),
+		safe_for_read(REQUEST_SENSE),
+		safe_for_read(READ_6),
+		safe_for_read(READ_10),
+		safe_for_read(READ_12),
+		safe_for_read(READ_16),
+		safe_for_read(READ_BUFFER),
+		safe_for_read(READ_LONG),
+		safe_for_read(INQUIRY),
+		safe_for_read(MODE_SENSE),
+		safe_for_read(MODE_SENSE_10),
+		safe_for_read(START_STOP),
+
+		/* Audio CD commands */
+		safe_for_read(GPCMD_PLAY_CD),
+		safe_for_read(GPCMD_PLAY_AUDIO_10),
+		safe_for_read(GPCMD_PLAY_AUDIO_MSF),
+		safe_for_read(GPCMD_PLAY_AUDIO_TI),
+
+		/* CD/DVD data reading */
+		safe_for_read(GPCMD_READ_CD),
+		safe_for_read(GPCMD_READ_CD_MSF),
+		safe_for_read(GPCMD_READ_DISC_INFO),
+		safe_for_read(GPCMD_READ_CDVD_CAPACITY),
+		safe_for_read(GPCMD_READ_DVD_STRUCTURE),
+		safe_for_read(GPCMD_READ_HEADER),
+		safe_for_read(GPCMD_READ_TRACK_RZONE_INFO),
+		safe_for_read(GPCMD_READ_SUBCHANNEL),
+		safe_for_read(GPCMD_READ_TOC_PMA_ATIP),
+		safe_for_read(GPCMD_REPORT_KEY),
+		safe_for_read(GPCMD_SCAN),
+
+		/* Basic writing commands */
+		safe_for_write(WRITE_6),
+		safe_for_write(WRITE_10),
+		safe_for_write(WRITE_VERIFY),
+		safe_for_write(WRITE_12),
+		safe_for_write(WRITE_VERIFY_12),
+		safe_for_write(WRITE_16),
+		safe_for_write(WRITE_BUFFER),
+		safe_for_write(WRITE_LONG),
+	};
+	unsigned char type = cmd_type[cmd[0]];
+
+	/* Anybody who can open the device can do a read-safe command */
+	if (type & CMD_READ_SAFE)
+		return 0;
+
+	/* Write-safe commands just require a writable open.. */
+	if (type & CMD_WRITE_SAFE) {
+		if (file->f_mode & FMODE_WRITE)
+			return 0;
+	}
+
+	/* And root can do any command.. */
+	if (capable(CAP_SYS_RAWIO))
+		return 0;
+
+	/* Otherwise fail it with an "Operation not permitted" */
+	return -EPERM;
+}
+
+static int sg_io(struct file *file, request_queue_t *q,
+		struct gendisk *bd_disk, struct sg_io_hdr *hdr)
 {
 	unsigned long start_time;
 	int reading, writing;
@@ -115,14 +187,14 @@
 	char sense[SCSI_SENSE_BUFFERSIZE];
 	unsigned char cmd[BLK_MAX_CDB];
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
 	if (hdr->interface_id != 'S')
 		return -EINVAL;
 	if (hdr->cmd_len > BLK_MAX_CDB)
 		return -EINVAL;
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
+	if (verify_command(file, cmd))
+		return -EPERM;
 
 	/*
 	 * we'll do that later
@@ -228,15 +300,13 @@
 #define READ_DEFECT_DATA_TIMEOUT	(60 * HZ )
 #define OMAX_SB_LEN 16          /* For backward compatibility */
 
-static int sg_scsi_ioctl(request_queue_t *q, struct gendisk *bd_disk,
-			 Scsi_Ioctl_Command __user *sic)
+static int sg_scsi_ioctl(struct file *file, request_queue_t *q,
+			 struct gendisk *bd_disk, Scsi_Ioctl_Command __user *sic)
 {
 	struct request *rq;
 	int err, in_len, out_len, bytes, opcode, cmdlen;
 	char *buffer = NULL, sense[SCSI_SENSE_BUFFERSIZE];
 
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
 	/*
 	 * get in an out lengths, verify they don't exceed a page worth of data
 	 */
@@ -273,6 +343,10 @@
 	if (copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
+	err = verify_command(file, rq->cmd);
+	if (err)
+		goto error;
+
 	switch (opcode) {
 		case SEND_DIAGNOSTIC:
 		case FORMAT_UNIT:
@@ -370,7 +444,7 @@
 			err = -EFAULT;
 			if (copy_from_user(&hdr, arg, sizeof(hdr)))
 				break;
-			err = sg_io(q, bd_disk, &hdr);
+			err = sg_io(file, q, bd_disk, &hdr);
 			if (err == -EFAULT)
 				break;
 
@@ -418,7 +492,7 @@
 			hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
 			hdr.cmd_len = sizeof(cgc.cmd);
 
-			err = sg_io(q, bd_disk, &hdr);
+			err = sg_io(file, q, bd_disk, &hdr);
 			if (err == -EFAULT)
 				break;
 
@@ -441,7 +515,7 @@
 			if (!arg)
 				break;
 
-			err = sg_scsi_ioctl(q, bd_disk, arg);
+			err = sg_scsi_ioctl(file, q, bd_disk, arg);
 			break;
 		case CDROMCLOSETRAY:
 			close = 1;

--------------020809090500060500000107--
