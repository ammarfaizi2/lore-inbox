Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263853AbSJHVB7>; Tue, 8 Oct 2002 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbSJHVB7>; Tue, 8 Oct 2002 17:01:59 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:28146 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S263853AbSJHVB5>; Tue, 8 Oct 2002 17:01:57 -0400
Message-ID: <3DA348EF.7060709@drugphish.ch>
Date: Tue, 08 Oct 2002 23:06:55 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Renold <martinxyz@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] tcp connection tracking 2.4.19
References: <20021008205053.GA2621@old.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

> There is a bug in the stable 2.4.19 kernel in the ip_conntrack code that
> allows the final ACK of a SYN - SYN/ACK - ACK tcp handshake to establish
> an ASSURED connection even if it has a wrong sequence number. The current
> code only checks the ACK number.

Yes, and more than that. You can remove ESTABLISHED entries in the 
conntrack table by sending packets with the RST flag set and matching 
the template <srcIP, srcPORT, dstIP, dstPORT>.

> This allows a DoS attack that will make it impossible to establish *real*
> connections for some days, once the maximum is reached. Somebody sent me
> an exploit:

:) You should probably send stuff like that to the netfilter-devel ml. 
Besides that it isn't really an exploit.

> http://old.homeip.net/martin/cdos.tgz
> 
> So I wrote a simple patch against 2.4.19, but I must admit that I do not
> really understand the code around it, especially why it does not mark
> such a packet as invalid (I'm new to most things here).

You might want to take a look at the TCP window tracking patch which 
comes with the latest pom. It's part of the extra patches. This will 
solve the problems for you.

> diff -urN -X dontdiff kernel-source-2.4.19.origin/net/ipv4/netfilter/ip_conntrack_proto_tcp.c kernel-source-2.4.19.patch/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
> --- kernel-source-2.4.19.origin/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Fri Oct  4 08:13:38 2002
> +++ kernel-source-2.4.19.patch/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Sat Oct  5 20:45:49 2002
> @@ -180,6 +180,8 @@
>  	if (oldtcpstate == TCP_CONNTRACK_SYN_SENT
>  	    && CTINFO2DIR(ctinfo) == IP_CT_DIR_REPLY
>  	    && tcph->syn && tcph->ack)
> +		conntrack->proto.tcp.handshake_seq
> +			= tcph->ack_seq;
>  		conntrack->proto.tcp.handshake_ack
>  			= htonl(ntohl(tcph->seq) + 1);
>  	WRITE_UNLOCK(&tcp_lock);
> @@ -196,6 +198,7 @@
>  		if (oldtcpstate == TCP_CONNTRACK_SYN_RECV
>  		    && CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL
>  		    && tcph->ack && !tcph->syn
> +		    && tcph->seq == conntrack->proto.tcp.handshake_seq
>  		    && tcph->ack_seq == conntrack->proto.tcp.handshake_ack)
>  			set_bit(IPS_ASSURED_BIT, &conntrack->status);
>  

Welcome to the world of almost-stateful packet filtering. Hey, other 
than that, the 3wahas 'exploit' is old. Also don't I understand why they 
claim that SYN cookies prevent syn flooding. Next time you meet someone 
of the guys, tell them about the backlog queue.

Cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

