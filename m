Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWJJQwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWJJQwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWJJQwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:52:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:58125 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030210AbWJJQwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:52:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144222762:sNHT1194553220"
Message-ID: <452BCF5C.2090407@intel.com>
Date: Tue, 10 Oct 2006 09:50:36 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, NetDev <netdev@vger.kernel.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug() directly.
References: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain> <452BC6C9.3050902@intel.com> <Pine.LNX.4.64.0610101227170.9699@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0610101227170.9699@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2006 16:52:35.0098 (UTC) FILETIME=[7C42FFA0:01C6EC8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Tue, 10 Oct 2006, Auke Kok wrote:
> 
>> Robert P. J. Day wrote:
>>> Delete the minimally-useful IXGB_DBG() macro and call pr_debug()
>>> directly from the main routine.
>>>
>>> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
>>> ---
>>> diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
>>> index 50ffe90..fb9fde5 100644
>>> --- a/drivers/net/ixgb/ixgb.h
>>> +++ b/drivers/net/ixgb/ixgb.h
>>> @@ -77,12 +77,6 @@ #include "ixgb_hw.h"
>>>  #include "ixgb_ee.h"
>>>  #include "ixgb_ids.h"
>>>
>>> -#ifdef _DEBUG_DRIVER_
>>> -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
>>> -#else
>>> -#define IXGB_DBG(args...)
>>> -#endif
>>> -
>>>  #define PFX "ixgb: "
>>>  #define DPRINTK(nlevel, klevel, fmt, args...) \
>>>  	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
>>> diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
>>> index e09f575..eada685 100644
>>> --- a/drivers/net/ixgb/ixgb_main.c
>>> +++ b/drivers/net/ixgb/ixgb_main.c
>>> @@ -1948,7 +1948,7 @@ #endif
>>>
>>>  			/* All receives must fit into a single buffer */
>>>
>>> -			IXGB_DBG("Receive packet consumed multiple buffers "
>>> +			pr_debug("ixgb: Receive packet consumed multiple
>>> buffers "
>>>  					 "length<%x>\n", length);
>>>
>>>  			dev_kfree_skb_irq(skb);
>>>
>>> --
>>>
>>>   all right ... what did i mess up *this* time?  :-)  it's good
>>> practice.  that's my story and i'm sticking to it.
 >>
>> We should really use dev_dbg() instead, as it retains the 'ethX:'
>> annotation afaics.
> 
> i actually tried to use that first, but it wasn't clear to me what i
> would use as that first argument to dev_dbg(), given the definitions
> in include/linux/device.h:
> 
> #define dev_dbg(dev, format, arg...)            \
>         dev_printk(KERN_DEBUG , dev , format , ## arg)
> 
> #define dev_printk(level, dev, format, arg...)  \
>         printk(level "%s %s: " format , dev_driver_string(dev) ,
>         (dev)->bus_id , ## arg)
> 
>   if someone wants to tell me what, in the context of ixgb_main.c, i
> would use as that "dev" argument, i'm all for that.

(CC netdev since it's a network driver topic).


all our macro's (e100, e1000, ixgb) use adapter->netdev->name inserted through the 
DPRINTK macro.

if you'd really want to clean it all up, you'd have to replace all DPRINTK() calls with 
dev_dbg(adapter->netdev->name, ....) which would just make it more lengthy and 
uncomfortable to read.

which puts this in a bigger perspective. I suppose the nicest way to do program these is 
to do something like this:

#define ixgb_dbg(args...) dev_dbg(adapter->netdev->name, args)
#define ixgb_err(args...) dev_err(adapter->netdev->name, args)
#define ixgb_info(args...) dev_info(adapter->netdev->name, args)

and use those consistently throughout the driver, ditto for e100/e1000.

I'll look into it and see what I can do.

Cheers,

Auke


