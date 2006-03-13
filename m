Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWCMXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWCMXpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWCMXpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:45:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750797AbWCMXpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:45:05 -0500
Date: Mon, 13 Mar 2006 15:42:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, promise_linux@promise.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
Message-Id: <20060313154236.32293cf9.akpm@osdl.org>
In-Reply-To: <20060313224112.GA19513@havoc.gtf.org>
References: <20060313224112.GA19513@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> All,
> 
> Here follows the 'shasta' driver, contributed by Promise, for review.
> They've asked me to make the "open source introduction" for them.
> The SuperTrak hardware is a controller where you talk to a firmware
> via SCSI CDBs.
> 
> It's been through a couple rounds of review by me, so its pretty clean
> already.  I already spotted another couple niggles though: my mispelling
> of 'SuperTrek', and the deprecated use of pci_module_init().
> 
> Anyway, comment away...  The driver maintainer is CC'd.

Hopefully a Signed-off-by: is forthcoming.

> The 'shasta' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 

Should I add that to -mm?

Looks generally good to me.  Minor comments:


> +config SCSI_SHASTA
> +	tristate "Promise SuperTrek EX8350/8300/16350/16300 support"
> +	depends on PCI && SCSI

Might it also depend upon BLK_DEV_SD?

> +#include <linux/config.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/ioport.h>
> +#include <linux/delay.h>
> +#include <linux/sched.h>
> +#include <linux/time.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>

Can't include linux/irq.h from generic code (we really ought to fix that).

> +#define ST_DRIVER_DATE "(Mar 6, 2006)"
> +#define ST_DRIVER_VERSION "2.9.0.13"
> +#define VER_MAJOR 		2	
> +#define VER_MINOR 		9
> +#define OEM 			0
> +#define BUILD_VER 		13

This info tends to go out of date quickly.

These identifires are rather generic-sounding and might clash with others
at some stage.


> +struct st_sgitem {
> +struct st_sgtable {
> +struct handshake_frame {
> +struct req_msg {
> +struct status_msg {

Has this all been tested on big-endian hardware?

> +static char console_inq_page[] =

const?

> +{
> +	0x03,0x00,0x03,0x03,0xFA,0x00,0x00,0x30,
> +	0x50,0x72,0x6F,0x6D,0x69,0x73,0x65,0x20,	/* "Promise " */
> +	0x52,0x41,0x49,0x44,0x20,0x43,0x6F,0x6E,	/* "RAID Con" */
> +	0x73,0x6F,0x6C,0x65,0x20,0x20,0x20,0x20,	/* "sole    " */
> +	0x31,0x2E,0x30,0x30,0x20,0x20,0x20,0x20,	/* "1.00    " */
> +	0x53,0x58,0x2F,0x52,0x53,0x41,0x46,0x2D,	/* "SX/RSAF-" */
> +	0x54,0x45,0x31,0x2E,0x30,0x30,0x20,0x20,	/* "TE1.00  " */
> +	0x0C,0x20,0x20,0x20,0x20,0x20,0x20,0x20
> +};
> +
> +MODULE_AUTHOR("Ed Lin");
> +MODULE_DESCRIPTION("Promise Technology SuperTrak EX Controllers");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(ST_DRIVER_VERSION);
> +
> ...
>
> +static inline u16 shasta_alloc_tag(u32 *bitmap)
> +{
> +	u16 i;
> +	for (i = 0; i < TAG_BITMAP_LENGTH; i++) 
> +		if (!((*bitmap) & (1 << i))) {
> +			*bitmap |= (1 << i);
> +			return i;
> +		}
> +
> +	return TAG_BITMAP_LENGTH;
> +}

This is too large to be inlined.

> +static inline void shasta_free_tag(u32 *bitmap, u16 tag)
> +{
> +	*bitmap &= ~(1 << tag);
> +}

What locking is used here?  hba->host->host_lock?

Please comment that, and check it.  Consider using clear_bit or __clear_bit.

> +static inline struct status_msg *shasta_get_status(struct st_hba *hba)
> +{
> +	struct status_msg *status = 
> +		hba->status_buffer + hba->status_tail;
> +
> +	++hba->status_tail;
> +	hba->status_tail %= MU_STATUS_COUNT;
> +
> +	return status;
> +}
> +
> +static inline struct req_msg *shasta_alloc_req(struct st_hba *hba)
> +{
> +	struct req_msg *req = ((struct req_msg *)hba->dma_mem) +
> +		hba->req_head;
> +
> +	++hba->req_head;
> +	hba->req_head %= MU_REQ_COUNT;
> +
> +	return req;
> +}

This is the awkward way of managing a ring buffer.  It's simpler to let the
head and tail incides wrap up to 0xffffffff and only mask them when
actually using them as indices.   That way,

	if (tail-head == size)
		buffer is full

	if (tail-head == 0)
		buffer is empty

in fact, at all times,

	tail-head == items_in_buffer

> +static inline void shasta_map_sg(struct st_hba *hba,
> +	struct req_msg *req, struct scsi_cmnd *cmd)
> +{
> +	struct pci_dev *pdev = hba->pdev;
> +	dma_addr_t dma_handle;
> +	struct scatterlist *src;
> +	struct st_sgtable *dst;
> +	int i;
> +
> +	dst = (struct st_sgtable *)req->variable;
> +	dst->max_sg_count = cpu_to_le16(ST_MAX_SG);
> +	dst->sz_in_byte = cpu_to_le32(cmd->request_bufflen);
> +
> +	if (cmd->use_sg) {
> +		src = (struct scatterlist *) cmd->request_buffer;
> +		dst->sg_count = cpu_to_le16((u16)pci_map_sg(pdev, src,
> +			cmd->use_sg, cmd->sc_data_direction));
> +
> +		for (i = 0; i < dst->sg_count; i++, src++) {
> +			dst->table[i].count = cpu_to_le32((u32)sg_dma_len(src));
> +			dst->table[i].addr = 
> +				cpu_to_le32(sg_dma_address(src) & 0xffffffff);

What does that 0xffffffff do?

Should it be DMA_32BIT_MASK?

> +			dst->table[i].addr_hi = 
> +				cpu_to_le32((sg_dma_address(src) >> 16) >> 16);
> +			dst->table[i].ctrl = SG_CF_64B | SG_CF_HOST;
> +    		}
> +		dst->table[--i].ctrl |= SG_CF_EOT;
> +		return;
> +	}
> +
> +	dma_handle = pci_map_single(pdev, cmd->request_buffer,
> +		cmd->request_bufflen, cmd->sc_data_direction);
> +	cmd->SCp.dma_handle = dma_handle;
> +
> +	dst->sg_count = cpu_to_le16(1);
> +	dst->table[0].addr = cpu_to_le32(dma_handle & 0xffffffff);
> +	dst->table[0].addr_hi = cpu_to_le32((dma_handle >> 16) >> 16);
> +	dst->table[0].count = cpu_to_le32((u32)cmd->request_bufflen);
> +	dst->table[0].ctrl = SG_CF_EOT | SG_CF_64B | SG_CF_HOST;
> +}
> +
> +static int shasta_direct_cp(struct scsi_cmnd *cmd, void *src, unsigned int len)
> +{
> +	void *dest;
> +	unsigned int cp_len;
> +	struct scatterlist *sg = cmd->request_buffer;
> +
> +	if (cmd->use_sg) {
> +		dest = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;

Please ensure that all usage of KM_IRQn always happens under
local_iq_disable().  If it doesn't, we have a nasty subtle bug.  (From my
quick reading we're OK, but please check).


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
> +}
> +
> ...
>
> +static inline void
> +shasta_send_cmd(struct st_hba *hba, struct req_msg *req, u16 tag)
> +{
> +	req->tag = cpu_to_le16(tag);
> +	req->task_attr = TASK_ATTRIBUTE_SIMPLE;
> +	req->task_manage = 0; /* not supported yet */
> +	req->payload_sz = (u8)((sizeof(struct req_msg))/sizeof(u32));
> +
> +	hba->ccb[tag].req = req;
> +	hba->out_req_cnt++;
> +	wmb();
> +
> +	writel(hba->req_head, hba->mmio_base + IMR0);
> +	writel(MU_INBOUND_DOORBELL_REQHEADCHANGED, hba->mmio_base + IDBL);
> +	readl(hba->mmio_base + IDBL); /* flush */
> +}

What is the wmb() for?  Flushing memory for the upcoming DMA?  That's not
what it's for.

When adding any sort of open-coded barrier, please always add a comment
explaining why it is there.

This function has two callsites and should be uninlined.

> +static int
> +shasta_queuecommand(struct scsi_cmnd *cmd, void (* fn)(struct scsi_cmnd *))
> +{
> +	struct st_hba *hba;
> + 	struct Scsi_Host *host;
> +	unsigned int id,lun;
> +	struct req_msg *req;
> +	u16 tag;
> +	host = cmd->device->host;
> +	id = cmd->device->id;
> +	lun = cmd->device->channel; /* firmware lun issue work around */
> +	hba = (struct st_hba *)host->hostdata;

Unneeded typecast.

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
> +	case MODE_SENSE:
> +	{
> +		char mode_sense[4] = { 3, 0, 0, 0 };

static?

> +		shasta_direct_cp(cmd, mode_sense, sizeof(mode_sense));
> +		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
> +		fn(cmd);
> +		return 0;
> +	}
> +	case MODE_SENSE_10:
> +	{
> +		char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };

static?

> +static inline void shasta_unmap_sg(struct st_hba *hba, struct scsi_cmnd *cmd)
> +{
> +	dma_addr_t dma_handle;
> +	if (cmd->sc_data_direction != DMA_NONE) {
> + 		if (cmd->use_sg) {
> +			pci_unmap_sg(hba->pdev, cmd->request_buffer,
> +				cmd->use_sg, cmd->sc_data_direction);
> +		} else {
> + 			dma_handle = cmd->SCp.dma_handle;
> +			pci_unmap_single(hba->pdev, dma_handle,
> +				cmd->request_bufflen, cmd->sc_data_direction);
> + 		}
> +	}
> +}

Three callsites, please uninline.

> +
> +static inline void shasta_mu_intr(struct st_hba *hba, u32 doorbell)
> +{

Two callsites, waaaaaaaay to big to be inlined.

<OK, I'll stop going on about overzealous inlining.  Please review all
inlined functions.  Unless they are exceedingly small or have a single
callsite, they should be uinlined>.


> +			if (waitqueue_active(&hba->waitq))
> +				wake_up(&hba->waitq);

This optimisation can cause missed wakeups unless done with care (addition
of memory barriers).  If there's extra locking which makes it safe then OK,
but some comment might be needed.

> +static int shasta_handshake(struct st_hba *hba)
> +{
> +	void __iomem *base = hba->mmio_base;
> +	struct handshake_frame *h;
> +	int i;
> +
> +	if (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
> +		writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
> +		readl(base + IDBL);
> +		for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
> +			&& i < MU_MAX_DELAY_TIME; i++) {
> +			rmb();
> +			msleep(1);
> +		}
> +
> +		if (i == MU_MAX_DELAY_TIME) {
> +			printk(KERN_ERR SHASTA_NAME
> +				"(%s): no handshake signature\n",
> +				pci_name(hba->pdev));
> +			return -1;
> +		}
> +	}
> +
> +	udelay(10);
> +
> +	h = (struct handshake_frame *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
> +	h->rb_phy = cpu_to_le32(hba->dma_handle);
> +	h->rb_phy_hi = cpu_to_le32((hba->dma_handle >> 16) >> 16);
> +	h->req_sz = cpu_to_le16(sizeof(struct req_msg));
> +	h->req_cnt = cpu_to_le16(MU_REQ_COUNT);
> +	h->status_sz = cpu_to_le16(sizeof(struct status_msg));
> +	h->status_cnt = cpu_to_le16(MU_STATUS_COUNT);
> +	shasta_gettime(&h->hosttime);
> +	h->partner_type = HMU_PARTNER_TYPE;
> +	wmb();

Another mystery barrier.

> +	writel(hba->dma_handle + MU_REQ_BUFFER_SIZE, base + IMR0);
> +	readl(base + IMR0);
> +	writel((hba->dma_handle >> 16) >> 16, base + OMR0); /* 4G border safe */
> +	readl(base + OMR0);
> +	writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
> +	readl(base + IDBL); /* flush */
> +
> +	udelay(10);
> +	for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
> +		&& i < MU_MAX_DELAY_TIME; i++) {
> +		rmb();

??

> +		msleep(1);
> +	}
> +
> +	if (i == MU_MAX_DELAY_TIME) {
> +		printk(KERN_ERR SHASTA_NAME
> +			"(%s): no signature after handshake frame\n",
> +			pci_name(hba->pdev));
> +		return -1;
> +	}
> +
> +	writel(0, base + IMR0);
> +	readl(base + IMR0);
> +	writel(0, base + OMR0);
> +	readl(base + OMR0);
> +	writel(0, base + IMR1);
> +	readl(base + IMR1);
> +	writel(0, base + OMR1);
> +	readl(base + OMR1); /* flush */
> +	hba->mu_status = MU_STATE_STARTED;
> +	return 0;
> +}
> +
> +static int shasta_abort(struct scsi_cmnd *cmd)
> +{
> +	struct Scsi_Host *host = cmd->device->host;
> +	struct st_hba *hba = (struct st_hba *)host->hostdata;
> +	u16 tag;
> +	void __iomem *base;
> +	u32 data;
> +	int fail = 0;

int result = SUCCESS;

> +	unsigned long flags;
> +	base = hba->mmio_base;
> +	spin_lock_irqsave(host->host_lock, flags);
> +
> +	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
> +		if (hba->ccb[tag].cmd == cmd && (hba->tag & (1 << tag))) {
> +			hba->wait_ccb = &(hba->ccb[tag]);
> +			break;
> +		}
> +	if (tag >= MU_MAX_REQUEST) goto out;

newline here, please.

> +
> +	data = readl(base + ODBL);
> +	if (data == 0 || data == 0xffffffff) goto fail_out;
> +
> +	writel(data, base + ODBL);
> +	readl(base + ODBL); /* flush */
> +
> +	shasta_mu_intr(hba, data);
> +
> + 	if (hba->wait_ccb == NULL) {
> + 		printk(KERN_WARNING SHASTA_NAME
> +			"(%s): lost interrupt\n", pci_name(hba->pdev));
> +		goto out;
> +	}
> +
> +fail_out:
> +	hba->wait_ccb->req = NULL; /* nullify the req's future return */
> +	hba->wait_ccb = NULL;
> +	fail = 1;

result = FAILED;

> +out:
> +	spin_unlock_irqrestore(host->host_lock, flags);
> +	return fail ? FAILED : SUCCESS;

return result;

> +}
>
> +static int shasta_reset(struct scsi_cmnd *cmd)
> +{
> +	struct st_hba *hba;
> +	int tag;
> +	int i = 0;
> +	unsigned long flags;
> +	hba = (struct st_hba *)cmd->device->host->hostdata;

Unneeded cast.

> +wait_cmds:
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
> +		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL) 
> +			break;
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> +	if (tag < MU_MAX_REQUEST) {
> +		msleep(1000);
> +		if (++i < 10) goto wait_cmds;

newline.

