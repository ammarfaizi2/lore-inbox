Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSFKO6G>; Tue, 11 Jun 2002 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSFKO6F>; Tue, 11 Jun 2002 10:58:05 -0400
Received: from pro18.it.dtu.dk ([130.225.76.218]:18852 "EHLO pro18.it.dtu.dk")
	by vger.kernel.org with ESMTP id <S317193AbSFKO6D> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 10:58:03 -0400
Message-ID: <3D060FF6.5000409@fugmann.dhs.org>
Date: Tue, 11 Jun 2002 16:57:58 +0200
From: Anders Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606 Debian/1.0.0-0pre1v1
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bandwidth 'depredation' revisited
In-Reply-To: <3D05EEAF.mailZE11URHZ@viadomus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you start a big download, you actually request a server to send as 
much data as possible to you. Quickly, the packet queues on your ISP's 
side gets filled up. If these queues are big (can hold many packets) you 
will see a rather high latency when trying to retrieve replys, since any 
pakcets (incl. ACK) will need first to enter the queue, and wait for 
their turn to be send to you.

The best solution would be to install some sort of traffic shaping on 
the remove side (you ISP), but that is often(/always) not a possible 
solution.

The second best solution is to simple drop packets comming in too 
quickly from the interface. By this, the sending machine will slow down 
transmission. The idea is to keep the queues at you ISP empty.

To do this you can use ingress scheduler.

Something like:
tc qdisc add dev eth0 handle ffff: ingress
tc filter add dev etc0 parent ffff: protocol ip prio 50 u32 \
         match ip src 0.0.0.0/0 police \
         rate 232kbit burst 10k drop flowid :1

The downside is, that this actually decreases the maximum download 
speed, but you can really feel the difference.

IIRC, All this was explained in the Advanced-Routing howto.
There is an example in it, which sets the ingress scheduler up. You can 
also take a look at the "wonder shaper" at http://lartc.org/wondershaper/.

Regards
Anders Fugmann

DervishD wrote:
>     Hi all :))
> 
>     I've took a look at the documentation related to Traffic Control
> and Class Based Queuing, but all of them seems to deal with upload
> bandwidth, so it won't solve my problem, which is that wget eats all
> my download bandwidth.
> 
>     I know: downlink traffic cannot be shaped and Traffic Control is
> for data WE send. So, am I missing something? Will my problem be solved
> and download bandwidth shared between apps thru Traffic Control or
> will I just get better interactive response?
> 
>     I think that I'm missing something here, but I'm clueless...
> 
>     Thanks in advance :)
> 
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



