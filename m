Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWJJSXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWJJSXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWJJSXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:23:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:7292 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965010AbWJJSXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:23:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144264084:sNHT19731978"
Message-ID: <452BE3FC.5010001@intel.com>
Date: Tue, 10 Oct 2006 11:18:36 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, NetDev <netdev@vger.kernel.org>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug() directly.
References: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain> <452BC6C9.3050902@intel.com> <Pine.LNX.4.64.0610101227170.9699@localhost.localdomain> <452BCF5C.2090407@intel.com> <Pine.LNX.4.64.0610101347270.10344@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0610101347270.10344@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2006 18:20:29.0719 (UTC) FILETIME=[C42E4A70:01C6EC98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Tue, 10 Oct 2006, Auke Kok wrote:
> 
>> Robert P. J. Day wrote:
> 
> ... snip ...
> 
>>>   if someone wants to tell me what, in the context of ixgb_main.c,
>>> i would use as that "dev" argument [for dev_dbg], i'm all for
>>> that.
>> (CC netdev since it's a network driver topic).
>>
>> all our macro's (e100, e1000, ixgb) use adapter->netdev->name
>> inserted through the DPRINTK macro.
>>
>> if you'd really want to clean it all up, you'd have to replace all
>> DPRINTK() calls with dev_dbg(adapter->netdev->name, ....) which
>> would just make it more lengthy and uncomfortable to read.
>>
>> which puts this in a bigger perspective. I suppose the nicest way to do
>> program these is to do something like this:
>>
>> #define ixgb_dbg(args...) dev_dbg(adapter->netdev->name, args)
>> #define ixgb_err(args...) dev_err(adapter->netdev->name, args)
>> #define ixgb_info(args...) dev_info(adapter->netdev->name, args)
>>
>> and use those consistently throughout the driver, ditto for e100/e1000.
>>
>> I'll look into it and see what I can do.
> 
> um, yeah.  i'm rapidly getting out of my comfort zone here.  this
> seemed like such a simple submission six hours ago.  :-)  live and
> learn.

digging into it much deeper, dev_dbg seems horribly unsuited for our needs as it prints 
the pci bus address and al. That's a lot of information when we really only care about 
'eth0: ' perhaps with 'ixgb: ' prepended to it.

You end up with pretty much the same code that was there before - unless we make 
something common for netdevices and use that instead:

#define netdev_dbg(netdev, args...) pr_debug(netdev->name, args)

and then use this stacked in the driver:

#define ixgb_dbg(args...) netdev_dbg(adapter->netdev, args)

that would seem clean and appropriate, and since this bit of infrastructure is missing 
from netdevice.h, explains the current situation in all netdrivers (chaos).

of course, I'm completely not taking netif_msg_level into account yet here, which 
probably makes it a bit more hairy.


Auke
