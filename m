Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267998AbTAIVtP>; Thu, 9 Jan 2003 16:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTAIVtP>; Thu, 9 Jan 2003 16:49:15 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42474 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267998AbTAIVtM> convert rfc822-to-8bit;
	Thu, 9 Jan 2003 16:49:12 -0500
content-class: urn:content-classes:message
Subject: RE: [2.5] IRQ distribution in the 2.5.52  kernel
Date: Thu, 9 Jan 2003 11:52:36 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE59@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.5] IRQ distribution in the 2.5.52  kernel
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK3+s7mtDPOyiPsEdeo8gBQi2jWzAAGOY/g
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Andrew Theurer" <habanero@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <mbligh@aracnet.com>
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 09 Jan 2003 19:52:36.0579 (UTC) FILETIME=[A884B330:01C2B818]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
  Your benchmark results are very impressive. Thanks for trying it out.
I have some thoughts after seeing the results. 
 
> Nitin,
> 
> I got a chance to run the NetBench benchmark with your patch on
2.5.54-
> mjb2
> kernel.  NetBench measures SMB/CIFS performance by using several SMB
> clients
> (in this case 44 Windows 2000 systems), sending SMB requests to a
Linux
> server running Samba 2.2.3a+sendfile.  Result is in throughput, Mbps.
> Generally the network traffic on the server is 60% recv, 40% tx.
> 
> I believe we have very similar systems.  Mine is a 4 x 1.6 GHz, 1 MB
L3 P4
> Xeon with 4 GB DDR memory (3.2 GB/sec I believe).  The chipset is
> "Summit".
> I also have more than one Intel e1000 adapters.
> 
> I decided to run a few configurations, first with just one adapter,
with
> and
> without HT support in the kernel (acpi=off), then add another adapter
and
> test again with/without HT.
> 
> Here are the results:
> 
> 4P, no HT, 1 x e1000, no kirq:	1214 Mbps, 4% idle
> 4P, no HT, 1 x e1000, kirq:		1223 Mbps, 4% idle,
+0.74%
[NK] It is surprising to see single e1000 is giving bandwidth more than
1Gbps. What can be the reason for this extra bandwidth? ... Maybe
compression is happening somewhere.

> 
> I suppose we didn't see much of an improvement here because we never
run
> into
> the situation where more than one interrupt with a high rate is routed
to
> a
> single CPU on irq_balance.
> 
> 4P, HT, 1 x e1000, no kirq:	1214 Mbps, 25% idle
> 4P, HT, 1 x e1000, kirq:	1220 Mbps, 30% idle,
+0.49%
> 
> Again, not much of a difference just yet, but lots of idle time.  We
may
> have
> reached the limit at which one logical CPU can process interrupts for
an
> e1000 adapter.  There are other things I can probably do to help this,
> like
> int delay, and NAPI, which I will get to eventually.
> 
> 4P, HT, 2 x e1000, no kirq:	1269 Mbps, 23% idle
> 4P, HT, 2 x e1000, kirq:	1329 Mbps, 18% idle
+4.7%
[NK] It can be a case that throughput is getting limited by the network
infrastructure or total load of clients. If we know the theoretical
desired maximum throughput then we will get a better idea about the
bottleneck. It would be interesting to see the results, after adding one
more e1000 card to the server.

> 
> OK, almost 5% better!  
[NK] It's a pretty good number!

Probably has to do with a couple of things; the
> fact
> that your code does not route two different interrupts to the same
> core/different logical cpus (quite obvious by looking at
> /proc/interrupts),
> and that more than one interrupt does not go to the same cpu if
possible.
> I
> suspect irq_balance did some of those [bad] things some of the time,
and
> we
> observed a bottleneck in int processing that was lower than with kirq.
> 
> I don't think all of the idle time is because of a int processing
> bottleneck.
> I'm just not sure what it is yet :)  Hopefully something will become
> obvious
> to me...
> 
> Overall I like the way it works, and I believe it can be tweaked to
work
> with
> NUMA when necessary.  
[NK] I also believe so.

I hope to have access to a specweb system on a NUMA
> box
> soon, so we can verify that.
> 
> -Andrew Theurer
[NK] 
Thanks & regards,
Nitin
