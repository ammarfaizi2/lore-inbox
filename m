Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVI1UKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVI1UKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVI1UKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:10:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4326 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750754AbVI1UKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:10:02 -0400
Message-ID: <433AF897.2050400@pobox.com>
Date: Wed, 28 Sep 2005 16:09:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e050926180156e58f59@mail.gmail.com>	 <433AEB4F.7010502@pobox.com> <355e5e5e0509281258536e4be4@mail.gmail.com>
In-Reply-To: <355e5e5e0509281258536e4be4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
>>>+     if (plugdata) {
>>>+             writeb(plugdata, mmio_base + hotplug_offset);
>>>+             for (i = 0; i < host_set->n_ports; ++i) {
>>>+                     ap = host_set->ports[i];
>>>+                     if (!(ap->flags & ATA_FLAG_SATA))
>>>+                             continue;  //No PATA support here... yet
>>>+                     // Check unplug flag
>>>+                     if (plugdata & 0x1) {
>>>+                             /* Do stuff related to unplugging a device */
>>>+                             ata_hotplug_unplug(ap);
>>>+                             handled = 1;
>>>+                     } else if ((plugdata >> 4) & 0x1) {  //Check plug flag
>>>+                             /* Do stuff related to plugging in a device */
>>>+                             ata_hotplug_plug(ap);
>>>+                             handled = 1;
>>
>>What happens if both bits are set?  Seems like that could happen, if a
>>plug+unplug (cable blip?) occurs in rapid succession.
> 
> 
> What IF both bits are set?  This is why we have a debounce timer to
> take care of the problem :P
> 
> The way this is set up, unplugging will win out (plugging will come
> first, unplugging will come and destroy 'plug's timer, and then the
> unplug action will be performed on timer expiry).  Personally, I like
> it this way, but I can reverse the order of these two to make plugging
> the default action.  Which do you prefer?

The above logic
* acks multiple events
* handles only a single event

so either way you lose an event.  In the code as it is written above, if 
both 'plug' and 'unplug' events are noted, then only the unplug get 
handled, and the newly-plugged device is never noticed.

	Jeff


