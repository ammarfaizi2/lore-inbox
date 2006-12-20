Return-Path: <linux-kernel-owner+w=401wt.eu-S1030274AbWLTSn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWLTSn7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWLTSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:43:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030274AbWLTSn6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:43:58 -0500
Message-ID: <45898359.9020303@redhat.com>
Date: Wed, 20 Dec 2006 13:39:21 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Pieter Palmers <pieterp@joow.be>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458956CB.7060004@joow.be>
In-Reply-To: <458956CB.7060004@joow.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pieter Palmers wrote:
> Kristian Høgsberg wrote:
>> Hi,
>>
>> Here's a new set of patches for the new firewire stack.  The changes
>> since the last set of patches address the issues that were raised on
>> the list and can be reviewed in detail here:
> .. for some reason I didn't get patch 3/4 and 4/4 on the linux1394-devel 
> list, so I'll reply to this one.
> 
> I would suggest a reordering of the interrupt flag checks. Currently the 
> interrupts that are least likely to occur are checked first. I don't see 
> why. I would reorder the check such that ISO interrupts are checked 
> first, as they have the most stringent timing constraints and are most 
> likely to occur (when using ISO traffic).

All the interrupt handler does is schedule tasklets and they are all handled 
before returning to userspace.  So not matter how you order them it's going to 
take the same time.  If you want to defer handling of async traffic to after 
your userspace handler has run, you need to schedule a work_struct for 
handling the async events.

Having said that, I doubt that the latency between iso interrupt and user 
space handler imposed by the irq handler and the tasklets will be a problem. 
All the async tasklets do is copy the data out of the DMA buffers, possibly 
lookup a corresponding request and eventually call complete() on some struct 
completion.  The worst case is the bus reset tasklet which does the topology 
walk, but even that is pretty fast.

> After processing the ISO interrupts (and maybe the Async ones), a bypass 
> could be inserted to exit the interrupt handler when there are no other 
> interrupts to be handled. All other interrupts are to report relatively 
> rare events or errors (error handling still to be added I assume). The 
> effective run-length of the interrupt handler would be shorter using 
> such a bypass, especially in the case where there is a lot of ISO traffic.
> 
> I'm looking forward to your ISO implementation, and I hope to 
> incorporate it into FreeBob really fast.

Sounds great, I'll get to the isochronous receive feature as soon as possible. 
  I'm open to changing the interrupt handling if we can acheive lower latency, 
but we need to be able to measure it before we start making changes.

cheers,
Kristian

