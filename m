Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUEEMfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUEEMfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUEEMfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:35:38 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:49473 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264527AbUEEMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:35:34 -0400
Date: Wed, 5 May 2004 14:35:32 +0200
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: linux-kernel@vger.kernel.org
Subject: ne2k-pci uncorrectly detecting collisions ?
Message-ID: <20040505123532.GA3011@blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have experienced problem with the ne2k-pci driver. The symptoms were
extremly poor performance with TCP. After some investigations, I believe
it might be caused by problems with detecting collisions.

I tested with 3 cards :
- eth1 : RTL8029 - not working properly
  the chip says RTL8029, but lspci says RTL8029(AS)
- eth2 : RTL8029AS - working.
- eth3 : RTL8029AS - not working properly
lspci for all three cards :
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8029(AS)

The same problem was experienced on FreeBSD, but it hurts a lot to say
that there wasn't any problem when I tested under Windows - so it's
probably not a broken card problem.

All 3 NICs were in the same box, using the same ne2k-pci driver compiled
as a module (kernel version is 2.4.24). They used the same 10/100 Hub to
talk to the same NIC on the other end. Traffic on the network during the
test was quite low but not nonexistent.

As you can see :
- throughput for eth1 and eth3 with TCP is extremly low.
- throughput with UDP is normal.
- eth1 and eth3 saw no collisions, but eth2 saw a lot.
- eth1 and eth3 saw lots of frame errors, but eth2 saw much less.
 
Here are the detailed test results. I can provide more results if needed.
+ ifconfig eth1 down
+ ifconfig eth2 down
+ ifconfig eth3 down
+ rmmod ne2k-pci
+ modprobe ne2k-pci
+ ifconfig eth1 172.36.1.2
+ ifconfig eth2 172.37.1.2
+ ifconfig eth3 172.38.1.2
+ netperf -H 172.36.1.1 -l 20
TCP STREAM TEST to 172.36.1.1
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

 87380  16384  16384    20.18       0.59   
+ netperf -H 172.37.1.1 -l 20
TCP STREAM TEST to 172.37.1.1
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

 87380  16384  16384    20.04       8.54   
+ netperf -H 172.38.1.1 -l 20
TCP STREAM TEST to 172.38.1.1
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

 87380  16384  16384    20.05       0.56   
+ netperf -t UDP_STREAM -H 172.36.1.1 -l 20 -- -m 1472
UDP UNIDIRECTIONAL SEND TEST to 172.36.1.1
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65535    1472   20.00       16027      0       9.44
 65535           20.00       15216              8.96

+ netperf -t UDP_STREAM -H 172.37.1.1 -l 20 -- -m 1472
UDP UNIDIRECTIONAL SEND TEST to 172.37.1.1
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65535    1472   19.99       15326      0       9.03
 65535           19.99       15326              9.03

+ netperf -t UDP_STREAM -H 172.38.1.1 -l 20 -- -m 1472
UDP UNIDIRECTIONAL SEND TEST to 172.38.1.1
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65535    1472   20.00       16008      0       9.43
 65535           20.00       15593              9.18

+ netstat -i
Table d'interfaces noyau
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
eth0   1500 0    140926      0      0      0  232637      0      0      0 BMRU
eth1   1500 0      1049      0      0      0   17292      0      0      0 BMRU
eth2   1500 0      7421      0      0      0   30134      0      0      0 BMRU
eth3   1500 0       982      0      0      0   17201      0      0      0 BMRU
lo    16436 0     22831      0      0      0   22831      0      0      0 LRU
+ ifconfig eth1
eth1      Lien encap:Ethernet  HWaddr 00:00:E8:D7:E9:46  
          inet adr:172.36.1.2  Bcast:172.36.255.255  Masque:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1049 errors:0 dropped:0 overruns:0 frame:165
          TX packets:17292 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:1000 
          RX bytes:75796 (74.0 KiB)  TX bytes:26148738 (24.9 MiB)
          Interruption:5 Adresse de base:0xd800 

+ ifconfig eth2
eth2      Lien encap:Ethernet  HWaddr 00:E0:7D:75:C2:D7  
          inet adr:172.37.1.2  Bcast:172.37.255.255  Masque:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7421 errors:0 dropped:0 overruns:0 frame:27
          TX packets:30134 errors:0 dropped:0 overruns:0 carrier:0
          collisions:225 lg file transmission:1000 
          RX bytes:491544 (480.0 KiB)  TX bytes:45590838 (43.4 MiB)
          Interruption:9 Adresse de base:0xdc00 

+ ifconfig eth3
eth3      Lien encap:Ethernet  HWaddr 00:00:E8:74:0E:1A  
          inet adr:172.38.1.2  Bcast:172.38.255.255  Masque:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:982 errors:0 dropped:0 overruns:0 frame:147
          TX packets:17201 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:1000 
          RX bytes:71062 (69.3 KiB)  TX bytes:26010052 (24.8 MiB)
          Interruption:11 Adresse de base:0xe000 

Thank you,
-- 
| Lucas Nussbaum
| lucas@lucas-nussbaum.net    lnu@gnu.org    GPG: 1024D/023B3F4F |
| jabber: lucas@linux.ensimag.fr   http://www.lucas-nussbaum.net |
| fingerprint: 075D 010B 80C3 AC68 BD4F B328 DA19 6237 023B 3F4F |
