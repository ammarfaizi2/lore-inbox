Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUCaA73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUCaA73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:59:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17101 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263162AbUCaA67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:58:59 -0500
Date: Tue, 30 Mar 2004 16:57:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: rddunlap@osdl.org, hari@in.ibm.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org, James Cleverdon <jamesclv@us.ibm.com>
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <270000000.1080694659@flay>
In-Reply-To: <20040330163928.7cafae3d.akpm@osdl.org>
References: <006701c415a4$01df0770$d100000a@sbs2003.local><20040329162123.4c57734d.akpm@osdl.org><20040329162555.4227bc88.akpm@osdl.org><20040330132832.GA5552@in.ibm.com><20040330151729.1bd0c5d0.rddunlap@osdl.org><187940000.1080692555@flay> <20040330163928.7cafae3d.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I'll just say that kexec fails without this patch and works with
>> > it applied, so I'd like to see it merged.  If this patch isn't
>> > acceptable, let's find out why and try to make one that is.
>> > 
>> > Thanks for the patch, Hari.
>> 
>> > From discussions with Andy, it seems this still has the same race as before
>> just smaller. I don't see how we can fix this properly without having some
>> locking on cpu_online_map .... probably RCU as it's massively read-biased
>> and we don't want to pay a spinlock cost to read it.
> 
> We do want to avoid adding stuff to the IPI path.

OK, but my thinking was that the readlock of RCU is free (pretty much).

> If the going-away CPU still responds to IPIs after it has gone away 
> then do we actually need to do anything?  For x86, at least?

Eeek, you *really* don't want it responding to IPIs after it's been shut
down. It's dead, dead, dead, and we don't want it rolling over in it's
gasping throes, and stabbing us in the back. Supposing we've kexeced or 
otherwise rebooted the machine? If we've shut down the other cpus, we
should be able to reprogram the IDT, drop back out of paging mode to 
reboot into the BIOS, or basically anything. Nothing short of an NMI or 
a power cycle (aka Startup / INIT sequence) should arouse it.

And if we don't take IPIs, I really think we're playing russian roulette 
here ... I was under the *impression* that if you sent an IPI to a cpu 
that was down and didn't ack it, we'd hang. Forever. At least on a P3 
style apic bus, when we're sending individual interrupts to each CPU, 
not broadcast.

I made a similar patch, but I don't see how we can really fix it without
providing locking on cpu_online_map. Or else you have to do something 
gross like mark the CPU offline, spin for 5 seconds, then take it offline.
Ick. Maybe we could be smart with a 2-stage commit with 2 bitmaps or
something, but I think that basically evolves into RCU anyway, and just
reimplements it ;-( 

Shared global data needs some form of locking, even if "oh we don't
write to that very often, I think we'll get away with it" ;-)

M.
