Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUD1Gze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUD1Gze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbUD1Gze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:55:34 -0400
Received: from esc.ortopedija.lt ([213.190.36.10]:51722 "EHLO
	otc.ortopedija.lt") by vger.kernel.org with ESMTP id S264667AbUD1Gz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:55:28 -0400
Message-ID: <408F5555.3080303@gmc.lt>
Date: Wed, 28 Apr 2004 09:55:17 +0300
From: Aidas Kasparas <a.kasparas@gmc.lt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: lt, en, ru, fr
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: linux-net@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, IPSec, NAT funnies
References: <1083133394.2817.40.camel@mentor.gurulabs.com>
In-Reply-To: <1083133394.2817.40.camel@mentor.gurulabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel bug. IPSec changes ip headers, but fails to say about this to 
conntrack. More information 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=215980
Patch at 
http://bugs.debian.org/cgi-bin/bugreport.cgi/ipsec_conntrack.diff?bug=215980&msg=3&att=1

As a workaround insert rule exemting ipsec traffic from masquerade:

iptables -t nat -I POSTROUTING 1 -p esp -j ACCEPT

Dax Kelson wrote:
> I have a 2.6 box doing IPSec and MASQUERADing that is borking up TCP
> port numbers of .
> 
>                      /======IPSec ESP SA=====\
> [box1]-----------[fw1]-------Internet-------[fw2]-----------[box2]
>      |           /    \                     /     \           |
>     .5    10.1.0.1  StaticRealIP    DHCPRealIP  10.200.1.1  .22
> 
> 
> fw1 = RHEL3 with latest official errata kernel (2.4+2.6ipsec)
> fw2 = Debian Sarge with 2.6.5-2 kernel from unstable
> 
> IKE daemon is identical on both boxes -- current OpenSWAN CVS
> 
> fw1 is SNATing the internal 10.1.0.0/16 network
> fw2 is MASQUERADing the internal 10.200.1.0/24 network
> 
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> 
> box2 sends a SYN packet to box1. It arrives OK at box1.
> 
> source TCP port 33763, destination TCP port 3389
> 
> So far so good.
> 
> box1 sends back a SYN/ACK with TCP source port 3389 destination 32834.
> It leaves fw1 and arrives at fw2 on the external interface (eth0) and
> gets decrypted OK and unmodified.
> 
> Here is the problem.
> 
> When the SYN/ACK packet leaves fw2 out eth1 towards box2 the TCP source
> port has changed from the correct 3389 to the incorrect 1024. Box2
> naturally sends back an ICMP error message--handshake never completes.
> 
> Packet capture details courtesy of tethereal...
> 
> arriving and being decrypted on the fw2 external interface (eth0):
> 
>   0.078883    a.b.c.d  -> w.x.y.z  ESP ESP (SPI=0x3bb63b4f)
>   0.078883    10.1.0.5 -> 10.200.1.22  TCP 3389 > 32834 [SYN, ACK] Seq=0
> Ack=1 Win=65535 Len=0 MSS=1460 WS=0 TSV=0 TSER=0
> 
> leaving the fw2 internal interface (eth1) now borked with the source
> port changed to 1024:
>                                             /-- error here
>  0.229413    10.1.0.5 -> 10.200.1.22  TCP 1024 > 32834 [SYN, ACK] Seq=0
> Ack=1 Win=65535 Len=0 MSS=1460 WS=0 TSV=0 TSER=0
> 
> If I flush the nat table on fw2 then the borkage disappears and the TCP
> connection is properly established. The fw2 nat rule is simply this:
> 
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> 
> Another data point. TCP connections from fw2 itself into the remote
> network are fine.
> 
> Dax Kelson
> Guru Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Aidas Kasparas
IT administrator
GM Consult Group, UAB
