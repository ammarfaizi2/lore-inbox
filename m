Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267109AbSKXALC>; Sat, 23 Nov 2002 19:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSKXALB>; Sat, 23 Nov 2002 19:11:01 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:2833 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267109AbSKXAK7>; Sat, 23 Nov 2002 19:10:59 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB19A6@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Steffen Persvold'" <sp@scali.com>, linux-kernel@vger.kernel.org
Subject: RE: Intel GbE performance on E7500
Date: Sat, 23 Nov 2002 16:17:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have used the P4DPE version of the E7500 motherboard and I have used both
82544GC/82546EB. However, I have used netperf to benchmark the numbers and
used the 4.3.2 version of the driver. Actually, I have also used the 4.3.15
version of the driver.

I have noticed pretty consistent performance. Can you send the kernel log
messages (dmesg)? Also, look at the statistics for the NICs in
/proc/net/PRO_Lan_adapters/eth*.info and see if you find anything
interesting. 

-----Original Message-----
From: Steffen Persvold [mailto:sp@scali.com]
Sent: Saturday, November 23, 2002 4:02 PM
To: linux-kernel@vger.kernel.org; linux.nics@intel.com
Subject: Intel GbE performance on E7500


Hi all,

Lately I've been playing with Intel Gigabit adapters on two SuperMicro 
P4DPR-6GM+ motherboards which have the Intel E7500 chipset and one 
onboard Intel 82544GC Gigabit Ethernet controller (and other features). 
I've also put in a Intel 82546EB Dual Gigabit Ethernet controller as a 
add-in card in the 100MHz PCI-X slot (64bit). I've been experiencing 
some (IMHO) wierd behavior, and come to you guys for advice.

As some of you may know the E7500 chipset has a Hub design. On these 
particular motherboards there is a memory controller (the MCH) and one 
P64H2 PCI-X bridge (and also a south bridge of course). The P64H2 has two 
PCI-X busses where one is dedicated to onboard devices (where the 
82544GC sits) and the other to the PCI-X slot (where the 82546EB dual card 
sits). The onboard bus runs in PCI mode at 66 MHz (because of the 
SCSI controller I guess) wheras the external bus runs in PCI-X mode. The 
P64H2 is connected to the MCH with a 1Gbyte/sec Hub-Link.

These boxes run the 2.4.20-rc2 kernel which uses the 4.4.12-k1 e1000 
driver (no special options). They are connected back-to-back with 
crossover cables (the oboard devices are connected together and the 
external devices are connected together). I'm using standard MTU, 1500 
bytes.

When I run netpipe-2.4 on these devices to benchmark some latencies and 
stuff, I get very different results. First I test one of the external 
devices (eth1 which is one of the 82546EB devices) :

Latency: 0.000123
Now starting main loop
  0:         1 bytes 2037 times -->    0.06 Mbps in 0.000123 sec
  1:         2 bytes 2025 times -->    0.12 Mbps in 0.000125 sec
  2:         3 bytes 2001 times -->    0.18 Mbps in 0.000125 sec
  3:         4 bytes 1334 times -->    0.24 Mbps in 0.000125 sec
  4:         6 bytes 1501 times -->    0.37 Mbps in 0.000125 sec
  5:         8 bytes 1001 times -->    0.49 Mbps in 0.000125 sec
  6:        12 bytes 1251 times -->    0.73 Mbps in 0.000125 sec
  7:        13 bytes  834 times -->    0.97 Mbps in 0.000102 sec
  8:        16 bytes 1126 times -->    1.79 Mbps in 0.000068 sec
  9:        19 bytes 2066 times -->    2.31 Mbps in 0.000063 sec
 10:        21 bytes 2519 times -->    2.56 Mbps in 0.000063 sec
 11:        24 bytes 2664 times -->    2.93 Mbps in 0.000063 sec

I interrupt the test and start over :

Latency: 0.000063
Now starting main loop
  0:         1 bytes 3983 times -->    0.12 Mbps in 0.000063 sec
  1:         2 bytes 3991 times -->    0.24 Mbps in 0.000063 sec
  2:         3 bytes 3990 times -->    0.36 Mbps in 0.000063 sec
  3:         4 bytes 2654 times -->    0.49 Mbps in 0.000063 sec
  4:         6 bytes 2987 times -->    0.73 Mbps in 0.000063 sec
  5:         8 bytes 1987 times -->    0.97 Mbps in 0.000063 sec
  6:        12 bytes 2485 times -->    1.37 Mbps in 0.000067 sec
  7:        13 bytes 1562 times -->    0.79 Mbps in 0.000125 sec
  8:        16 bytes  924 times -->    0.98 Mbps in 0.000125 sec
  9:        19 bytes 1125 times -->    1.16 Mbps in 0.000125 sec
 10:        21 bytes 1264 times -->    1.28 Mbps in 0.000125 sec
 11:        24 bytes 1334 times -->    1.47 Mbps in 0.000125 sec


Ok, so I think this must be some of the "interrupt coalescing" logic which 
is interferring (netpipe is by default ping-pong traffic). So I test the 
other 82546EB device (eth2), same result.

_But_ (and here is the point) when I test the onboard 82544GC device I get 
a very different result :

Latency: 0.000030
Now starting main loop
  0:         1 bytes 8208 times -->    0.27 Mbps in 0.000028 sec
  1:         2 bytes 8876 times -->    0.54 Mbps in 0.000028 sec
  2:         3 bytes 8927 times -->    0.82 Mbps in 0.000028 sec
  3:         4 bytes 5981 times -->    1.10 Mbps in 0.000028 sec
  4:         6 bytes 6785 times -->    1.66 Mbps in 0.000028 sec
  5:         8 bytes 4523 times -->    2.21 Mbps in 0.000028 sec
  6:        12 bytes 5659 times -->    3.31 Mbps in 0.000028 sec
  7:        13 bytes 3761 times -->    3.50 Mbps in 0.000028 sec
  8:        16 bytes 4071 times -->    4.39 Mbps in 0.000028 sec
  9:        19 bytes 5057 times -->    5.17 Mbps in 0.000028 sec
 10:        21 bytes 5634 times -->    5.32 Mbps in 0.000030 sec
 11:        24 bytes 5537 times -->    6.46 Mbps in 0.000028 sec


It has _half_ the latency of the other devices, _and_ it is consistent 
(i.e not bouncing up and down). When I test them with large messages (for 
bandwidth) they all perform equally.

What could be the reason for this rather large latency difference ? 

I would appreciate any input, and would be happy to test out other 
versions of the driver (although I don't think this is a driver issue).

PS:

I must admit, less than 30us latency with an interrupt driven technology 
is very impressive (I know there are other GbE devices which acheives this 
too).

DS

 Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
