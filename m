Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUEQS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUEQS0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUEQS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:26:54 -0400
Received: from fmr02.intel.com ([192.55.52.25]:42960 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262071AbUEQS0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:26:46 -0400
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
From: Len Brown <len.brown@intel.com>
To: Robert Fendt <fendt@physik.uni-dortmund.de>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       James P Ketrenos <james.p.ketrenos@intel.com>
In-Reply-To: <20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	 <1084584998.12352.306.camel@dhcppc4>
	 <20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
Content-Type: text/plain
Organization: 
Message-Id: <1084818282.12349.334.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 May 2004 14:24:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 06:30, Robert Fendt wrote:
> On 14 May 2004 21:36:38 -0400
> Len Brown <len.brown@intel.com> wrote:
> 
> > If the 8139too has statistics counters showing if it gets
> > RX buffer over-runs, that would be interseting to observe.
> 

> a) with 'processor' loaded
> 
> robert@betazed:~$ wget http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
> --12:27:16--  http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
>            => `smgl-i386-2.6.5-20040414.iso.bz2'
> Resolving download.sourcemage.org... 152.2.210.81
> Connecting to download.sourcemage.org[152.2.210.81]:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 142,065,569 [text/plain]
> 
>  0% [                                     ] 202,609        2.30K/s ETA 10:17:41
> 
> 
> robert@betazed:~$ /sbin/ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:0C:6E:8A:DD:BA  
>           inet addr:129.217.168.125  Bcast:129.217.168.255  Mask:255.255.255.0
>           inet6 addr: fe80::20c:6eff:fe8a:ddba/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:933 errors:117 dropped:212 overruns:117 frame:0

BINGO

There may be a way to get more detailed stats out of the driver with
netstat or something, Jeff would know.

>           TX packets:638 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:622241 (607.6 KiB)  TX bytes:54355 (53.0 KiB)
>           Interrupt:5 Base address:0xc800 
> 
> 
> b) without 'processor' loaded
> 
> robert@betazed:~$ wget http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
> --11:29:17--  http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
>            => `smgl-i386-2.6.5-20040414.iso.bz2.2'
> Resolving download.sourcemage.org... 152.2.210.81
> Connecting to download.sourcemage.org[152.2.210.81]:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 142,065,569 [text/plain]
> 
>  3% [=>                                                  ] 5,526,132    514.93K/s
> 
> robert@betazed:~$ /sbin/ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:0C:6E:8A:DD:BA  
>           inet addr:129.217.168.125  Bcast:129.217.168.255  Mask:255.255.255.0
>           inet6 addr: fe80::20c:6eff:fe8a:ddba/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:4187 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2313 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:5904292 (5.6 MiB)  TX bytes:149285 (145.7 KiB)
>           Interrupt:5 Base address:0xc800 
> 
> 
> One additional problem in debugging this is that it seems to be
> depending on the local network topology, since I somehow cannot
> reproduce it when downloading from machines on the LAN or when I have a
> slow downstream connection (e.g. DSL).

Probably something to do with packet arrival time and the ability of the
system to think it is idle.  What topology does it fail with?

> > It would also be interesting to know if you see the problem
> > more frequently when running on battery power, since some
> > systems have higher c-state exit latency when on battery.
> 
> Hmmm, I cannot see a difference between battery and ac. I will look into
> it a bit more, though.

Does
cat /proc/acpi/processor/CPU0/power
show any C3 usage?

This could be either an ACPI issue -- we may enter C3 when there really
isn't enough time to enter and exit C3 w/o thrashing the system; AND/OR
a NIC problem where the driver/device is prone to over-run errors
when the latency to memory is high.

I think we're having a similar problem with the ipw2100.  it would
be interesting if you plugged an e100 into the failing config if
it fails the same way.

-Len


