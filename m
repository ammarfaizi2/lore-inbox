Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWFJRGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWFJRGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 13:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWFJRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 13:06:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030278AbWFJRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 13:06:42 -0400
Date: Sat, 10 Jun 2006 18:06:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060610170640.GA25118@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	promise_linux@promise.com
References: <20060610160852.GA15316@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610160852.GA15316@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/config.h>

including config.h isn't needed anymore.

> +enum{

enum {


> +static inline u16 stex_alloc_tag(unsigned long *bitmap)
> +{
> +	int i;
> +	i = find_first_zero_bit(bitmap, TAG_BITMAP_LENGTH);
> +	if (i < TAG_BITMAP_LENGTH)
> +		__set_bit(i, bitmap);
> +	return (u16)i;
> +}

Please use the block layer tag helpers from block/ll_rw_blk.c:

extern int blk_queue_start_tag(request_queue_t *, struct request *);
extern struct request *blk_queue_find_tag(request_queue_t *, int);
extern void blk_queue_end_tag(request_queue_t *, struct request *);
extern int blk_queue_init_tags(request_queue_t *, int, struct blk_queue_tag *);
extern void blk_queue_free_tags(request_queue_t *);
extern int blk_queue_resize_tags(request_queue_t *, int);
extern void blk_queue_invalidate_tags(request_queue_t *);

> +static inline struct req_msg *stex_alloc_req(struct st_hba *hba)

There's far too many inline functions here.  In doubt I'd just remove all
the inline attributes and let the copiler handle it.  Given the functions
in the driver are already in natural order even a current gcc will do
a pretty good job at that.

> +
> +	if (cmd->use_sg) {
> +		src = (struct scatterlist *) cmd->request_buffer;
> +		dst->sg_count = cpu_to_le16((u16)pci_map_sg(pdev, src,
> +			cmd->use_sg, cmd->sc_data_direction));

You need to handle an error return from pci_map_sg and bail out if it
returns zero segments.

> +		dst->table[--i].ctrl |= SG_CF_EOT;
> +		return;
> +	}
> +	dma_handle = pci_map_single(pdev, cmd->request_buffer,
> +		cmd->request_bufflen, cmd->sc_data_direction);
> +	cmd->SCp.dma_handle = dma_handle;

I've just posted a patch to kill the last non-sg codepath so this should't
be needed anymore.

> +static int stex_direct_cp(struct scsi_cmnd *cmd,
> +	const void *src, unsigned int len)
> +{
> +	void *dest;
> +	unsigned int cp_len;
> +	struct scatterlist *sg = cmd->request_buffer;
> +
> +	if (cmd->use_sg) {
> +		dest = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
> +		cp_len = min(sg->length, len);
> +	} else {
> +		dest = cmd->request_buffer;
> +		cp_len = min(cmd->request_bufflen, len);
> +	}
> +
> +	memcpy(dest, src, cp_len);
> +
> +	if (cmd->use_sg)
> +		kunmap_atomic(dest - sg->offset, KM_IRQ0);
> +	return cp_len == len;

As mentioned before this should use scsi_kmap_atomic_sg/scsi_kunmap_atomic_sg.

> +static int
> +stex_queuecommand(struct scsi_cmnd *cmd, void (* fn)(struct scsi_cmnd *))
> +{

The callback argument to ->queuecommand is called one in almost every
driver.  It would help to understand your driver more easily if it followed
that convention.

> +	struct st_hba *hba;
> +	struct Scsi_Host *host;
> +	unsigned int id,lun;
> +	struct req_msg *req;
> +	u16 tag;
> +	host = cmd->device->host;
> +	id = cmd->device->id;
> +	lun = cmd->device->channel; /* firmware lun issue work around */

Please explain the firmware issue in more detail, this looks rather odd.

> +	hba = (struct st_hba *) &host->hostdata[0];
> +
> +	switch (cmd->cmnd[0]) {
> +	case READ_6:
> +	case WRITE_6:
> +		cmd->cmnd[9] = 0;
> +		cmd->cmnd[8] = cmd->cmnd[4];
> +		cmd->cmnd[7] = 0;
> +		cmd->cmnd[6] = 0;
> +		cmd->cmnd[5] = cmd->cmnd[3];
> +		cmd->cmnd[4] = cmd->cmnd[2];
> +		cmd->cmnd[3] = cmd->cmnd[1] & 0x1f;
> +		cmd->cmnd[2] = 0;
> +		cmd->cmnd[1] &= 0xe0;
> +		cmd->cmnd[0] += READ_10 - READ_6;
> +		break;

Please remove this emulation and set sdev->use_10_for_rw in ->slave_configure.


> +	case MODE_SENSE:
> +	{
> +		static char mode_sense[4] = { 3, 0, 0, 0 };
> +
> +		stex_direct_cp(cmd, mode_sense, sizeof(mode_sense));
> +		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
> +		fn(cmd);
> +		return 0;
> +	}

I'd kill this aswell and set use_10_for_ms in slave_configure.

> +	case MODE_SENSE_10:
> +	{
> +		static char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
> +
> +		stex_direct_cp(cmd, mode_sense10, sizeof(mode_sense10));
> +		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
> +		fn(cmd);
> +		return 0;
> +	}
> +	case INQUIRY:
> +		if (id != ST_MAX_ARRAY_SUPPORTED || lun != 0)
> +			break;
> +		if((cmd->cmnd[1] & INQUIRY_EVPD) == 0) {
> +			stex_direct_cp(cmd, console_inq_page,
> +				sizeof(console_inq_page));
> +			cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
> +		} else
> +			cmd->result = DID_ERROR << 16 | COMMAND_COMPLETE << 8;
> +		fn(cmd);
> +		return 0;

I'd suggest to kill INQUIRY completely

> +	case PASSTHRU_CMD:
> +		if (cmd->cmnd[1] == PASSTHRU_GET_DRVVER) {
> +			struct st_drvver ver;
> +			ver.major = ST_VER_MAJOR;
> +			ver.minor = ST_VER_MINOR;
> +			ver.oem = ST_OEM;
> +			ver.build = ST_BUILD_VER;
> +			ver.signature[0] = PASSTHRU_SIGNATURE;
> +			ver.console_id = ST_MAX_ARRAY_SUPPORTED;
> +			ver.host_no = hba->host->host_no;
> +			cmd->result = stex_direct_cp(cmd, &ver, sizeof(ver)) ?
> +				DID_OK << 16 | COMMAND_COMPLETE << 8 :
> +				DID_ERROR << 16 | COMMAND_COMPLETE << 8;
> +			fn(cmd);
> +			return 0;
> +		}

Please don't abuse passthru commands to expose driver data.  Add a few
sysfs attributes instead respectively a MODULE_VERSION tag for the
version.

> +	hba->ccb[tag].cmd = cmd;
> +	hba->ccb[tag].sense_bufflen = SCSI_SENSE_BUFFERSIZE;
> +	hba->ccb[tag].sense_buffer = cmd->sense_buffer;
> +	if (cmd->use_sg) {
> +		hba->ccb[tag].page_offset =
> +			((struct scatterlist *)cmd->request_buffer)->offset;
> +		hba->ccb[tag].page =
> +			((struct scatterlist *)cmd->request_buffer)->page;
> +	}

How does this work?  The driver claims to accept sg lists up to 32 entries
but we only add the first here?


> +static void stex_init_hba(struct st_hba *hba,
> +	struct Scsi_Host * host, struct pci_dev *pdev)
> +{
...
> +}
> +
> +static int stex_init_shm(struct st_hba *hba, struct pci_dev *pdev)
> +{
...
> +

Could you just merge these two functions into it's only caller so the
initialization path is easier to read without hopping forth and back?


> +	scsi_scan_host(host);

Any chance you could add the targets directly using scsi_add_device
or scsi_scan_target instead of trying to emulate a SPI scanning sequence?

> +static void stex_hba_free(struct st_hba *hba)
> +{
> +	free_irq(hba->pdev->irq, hba);
> +
> +	iounmap(hba->mmio_base);
> +
> +	pci_release_regions(hba->pdev);
> +
> +	if (hba->dma_mem)
> +		pci_free_consistent(hba->pdev, MU_BUFFER_SIZE,
> +			hba->dma_mem, hba->dma_handle);

this check is not needed.  stex_hba_free is never called with a NULL
hba->dma_mem.  I'd also merge this function into it's only caller,
as that would increase readability.


Overall a very nice driver, thanks a lot!
