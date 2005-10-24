Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVJXMxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVJXMxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVJXMxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:53:01 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:52141 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750821AbVJXMxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:53:01 -0400
Message-ID: <435CD90F.3080108@acm.org>
Date: Mon, 24 Oct 2005 07:52:31 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-6mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/9] ipmi: use refcount in message handler
References: <20051021144909.GA19532@i2.minyard.local> <20051024021931.GA9696@us.ibm.com> <20051024044217.GA32199@lists.us.dell.com> <20051024062909.GA10337@us.ibm.com>
In-Reply-To: <20051024062909.GA10337@us.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:

>On Sun, Oct 23, 2005 at 11:42:17PM -0500, Matt Domsch wrote:
>  
>
>>On Sun, Oct 23, 2005 at 07:19:32PM -0700, Paul E. McKenney wrote:
>>    
>>
>>>My guess is that this read-side critical section can be invoked from and
>>>SMI, and that SMIs can occur even if interrupts are disabled.  If my guess
>>>is wrong, please enlighten me.  And feel free to ignore the next few
>>>paragraphs in that case, along with a number of my suggested changes,
>>>since they all depend critically on my guess being correct.
>>>      
>>>
>>Paul, it took me a bit to figure this out too, but Corey uses the TLA
>>"SMI" to mean "Systems Management Interface", not "Systems Management
>>Interrupt".   From Documentation/IPMI.txt:
>>
>>ipmi_msghandler - This is the central piece of software for the IPMI
>>system.  It handles all messages, message timing, and responses.  The
>>IPMI users tie into this, and the IPMI physical interfaces (called
>>System Management Interfaces, or SMIs) also tie in here.
>>
>>
>>There are at least 4 basic types of physical hardware interfaces (BT,
>>SMIC, KCS, and I2C), which may (or more often, may not) have their own
>>hardware interrupt lines, but these are normal interrupts, not
>>CPU-magic "systems management interrupts".  So I think this isn't a
>>problem.
>>    
>>
>
>OK, thank you for the tutorial on the "other SMI"!
>  
>
Yeah, I've really misnamed this, unfortunately.  Too many TLAs.

>The comments about turning synchronize_rcu() into synchronize_sched()
>and rcu_read_lock() into preempt_disable() do not apply, please ignore.
>
>However, I still do not understand how using RCU on cmd_rcvrs helps,
>given that all of the accesses that I could see were already protected
>by cmd_rcvrs_lock.
>
>Any further enlightenment available?
>  
>
The calls in handle_ipmb_get_msg_cmd and handle_lan_get_msg_cmd don't
need spinlock protection, just an RCU read lock.  Kind of the point of
the RCU list. Thanks for spotting this.

Thanks,

-Corey
