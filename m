Return-Path: <linux-kernel-owner+w=401wt.eu-S1751127AbWLNUuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWLNUuu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWLNUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:50:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40821 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbWLNUut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:50:49 -0500
Message-ID: <4581B88C.9040104@redhat.com>
Date: Thu, 14 Dec 2006 15:48:12 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 3/3] Import fw-sbp2 driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052253.7213.41796.stgit@dinky.boston.redhat.com> <45750C9A.607@garzik.org>
In-Reply-To: <45750C9A.607@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

Again, thanks for your comments, I've added patches to my git repo, will send 
out a new set on LKML before the end of this week.

>> +/* I don't know why the SCSI stack doesn't define something like 
>> this... */
>> +typedef void (*scsi_done_fn_t) (struct scsi_cmnd *);
> 
> submit a patch?

Hehe, yeah, that might work.

>> +struct sbp2_status {
>> +    unsigned int orb_high:16;
> 
> unsigned short?  probably generates better code than a bitfield:16

This and all other bit fields are now just u32s that I access by shifting and 
masking.

>> +struct sbp2_login_response {
>> +    u16 login_id;
>> +    u16 length;
>> +    u32 command_block_agent_high;
>> +    u32 command_block_agent_low;
>> +    u32 reconnect_hold;
>> +};
> 
> __le16 and __le32?

This struct is filled in using fw_memcpy_from_be32() to copy and byteswap the 
incoming payload, so the fields here are always cpu endian.  The two u16 
fields assume little endian ordering though, I fixed that.

>> +sbp2_send_management_orb(struct fw_unit *unit, int node_id, int 
>> generation,
>> +             int function, int lun, void *response)
>> +{
>> +    struct fw_device *device = fw_device(unit->device.parent);
>> +    struct sbp2_device *sd = unit->device.driver_data;
>> +    struct sbp2_management_orb *orb;
>> +    unsigned long timeout;
>> +    int retval = -EIO;
>> +
>> +    orb = kzalloc(sizeof *orb, GFP_ATOMIC);
>> +    if (orb == NULL)
>> +        return -ENOMEM;
>> +
>> +    /* The sbp2 device is going to send a block read request to
>> +     * read out the request from host memory, so map it for
>> +     * dma. */
>> +    orb->base.request_bus =
>> +        dma_map_single(device->card->device, &orb->request,
>> +                   sizeof orb->request, DMA_TO_DEVICE);
>> +
>> +    orb->response_bus =
>> +        dma_map_single(device->card->device, &orb->response,
>> +                   sizeof orb->response, DMA_FROM_DEVICE);
> 
> check for DMA mapping error

Oops, fixed.

>> +    if (sd->workarounds)
>> +        fw_notify("Workarounds for node %s: 0x%x "
>> +              "(firmware_revision 0x%06x, model_id 0x%06x)\n",
>> +              unit->device.bus_id,
>> +              sd->workarounds, firmware_revision, model);
>> +
>> +    /* FIXME: Make this work for multi-lun devices. */
>> +    lun = 0;
> 
> doesn't allowing the stack to issue REPORT LUNS take care of this?

Possibly, I don't have firewire multi-LUN devices to test with here.  The LUNs 
are also discoverable from the firewire config rom, which is why I put the 
comment there.  This doesn't mean that the SCSI commands for discovering LUNs 
doesn't also work.

>> +/* SCSI stack integration */
>> +
>> +static int sbp2_scsi_queuecommand(struct scsi_cmnd *cmd, 
>> scsi_done_fn_t done)
>> +{
>> +    if (cmd->cmnd[0] == REQUEST_SENSE) {
>> +        fw_notify("request_sense");
>> +        memcpy(cmd->request_buffer, cmd->sense_buffer, 
>> cmd->request_bufflen);
>> +        memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
>> +        cmd->result = DID_OK << 16;
>> +        done(cmd);
>> +        return 0;
>> +    }
> 
> this is a broken emulation.  this command is specified to not repeatedly 
> return the same sense data.

I copied it over from the old stack under the assumption that it fixed 
something for some device.  I took it out and tested with the 10 or so storage 
devices I have here and it makes no difference.  I've never seen the 
fw_notify() that I put in there trigger.  I'm taking out this workaround for 
now, unless someone can tell me why it should stay there.

Kristian
