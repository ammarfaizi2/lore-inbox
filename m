Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWELUcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWELUcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWELUcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:32:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932222AbWELUcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:32:21 -0400
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
From: Arjan van de Ven <arjan@infradead.org>
To: amah@highpoint-tech.com
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605092202.k49M2Hqr027225@mail.hypersurf.com>
References: <200605092202.k49M2Hqr027225@mail.hypersurf.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 22:32:11 +0200
Message-Id: <1147465931.3173.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <asm/div64.h>
> +#include <linux/hdreg.h>

please put all asm/ includes after the linux/ ones

> +{
> + u32 req = 0;
> + int i;

in linux coding style we use a tab as indent character, not a space


> +
> + for (i = 0; i < millisec; i++) {
> +  req = readl(&iop->inbound_queue);
> +   if (req != IOPMU_QUEUE_EMPTY)
> +   break;
> +  mdelay(1);

mdelay is evil. Really evil. Are you really sure you need to busy wait
here?


> + }
> +
> + if (req != IOPMU_QUEUE_EMPTY) {
> +  writel(req, &iop->outbound_queue);

does this need a PCI posting flush?



> +static int __iop_intr(struct hptiop_hba * hba)
> +{
> + struct hpt_iopmu __iomem * iop = hba->iop;
> + u32 status;
> + int ret = 0;
> +
> + status = readl(&iop->outbound_intstatus);
> +
> + if (status & IOPMU_OUTBOUND_INT_MSG0) {
> +  u32 msg = readl(&iop->outbound_msgaddr0);
> +  dprintk("received outbound msg %x\n", msg);

dprintk???

> +  writel(IOPMU_OUTBOUND_INT_MSG0, &iop->outbound_intstatus);


> + for (i = 0; i < millisec; i++) {
> +  __iop_intr(hba);
> +  if (readl(&req->context))
> +   return 0;
> +  mdelay(1);


same question about the mdelay.



> +
> +static int iop_send_sync_msg(struct hptiop_hba * hba, u32 msg, u32 millisec)
> +{
> + u32 i;
> +
> + hba->msg_done = 0;
> +
> + writel(msg, &hba->iop->inbound_msgaddr0);
> +
> + for (i = 0; i < millisec; i++) {
> +  __iop_intr(hba);
> +  if (hba->msg_done)
> +   break;
> +  mdelay(1);
> + }

and here, but here you're very clearly missing a pci posting flush




> +static int hptiop_map_pci_bar(struct hptiop_hba * hba)
> +{
> + u8 cmd;
> + u32 mem_base_phy, length;
> + void __iomem * mem_base_virt;
> + struct pci_dev *pcidev = hba->pcidev;
> +
> + pci_read_config_byte(pcidev, PCI_COMMAND, &cmd);
> + pci_write_config_byte(pcidev, PCI_COMMAND,
> +   cmd | PCI_COMMAND_MASTER |
> +   PCI_COMMAND_MEMORY | PCI_COMMAND_INVALIDATE);

eh this is almost always a really bad bug. You're bypassing the linux
pci layer if you do this. there is pci_enable_device and pci_set_master
and friends.





> +  if (scp->use_sg)

this is not needed; you'll never get non-use_sg fields anymore
> + p = (struct hpt_iop_request_ioctl_command __iomem *)req;
> + arg = (struct hpt_ioctl_k *)(unsigned long)
> +  (readl(&req->context) |
> +   ((u64)readl(&req->context_hi32)<<32));

these typecasts make my head hurt... and I smell a fish here ;)

> + else
> +  arg->result = HPT_IOCTL_RESULT_FAILED;
> +
> + arg->done(arg);
> + writel(tag, &hba->iop->outbound_queue);
> +}

this looks like it needs a posting flush again


> +
> +static irqreturn_t hptiop_intr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> + struct hptiop_hba * hba = (struct hptiop_hba *)dev_id;
> + int  handled = 0;
> + unsigned long flags;
> +
> + spin_lock_irqsave(hba->host->host_lock, flags);
> + handled = __iop_intr(hba);
> + spin_unlock_irqrestore(hba->host->host_lock, flags);
> +
> +


hmm this looks fishy to me a bit...

> \+  HPT_SCP(scp)->sgcnt = pci_map_sg(hba->pcidev,
> +    sglist, scp->use_sg,
> +    scp->sc_data_direction);
> +  HPT_SCP(scp)->mapped = 1;
> +  BUG_ON(HPT_SCP(scp)->sgcnt > hba->max_sg_descriptors);
> +
> +  psg--;
> +  for (idx = 0; idx < HPT_SCP(scp)->sgcnt; idx++) {
> +   addr = sg_dma_address(&sglist[idx]);
> +   length = sg_dma_len(&sglist[idx]);
> +   /* merge the sg elements if possible */

eh afaik this is already done by the map function. Drivers really
shouldn't do that behind the pci mapping layers back; there may well be
very good reasons why the generic layer didn't do this in the first
place (like chipset bugs or iommu reasons)



> +
> + atomic_inc(&hba->outstandingcommands);

hmm why are you counting this? the scsi layer is already counting this;
no need to count again with an expensive atomic operation even

> + memcpy(req->cdb, scp->cmnd, sizeof(req->cdb));
> +
> + writel(IOPMU_QUEUE_ADDR_HOST_BIT | _req->req_shifted_phy,
> +   &hba->iop->inbound_queue);

this needs pci posting flush

> +static int hptiop_abort(struct scsi_cmnd *scp)
> +{
> + dprintk("hptiop_abort(%d/%d/%d) scp=%p\n",
> +   scp->device->host->host_no, scp->device->channel,
> +   scp->device->id, scp);
> + return FAILED;
> +}

it's better to just not provide an abort then if you can't support it.


> +
> +static int hptiop_reset_hba(struct hptiop_hba * hba)
> +{
> + if (atomic_xchg(&hba->resetting, 1) == 0) {
> +  atomic_inc(&hba->reset_count);
> +  writel(IOPMU_INBOUND_MSG0_RESET,
> +    &hba->iop->outbound_msgaddr0);
> + }

this needs a pci posting flush

> +
> + wait_event_timeout(hba->reset_wq,
> +   atomic_read(&hba->resetting) == 0, 60 * HZ);
> +
> + if (atomic_read(&hba->resetting)) {
> +  /* IOP is in unkown state, abort reset */
> +  printk(KERN_ERR "scsi%d: reset failed\n", hba->host->host_no);
> +  return -1;
> + }
> +
> + /* all scp should be finished */
> + BUG_ON(atomic_read(&hba->outstandingcommands) != 0);

this is really rude action I suppose


> +
> + spin_lock_irq(hba->host->host_lock);
> +
> + if (iop_send_sync_msg(hba,

since this does a busy wait mdelay() this will trigger the watchdogs
because IRQ's are off. Not good.



> +static int hptiop_copy_info(struct hptiop_getinfo *pinfo, char *fmt, ...)
> +{
> + va_list args;
> + char buf[128];
> + int len;
> +
> + va_start(args, fmt);
> + len = vsprintf(buf, fmt, args);
> + va_end(args);
> + hptiop_copy_mem_info(pinfo, buf, len);
> + return len;
> +}

hmm what is this for??

> +
> +static void hptiop_do_ioctl(struct hpt_ioctl_k *arg)
> +{

you're just exporting some controller data structure. That sounds like a
really obvious candidate for a sysfs file instead

> +
> + /* Enable 64bit DMA if possible */
> + if (pci_set_dma_mask(pcidev, 0xFFFFFFFFFFFFFFFFULL)) {
> +  if (pci_set_dma_mask(pcidev, 0xFFFFFFFFUL)) {

we have very nice symbolic names for these... why not use them ;)


> +
> +typedef u32 hpt_id_t;

why this typedef?

> +
> +#if 0
> +#define dprintk(fmt, args...) do { printk(fmt, ##args); } while(0)
> +#else
> +#define dprintk(fmt, args...)
> +#endif


you're duplicating prdebug() here. Please use that instead.

