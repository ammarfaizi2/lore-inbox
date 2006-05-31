Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWEaJq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWEaJq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEaJq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:46:28 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:61843 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S964930AbWEaJq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:46:27 -0400
Date: Wed, 31 May 2006 11:46:26 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
Message-ID: <20060531094626.GA23156@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two machines named "porvoo" and "espoo". The first one
has netconsole configured to send kernel messages to UDP port 514
(a.k.a. syslog) on the other machine.

Somewhere between 2.6.13.2 and 2.6.17-rc4 there is a regression causing
the netconsole messages which originate from netfilter to be truncated
right after the MAC addresses. For example, /var/log/messages on the
sending machine says:

May 31 09:28:11 porvoo kernel: IN=eth0 OUT= MAC=00:12:3f:85:9f:92:00:04:9a:a0:1d:d1:08:00 SRC=192.168.100.30 DST=172.17.1.113 LEN=60 TOS=0x00 PREC=0x00 TTL=54 ID=51496 DF PROTO=TCP SPT=50868 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0 

but netconsole messages captured in /var/log/messages on the receiving
machine:

May 31 09:28:11 porvoo IN=eth0 OUT= 
May 31 09:28:11 porvoo MAC=
May 31 09:28:11 porvoo 00:
May 31 09:28:11 porvoo 12:
May 31 09:28:11 porvoo 3f:
May 31 09:28:11 porvoo 85:
May 31 09:28:11 porvoo 9f:
May 31 09:28:11 porvoo 92:
May 31 09:28:11 porvoo 00:
May 31 09:28:11 porvoo 04:
May 31 09:28:11 porvoo 9a:
May 31 09:28:11 porvoo a0:
May 31 09:28:11 porvoo 1d:
May 31 09:28:11 porvoo d1:
May 31 09:28:11 porvoo 08:
May 31 09:28:11 porvoo 00 
May 31 09:49:06 espoo -- MARK --

I ran a tcpdump on the sending machine to verify(?) what goes out but in
that case the 2.6.17-rc4 kernel starts to report "protocol 0000 is buggy":

May 31 11:00:49 porvoo kernel: device eth0 entered promiscuous mode
May 31 11:03:31 porvoo kernel: IN=eth0 OUT= MAC=00:12:3f:85:9f:92:00:12:3f:85:17:52:08:00 SRC=172.17.1.64 DST=172.17.1.113 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=60618 DF PROTO=TCP SPT=34984 DPT=21212 WINDOW=5840 RES=0x00 SYN URGP=0
May 31 11:03:31 porvoo kernel: protocol 0000 is buggy, dev eth0
May 31 11:03:31 porvoo last message repeated 9 times

the netconsole output captured on the receiving machine:

May 31 11:00:49 porvoo device eth0 entered promiscuous mode 
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo IN=eth0 OUT= 
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo MAC=
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 00:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 12:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 3f:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 85:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 9f:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 92:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 00:
May 31 11:03:31 porvoo protocol 0000 is buggy, dev eth0 
May 31 11:03:31 porvoo 12:
May 31 11:03:31 porvoo 3f:
May 31 11:03:31 porvoo 85:
May 31 11:03:31 porvoo 17:
May 31 11:03:31 porvoo 52:
May 31 11:03:31 porvoo 08:
May 31 11:03:31 porvoo 00 

again 9 packets are missing and there are 9 "protocol 0000 is buggy"
messages. Netfilter has almost everything configured. IPv6 is left out
everywhere. Above has been produced using this rule on the netconsole
sending machine:

iptables -I INPUT -p tcp -s espoo --dport 21212 -j LOG

-- 
Frank
