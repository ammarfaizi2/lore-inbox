Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSH1IIa>; Wed, 28 Aug 2002 04:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318761AbSH1IIa>; Wed, 28 Aug 2002 04:08:30 -0400
Received: from elin.scali.no ([62.70.89.10]:14858 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S318760AbSH1II2>;
	Wed, 28 Aug 2002 04:08:28 -0400
Date: Wed, 28 Aug 2002 10:06:19 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: linux-kernel@vger.kernel.org
cc: beowulf@beowulf.org
Subject: Channel bonding GbE (Tigon3)
In-Reply-To: <Pine.LNX.4.44.0208271934180.18659-100000@sp-laptop.isdn.scali.no>
Message-ID: <Pine.LNX.4.44.0208280933250.9999-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for reposting this one guys, but I noticed that my original email 
had no subject (which in some cases doesn't get peoples attention :)

On Tue, 27 Aug 2002, Steffen Persvold wrote:

> Dear list people,
> 
> Lately I've been testing out a couple of Dell PowerEdge 2650 machines. 
> These babies have dual onboard BCM95701A10 NICs (Tigon3 chip) mounted 
> in the same PCI-X 133MHz 64 bit bus.
> 
> Since they have dual onboard GbE, I've been trying to channel bond them 
> using just two crossover cables between two machines. The results I'm 
> seeing is at the first glance very strange. What I see is that the 
> performance when bonded (round robin) is about _half_ (and sometimes even 
> less) compared to just using a single interface. Here are some netpipe-2.4 
> results :
> 
> 64k message size, single interface
>   1:     65536 bytes  190 times -->  760.54 Mbps in 0.000657 sec
> 
> 256k message size, single interface
>   1:    262144 bytes   53 times -->  855.04 Mbps in 0.002339 sec
> 
> 64 message size, both interfaces (using round robin)
>   1:     65536 bytes   65 times -->  257.06 Mbps in 0.001945 sec
> 
> 256k message size, both interfaces (using round robin)
>   1:    262144 bytes   25 times -->  376.01 Mbps in 0.005319 sec
> 
> Looking at the output of netstat -s after a testrun with 256k message 
> size, I see some differences (main items) :
> 
> Single interface :
>  Tcp:
>       0 segments retransmited
> 
>  TcpExt:
>      109616 packets directly queued to recvmsg prequeue.
>      52249581 packets directly received from backlog
>      125694404 packets directly received from prequeue
>      78 packets header predicted
>      124999 packets header predicted and directly queued to user
>      TCPPureAcks: 93
>      TCPHPAcks: 22981
> 
>       
> Bonded interfaces :
>   Tcp:
>       234 segments retransmited
> 
>   TcpExt:
>       1 delayed acks sent
>       Quick ack mode was activated 234 times
>       67087 packets directly queued to recvmsg prequeue.
>       6058227 packets directly received from backlog
>       13276665 packets directly received from prequeue
>       6232 packets header predicted
>       4625 packets header predicted and directly queued to user
>       TCPPureAcks: 25708
>       TCPHPAcks: 4456
> 
> 
> The biggest difference as far as I can see is the 'packtes header 
> predicted', 'packets header predicted and directly queued to user', 
> 'TCPPureAcks' and TCPHPAcks.
> 
> I have an idea that this happens because the packets are comming out of 
> order into the receiving node (i.e the bonding device is alternating 
> between each interface when sending, and when the receiving node gets the 
> packets it is possible that the first interface get packets number 0, 2, 
> 4 and 6 in one interrupt and queues it to the network stack before packet 
> 1, 3, 5 is handled on the other interface).
> 
> If this is the case, any ideas how to fix this...
> 
> I would really love to get 2Gbit/sec on these machines....
> 
> 
> PS
> 
> I've also seen this feature on the Intel GbE cards (e1000), but these 
> drivers has a parameter named RxIntDelay which can be set to 0 to get 
> interrupt for each packet. Is this possible with the tg3 driver too ?
> 
> DS
> 
> Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com | http://www.scali.com
Tel: (+47) 2262 8950 |  Olaf Helsets vei 6
Fax: (+47) 2262 8951 |  N0621 Oslo, NORWAY

