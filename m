Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVGHOA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVGHOA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVGHOA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:00:27 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:55540 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262668AbVGHN7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:59:12 -0400
Message-ID: <42CE86B5.2080705@gentoo.org>
Date: Fri, 08 Jul 2005 14:59:17 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: 2.6.12 netfilter: local packets marked as invalid
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some Gentoo users have reported very long application startup times in 2.6.12.
This seems to be because the applications are attempting to connect to local
ports such as sunrpc/portmap (where these services are not running), but some
packets are being dropped, so the application load just pauses until the
connection times out.

There was a similar problem reported recently ("2.6.12: connection tracking
broken?"), regarding bridge devices. No bridge devices are involved here.

This is easy to reproduce, and the problem exists on both Linux 2.6.12 and
2.6.13-rc2. This was not a problem on Linux 2.6.11.

Taking a simple configuration:

	# iptables -P INPUT ACCEPT
	# iptables -P OUTPUT ACCEPT
	# iptables -P FORWARD ACCEPT

I don't have a webserver running. If I try and telnet to port 80, I
immediately get connection refused, as expected:

	# telnet 127.0.0.1 80
	Trying 127.0.0.1...
	telnet: connect to address 127.0.0.1: Connection refused

I now add another rule, to drop invalid packets, and retry the telnet connection.

	# iptables -A INPUT -m state --state INVALID -j DROP
	# telnet 127.0.0.1 80
	<very long pause>
	telnet: connect to address 127.0.0.1: Connection timed out

During the pause, netstat reports the connection state as SYN_SENT:

Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      1 localhost:39066         localhost:http          SYN_SENT

I now flush the filter table, and make the kernel log invalid packets:

	# iptables -t filter -F
	#iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "inv "

When retrying the telnet test, this appears in the logs:

Jul  8 14:53:04 dsd inv IN=lo OUT=
MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1
LEN=40 TOS=0x10 PREC=0x00 TTL=64 ID=15 DF PROTO=TCP SPT=80 DPT=58950 WINDOW=0
RES=0x00 ACK RST URGP=0

Does this mean that the kernel thinks its own ACK RST packet is invalid?

There is a Gentoo bug on this here:
http://bugs.gentoo.org/96948
...but I think I got the imporant info into this message.

Let me know if I can provide any more info. For those interested in a
temporary workaround, you can explicitly allow all local traffic, i.e.

	# iptables -A INPUT -i lo -j ACCEPT
	# iptables -A INPUT -m state --state INVALID -j DROP

Thanks.
Daniel
