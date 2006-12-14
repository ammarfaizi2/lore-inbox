Return-Path: <linux-kernel-owner+w=401wt.eu-S932948AbWLNVkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWLNVkz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbWLNVkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:40:55 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:47860 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbWLNVky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:40:54 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4581C4D1.8090803@s5r6.in-berlin.de>
Date: Thu, 14 Dec 2006 22:40:33 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Import fw-sbp2 driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052253.7213.41796.stgit@dinky.boston.redhat.com> <45750C9A.607@garzik.org> <4581B88C.9040104@redhat.com>
In-Reply-To: <4581B88C.9040104@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Jeff Garzik wrote:
>> doesn't allowing the stack to issue REPORT LUNS take care of this?
> 
> Possibly, I don't have firewire multi-LUN devices to test with here. 
> The LUNs are also discoverable from the firewire config rom, which is
> why I put the comment there.  This doesn't mean that the SCSI commands
> for discovering LUNs doesn't also work.

I expect REPORT LUNS won't work for many SBP-2 devices. It is not included
in RBC.

We discover LUs properly from the information in the ISO 13213 ROM. We just
don't map multiple LUs of the same target to scsi_device's beneath a single
scsi_target. (We instantiate one Scsi_Host for each LU. I might implement
a respective mapping some day, but there is no bigger benefit of doing so.)

>>> +static int sbp2_scsi_queuecommand(struct scsi_cmnd *cmd,
>>> scsi_done_fn_t done)
>>> +{
>>> +    if (cmd->cmnd[0] == REQUEST_SENSE) {
>>> +        fw_notify("request_sense");
>>> +        memcpy(cmd->request_buffer, cmd->sense_buffer,
>>> cmd->request_bufflen);
>>> +        memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
>>> +        cmd->result = DID_OK << 16;
>>> +        done(cmd);
>>> +        return 0;
>>> +    }
>>
>> this is a broken emulation.  this command is specified to not
>> repeatedly return the same sense data.
> 
> I copied it over from the old stack under the assumption that it fixed
> something for some device.

Yes, it's in the old driver. I haven't checked yet when and why it was
written that way. Will do so eventually.

Usually, the SBP-2 status block is used to communicate autosense data.
Targets which do so may not support REQUEST SENSE. Targets which don't
do so have to support REQUEST SENSE; I suppose sbp2's curious REQUEST
SENSE handling is badly broken for such devices as far as any exist.

> I took it out and tested with the 10 or so
> storage devices I have here and it makes no difference.  I've never seen
> the fw_notify() that I put in there trigger.  I'm taking out this
> workaround for now,

OK.

> unless someone can tell me why it should stay there.
> 
> Kristian

-- 
Stefan Richter
-=====-=-==- ==-- -===-
http://arcgraph.de/sr/
