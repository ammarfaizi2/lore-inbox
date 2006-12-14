Return-Path: <linux-kernel-owner+w=401wt.eu-S932817AbWLNU0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbWLNU0N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWLNU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:26:12 -0500
Received: from codepoet.org ([166.70.99.138]:42167 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784AbWLNU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:26:10 -0500
Date: Thu, 14 Dec 2006 13:26:08 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] support HDIO_GET_IDENTITY in libata
Message-ID: <20061214202608.GA2313@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581AEA0.3040708@garzik.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 14, 2006 at 03:05:52PM -0500, Jeff Garzik wrote:
> FWIW, libata generally follows a "implement it, if enough people care 
> about it" policy for the old HDIO_xxx ioctls.

I personally care about HDIO_GET_IDENTITY and find it terribly
useful to quickly find out about a drive.  Perhaps enough other
people care about this ioctl that it might make it into the official
libata tree.  Well tested with a number of months of use.

Signed-off-by: Erik Andersen <andersen@codepoet.org>

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- orig/drivers/ata/libata-scsi.c	2006-10-16 16:50:50.000000000 -0600
+++ linux-2.6.18/drivers/ata/libata-scsi.c	2006-10-16 16:50:50.000000000 -0600
@@ -303,6 +303,172 @@
 	return rc;
 }
 
+static void ide_fixstring (u8 *s, const int bytecount)
+{
+	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
+
+#ifndef __BIG_ENDIAN
+# ifdef __LITTLE_ENDIAN
+	/* convert from big-endian to host byte order */
+	for (p = end ; p != s;) {
+		unsigned short *pp = (unsigned short *) (p -= 2);
+		*pp = ntohs(*pp);
+	}
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
+	/* strip leading blanks */
+	while (s != end && *s == ' ')
+		++s;
+	/* compress internal blanks and strip trailing blanks */
+	while (s != end && *s) {
+		if (*s++ != ' ' || (s != end && *s && *s != ' '))
+			*p++ = *(s-1);
+	}
+	/* wipe out trailing garbage */
+	while (p != end)
+		*p++ = '\0';
+}
+
+static void ide_fix_driveid (struct hd_driveid *id)
+{
+#ifndef __LITTLE_ENDIAN
+# ifdef __BIG_ENDIAN
+	int i;
+	u16 *stringcast;
+
+	id->config         = __le16_to_cpu(id->config);
+	id->cyls           = __le16_to_cpu(id->cyls);
+	id->reserved2      = __le16_to_cpu(id->reserved2);
+	id->heads          = __le16_to_cpu(id->heads);
+	id->track_bytes    = __le16_to_cpu(id->track_bytes);
+	id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
+	id->sectors        = __le16_to_cpu(id->sectors);
+	id->vendor0        = __le16_to_cpu(id->vendor0);
+	id->vendor1        = __le16_to_cpu(id->vendor1);
+	id->vendor2        = __le16_to_cpu(id->vendor2);
+	stringcast = (u16 *)&id->serial_no[0];
+	for (i = 0; i < (20/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->buf_type       = __le16_to_cpu(id->buf_type);
+	id->buf_size       = __le16_to_cpu(id->buf_size);
+	id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
+	stringcast = (u16 *)&id->fw_rev[0];
+	for (i = 0; i < (8/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	stringcast = (u16 *)&id->model[0];
+	for (i = 0; i < (40/2); i++)
+		stringcast[i] = __le16_to_cpu(stringcast[i]);
+	id->dword_io       = __le16_to_cpu(id->dword_io);
+	id->reserved50     = __le16_to_cpu(id->reserved50);
+	id->field_valid    = __le16_to_cpu(id->field_valid);
+	id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
+	id->cur_heads      = __le16_to_cpu(id->cur_heads);
+	id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
+	id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
+	id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
+	id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
+	id->dma_1word      = __le16_to_cpu(id->dma_1word);
+	id->dma_mword      = __le16_to_cpu(id->dma_mword);
+	id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
+	id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
+	id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
+	id->eide_pio       = __le16_to_cpu(id->eide_pio);
+	id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
+	for (i = 0; i < 2; ++i)
+		id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
+	for (i = 0; i < 4; ++i)
+		id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
+	id->queue_depth    = __le16_to_cpu(id->queue_depth);
+	for (i = 0; i < 4; ++i)
+		id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
+	id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
+	id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
+	id->command_set_1  = __le16_to_cpu(id->command_set_1);
+	id->command_set_2  = __le16_to_cpu(id->command_set_2);
+	id->cfsse          = __le16_to_cpu(id->cfsse);
+	id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
+	id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
+	id->csf_default    = __le16_to_cpu(id->csf_default);
+	id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
+	id->trseuc         = __le16_to_cpu(id->trseuc);
+	id->trsEuc         = __le16_to_cpu(id->trsEuc);
+	id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
+	id->mprc           = __le16_to_cpu(id->mprc);
+	id->hw_config      = __le16_to_cpu(id->hw_config);
+	id->acoustic       = __le16_to_cpu(id->acoustic);
+	id->msrqs          = __le16_to_cpu(id->msrqs);
+	id->sxfert         = __le16_to_cpu(id->sxfert);
+	id->sal            = __le16_to_cpu(id->sal);
+	id->spg            = __le32_to_cpu(id->spg);
+	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
+	for (i = 0; i < 22; i++)
+		id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
+	id->last_lun       = __le16_to_cpu(id->last_lun);
+	id->word127        = __le16_to_cpu(id->word127);
+	id->dlf            = __le16_to_cpu(id->dlf);
+	id->csfo           = __le16_to_cpu(id->csfo);
+	for (i = 0; i < 26; i++)
+		id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
+	id->word156        = __le16_to_cpu(id->word156);
+	for (i = 0; i < 3; i++)
+		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
+	id->cfa_power      = __le16_to_cpu(id->cfa_power);
+	for (i = 0; i < 14; i++)
+		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
+	for (i = 0; i < 31; i++)
+		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
+	for (i = 0; i < 48; i++)
+		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
+	id->integrity_word  = __le16_to_cpu(id->integrity_word);
+# else
+#  error "Please fix <asm/byteorder.h>"
+# endif
+#endif
+	ide_fixstring(id->model,     sizeof(id->model));
+	ide_fixstring(id->fw_rev,    sizeof(id->fw_rev));
+	ide_fixstring(id->serial_no, sizeof(id->serial_no));
+}
+
+/**
+ *	ata_identify_ioctl - Handler for HDIO_GET_IDENTITY ioctl
+ *	@scsidev: Device to which we are issuing command
+ *	@id: a SECTOR_SIZE buffer in which to return the ATA identity
+ *
+ *	LOCKING:
+ *	Defined by the SCSI layer.  We don't really care.
+ *
+ *	RETURNS:
+ *	Zero on success, negative errno on error.
+ */
+int ata_identify_ioctl(struct scsi_device *scsidev, int cmd, u8 *argbuf)
+{
+	int rc = 0;
+	u8 scsi_cmd[MAX_COMMAND_SIZE];
+	struct scsi_sense_hdr sshdr;
+	struct hd_driveid *id;
+
+	memset(scsi_cmd, 0, sizeof(scsi_cmd));
+	scsi_cmd[0]  = ATA_16;
+	scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
+	scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
+				    block count in sector count field */
+	scsi_cmd[14] = cmd;      /* WIN_IDENTIFY or WIN_PIDENTIFY */
+
+	/* Good values for timeout and retries?  Values below
+	   from scsi_ioctl_send_command() for default case... */
+	if (scsi_execute_req(scsidev, scsi_cmd, DMA_FROM_DEVICE,
+				argbuf, SECTOR_SIZE, &sshdr, (10*HZ), 5))
+		rc = -EIO;
+
+	/* Need code to retrieve data from check condition? */
+	id = (struct hd_driveid *) argbuf;
+	ide_fix_driveid(id);
+
+	return rc;
+}
+
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
 	int val = -EINVAL, rc = -EINVAL;
@@ -330,6 +496,45 @@
 			return -EACCES;
 		return ata_task_ioctl(scsidev, arg);
 
+	case HDIO_GET_IDENTITY:
+	case HDIO_OBSOLETE_IDENTITY:
+		{
+			u8 *argbuf;
+			int ret, idcmd;
+			struct ata_port *ap;
+			struct ata_device *dev;
+
+			if (!capable(CAP_SYS_RAWIO))
+				return -EACCES;
+
+			ap = (struct ata_port *) &scsidev->host->hostdata[0];
+			if (!ap)
+				return -ENODEV;
+
+			dev = ata_scsi_find_dev(ap, scsidev);
+			if (!dev)
+				return -ENODEV;
+
+			argbuf = kmalloc(SECTOR_SIZE, GFP_KERNEL);
+			if (NULL == (void *)argbuf) {
+				return -ENOMEM;
+			}
+
+			idcmd = WIN_IDENTIFY;
+			if (!atapi_enabled && dev->class == ATA_DEV_ATAPI) {
+				idcmd = WIN_PIDENTIFY;
+			}
+			ret = ata_identify_ioctl(scsidev, idcmd, argbuf);
+			if (ret!=0 || copy_to_user((char *)arg, (char *)argbuf,
+					(cmd == HDIO_GET_IDENTITY) ?
+					sizeof(struct hd_driveid) : 142))
+			{
+				ret = -EFAULT;
+			}
+			kfree(argbuf);
+			return ret;
+		}
+
 	default:
 		rc = -ENOTTY;
 		break;
