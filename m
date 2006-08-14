Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWHNBPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWHNBPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWHNBPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:15:46 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2222 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751609AbWHNBPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:15:45 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=PArK8fZNiYSbIsdgchGaGn/Kg1ZAJUpIj+iJByTGRTswvyW3mCBM+DbFyEdutND3f
	ZB/I6MJVgE3FV2mhdO2sw==
Message-ID: <44DFCE9C.402@google.com>
Date: Sun, 13 Aug 2006 18:15:08 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: a.p.zijlstra@chello.nl, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <1155132440.12225.70.camel@twins>	<20060809.165846.107940575.davem@davemloft.net>	<44DF9817.8070509@google.com> <20060813.164934.00081381.davem@davemloft.net>
In-Reply-To: <20060813.164934.00081381.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
>From: Daniel Phillips <phillips@google.com>
>>David Miller wrote:
>>
>>>The reason is that there is no refcounting performed on these devices
>>>when they are attached to the skb, for performance reasons, and thus
>>>the device can be downed, the module for it removed, etc. long before
>>>the skb is freed up.
>>
>>The virtual block device can refcount the network device on virtual
>>device create and un-refcount on virtual device delete.
> 
> What if the packet is originally received on the device in question,
> and then gets redirected to another device by a packet scheduler
> traffic classifier action or a netfilter rule?
> 
> It is necessary to handle the case where the device changes on the
> skb, and the skb gets freed up in a context and assosciation different
> from when the skb was allocated (for example, different from the
> device attached to the virtual block device).

This aspect of the patch became moot because of the change to a single
reserve for all layer 2 delivery in Peter's more recent revisions.

*However* maybe it is worth mentioning that I intended to provide a
pointer from each sk_buff to a common accounting struct.  This pointer
is set by the device driver.  If the driver knows nothing about memory
accounting then the pointer is null, no accounting is done, and block
IO over the interface will be dangerous.  Otherwise, if the system is
in reclaim (which we currently detect crudely when a normal allocation
fails) then atomic ops will be done on the accounting structure.

I planned to use the (struct sock *)sk_buff->sk field for this, which
is unused during layer 2 delivery as far as I can see.  The accounting
struct can look somewhat like a struct sock if we like, size doesn't
really matter, and it might make the code more robust.  Or the field
could become a union.

Anyway, this bit doesn't matter any more, the single global packet
delivery reserve is better and simpler.

Regards,

Daniel
