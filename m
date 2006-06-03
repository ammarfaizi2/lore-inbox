Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWFCIkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWFCIkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWFCIkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:40:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58758 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750941AbWFCIkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:40:12 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44814A63.1080707@s5r6.in-berlin.de>
Date: Sat, 03 Jun 2006 10:37:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: Jody McIntyre <scjody@modernduck.com>, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net, stable@kernel.org
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of	hpsb_allocate_and_register_addrspace
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de> <20060603013515.GV18769@moss.sous-sol.org>
In-Reply-To: <20060603013515.GV18769@moss.sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.882) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
...
>>+++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c	2006-06-03 01:54:23.000000000 +0200
>>@@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
>> 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
>> 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
>> 			0x010000000000ULL, CSR1212_ALL_SPACE_END);
>>-	if (!scsi_id->status_fifo_addr) {
>>+	if (scsi_id->status_fifo_addr == ~0ULL) {
>> 		SBP2_ERR("failed to allocate status FIFO address range");
>> 		goto failed_alloc;
>> 	}
>>
> 
> 
> Is that enough?
> 
> failed_alloc:
>         sbp2_remove_device(scsi_id);
> 
> sbp2_remove_device(scsi_id)
>   if (scsi_id->status_fifo_addr)
>     hpsb_unregister_addrspace()
> 
> Suppose status_fifo_addr won't match any as->start.

Thanks, here is another bug. An address space beginning at 0 won't be 
de-registered. But this is not a big issue because 1. a configuration 
where a FIFO address space starting from 0 is impractical anyway (can 
occur if CONFIG_IEEE1394_SBP2_PHYS_DMA=N and physical DMA is unavailable 
from the host adapter, which won't work at the moment) and 2. the 
address space is a plenty resource (both as a bus address and with 
respect to the backing data structures) and 3. would be unregistered if 
the sbp2 module was unloaded. This is not critical for -stable.

On the other hand, if hpsb_unregister_addrspace(HL_driver, host, 
address) with address == ~0ULL (i.e. 
hpsb_allocate_and_register_addrspace failed before), it would do nothing 
but burn a few CPU cycles unsuccessfully searching for an address space 
starting at ~0ULL. Valid address spaces start at an address lower than 
CSR1212_ALL_SPACE_END == 1ULL << 48.

I will post a follow-up patch after breakfast, but it isn't relevant for 
-stable.

Thanks,
-- 
Stefan Richter
-=====-=-==- -==- ---==
http://arcgraph.de/sr/
