Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHNJmp>; Tue, 14 Aug 2001 05:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbRHNJmg>; Tue, 14 Aug 2001 05:42:36 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:39953 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S268145AbRHNJmW>; Tue, 14 Aug 2001 05:42:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: 3c905b works with 10bt hub - not with 10/100 switch
Date: Tue, 14 Aug 2001 11:42:23 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010814021445.A7454@vitelus.com>
In-Reply-To: <20010814021445.A7454@vitelus.com>
MIME-Version: 1.0
Message-Id: <01081411422301.01754@asterix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so if i understood correctly you did your test only with that 3Com's that
are your eth2@server (3Com PCI 3c905B) resp. eth0@client 
(3Com PCI 3c905B). do you have another 3Com PCI 3c905B? 
exchange one after the other and test again. i'had exactly the same 
with some tulip NIS's when switching from a 10Mb to a 100Mb hub. 
after exchanging one of the tulipNIS's it worked fine.

chris

On Tuesday 14 August 2001 11:14, Aaron Lehmann wrote:
> I've been having major problems on my network as of today.
>
> For the purpose of this explaination, there are two machines: the
> Server and the Client.
>
> The Server has the following network card setup:
>
>
> 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others.
> http://www.scyld.com/network/vortex.html See
> Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c590 Vortex 10Mbps at 0xd800, <6>eth0: Overriding PCI
> latency timer (CFLT) setting of 32, new value is 248. 00:20:af:f8:2d:c4,
> IRQ 11
>   product code 4244 rev 00.0 date 11-06-95
>   32K byte-wide RAM 1:1 Rx:Tx split, autoselect/10baseT interface.
> eth0: scatter/gather disabled. h/w checksums disabled
> PCI: Found IRQ 11 for device 00:0a.0
> IRQ routing conflict in pirq table for device 00:0a.0
> eth1: 3Com PCI 3c905 Boomerang 100baseTx at 0xdc00,  00:60:97:31:d9:bd, IRQ
> 10 product code 4848 rev 00.0 date 11-04-96
>   8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
>   MII transceiver found at address 24, status 782d.
>   Enabling bus-master transmits and whole-frame receives.
> eth1: scatter/gather enabled. h/w checksums disabled
> PCI: Found IRQ 10 for device 00:0b.0
> IRQ routing conflict in pirq table for device 00:0b.0
> eth2: 3Com PCI 3c905B Cyclone 100baseTx at 0xe000,  00:10:4b:79:46:76, IRQ
> 12 product code 4e4b rev 00.9 date 04-17-98
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>   MII transceiver found at address 24, status 786d.
>   Enabling bus-master transmits and whole-frame receives.
> eth2: scatter/gather enabled. h/w checksums enabled
>
> The card we are interested in is eth2. It is what connects the server
> to the segment of the network which I will describe. The server is
> running 2.4.4.
>
> On the client, we have this simpler ethernet configuration:
>
> PCI: Found IRQ 9 for device 00:0f.0
> PCI: Sharing IRQ 9 with 00:03.0
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:0f.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xcc00. Vers LK1.1.16
>
> The Client is running 2.4.8-ac2.
>
> This morning, the connection between these two machines (and a few
> others which were idle or powered down) was a very simple 5 port 10
> base T hub. This makes NFS pretty miserable, which is why I installed
> a CentreCOM FS704 Fast Ethernet switch in place of the hub today. At
> first, it worked great. The machines negotiated full duplex and were
> on the network. I was able to get expected speeds out of the network.
>
> In the late afternoon, I was not at home, but ssh'd into Server. I was
> rather shocked that I could not ping Client. When I got home, the
> first thing I did was investigate this further. When either machine
> tried to ping the other, the correct lights on the hub blinked, but no
> packages were recieved. Shortly after this experimentation, Client
> started complaining about invalid arguments whenever I tried to su and
> proceeded to lock up pretty hard. "Oh well," I thought, "It's was in a
> bad state, but after a reboot it should work." Wrong. After a reboot, the
> pings were still not able to reach each other. Substituting back the
> old slow hub caused things to work perfectly again.
>
> I decided to try forcing a particular mode of duplex. After compiling
> the driver as a module, I tried insmoding it with full_duplex=0 and
> full_duplex=1. This caused even more problems, yielding Tx timeout
> errors on one of them and not working with the other, even with the
> hub. Just then, my scsi0 card tried to reset the scsi bus for no
> apparent reason and locked up the system. I thought to myself "Ah hah,
> Client's 3c905 is sharing an IRQ with scsi1 (NOT scsi0, i had two
> different cards)." To make things simple, I removed scsi1 from the
> system. However, even this didn't help! Now my 3c905 is sharing an IRQ
> with my emu10k1, and it still works fine with the hub but not with the
> switch (BTW: I went back to a compiled-in driver at this point).
>
> This is really, really weird. I'm pretty sure the switch is okay
> because I have two units, and each does the same thing. The odd thing
> is the switch was working fine this morning, when I just installed it.
>
> I would like to have tried a crossover cable between Client and
> Server, but they're over 100 feet apart and I don't have a crossover
> cable that long, nor do I have a double female adaptor that would
> allow me to tack on a crossover cable handy (!@#$ it must be around
> her somewhere!).
>
> Anyway, I'm hoping somebody can shed light on what's going on from the
> perspective of the driver.
>
>
> P.S. I JUST realized that I nearly trashed a 100base T hub for
> displaying essensially the exact behavior as I saw in the switches!
> And similarly, it worked at first and then never worked again,
> although the hub worked for a few months instead of the partial day of
> the switch. And this must have been 6 months to a year ago! Perhaps
> the card in Server or Client is having trouble running correctly at
> 100mbits.
>
> I'd be happy to perform more tests. I'd even give out network access
> as necessary. I just don't want to be stuck at 10mbits!
>
> Uh oh, I'm finding data as I write this post. Well, I hope that's
> alright. At least, I hope nobody minds this weird style.
>
> Anyway, I just brought another machine onto the network. For the sake
> of neutrality, it was an old mac 68k with MacTCP. It only does
> 10megabits, but I don't think that matters -- I'm just trying to
> figure out whether Server or Client's ethernet is dying once on a
> 100mbit network.
>
> And the answer is... Server's! Client can ping Mac on the switch,
> Server can't. So, looks like there are some problems with eth2 in
> Server. That's odd. I'm not getting any interesting messages. At most,
> I'm getting
>
> eth2: Setting full-duplex based on MII #24 link partner capability of 41e1.
>
> when plugging into the switch
>
> and
>
> eth2: Setting half-duplex based on MII #24 link partner capability of 4021.
>
> when connecting to the hub.
>
> So, I suppose this boils down to: is this a driver bug for the 905B
> (eth2 is the only Cyclone I have), or is the card defective? I'll do
> what I can to debug, and try to cooperate with the driver developers,
> but I think I have some eepro cards that are kind of tempting to pop
> in and try.
>
>
> Good luck,
> Aaron Lehmann
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
