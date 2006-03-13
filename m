Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWCNFRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWCNFRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWCNFRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:17:51 -0500
Received: from 67.111.72.3.ptr.us.xo.net ([67.111.72.3]:32062 "EHLO
	nonameb.ptu.promise.com") by vger.kernel.org with ESMTP
	id S1751830AbWCNFRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:17:50 -0500
Date: Mon, 13 Mar 2006 21:17:47 +0800
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
Message-ID: <NONAMEBmD3JkUwWpSWe000000e3@nonameb.ptu.promise.com>
X-OriginalArrivalTime: 14 Mar 2006 05:17:55.0750 (UTC) FILETIME=[A6AFB460:01C64726]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >> +static inline void shasta_map_sg(struct st_hba *hba,
>> >> +	struct req_msg *req, struct scsi_cmnd *cmd)
>> >> +{
>> >> +	struct pci_dev *pdev = hba->pdev;
>> >> +	dma_addr_t dma_handle;
>> >> +	struct scatterlist *src;
>> >> +	struct st_sgtable *dst;
>> >> +	int i;
>> >> +
>> >> +	dst = (struct st_sgtable *)req->variable;
>> >> +	dst->max_sg_count = cpu_to_le16(ST_MAX_SG);
>> >> +	dst->sz_in_byte = cpu_to_le32(cmd->request_bufflen);
>> >> +
>> >> +	if (cmd->use_sg) {
>> >> +		src = (struct scatterlist *) cmd->request_buffer;
>> >> +		dst->sg_count = cpu_to_le16((u16)pci_map_sg(pdev, src,
>> >> +			cmd->use_sg, cmd->sc_data_direction));
>> >> +
>> >> +		for (i = 0; i < dst->sg_count; i++, src++) {
>> >> +			dst->table[i].count = cpu_to_le32((u32)sg_dma_len(src));
>> >> +			dst->table[i].addr = 
>> >> +				cpu_to_le32(sg_dma_address(src) & 0xffffffff);
>> >
>> >What does that 0xffffffff do?
>> >
>> >Should it be DMA_32BIT_MASK?
>> >
>> 
>> It is just a 32-bit mask.
>
>Well yes ;)
>
>But what are the implications of this mask on 64-bit platforms?

This is the lower 32-bit of the dma handle. The upper 32-bit is at the
following line of code:

	dst->table[i].addr_hi = 
				cpu_to_le32((sg_dma_address(src) >> 16) >> 16);

>
>> I guess DMA_32BIT_MASK is OK?
>
>If that's semantically what the 0xffffffff means then yes.
>
>> > ...
>> >>
>> >> +static inline void
>> >> +shasta_send_cmd(struct st_hba *hba, struct req_msg *req, u16 tag)
>> >> +{
>> >> +	req->tag = cpu_to_le16(tag);
>> >> +	req->task_attr = TASK_ATTRIBUTE_SIMPLE;
>> >> +	req->task_manage = 0; /* not supported yet */
>> >> +	req->payload_sz = (u8)((sizeof(struct req_msg))/sizeof(u32));
>> >> +
>> >> +	hba->ccb[tag].req = req;
>> >> +	hba->out_req_cnt++;
>> >> +	wmb();
>> >> +
>> >> +	writel(hba->req_head, hba->mmio_base + IMR0);
>> >> +	writel(MU_INBOUND_DOORBELL_REQHEADCHANGED, hba->mmio_base + IDBL);
>> >> +	readl(hba->mmio_base + IDBL); /* flush */
>> >> +}
>> >
>> >What is the wmb() for?  Flushing memory for the upcoming DMA?  That's not
>> >what it's for.
>> >
>> >When adding any sort of open-coded barrier, please always add a comment
>> >explaining why it is there.
>> >
>> >This function has two callsites and should be uninlined.
>> >
>> 
>> It's just for write order, but it seems unnecessary on i386.
>
>write order of what with respect to what?
>

To make sure the content of request payload is valid before dma starting,
or at least no later than that. It might be unnecessary. But I don't know
if there is a systematic way to do it.

>> >
>> >> +	switch (cmd->cmnd[0]) {
>> >> +	case READ_6:
>> >> +	case WRITE_6:
>> >> +		cmd->cmnd[9] = 0;
>> >> +		cmd->cmnd[8] = cmd->cmnd[4];
>> >> +		cmd->cmnd[7] = 0;
>> >> +		cmd->cmnd[6] = 0;
>> >> +		cmd->cmnd[5] = cmd->cmnd[3];
>> >> +		cmd->cmnd[4] = cmd->cmnd[2];
>> >> +		cmd->cmnd[3] = cmd->cmnd[1] & 0x1f;
>> >> +		cmd->cmnd[2] = 0;
>> >> +		cmd->cmnd[1] &= 0xe0;
>> >> +		cmd->cmnd[0] += READ_10 - READ_6;
>> >> +		break;
>> >> +	case MODE_SENSE:
>> >> +	{
>> >> +		char mode_sense[4] = { 3, 0, 0, 0 };
>> >
>> >static?
>> >
>> >> +		shasta_direct_cp(cmd, mode_sense, sizeof(mode_sense));
>> >> +		cmd->result = DID_OK << 16 | COMMAND_COMPLETE << 8;
>> >> +		fn(cmd);
>> >> +		return 0;
>> >> +	}
>> >> +	case MODE_SENSE_10:
>> >> +	{
>> >> +		char mode_sense10[8] = { 0, 6, 0, 0, 0, 0, 0, 0 };
>> >
>> >static?
>> >
>> 
>> These commands are called just one or two times anyway, maybe need not
>> static here?
>
>The way you have the code here the compiler will need to create an array on
>the stack and then populate each item in that array each time it's used.
>
>If these are made static, that's all done at compile time.
>

That's OK. Seems "static" is better.

>> The rmb() here intends to guarantee every readl() to be really effective 
>> (directly from hardware), although there is already "volatile".
>
>readl() should already take care of all that.
>
>> The megaraid_mbox driver uses this...
>> 
>> I used to observe sporadic handshake failure, so I added this(rmb()).
>
>In that case something funny is going on.  We should understand what that
>is - it'll come back to bite us.
>

OK. I guess here if we use ioremap_nocache() then the rmb() will be unneeded.
But it's ioremap() in the driver. So we can not safely remove the rmb() 
unless we change ioremap() to ioremap_nocache(), and do substantial testing
on it. It should be caching that caused the problem.



