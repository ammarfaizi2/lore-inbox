Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274692AbRIYXJs>; Tue, 25 Sep 2001 19:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274695AbRIYXJk>; Tue, 25 Sep 2001 19:09:40 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:36489 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S274692AbRIYXJ0>;
	Tue, 25 Sep 2001 19:09:26 -0400
X-WebMail-UserID: newton
Date: Tue, 25 Sep 2001 20:19:14 -0300
From: Chris Newton <newton@unb.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00003025, 00003442
Subject: FWD: RE: excessive interrupts on network cards
Message-ID: <3BB13A1B@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I checked... and yup, lots of sharing:

  one scsi channel on irq 5, one net card on 5
  one scsi channel on irq 11, one net card (the busy one) on 11

  but..

  I disabled all the serial, parallel ports, and USB, rebooted, and the irq 
sharing cleaned all up..

  Everything now has it's own IRQ...

  However, the problem still exists.  The network card is generating 3 times 
as many interrupts as there are packets recieved on this wire.


[root@phantom bin]# ifconfig eth0;sleep 1;ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:01:02:CC:8C:88
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2024138 errors:0 dropped:0 overruns:1 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:20 Base address:0xd480

eth0      Link encap:Ethernet  HWaddr 00:01:02:CC:8C:88
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2031162 errors:0 dropped:0 overruns:1 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:20 Base address:0xd480


--------------------------
procinfo -D


Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        900988      432032      468956           0        6756      345412
Swap:       449812           0      449812

Bootup: Tue Sep 25 20:00:55 2001    Load average: 0.61 0.67 0.32 1/31 839

user  :       0:00:00.96   9.6%  page in :      756
nice  :       0:00:00.00   0.0%  page out:     1452
system:       0:00:01.29  12.9%  swap in :        0
idle  :       0:00:07.75  77.5%  swap out:        0
uptime:       0:07:54.17         context :    43253

irq  0:       500 timer                 irq 16:       131 eth2
irq  1:         0 keyboard              irq 20:     22266 eth0
irq  2:         0 cascade [4]           irq 21:         0 eth1
irq  6:         0                       irq 30:         0 aic7xxx
irq 12:         0                       irq 31:       121 aic7xxx
irq 14:         0 ide0


------------

Francois Romieu got me to run 'lspci -x', and came to the conclusion that the
net card and scsi card are sharing IRQs...

  Someone just told me tha the had had a sound card and a network card sharing
IRQs, and that caused the network card to generate 'oodles of interrupts for
no apparent reason'.

  This on the right track?

Thanks

Chris

>===== Original Message From Francois Romieu <romieu@cogenit.fr> =====
Chris Newton <newton@unb.ca> :
[...]
> 00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
> 08)
> 00: 86 80 29 12 17 01 90 02 08 00 00 02 08 20 00 00
> 10: 00 20 10 fe c1 ec 00 00 00 00 00 fe 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 9b 00
> 30: 00 00 00 fd dc 00 00 00 00 00 00 00 0b 01 08 38
                                           ^
[...]
> 01:02.0 SCSI storage controller: Adaptec 7899P (rev 01)
> 00: 05 90 cf 00 16 01 b0 02 01 00 00 01 08 20 80 80
> 10: 01 dc 00 00 04 10 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ce 00
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 05 01 28 19
                                           ^
[...]
> 01:02.1 SCSI storage controller: Adaptec 7899P (rev 01)
> 00: 05 90 cf 00 16 01 b0 02 01 00 00 01 08 20 80 80
> 10: 01 d8 00 00 04 00 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ce 00
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 0b 02 28 19
                                           ^
[...]
> 01:06.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
> [Python-T] (rev 78)
> 00: b7 10 05 98 17 01 10 02 78 00 00 02 08 20 00 00
> 10: 81 d4 00 00 00 24 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 05 01 0a 0a
                                           ^
[...]
> 01:08.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
> [Python-T] (rev 78)
> 00: b7 10 05 98 17 01 10 02 78 00 00 02 08 20 00 00
> 10: 01 d4 00 00 00 20 00 f9 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
> 30: 00 00 00 f8 dc 00 00 00 00 00 00 00 0b 01 0a 0a
                                           ^
Each of your ethernet adapter shares an irq with a scsi controller.
I had some results pulling some cards from the PCI slots and moving
the network adapter around until its irq differs but I won't claim
it's the cure for your problem (it was on HP Netserver motherboards).

--
Ueimor

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

