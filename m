Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbRJBRAw>; Tue, 2 Oct 2001 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJBRAm>; Tue, 2 Oct 2001 13:00:42 -0400
Received: from robur.slu.se ([130.238.98.12]:38406 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S275716AbRJBRAc>;
	Tue, 2 Oct 2001 13:00:32 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15289.62283.695135.525478@robur.slu.se>
Date: Tue, 2 Oct 2001 19:03:07 +0200
To: Ben Greear <greearb@candelatech.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, jamal <hadi@cyberus.ca>,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        Robert Olsson <Robert.Olsson@data.slu.se>, Ingo Molnar <mingo@elte.hu>,
        netdev@oss.sgi.com
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BB956D3.AE0FCC54@candelatech.com>
In-Reply-To: <20011001210445.D15341@redhat.com>
	<Pine.GSO.4.30.0110012127410.28105-100000@shell.cyberus.ca>
	<20011002011351.A20025@redhat.com>
	<3BB956D3.AE0FCC54@candelatech.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello!

Jamal mentioned some about the polling efforts for Linux. I can give some
experimental data here with GIGE. Motivation, implantation etc is in paper 
to presented at USENIX Oakland. 

Below a IP forwarding test. Injected 10 Million 64 byte packets into eth0 at 
a speed of 890.000 p/s received and routed and TX:ed on eth1.

PIII @ 933 MHz. Kernel UP 2.4.10 with polling patch the are NIC's e1000 
eth0 (irq=24) and eth1 (irq=26)


Iface   MTU Met  RX-OK RX-ERR RX-DRP RX-OVR  TX-OK TX-ERR TX-DRP TX-OVR Flags
eth0   1500   0 4031309 7803725 7803725 5968699     22      0      0      0 BRU
eth1   1500   0     18      0      0      0 4031305      0      0      0 BRU


The RX-ERR, RX-DRP are bugs from the e1000 driver. Anyway we getting 40% of 
packet storm routed. With a estimated throughput is about 350.000 p/s 

 irq       CPU0       
 24:      80652   IO-APIC-level  e1000
 26:         41   IO-APIC-level  e1000

The for RX (polling) we use only 24 interrupts. TX is mitigated (not polled) 
in this run. We see a lot more interrupts for same amount of packets. I think 
we can actually tune this a bit... And I should also say that RxIntDelay=0
(e1000 driver). So there is no latency before the driver register for polling 
by kernel.

USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND
root         3  3.0  0.0     0     0  ?  SWN  12:51   0:11 (ksoftirqd_CPU0)

The polling (softirq) now handled by ksoftirqd  but I have seen a path from 
Ingo that schedules without the need for ksoftirqd.

Also note that during poll we disable only RX interrupts so all other device
interrupts/functions are handled properly.

And tulip variants of this is in production use and seems very solid. The 
kernel code part holds ANK-trademark. :-)

Cheers.
 
						--ro
