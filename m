Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUFVTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUFVTEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265440AbUFVTBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:01:41 -0400
Received: from cpc3-cmbg4-4-0-cust78.cmbg.cable.ntl.com ([81.103.19.78]:11792
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S265244AbUFVS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:57:48 -0400
Message-ID: <40D880FE.6090708@thekelleys.org.uk>
Date: Tue, 22 Jun 2004 19:57:02 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: simon@thekelleys.org.uk
Subject: Oops in dev_get_by_index.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've received a bug-report that dnsmasq 
(http://www.thekelleys.org.uk/dnsmasq) is provoking a kernel Oops and 
I'm posting everything I know about it here in the hope that someone who 
knows the relevant code will be able to see instantly what the problem is.

The Oops looks like this:

CPU:    0
EIP:    0060:[<02237d52>]    Not tainted
EFLAGS: 00010202   (2.6.6-1.435)
EIP is at __dev_get_by_index+0x14/0x2b
eax: 10a64134   ebx: 02cabef8   ecx: 00000006   edx: 00000000
esi: 075ab000   edi: 00008910   ebp: fef735e0   esp: 02cabef0
ds: 007b   es: 007b   ss: 0068
Process dnsmasq (pid: 7524, threadinfo=02cab000 task=0e3f7270)
Stack: 02238e9a 00000000 00000000 00000000 080570eb 0977bdd0 00000006 
fef73608
00ae007e 00b44ffc fef735e0 075ab000 00008910 02266641 02239733 fef735e0
00000008 00000000 11566b80 09774436 000001da 02cabf70 0000000c 0000000c
Call Trace:
   [<02238e9a>] dev_ifname+0x30/0x66
   [<02266641>] udp_ioctl+0x0/0x6e
   [<02239733>] dev_ioctl+0x83/0x283
   [<02266641>] udp_ioctl+0x0/0x6e
   [<0226c323>] inet_ioctl+0x6e/0x73
   [<02232936>] sock_ioctl+0x26d/0x285
   [<0214f7f6>] sys_ioctl+0x1f2/0x224

Code: 0f 18 02 90 2d 34 01 00 00 39 48 34 74 08 85 d2 89 d0 75 ea

This is the kernel part of the ioctl in dnsmasq-2.8/src/forward.c which does

ifr.ifr_ifindex = if_index;
ioctl(fd, SIOCGIFNAME, &ifr)

were the fd is a UDP socket which has had recvmsg called to get the 
datagram and IP_PKTINFO auxiliary data from which the if_index is derived.

The kernel version in question is 2.6.6-1.435 from Fedora.

There's a possibility if IPv6 involvement. The kernel has IPv6 loaded 
and the network interfaces have IPv6 addresses. Under those 
circumstances dnsmasq will bind the IPv6 addresses automatically. I have 
no way of telling if the Oops was as a result of receiving an IPv6 
datagram, but it is unlikely since IPv6 is not in active use.

The Oops happens rarely: there is no known way to reproduce it on demand.

That's all the information  I have: can anybody spot a problem?

Cheers,

Simon.
