Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTKFONq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTKFONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:13:46 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:13844 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S263662AbTKFONn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:13:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Dain <omd1@cornell.edu>
To: Gianni Tedesco <gianni@scaramanga.co.uk>, odain2@mindspring.com
Subject: Re: CONFIG_PACKET_MMAP revisited
Date: Thu, 6 Nov 2003 09:13:41 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <176730-2200310329491330@M2W026.mail2web.com> <1068116914.6144.1410.camel@lemsip>
In-Reply-To: <1068116914.6144.1410.camel@lemsip>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311060913.41719.omd1@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 6 2003 6:08 am, Gianni Tedesco wrote:
> On Wed, 2003-10-29 at 05:09, odain2@mindspring.com wrote:
> > I believe that in normal operation each packet
> > (or with NICs that do interrupt coalescing, every n packets) causes an
> > interrupt which causes a context switch, the kernel then copies the data
> > from the DMA buffer to the shared buffer and does a RETI.  That's fairly
> > expensive.
>
> The cost of handling that interrupt and doing an iret is unavoidable
> (ignoring NAPI). The main point you are missing with the ring buffer is
> that if packets come in at a fast enough rate, the usermode task never
> context switches, because there is always data in the ring buffer, so it
> loops in usermode forever.

It seems to me that it can't loop in user mode forever.  There is no way to 
get data into user mode (the ring buffer) witout going through the kernel.  
My understanding is that the NIC doesn't transfer directly to the user mode 
ring buffer, but rather to a different DMA buffer.  The kernel must copy it 
from the DMA buffer to the ring buffer. Thus once the user mode app has 
processed all the data in the ring buffer the kenel _must_ get involved to 
get more data to user space.  Currently the data gets there because the NIC 
produces an interrupt for each packet (or for every few packets) and when the 
kernel handles these the data is copied to user space.  Then, as you point 
out, the cost of the RETI can't be avoided.  

NAPI tries to solve this problem.  I don't know much about NAPI, but as I 
understand it, the idea is this: The cost of the RETI's and context switches 
(which occur on each interrupt) can be reduced if the NIC doesn't produce an 
interrupt for every packet but instead does interrupt coalescing, but this 
only goes so far.  If too many packets are coalesced the data copied by the 
kernel will no longer fit in the L1 cache and we'll pay the price of moving 
it there twice (once when the kernel copies the data from main memory to the 
ring buffer and once when the user mode application reads it out of the 
ring), the latency may become a problem, we've still got a context switch 
every time the user mode application has processed everything in the ring 
buffer (and perhaps more often), and we're still paying the price of copying 
data from the DMA buffer to the ring.

However, if the NIC could transfer the data directly to user space it wouldn't 
need to cause an interrupt and the cost of the RETI and the context switch is 
avoided.  The user mode app really could process forever without sleeping at 
that point.

> The problem could be the packets are coming in just too slow to allow
> the ring buffer to work properly and causing the application to sleep on
> poll(2) every time. This would kill performance at pathelogical packet
> rates I guess.
>
> You could work around this by spinning for a few thousand spins before
> calling poll(2) (or even indefinately for that matter, and allow the
> kernel to preempt you if need be).


