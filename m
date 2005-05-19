Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVESAao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVESAao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVESAao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:30:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:27535 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262423AbVESA3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:29:37 -0400
Message-ID: <428BDDEB.9030206@comcast.net>
Date: Wed, 18 May 2005 20:29:31 -0400
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Enable reads on Plextor 712-SA on 2.6.11.5
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch enables mount, umount, and read operations on the Plextor
712SA SATA DVD burner  Write operations still do not work for me.  Apply
this patch to linux-2.6.11.5.  I hope it works for you, too.  At least
you'll be able to read stuff.

To make this work, be sure that the "deprecated" SATA code is disabled
and that libata is enabled.

I certify that this is my original work and that I am pefectly OK with
this code being covered under the GPL if included into the Linux kernel.

If this code stinks, please tell me why so I can do better next time.
:-)  This is my first patch submission.


**************************************************************************
- --- linux-2.6.11.5/include/linux/libata.h       2005-03-19
01:34:50.000000000 -0500
+++ linux-2.6.11.5/include/linux/libata.h       2005-04-02
14:49:45.000000000 -0500
@@ -37,7 +37,7 @@
 #undef ATA_VERBOSE_DEBUG       /* yet more debugging output */
 #undef ATA_IRQ_TRAP            /* define to ack screaming irqs */
 #undef ATA_NDEBUG              /* define to disable quick runtime checks */
- -#undef ATA_ENABLE_ATAPI                /* define to enable ATAPI
support */
+#define ATA_ENABLE_ATAPI       /* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA         /* define to enable PATA support in some
                                 * low-level drivers */
 #undef ATAPI_ENABLE_DMADIR     /* enables ATAPI DMADIR bridge support */

- --- linux-2.6.11.5/drivers/scsi/libata-scsi.c   2005-03-19
01:34:55.000000000 -0500
+++ linux-2.6.11.5/drivers/scsi/libata-scsi.c   2005-04-17
00:54:29.000000000 -0400
@@ -798,6 +802,66 @@
 }

 /**
+ *     atapi_scsiop_inq_std - Simulate INQUIRY command
+ *     @args: device IDENTIFY data / SCSI command of interest.
+ *     @rbuf: Response buffer, to which simulated SCSI cmd output is sent.
+ *     @buflen: Response buffer length.
+ *
+ *     Returns standard device identification data associated
+ *     with non-EVPD INQUIRY command output.
+ *
+ *     LOCKING:
+ *     spin_lock_irqsave(host_set lock)
+ */
+
+unsigned int atapi_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
+                                 unsigned int buflen)
+{
+/*        printk(KERN_INFO "AMS_HACK_ALERT - got to
atapi_scsiop_inq_std()\n"); */
+
+       u8 hdr[] = {
+         TYPE_ROM, /* CD-ROM device */
+         0,        /* removeable media - set later... */
+         0x5,      /* claim SPC-3 version compatibility */
+         2,        /* response data format */
+         95 - 4
+       };
+
+       /* set scsi removeable (RMB) bit per ata bit */
+       if (ata_id_removeable(args->id))
+               hdr[1] |= (1 << 7);
+
+       VPRINTK("ENTER\n");
+
+       memcpy(rbuf, hdr, sizeof(hdr));
+
+       if (buflen > 35) {
+               memcpy(&rbuf[8], "ATAPI   ", 8);
+               ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+               ata_dev_id_string(args->id, &rbuf[32],
ATA_ID_FW_REV_OFS, 4);
+               if (rbuf[32] == 0 || rbuf[32] == ' ')
+                       memcpy(&rbuf[32], "n/a ", 4);
+       }
+
+       if (buflen > 63) {
+               const u8 versions[] = {
+                       0x60,   /* SAM-3 (no version claimed) */
+
+                       0x03,
+                       0x20,   /* SBC-2 (no version claimed) */
+
+                       0x02,
+                       0x60    /* SPC-3 (no version claimed) */
+               };
+
+               memcpy(rbuf + 59, versions, sizeof(versions));
+       }
+
+/*        printk(KERN_INFO "AMS_HACK_ALERT - leaving
atapi_scsiop_inq_std()\n"); */
+       return 0;
+}
+
+/**
  *     ata_scsiop_inq_std - Simulate INQUIRY command
  *     @args: device IDENTIFY data / SCSI command of interest.
  *     @rbuf: Response buffer, to which simulated SCSI cmd output is sent.
@@ -1473,6 +1544,7 @@
        struct ata_port *ap;
        struct ata_device *dev;
        struct scsi_device *scsidev = cmd->device;
+       struct ata_scsi_args args;

        ap = (struct ata_port *) &scsidev->host->hostdata[0];

@@ -1493,8 +1565,41 @@
                        ata_scsi_translate(ap, dev, cmd, done, xlat_func);
                else
                        ata_scsi_simulate(dev->id, cmd, done);
- -       } else
- -               ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+       } else {
+/*             printk(KERN_INFO "AMS_HACK_ALERT - ata_scsi_queuecmd(),
for non-ATA_DEV_ATA class\n"); */
+               u8 *scsicmd = cmd->cmnd;
+/*                printk(KERN_INFO "AMS_HACK_ALERT - CDB (%u:%d,%d,%d)
%02x %02x %02x %02x %02x %02x %02x %02x %02x\n", */
+/*                    ap->id, */
+/*                    scsidev->channel, scsidev->id, scsidev->lun, */
+/*                    scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3], */
+/*                    scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7], */
+/*                    scsicmd[8]); */
+               /* begin AMS HACK */
+               if (scsicmd[0] == INQUIRY) {
+/*               printk(KERN_INFO "AMS_HACK_ALERT - got to new_andy
hack for ATAPI devices - its a SCSI INQUIRY\n"); */
+                 args.id = dev->id;
+                 args.cmd = cmd;
+                 args.done = done;
+
+                 if (scsicmd[1] & 2)              /* is CmdDt set?  */
+                   ata_bad_cdb(cmd, done);
+                 else if ((scsicmd[1] & 1) == 0)    /* is EVPD clear? */
+                   ata_scsi_rbuf_fill(&args, atapi_scsiop_inq_std);
+/*               else if (scsicmd[2] == 0x00) */
+/*                 ata_scsi_rbuf_fill(&args, ata_scsiop_inq_00); */
+/*               else if (scsicmd[2] == 0x80) */
+/*                 ata_scsi_rbuf_fill(&args, ata_scsiop_inq_80); */
+/*               else if (scsicmd[2] == 0x83) */
+/*                 ata_scsi_rbuf_fill(&args, ata_scsiop_inq_83); */
+                 else
+                   ata_bad_cdb(cmd, done);
+               }
+               else {
+/*               printk(KERN_INFO "AMS_HACK_ALERT - got to new_andy
hack for ATAPI devices - calling ata_scsi_translate\n"); */
+                 ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+               }
+               /* end AMS HACK */
+       }

 out_unlock:
        return 0;


- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCi93qHl0iXDssISsRAsUDAJ4zX1nzAfyg+G14vSR78fB0NOYNOQCeNJDs
oHhW9E225T+IaXWtCw6uGfo=
=yrjD
-----END PGP SIGNATURE-----
