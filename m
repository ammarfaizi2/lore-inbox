Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTJYNSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 09:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJYNSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 09:18:39 -0400
Received: from 213-187-186-100.dd.nextgentel.com ([213.187.186.100]:34444 "HELO
	tellus.sxdesign.com") by vger.kernel.org with SMTP id S262052AbTJYNSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 09:18:36 -0400
Subject: netfilter: port restricted NAT
From: "Alfred E. Heggestad" <alfredh@sxdesign.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: SX Design
Message-Id: <1067087914.10240.321.camel@tellus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 25 Oct 2003 15:18:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[this question was sent to netfilter mailing list but dropped]

I have a question about restricted NAT vs. port restricted NAT
in the implentation of netfilter in 2.4.18 kernel. We are
developing Voice-over-IP products using SIP for signalling,
where the packets normally go over UDP port 5060.

For VoIP devices located behind NATs we use a protocol called
"STUN - Simple Traversal of UDP Through NATs" (RFC3489) to probe
for public interface ip/ports, and refresh connection tracking
in netfilter for outgoing/incoming RTP streams. The SIP proxies
and/or devices are located on the public network.

This works quite well with most SIP proxies but we have seen some
cases where the response is "lost" in the gateway (linux 2.4.18)
This is the case where the source port of the response is not the
same as destination port of the request. I have looked around in
these files:

  net/ipv4/netfilter/ip_conntrack_proto_udp.c
  net/ipv4/netfilter/ip_nat_proto_udp.c

and it looks like the connection tracker requires the response to
come from the same port as the ougoing request was sent to.

Typical scenario:


-------------------------------------------
[           DEVICE 10.47.11.109           ]
-------------------------------------------
    |
    |
   \/
src: 10.47.11.109:5060
dst: 80.80.80.80.5060
    |
    |
-------------------------------------------
[       GATEWAY 213.187.186.10            ]
-------------------------------------------
    |                                 /\
    |                                  |
   \/                                  |
src: 213.187.186.100:5060     src:80.80.80.80.12345
dst: 80.80.80.80:5060         dst:213.187.186.100:5060
    |                                 /\
    |                                  |
   \/                                  |
-------------------------------------------
[        SIP PROXY 80.80.80.80            ]
-------------------------------------------


The packet is lost in the gateway.

>From RFC3489:

   Restricted Cone: A restricted cone NAT is one where all requests
      from the same internal IP address and port are mapped to the same
      external IP address and port.  Unlike a full cone NAT, an external
      host (with IP address X) can send a packet to the internal host
      only if the internal host had previously sent a packet to IP
      address X.

   Port Restricted Cone: A port restricted cone NAT is like a
      restricted cone NAT, but the restriction includes port numbers.  
      Specifically, an external host can send a packet, with source IP 
      address X and source port P, to the internal host only if the    
      internal host had previously sent a packet to IP address X and   
      port P.


This behaviour I suspect would be close to the "Port Restricted Cone"
definition. My main question is: With netfilter, is it possible at all
to have only "Restricted Cone" with no source port checking and if yes
how is this possible to configure?

I have read through iptables man page and searched www but could not
find any reference to my problem.


For reference, here is the iptables NAT table on my gateway:

root@uranus:~# iptables -t nat -vL
Chain PREROUTING (policy ACCEPT 1762K packets, 285M bytes)
 pkts bytes target     prot opt in     out     source              
destination         

Chain POSTROUTING (policy ACCEPT 833K packets, 209M bytes)
 pkts bytes target     prot opt in     out     source              
destination         
 177K   11M MASQUERADE  all  --  any    eth0    10.47.10.0/24       
anywhere           
 107K   13M SNAT       all  --  any    eth0    anywhere            
anywhere           to:213.187.186.100 

Chain OUTPUT (policy ACCEPT 227K packets, 26M bytes)
 pkts bytes target     prot opt in     out     source              
destination  



Hopefully you are able to understand my question, thanks for any help.

/alfred
