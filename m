Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbTBNALM>; Thu, 13 Feb 2003 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268152AbTBNALM>; Thu, 13 Feb 2003 19:11:12 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:37589 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268151AbTBNALI>; Thu, 13 Feb 2003 19:11:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Fri, 14 Feb 2003 11:20:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15948.13879.734412.313081@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
In-Reply-To: message from David S. Miller on Thursday February 13
References: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
	<1045120278.5115.0.camel@rth.ninka.net>
	<15947.25922.785515.945307@notabene.cse.unsw.edu.au>
	<20030213.011903.32136660.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 13, davem@redhat.com wrote:
>    From: Neil Brown <neilb@cse.unsw.edu.au>
>    Date: Thu, 13 Feb 2003 20:28:34 +1100
> 
>    On  February 12, davem@redhat.com wrote:
>    > On Wed, 2003-02-12 at 15:18, Neil Brown wrote:
>    > > Is this a bug, or is there some configuration I can change?
>    > 
>    > Specify the correct 'src' parameter in your 'ip' route
>    > command invocations.
>    
>    Thanks... but I think I need a bit more help.
>    
> Sorry, I forgot to add that you need to enable the
> arp_filter sysctl as well to make this work properly.
> 
> It should work once you do this.

Nope...

Maybe I'm not explaining myself well enough.  
So I expermented a bit more and did some "strace"ing, and read some
man pages....

It turns out that the problem occurs when send_msg is used to send a
UDP packet, and the control information contains
              struct in_pktinfo {
                  unsigned int   ipi_ifindex;  /* Interface index */
                  struct in_addr ipi_spec_dst; /* Local address */
                  struct in_addr ipi_addr;     /* Header Destination address */
              };
specifying the address and interface of the message that we are
replying to.
I'll include all the numbers below for completenes, but the brief
description goes:
 Three subnets, A,B,C  all connected by a router.
 Client X on subnet B - default route to router.
 
 Server Y: three interfaces:
     eth0 on A -  default route to router on A
     eth1 on B  ( and so directly connected to client X)
     eth2 on C

 Packet from X to Y:C  (i.e. address of eth2 on Y) goes through router
 to Y.
 Y responds with sendmsg specifying that the incoming packet was on
 eth2 and was addressed to Y:C.

 What *should* (IMO) happen is the response should have Y:C as the
 source address, and that packet should be routed with a preference
 to eth2.  As eth2 in not on B, and there are no known routes to B via
 eth2, the reply should be routed normally: i.e. directly to eth1.

 What *does* happen is that the reply is sent on eth2 as though the
 client X were local to eth2.  i.e. an ARP request is sent to find the
 MAC address, and then the packets is sent to this MAC address.

 It might be reasonable that my *should* case would require
 ip_forwarding begin turned on, but I have ip_forwarding turned on and
 it doesn't help.
 
 In any case the *does* case is wrong because it sends a packet on an
 interface to a neighbour that in known not to be directly attached to
 that interface.

Does that make my situation clearer?

Thanks,

NeilBrown
-------------------------
The numbers: 

On a multi homed host with the following interfaces:

bartok # ./ip address show
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:10:4b:1c:a3:a4 brd ff:ff:ff:ff:ff:ff
    inet 129.94.242.45/24 brd 129.94.242.255 scope global eth0
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:a0:c9:8f:7f:3c brd ff:ff:ff:ff:ff:ff
    inet 129.94.172.12/22 brd 129.94.242.255 scope global eth1
4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:90:27:37:bb:d5 brd ff:ff:ff:ff:ff:ff
    inet 129.94.208.2/22 brd 129.94.242.255 scope global eth2


and the following routes:

bartok # ./ip route show
129.94.232.0/24 via 129.94.172.66 dev eth1 
129.94.242.0/24 dev eth0  proto kernel  scope link  src 129.94.242.45 
129.94.241.0/24 via 129.94.174.2 dev eth1 
129.94.172.0/22 dev eth1  proto kernel  scope link  src 129.94.172.12 
129.94.208.0/22 dev eth2  proto kernel  scope link  src 129.94.208.2 
default via 129.94.242.1 dev eth0 


1/ A TCP SYN/ACK with 
	source 129.94.172.12 dest 129.94.211.194 
  that is in response to a TCP SYN with
	source 129.94.211.194 dest 129.94.172.12
  that arrived on eth1 will be sent directly to
    129.94.211.194 on eth2

  This is what you would expect.

2/ A UDP packet with 
	source 129.94.172.12 dest 129.94.211.194 
   that is sent (sendto) on a newly created and bound
   SOCK_DGRAM socket will be sent directly to
    129.94.211.194 on eth2

   This is also what you would expect.

3/ A UDP packet sent on a newly created unbound
   socket (bound to 0.0.0.0) to 129.94.211.194
   will have

	source 129.94.208.2 dest 129.94.211.194
   and will be sent directly on eth2

   Again as you would expect.

However:

4/ A UDP packet send on an unbound socket (bound to a port but not an
   IP address) to 129.94.211.194, via a sendmsg request with
   in_pktinfo specifing that the incoming packet was recieved on eth1
   and had
	source 129.94.211.194 dest 129.94.172.12
   will have
	source 129.94.172.12 dest 129.94.211.194

   and will be sent directly to 129.94.211.194 ON ETH1

   By 'sent directly' I mean if the arp table has an entry for 
   129.94.211.194 on eth1, it will be sent to that MAC address, and if
   it doesn't an ARP request will be broadcast on eth1 to find an
   appropriate MAC address.

   This is *wrong*.

   I am happy that the source address is 129.94.172.12 in this case
   while in case 3 it is 129.94.208.2.  I am not happy that it
   directly sends to eth1.
