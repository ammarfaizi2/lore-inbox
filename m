Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWGER3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWGER3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWGER3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:29:19 -0400
Received: from titanium.sabren.com ([67.19.173.4]:39904 "EHLO
	titanium.sabren.com") by vger.kernel.org with ESMTP id S964899AbWGER3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:29:17 -0400
Date: Wed, 5 Jul 2006 19:29:08 +0200
From: Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Allen Martin <AMartin@nvidia.com>
Subject: Re: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Message-ID: <20060705172908.GA6482@noir>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Allen Martin <AMartin@nvidia.com>
References: <20060626192309.GA10711@noir> <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com>
X-Accept-Language: es,en
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-06-26, Allen Martin <AMartin@nvidia.com> wrote:
> Have you tried the 2.6.9 sata_nv.c on 2.6.10?  All you should have
> to do to get it working is change the host_set->pdev references
> to use to_pci_dev().
> [...]
> You can try changing that back to see if it makes a difference.
> I would also investigate changes in libata too.

I checked the differences between libata-*c and the following
changes seemed relevant to me. Though I have no idea if they do
anything at all for my setup, and I don't know really what to change.

--- linux-2.6.9/drivers/scsi/libata-core.c      2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.10/drivers/scsi/libata-core.c     2004-12-24 22:33:48.000000000 +0100
@@ -1945,8 +1950,6 @@ void ata_sg_init_one(struct ata_queued_c
        sg->page = virt_to_page(buf);
        sg->offset = (unsigned long) buf & ~PAGE_MASK;
        sg_dma_len(sg) = buflen;
-
-       WARN_ON(buflen > PAGE_SIZE);
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2167,14 +2170,20 @@ static void ata_pio_sector(struct ata_qu
        struct scatterlist *sg = qc->sg;
        struct ata_port *ap = qc->ap;
        struct page *page;
+       unsigned int offset;
        unsigned char *buf;
 
        if (qc->cursect == (qc->nsect - 1))
                ap->pio_task_state = PIO_ST_LAST;
 
        page = sg[qc->cursg].page;
-       buf = kmap(page) +
-             sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+       offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
+
+       /* get the current page and offset */
+       page = nth_page(page, (offset >> PAGE_SHIFT));
+       offset %= PAGE_SIZE;
+
+       buf = kmap(page) + offset;
 
        qc->cursect++;
        qc->cursg_ofs++;
@@ -2265,19 +2318,30 @@ static void ata_pio_block(struct ata_por
                }
        }
 
-       /* handle BSY=0, DRQ=0 as error */
-       if ((status & ATA_DRQ) == 0) {
-               ap->pio_task_state = PIO_ST_ERR;
-               return;
-       }
-
        qc = ata_qc_from_tag(ap, ap->active_tag);
        assert(qc != NULL);
 
-       if (is_atapi_taskfile(&qc->tf))
-               atapi_pio_sector(qc);
-       else
+       if (is_atapi_taskfile(&qc->tf)) {
+               /* no more data to transfer or unsupported ATAPI command */
+               if ((status & ATA_DRQ) == 0) {
+                       ap->pio_task_state = PIO_ST_IDLE;
+
+                       ata_irq_on(ap);
+
+                       ata_qc_complete(qc, status);
+                       return;
+               }
+
+               atapi_pio_bytes(qc);
+       } else {
+               /* handle BSY=0, DRQ=0 as error */
+               if ((status & ATA_DRQ) == 0) {
+                       ap->pio_task_state = PIO_ST_ERR;
+                       return;
+               }
+
                ata_pio_sector(qc);
+       }
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -2356,10 +2473,29 @@ static void ata_pio_task(void *_data)
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
        struct ata_port *ap = qc->ap;
+       struct ata_device *dev = qc->dev;
        u8 host_stat = 0, drv_stat;
 
        DPRINTK("ENTER\n");
 
+       /* FIXME: doesn't this conflict with timeout handling? */
+       if (qc->dev->class == ATA_DEV_ATAPI && qc->scsicmd) {
+               struct scsi_cmnd *cmd = qc->scsicmd;
+
+               if (!scsi_eh_eflags_chk(cmd, SCSI_EH_CANCEL_CMD)) {
+
+                       /* finish completing original command */
+                       __ata_qc_complete(qc);
+
+                       atapi_request_sense(ap, dev, cmd);
+
+                       cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
+                       scsi_finish_command(cmd);
+
+                       goto out;
+               }
+       }
+
        /* hack alert!  We cannot use the supplied completion
         * function from inside the ->eh_strategy_handler() thread.
         * libata is the only user of ->eh_strategy_handler() in
--- linux-2.6.9/drivers/scsi/libata-scsi.c      2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.10/drivers/scsi/libata-scsi.c     2004-12-24 22:34:32.000000000 +0100
@@ -100,7 +97,7 @@ int ata_scsi_ioctl(struct scsi_device *s
                return 0;
 
        default:
-               rc = -EOPNOTSUPP;
+               rc = -ENOTTY;
                break;
        }
@@ -901,8 +898,8 @@ unsigned int ata_scsiop_inq_80(struct at
        };
        memcpy(rbuf, hdr, sizeof(hdr));
 
-       if (buflen > (ATA_SERNO_LEN + 4))
-               ata_dev_id_string(args->dev, (unsigned char *) &rbuf[4],
+       if (buflen > (ATA_SERNO_LEN + 4 - 1))
+               ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
                                  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
        return 0;
@@ -930,7 +927,7 @@ unsigned int ata_scsiop_inq_83(struct at
        rbuf[3] = 4 + strlen(inq_83_str);       /* page len */
 
        /* our one and only identification descriptor (vendor-specific) */
-       if (buflen > (strlen(inq_83_str) + 4 + 4)) {
+       if (buflen > (strlen(inq_83_str) + 4 + 4 - 1)) {
                rbuf[4 + 0] = 2;        /* code set: ASCII */
                rbuf[4 + 3] = strlen(inq_83_str);
                memcpy(rbuf + 4 + 4, inq_83_str, strlen(inq_83_str));

