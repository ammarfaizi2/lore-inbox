Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVFRT0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVFRT0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFRT0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:26:01 -0400
Received: from [195.55.102.196] ([195.55.102.196]:14234 "EHLO
	mx.aytolacoruna.es") by vger.kernel.org with ESMTP id S262118AbVFRTZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:25:45 -0400
Date: Sat, 18 Jun 2005 21:25:41 +0200
From: Santiago Garcia Mantinan <netfilter-devel@manty.net>
To: Chris Rankin <rankincj@yahoo.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050618192541.GA27439@pul.manty.net>
References: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050618124359.39052.qmail@web52901.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just tried upgrading my firewall to 2.6.12, but neither of the
> following rules in my FORWARD table was allowing return traffic:

This seems to happen only if you use bridge interfaces, as you said it is
something related to connection tracking otherwise netfilter seems to work
ok.

I have sent this right now to the bridge list, I'm copying it here so that
more info is available about this bug.


---------------------------------------------------------------------------
Hi!

As noted by Chris Rankin on a mail to netfilter-devel and to the
linux-kernel mailing list (subject: 2.6.12: connection tracking broken?),
there is a problem with the connection tracking of iptables when one of the
interfaces is a bridge.

On my tests here I have setup a connection between two machines using a real
interface (eth0) and then the same setup using a bridge interface (br0) to
which that interface had been enslaved:

The setup had modules ipt_LOG, ipt_state, ip_conntrack, iptable_filter and
ip_tables loaded, as well as bridge and I loaded a simple set of rules,
exactly the same set each time but changing the interface name, I'll just
write the setup for br0, but the setup was the same one for eth0 with that
little change:

iptables -A INPUT -i br0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i br0 -j LOG --log-level 7 --log-prefix "NOTESTABLISHED "
iptables -A INPUT -i br0 -j DROP

this set of rules with eth0 on them worked ok when I tried to telnet a port
on a remote machine (192.168.0.1) from the local machine (192.168.0.2),
concretelly the test was a telnet to port 22 where the ssh daemon was
listening. However, when I did the same test using the br0 interface, I got
this logged:

NOTESTABLISHED IN=br0 OUT= PHYSIN=eth0
MAC=00:50:ba:54:39:8c:00:48:54:6a:58:90:08:00 SRC=192.168.0.1
DST=192.168.0.2 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=TCP SPT=22
DPT=48448 WINDOW=5792 RES=0x00 ACK SYN URGP=0 

doing a grep for 192.168.0.1 on /proc/net/ip_conntrack* returned nothing,
however netstat showed the connection:
tcp        0      1 192.168.0.2:48448       192.168.0.1:22          SYN_SENT

I believe that iptables works ok execept for the connection tracking, but I
have not tested this fully.

Machines were I tried this were a Pentium III and an AMD K6II both with
kernel 2.6.12, I know this is happening at least from RC5, but at that time
I didn't have the time to check and I thought it was due to the kernel
bridge firewall being loaded, the tests I did today with 2.6.12 final didn't
have the kernel bridge firewall, just normal bridge and normal iptables.

If you need any other info to check this just ask for it.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
