Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSFKBtO>; Mon, 10 Jun 2002 21:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFKBtN>; Mon, 10 Jun 2002 21:49:13 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:37614 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S316199AbSFKBtM>; Mon, 10 Jun 2002 21:49:12 -0400
Date: Tue, 11 Jun 2002 09:42:06 +0800 (SGT)
From: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Subject: RE: kernel: svc: bad direction / kernel: svc: short len 4, dropp
In-Reply-To: <XFMail.011005112704.gregory.hosler@eno.ericsson.se>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Reply-to: gregory.hosler@eno.ericsson.se
Message-id: <XFMail.020611094206.gregory.hosler@eno.ericsson.se>
Organization: Ericsson Telecommunications, Pte Ltd
MIME-version: 1.0
X-Mailer: XFMail 1.3 [p0] on Linux
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8bit
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry to reply to myself on such an old matter, but since others have had this
problem, and found me (thru the mailing list archives), I thought it might help
some future poor sole for me to post how I resolved this issue. believe me, the
log files will grind your system to a halt if this problem is left unaddressed.

Note that this problem does not happen in Kernel 2.0 - not sure what the
difference in 2.2 and beyond that makes this happen.

The problem stems from an errant server sending what appears to Linux to be
malformed rpc packets. worse, in my case at least, the packets are being
"broadcast" (i.e. dest address is x.x.x.255). Anyway, this is what I did to
track down the problem, and then to further resolve it (resolution means I
stopped /var from filling up).

The first step is to isolate your host from the local lan, and I mean unplug it
at the router. if the problem goes away, then you probably have the same problem
I have/had. This also means that the source of the problem is from the network,
and not from within your box.

>From this, I learnt that one of the machines on out local lan was (is)
broadcasting it's data to a server on the greater wan. why it is using a
broadcast, instead of a direct IP connection, is beyond me.

What I did was to install a iptables firewall. I set up a chain to log
(several, one for TCP, then one for UDP, etc), with default policy to accept.
then in the input chain, I routed the udp to the udp logger, and the tcp to the
tcp logger. (the separate chains are not really necessary, as you can do the
logging in the INPUT chain, as I later learnt).

your problem host should become self evident with a very short matter of time
of installing the firewall.

you will see your traffic that is causing the scv logging, being logged to your
iptables log (/var/log/messages), and the offending IP will be there (as the
source IP).

You then either track back the IP to the host, or you install a reject/deny
rule against either all traffic, or selected traffic from that host. if you're
feeling kind, you DROP the traffic. If you want to make a point, you REJECT the
traffic (but realize that you're adding traffic to the network, in the form of
reject packets.)

oh, I think (not 100% positive) that if you disable the portmapper the problem
goes away, but generally if you're running portmapped services, you cannot do
that.

Hope that this helps someone else with this problem.

-Greg

On 05-Oct-01 Gregory Hosler wrote:
> Hi,
> 
> I'm running Linux kernel 2.4.7, and I'm seeing the following in my syslog:
> 
> Oct  5 09:13:44 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:45 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:46 camelot kernel: svc: bad direction 525795537, dropping
> request
> Oct  5 09:13:46 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:47 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525861077, dropping
> request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525927291, dropping
> request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525992033, dropping
> request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 526057939, dropping
> request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 526123899, dropping
> request
> Oct  5 09:13:48 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:49 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:49 camelot kernel: svc: bad direction 526189001, dropping
> request
> Oct  5 09:13:50 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:50 camelot kernel: svc: bad direction 526254179, dropping
> request
> 
> several (3 to 5) messages per second.
> 
> I have tracked down these messages to coming out of:
> 
>         /usr/src/linux/net/sunrpc/svc.c
> 
> but I do not understand what's triggering them, or what to do about them.
> 
> any suggestions, pointers, hints appreciated.
> 
> thank you, and regards,
> 
> -Greg
> 
> ----------------------------------
> E-Mail: Gregory Hosler <gregory.hosler@eno.ericsson.se>
> Date: 05-Oct-01
> Time: 11:23:35
> 
>    You can release software that's good, software that's inexpensive, or
>    software that's available on time.  You can usually release software
>    that has 2 of these 3 attributes -- but not all 3.
> 
> ----------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

----------------------------------
E-Mail: Gregory Hosler <gregory.hosler@eno.ericsson.se>
Date: 11-Jun-02
Time: 09:19:02

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.

----------------------------------
