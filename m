Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWCaPVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWCaPVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWCaPVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:21:15 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:52154 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751333AbWCaPVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:21:14 -0500
Message-ID: <442D48E2.3050706@garzik.org>
Date: Fri, 31 Mar 2006 10:21:06 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ed Lin <ed.lin@promise.com>
CC: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
References: <NONAMEBK04QBh0TzlYb000006b5@nonameb.ptu.promise.com>
In-Reply-To: <NONAMEBK04QBh0TzlYb000006b5@nonameb.ptu.promise.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Lin wrote:
> ======= On 2006-03-15 04:04:30, Matthew Wilcox wrote:
> 
>> On Mon, Mar 13, 2006 at 03:42:36PM -0800, Andrew Morton wrote:
>>>> +#include <linux/irq.h>
>>> Can't include linux/irq.h from generic code (we really ought to fix that).
>> In a sense we have -- everybody should include <linux/interrupt.h> and
>> not <*/irq.h>.  Perhaps we need to poison the includes.
>>
>>>> +static inline u16 shasta_alloc_tag(u32 *bitmap)
>>>> +{
>>>> +	u16 i;
>>>> +	for (i = 0; i < TAG_BITMAP_LENGTH; i++) 
>>>> +		if (!((*bitmap) & (1 << i))) {
>>>> +			*bitmap |= (1 << i);
>>>> +			return i;
>>>> +		}
>>>> +
>>>> +	return TAG_BITMAP_LENGTH;
>>>> +}
>>> This is too large to be inlined.
>> And if I read the driver right, is unnecessary code.  It could just use
>> the midlayer tag code (ok, not scsi_populate_tag_msg() which is
>> SPI-specific, but scsi_activate_tcq(), scsi_deactivate_tcq(),
>> scsi_find_tag(), scsi_set_tag_type(), and scsi_get_tag_type() should all
>> work, being thin wrappers around the block layer functionality.
>>
> 
> Really sorry about that. But...
> 
> When I was starting to implement the tcq according to the advice, I
> suddenly found there may be a misunderstanding here. I think the tagged
> command queue should be applied to a disk. But here the tag is adapter(HBA)
> wide, not just for a specific disk. So maybe this is not the proper case
> where tagged queue is being used...

The block layer code works just fine with host queueing, but I agree
that it may not be appropriate for the SCSI tcq API.

In any case, I'm fine with merging the driver with existing tagging --
since its known to work -- and then pondering the best course of action
for tagging APIs in a later patch to the shasta driver.

Let's go ahead and get it in, minus the requested tagging changes but
including the other requests.

	Jeff



