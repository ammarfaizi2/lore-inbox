Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWFBMgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWFBMgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWFBMgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:36:04 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:11136 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751393AbWFBMgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:36:02 -0400
Date: Fri, 2 Jun 2006 14:35:59 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
Message-ID: <20060602123559.GA7505@janus>
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus> <447DC613.10102@trash.net> <20060531172936.GB25788@janus> <447DD66C.30605@trash.net> <20060601091124.GA31642@janus> <447F2537.1080807@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447F2537.1080807@trash.net>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 07:34:47PM +0200, Patrick McHardy wrote:
> Frank van Maarseveen wrote:
> > ok, now "tc -s -d qdisc show" says (after noticing missing netconsole
> > packets):
> > 
> > qdisc pfifo_fast 0: dev eth0 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
> >  Sent 155031 bytes 2067 pkt (dropped 0, overlimits 0 requeues 0) 
> >  backlog 0b 0p requeues 0 
> 
> 
> Mhh no dropped packets. I tried to reproduce the problem by changing
> netconsole to always use the dev_queue_xmit path, but works flawlessly
> for me. Please try to find out if the packets are lost before or after
> the qdisc by looking at the packet counter.

qdisc pfifo_fast 0: dev eth0 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
 Sent 155031 bytes 2067 pkt (dropped 0, overlimits 0 requeues 0) 
                   ^^^^

This packet counter increases by 17: the TCP RST plus 16 netconsole
packets which are received. But it should have been 27 (TCP RST plus 26):
10 are missing (I thought 9 but it's 10).

> 
> BTW: You still haven't sent me the packet dump (from the originating
> machine).

tcpdump:

10:50:22.811044 00:12:3f:85:17:52 > 00:08:c7:69:29:ae, ethertype IPv4 (0x0800), length 74: IP espoo.38629 > posio.21212: S 2489079094:2489079094(0) win 5840 <mss 1460,sackOK,timestamp 1359482768 0,nop,wscale 7>
10:50:22.811679 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 54: IP posio.21212 > espoo.38629: R 0:0(0) ack 2489079095 win 0
10:50:22.811731 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 55: IP posio.6665 > espoo.syslog: UDP, length: 13
10:50:22.811738 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 46: IP posio.6665 > espoo.syslog: UDP, length: 4
10:50:22.811745 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811752 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811760 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811766 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811773 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811780 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811787 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811795 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811801 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811809 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811816 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811823 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811830 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
10:50:22.811839 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3

On "espoo" I do a "netcat posio 21212" to trigger the netfilter rule on
posio (there's only 1 rule):

Chain INPUT (policy ACCEPT 2876 packets, 743K bytes)
 pkts bytes target     prot opt in     out     source               destination
    1    60 LOG        tcp  --  *      *       172.17.1.64          0.0.0.0/0           tcp dpt:21212 LOG flags 0 level 4

The netfilter message is sent back via netconsole from "posio" to "espoo"
except for 10 packets. This is a tcpdump done after rebooting "posio"
to 2.6.13.2 showing how it should have looked:

12:28:29.900384 00:12:3f:85:17:52 > 00:08:c7:69:29:ae, ethertype IPv4 (0x0800), length 74: IP espoo.45517 > posio.21212: S 122190451:122190451(0) win 5840 <mss 1460,sackOK,timestamp 1365370072 0,nop,wscale 7>
12:28:29.900939 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 54: IP posio.21212 > espoo.45517: R 0:0(0) ack 122190452 win 0
12:28:29.900995 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 55: IP posio.6665 > espoo.syslog: UDP, length: 13
12:28:29.901026 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 46: IP posio.6665 > espoo.syslog: UDP, length: 4
12:28:29.901055 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901082 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901112 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901158 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901185 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901212 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901238 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901275 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901301 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901308 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901314 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901319 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901326 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901332 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 45: IP posio.6665 > espoo.syslog: UDP, length: 3
12:28:29.901342 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901348 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901354 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901360 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901366 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901372 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901405 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901411 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901418 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33
12:28:29.901423 00:08:c7:69:29:ae > 00:12:3f:85:17:52, ethertype IPv4 (0x0800), length 75: IP posio.6665 > espoo.syslog: UDP, length: 33

I'm unable to get the exact text due to varying packet loss at some
other place right now (verified by running tcpdump at both ends) but
it should be something like this (different machine, different case but
just to give an impression about the formatting):

May 31 10:39:02 sirkka IN=eth0 OUT= 
May 31 10:39:02 sirkka MAC=
May 31 10:39:02 sirkka 00:
May 31 10:39:02 sirkka 60:
May 31 10:39:02 sirkka 97:
May 31 10:39:02 sirkka bc:
May 31 10:39:02 sirkka 4b:
May 31 10:39:02 sirkka a3:
May 31 10:39:02 sirkka 00:
May 31 10:39:02 sirkka 04:
May 31 10:39:02 sirkka 9a:
May 31 10:39:02 sirkka a0:
May 31 10:39:02 sirkka 1d:
May 31 10:39:02 sirkka d1:
May 31 10:39:02 sirkka 08:
May 31 10:39:02 sirkka 00 
May 31 10:39:02 sirkka SRC=172.19.1.4 DST=172.17.1.110 
May 31 10:39:02 sirkka LEN=48 TOS=0x00 PREC=0x00 TTL=126 ID=10359 
May 31 10:39:02 sirkka DF 
May 31 10:39:02 sirkka PROTO=TCP 
May 31 10:39:02 sirkka SPT=1681 DPT=445 
May 31 10:39:02 sirkka WINDOW=64512 
May 31 10:39:02 sirkka RES=0x00 
May 31 10:39:02 sirkka SYN 
May 31 10:39:02 sirkka URGP=0 
May 31 10:39:02 sirkka  

-- 
Frank
