Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbQLNNkv>; Thu, 14 Dec 2000 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbQLNNkm>; Thu, 14 Dec 2000 08:40:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131294AbQLNNkc>;
	Thu, 14 Dec 2000 08:40:32 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141210.eBECAiF06083@flint.arm.linux.org.uk>
Subject: Re: linux ipv6 questions.  bugs?
To: kuznet@ms2.inr.ac.ru
Date: Thu, 14 Dec 2000 12:10:43 +0000 (GMT)
Cc: pete@research.NETsol.COM (Pete Toscano), linux-kernel@vger.kernel.org
In-Reply-To: <200012132027.XAA15957@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Dec 13, 2000 11:27:00 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru writes:
> Your guess? 8) Of course, it is incorrect. I even have no idea
> how it is possible to put system into such sad state.
> Though... probably, you forgot to up loopback.

I've seen exactly the same thing here.  I have ipv6 in -test11 built as
a module, and after the machine has booted, I can ping the ipv4 loopback
address (using normal ping).

When I insert the ipv6 module, I can still ping the ipv4 loopback address
fine, but trying to ping6 the ipv6 loopback address results in the packets
getting lost.

According to the ipv6 SNMP file, the icmp ping echos and ping responses
are sent and received, but ping6 never sees them (strace reveals that
the recvmsg function never returns any data):

sendto(3, "\200\0\0\0l\32\0\0\7\2678:YH\16\0\10\t\n\v\f\r\16\17\20"..., 64, 0, {sin_family=AF_INET6, sin6_port=htons(58), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=htonl(0)}}, 24) = 64
setitimer(ITIMER_REAL, {it_interval={0, 0}, it_value={1, 0}}, NULL) = 0
time(NULL)                              = 976795399
recvmsg(3, 0xbffff9e4, 0)               = ? ERESTARTSYS (To be restarted)--- SIGALRM (Alarm clock) ---

- /proc/net/snmp6 (zero entries removed) -
Ip6InReceives                   	6
Ip6OutRequests                  	6
Icmp6InMsgs                     	6
Icmp6InEchos                    	3
Icmp6InEchoReplies              	3
Icmp6OutMsgs                    	15
Icmp6OutEchoReplies             	3
Icmp6OutRouterSolicits          	8
Icmp6OutNeighborSolicits        	4

So, the ipv6 pings are being sent, they are also being received, but are not
being passed back to ping6.

I'm not well up on ipv6, and crawling the web for information reveals very
little about this, but should I be able to ping6 these link addresses?

eth0      Link encap:Ethernet  HWaddr 08:00:2B:95:1D:7B
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::800:2b95:1d7b/10 Scope:Link
          inet6 addr: fe80::a00:2bff:fe95:1d7b/10 Scope:Link

If yes, I don't seem to be able to:

bash-2.04# ping6 fe80::a00:2bff:fe95:1d7b
connect: Invalid argument
bash-2.04# ping6 fe80::800:2b95:1d7b
connect: Invalid argument

And yes, eth0 is up and running (its a ipv4 root-NFS box so if it wasn't, I
wouldn't be able to run any of these commands). ;)

>From my (probably wrong) understanding, it looks like the Linux ipv6 stack
is really sick in 2.4.0-test11 and probably needs a visit to the local
surgery for a health check.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
