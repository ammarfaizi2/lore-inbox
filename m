Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbRFAGOW>; Fri, 1 Jun 2001 02:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFAGOL>; Fri, 1 Jun 2001 02:14:11 -0400
Received: from crusoe.degler.net ([160.79.55.71]:40711 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S263394AbRFAGOG>;
	Fri, 1 Jun 2001 02:14:06 -0400
Date: Fri, 1 Jun 2001 02:13:58 -0400
From: Stephen Degler <sdegler@degler.net>
To: John William <jw2357@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RECV network performance
Message-ID: <20010601021358.A24567@crusoe.degler.net>
In-Reply-To: <F4YIkTQ81VSaoSJ0vYW0001c0ff@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F4YIkTQ81VSaoSJ0vYW0001c0ff@hotmail.com>; from jw2357@hotmail.com on Mon, May 28, 2001 at 03:47:22AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm guessing that the tulip driver is not setting the chip up correctly.
I've seen this happen with other tulip variants (21143) when tries to
autonegotiate.  if you do an ifconfig eth1 you will see numerous carrier
and crc errors.

Set the tulip_debug flag to 2 or 3 in /etc/modules.conf and see what
gets said.

A newer version of the driver may help you.  You might try the one on
sourceforge.

Also, I've only ever seen full 100BaseT speeds with decent adapters,
like 21143 based tulips, Intel eepros, and vortex/boomerang 3com cards.
A lot of the cheaper controllers just won't get there.

skd

On Mon, May 28, 2001 at 03:47:22AM +0000, John William wrote:
> Can someone please help me troubleshoot this problem - I am getting abysmal 
> (see numbers below) network performance on my system, but the poor 
> performance seems limited to receiving data. Transmission is OK.
> 
> The computer in question is a dual Pentium 90 machine. The machine has 
> RedHat 7.0 (kernel 2.2.16-22 from RedHat). I have compiled 2.2.19 (stock) 
> and 2.4.3 (stock) for the machine and used those for testing. I had a 
> NetGear FA310TX card that I used with the "tulip" driver and a 3Com 3CSOHO 
> card (Hurricane chipset) that I used with the "3c59x" driver. I used the 
> netperf package to test performance (latest version, but I don't have the 
> version number off-hand). The numbers netperf is giving me seem to correlate 
> well to FTP statistics I see to the box.
> 
> I have a second machine (P2-350) with a NetGear FA311 (running 2.4.3 and the 
> "natsemi" driver) that I used to talk with the Pentium 90 machine. The two 
> machines are connected through a NetGear FS105 10/100 switch. I also tried 
> using a 10BT hub (see below).
> 
> When connected, the switch indicated 100 Mbps, full duplex connections to 
> both cards. This matches the speed indicator lights on both cards. I have 
> run the miidiag program in the past to verify that the cards are actually 
> set to full duplex, but I didn't run it again this time (this isn't the 
> first time I have tried to chase this problem down).
> 
> For the purposes of this message, call the P2-350 machine "A" and the dual 
> P-90 machine "B". I ran the following tests:
> 
> Machine "A" to localhost	754.74	Mbps
> 
> Kernel 2.2.19SMP
> Machine "B" to localhost	80.63	Mbps
> Machine "B" to "A" (tulip)	55.38	Mbps
> Machine "A" to "B" (tulip)	10.60	Mbps
> Machine "A" to "B" (3c95x)	12.10	Mbps
> 
> Kernel 2.4.3 SMP
> Machine "B" to localhost	83.87	Mbps
> Machine "B" to "A" (tulip)	68.07	Mbps
> Machine "A" to "B" (tulip)	1.62	Mbps
> Machine "A" to "B" (3c95x)	2.37	Mbps
> 
> Kernel 2.2.16-22 (RedHat kernel)
> Machine "B" to localhost	92.29	Mbps
> Machine "B" to "A" (tulip)	57.34	Mbps
> Machine "A" to "B" (tulip)	9.98	Mbps
> Machine "A" to "B" (3c95x)	9.05	Mbps
> 
> Now, with both "A" and "B" plugged into a 10BT hub:
> 
> Kernel 2.2.19SMP
> Machine "B" to "A" (tulip)	6.96	Mbps
> Machine "A" to "B" (tulip)	6.89	Mbps
> 
> At the end of the runs, I do not see any messages in syslog that would 
> indicate a problem. Using the switch, there were no collisions but looking 
> at /sbin/ifconfig there were a lot of "Frame:" errors on receive. "A lot" 
> means ~30% of the total packets received. This happened with both cards and 
> all kernels.
> 
> The conclusions I draw from this data are:
> 
> 1) Both machines connecting to localhost (data not going out over the wire) 
> give reasonable numbers and are considerably above what I actually see going 
> over the network (as would be expected).
> 2) The P-90 machine seems to have good transmit speed over both cards and 
> all kernels. Transmit performance is close to the localhost numbers, so I 
> can believe them. In the past, I have compared the performance of the FA310 
> to the 3ComSOHO card and there did not seem to be any measurable performance 
> difference between the two.
> 3) Both the FA310 and the 3ComSOHO card have similar receive speeds, leading 
> me to believe that the problem lies with either the machine or the kernel 
> and not the individual cards or drivers.
> 4) Booting the machine as a uni-processor machine (with a non-SMP 2.2.16 
> kernel) did not change anything, so it does not appear to be a problem with 
> SMP.
> 5) Kernel 2.4.3 receive performance is significantly lower than either 2.2.x 
> kernel, so that tends to point to some fundamental problem in the kernel.
> 6) As I understand it, the 3Com card has some hardware acceleration for 
> checksumming, and this is a slow machine, so why is the performance almost 
> identical to the FA310?
> 
> So, my questions are:
> 
> What kind of performance should I be seeing with a P-90 on a 100Mbps 
> connection? I was expecting something in the range of 40-70 Mbps - certainly 
> not 1-2 Mbps.
> 
> What can I do to track this problem down? Has anyone else had problems like 
> this?
> 
> Thanks in advance for any help you can offer.
> 
> - John
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
