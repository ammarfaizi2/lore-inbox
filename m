Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTAIQKM>; Thu, 9 Jan 2003 11:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTAIQKL>; Thu, 9 Jan 2003 11:10:11 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27590 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266535AbTAIQKF> convert rfc822-to-8bit;
	Thu, 9 Jan 2003 11:10:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] IRQ distribution in the 2.5.52  kernel
Date: Thu, 9 Jan 2003 10:10:26 -0600
User-Agent: KMail/1.4.3
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE51@fmsmsx407.fm.intel.com>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA5CE51@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301091010.26853.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 January 2003 20:50, Kamble, Nitin A wrote:
> Hello All,
>
>   We were looking at the performance impact of the IRQ routing from
> the 2.5.52 Linux kernel. This email includes some of our findings
> about the way the interrupts are getting moved in the 2.5.52 kernel.
> Also there is discussion and a patch for a new implementation. Let
> me know what you think at nitin.a.kamble@intel.com

Nitin,

I got a chance to run the NetBench benchmark with your patch on 2.5.54-mjb2 
kernel.  NetBench measures SMB/CIFS performance by using several SMB clients 
(in this case 44 Windows 2000 systems), sending SMB requests to a Linux 
server running Samba 2.2.3a+sendfile.  Result is in throughput, Mbps.  
Generally the network traffic on the server is 60% recv, 40% tx.  

I believe we have very similar systems.  Mine is a 4 x 1.6 GHz, 1 MB L3 P4 
Xeon with 4 GB DDR memory (3.2 GB/sec I believe).  The chipset is "Summit".  
I also have more than one Intel e1000 adapters.  

I decided to run a few configurations, first with just one adapter, with and 
without HT support in the kernel (acpi=off), then add another adapter and 
test again with/without HT. 

Here are the results:

4P, no HT, 1 x e1000, no kirq:	1214 Mbps, 4% idle
4P, no HT, 1 x e1000, kirq:		1223 Mbps, 4% idle,		+0.74%

I suppose we didn't see much of an improvement here because we never run into 
the situation where more than one interrupt with a high rate is routed to a 
single CPU on irq_balance.  

4P, HT, 1 x e1000, no kirq:	1214 Mbps, 25% idle
4P, HT, 1 x e1000, kirq:	1220 Mbps, 30% idle,			+0.49%

Again, not much of a difference just yet, but lots of idle time.  We may have 
reached the limit at which one logical CPU can process interrupts for an 
e1000 adapter.  There are other things I can probably do to help this, like 
int delay, and NAPI, which I will get to eventually.  

4P, HT, 2 x e1000, no kirq:	1269 Mbps, 23% idle
4P, HT, 2 x e1000, kirq:	1329 Mbps, 18% idle			+4.7%

OK, almost 5% better!  Probably has to do with a couple of things; the fact 
that your code does not route two different interrupts to the same 
core/different logical cpus (quite obvious by looking at /proc/interrupts), 
and that more than one interrupt does not go to the same cpu if possible.  I 
suspect irq_balance did some of those [bad] things some of the time, and we 
observed a bottleneck in int processing that was lower than with kirq. 

I don't think all of the idle time is because of a int processing bottleneck.  
I'm just not sure what it is yet :)  Hopefully something will become obvious 
to me...

Overall I like the way it works, and I believe it can be tweaked to work with 
NUMA when necessary.  I hope to have access to a specweb system on a NUMA box 
soon, so we can verify that.  

-Andrew Theurer










