Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWCNCim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWCNCim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWCNCim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:38:42 -0500
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:65272 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1750877AbWCNCil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:38:41 -0500
Date: Mon, 13 Mar 2006 18:38:33 +0800
From: "Ed Lin" <ed.lin@promise.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NONAMEBgJJ72jYxDwLd000000d3@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 14 Mar 2006 02:38:41.0171 (UTC) FILETIME=[67B6A630:01C64710]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments. Here is a quick answer to some questions.

>
>> +#include <linux/config.h>
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/ioport.h>
>> +#include <linux/delay.h>
>> +#include <linux/sched.h>
>> +#include <linux/time.h>
>> +#include <linux/pci.h>
>> +#include <linux/irq.h>
>
>Can't include linux/irq.h from generic code (we really ought to fix that).
>

OK. This line could be deleted.

>> +#define ST_DRIVER_DATE "(Mar 6, 2006)"
>> +#define ST_DRIVER_VERSION "2.9.0.13"
>> +#define VER_MAJOR 		2	
>> +#define VER_MINOR 		9
>> +#define OEM 			0
>> +#define BUILD_VER 		13
>
>This info tends to go out of date quickly.
>
>These identifires are rather generic-sounding and might clash with others
>at some stage.
>

We could add prefixes for this matter.

>
>> +struct st_sgitem {
>> +struct st_sgtable {
>> +struct handshake_frame {
>> +struct req_msg {
>> +struct status_msg {
>
>Has this all been tested on big-endian hardware?
>

No. It was only tested on i386 and x86-64 machines.

> ...
>
>> +static inline void shasta_free_tag(u32 *bitmap, u16 tag)
>> +{
>> +	*bitmap &= ~(1 << tag);
>> +}
>
>What locking is used here?  hba->host->host_lock?

This is called always with hba->host->host_lock locked.

>
>Please comment that, and check it.  Consider using clear_bit or __clear_bit.
>
>> +static inline struct status_msg *shasta_get_status(struct st_hba *hba)
>> +{
>> +	struct status_msg *status = 
>> +		hba->status_buffer + hba->status_tail;
>> +
>> +	++hba->status_tail;
>> +	hba->status_tail %= MU_STATUS_COUNT;
>> +
>> +	return status;
>> +}
>> +
>> +static inline struct req_msg *shasta_alloc_req(struct st_hba *hba)
>> +{
>> +	struct req_msg *req = ((struct req_msg *)hba->dma_mem) +
>> +		hba->req_head;
>> +
>> +	++hba->req_head;
>> +	hba->req_head %= MU_REQ_COUNT;
>> +
>> +	return req;
>> +}
>
>This is the awkward way of managing a ring buffer.  It's simpler to let the
>head and tail incides wrap up to 0xffffffff and only mask them when
>actually using them as indices.   That way,
>
>	if (tail-head == size)
>		buffer is full
>
>	if (tail-head == 0)
>		buffer is empty
>
>in fact, at all times,
>
>	tail-head == items_in_buffer
>

I was always thinking about this problem, because here the req count is not
power of 2.
If we use wrap up, is the extra code handling 0xffffffff needed?

>> +static inline void shasta_map_sg(struct st_hba *hba,
>> +	struct req_msg *req, struct scsi_cmnd *cmd)
>> +{
>> +	struct pci_dev *pdev = hba->pdev;
>> +	dma_addr_t dma_handle;
>> +	struct scatterlist *src;
>> +	struct st_sgtable *dst;
>> +	int i;
>> +
>> +	dst = (struct st_sgtable *)req->variable;
>> +	dst->max_sg_count = cpu_to_le16(ST_MAX_SG);
>> +	dst->sz_in_byte = cpu_to_le32(cmd->request_bufflen);
>> +
>> +	if (cmd->use_sg) {
>> +		src = (struct scatterlist *) cmd->request_buffer;
>> +		dst->sg_count = cpu_to_le16((u16)pci_map_sg(pdev, src,
>> +			cmd->use_sg, cmd->sc_data_direction));
>> +
>> +		for (i = 0; i < dst->sg_count; i++, src++) {
>> +			dst->table[i].count = cpu_to_le32((u32)sg_dma_len(src));
>> +			dst->table[i].addr = 
>> +				cpu_to_le32(sg_dma_address(src) & 0xffffffff);
>
>What does that 0xffffffff do?
>
>Should it be DMA_32BIT_MASK?
>

It is just a 32-bit mask. I guess DMA_32BIT_MASK is OK?

> ...
>>
>> +static inline void
>> +shasta_send_cmd(struct st_hba *hba, struct req_msg *req, u16 tag)
>> +{
>> +	req->tag = cpu_to_le16(tag);
>> +	req->task_attr = TASK_ATTRIBUTE_SIMPLE;
>> +	req->task_manage = 0; /* not supported yet */
>> +	req->payload_sz = (u8)((sizeof(struct req_msg))/sizeof(u32));
>> +
>> +	hba->ccb[tag].req = req;
>> +	hba->out_req_cnt++;
>> +	wmb();
>> +
>> +	writel(hba->req_head, hba->mmio_base + IMR0);
>> +	writel(MU_INBOUND_DOORBELL_REQHEADCHANGED, hba->mmio_base + IDBL);
>> +	readl(hba->mmio_base + IDBL); /* flush */
>> +}
>
>What is the wmb() for?  Flushing memory for the upcoming DMA?  That's not
>what it's for.
>
>When adding any sort of open-coded barrier, please always add a comment
>explaining why it is there.
>
>This function has two callsites and should be uninlined.
>

It's just for write order, but it seems unnecessary on i386.

>
>> +	switch (cmd->cmnd[0]) {
>> +	case READ_6:
>> +	case WRITE_6:
>> +		cmd->cmnd[9] = 0;
>> +		cmd->cmnd[8] = cmd->cmnd[4];
>> +		cmd->cmnd[7] = 0;
>> +		cmd->cmnd[6] = 0;
>> +		cmd->cmnd[5] = cmd->cmnd[3];
>> +		cmd->cmnd[4] = cmd->cmnd[2];
>> +		cmd->cmnd[3] = cmd->cmnd[1] & 0x1f;
>> +		cmd->cmnd[2] = 0;
>> +		cmd->cmnd[1] &= 0xe0;
>> +		cmd->cmnd[0] += READ_10 - READ_6;
>> +		break;
>> +	case MODE_SENSE:
>> +	{
>> +		char mode_sense[4] = { 3, 0, 0, 0 };
>
>static?
>
>> +		shasta_direct_cp(cmd, mode_sense, sizeof(mode_sense));
>> +		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
>> +		fn(cmd);
>> +		return 0;
>> +	}
>> +	case MODE_SENSE_10:
>> +	{
>> +		char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
>
>static?
>

These commands are called just one or two times anyway, maybe need not
static here?

>> +static inline void shasta_unmap_sg(struct st_hba *hba, struct scsi_cmnd *cmd)
>> +{
>> +	dma_addr_t dma_handle;
>> +	if (cmd->sc_data_direction != DMA_NONE) {
>> + 		if (cmd->use_sg) {
>> +			pci_unmap_sg(hba->pdev, cmd->request_buffer,
>> +				cmd->use_sg, cmd->sc_data_direction);
>> +		} else {
>> + 			dma_handle = cmd->SCp.dma_handle;
>> +			pci_unmap_single(hba->pdev, dma_handle,
>> +				cmd->request_bufflen, cmd->sc_data_direction);
>> + 		}
>> +	}
>> +}
>
>Three callsites, please uninline.
>
>> +
>> +static inline void shasta_mu_intr(struct st_hba *hba, u32 doorbell)
>> +{
>
>Two callsites, waaaaaaaay to big to be inlined.
>
><OK, I'll stop going on about overzealous inlining.  Please review all
>inlined functions.  Unless they are exceedingly small or have a single
>callsite, they should be uinlined>.
>
>

I'll check and fix them.

>> +			if (waitqueue_active(&hba->waitq))
>> +				wake_up(&hba->waitq);
>
>This optimisation can cause missed wakeups unless done with care (addition
>of memory barriers).  If there's extra locking which makes it safe then OK,
>but some comment might be needed.
>
>> +static int shasta_handshake(struct st_hba *hba)
>> +{
>> +	void __iomem *base = hba->mmio_base;
>> +	struct handshake_frame *h;
>> +	int i;
>> +
>> +	if (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
>> +		writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
>> +		readl(base + IDBL);
>> +		for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
>> +			&& i < MU_MAX_DELAY_TIME; i++) {
>> +			rmb();
>> +			msleep(1);
>> +		}
>> +
>> +		if (i == MU_MAX_DELAY_TIME) {
>> +			printk(KERN_ERR SHASTA_NAME
>> +				"(%s): no handshake signature\n",
>> +				pci_name(hba->pdev));
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	udelay(10);
>> +
>> +	h = (struct handshake_frame *)(hba->dma_mem + MU_REQ_BUFFER_SIZE);
>> +	h->rb_phy = cpu_to_le32(hba->dma_handle);
>> +	h->rb_phy_hi = cpu_to_le32((hba->dma_handle >> 16) >> 16);
>> +	h->req_sz = cpu_to_le16(sizeof(struct req_msg));
>> +	h->req_cnt = cpu_to_le16(MU_REQ_COUNT);
>> +	h->status_sz = cpu_to_le16(sizeof(struct status_msg));
>> +	h->status_cnt = cpu_to_le16(MU_STATUS_COUNT);
>> +	shasta_gettime(&h->hosttime);
>> +	h->partner_type = HMU_PARTNER_TYPE;
>> +	wmb();
>
>Another mystery barrier.
>

It's same for the "write order" thing. It can be deleted if unnecessary.

>> +	writel(hba->dma_handle + MU_REQ_BUFFER_SIZE, base + IMR0);
>> +	readl(base + IMR0);
>> +	writel((hba->dma_handle >> 16) >> 16, base + OMR0); /* 4G border safe */
>> +	readl(base + OMR0);
>> +	writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
>> +	readl(base + IDBL); /* flush */
>> +
>> +	udelay(10);
>> +	for (i = 0; readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE
>> +		&& i < MU_MAX_DELAY_TIME; i++) {
>> +		rmb();
>
>??

The rmb() here intends to guarantee every readl() to be really effective 
(directly from hardware), although there is already "volatile".

The megaraid_mbox driver uses this...

I used to observe sporadic handshake failure, so I added this(rmb()).

>
>> +		msleep(1);
>> +	}
>> +
>> +	if (i == MU_MAX_DELAY_TIME) {
>> +		printk(KERN_ERR SHASTA_NAME
>> +			"(%s): no signature after handshake frame\n",
>> +			pci_name(hba->pdev));
>> +		return -1;
>> +	}
>> +
>> +	writel(0, base + IMR0);
>> +	readl(base + IMR0);
>> +	writel(0, base + OMR0);
>> +	readl(base + OMR0);
>> +	writel(0, base + IMR1);
>> +	readl(base + IMR1);
>> +	writel(0, base + OMR1);
>> +	readl(base + OMR1); /* flush */
>> +	hba->mu_status = MU_STATE_STARTED;
>> +	return 0;
>> +}
>> +
>> +static int shasta_abort(struct scsi_cmnd *cmd)
>> +{
>> +	struct Scsi_Host *host = cmd->device->host;
>> +	struct st_hba *hba = (struct st_hba *)host->hostdata;
>> +	u16 tag;
>> +	void __iomem *base;
>> +	u32 data;
>> +	int fail = 0;
>
>int result = SUCCESS;
>
>> +	unsigned long flags;
>> +	base = hba->mmio_base;
>> +	spin_lock_irqsave(host->host_lock, flags);
>> +
>> +	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
>> +		if (hba->ccb[tag].cmd == cmd && (hba->tag & (1 << tag))) {
>> +			hba->wait_ccb = &(hba->ccb[tag]);
>> +			break;
>> +		}
>> +	if (tag >= MU_MAX_REQUEST) goto out;
>
>newline here, please.
>
>> +
>> +	data = readl(base + ODBL);
>> +	if (data == 0 || data == 0xffffffff) goto fail_out;
>> +
>> +	writel(data, base + ODBL);
>> +	readl(base + ODBL); /* flush */
>> +
>> +	shasta_mu_intr(hba, data);
>> +
>> + 	if (hba->wait_ccb == NULL) {
>> + 		printk(KERN_WARNING SHASTA_NAME
>> +			"(%s): lost interrupt\n", pci_name(hba->pdev));
>> +		goto out;
>> +	}
>> +
>> +fail_out:
>> +	hba->wait_ccb->req = NULL; /* nullify the req's future return */
>> +	hba->wait_ccb = NULL;
>> +	fail = 1;
>
>result = FAILED;
>
>> +out:
>> +	spin_unlock_irqrestore(host->host_lock, flags);
>> +	return fail ? FAILED : SUCCESS;
>
>return result;
>
>> +}
>>
>> +static int shasta_reset(struct scsi_cmnd *cmd)
>> +{
>> +	struct st_hba *hba;
>> +	int tag;
>> +	int i = 0;
>> +	unsigned long flags;
>> +	hba = (struct st_hba *)cmd->device->host->hostdata;
>
>Unneeded cast.
>
>> +wait_cmds:
>> +	spin_lock_irqsave(hba->host->host_lock, flags);
>> +	for (tag = 0; tag < MU_MAX_REQUEST; tag++)
>> +		if ((hba->tag & (1 << tag)) && hba->ccb[tag].req != NULL) 
>> +			break;
>> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +	if (tag < MU_MAX_REQUEST) {
>> +		msleep(1000);
>> +		if (++i < 10) goto wait_cmds;
>
>newline.
>

OK, I will modify as the comments suggest. Thanks!



