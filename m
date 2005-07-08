Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVGHOe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVGHOe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVGHOe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:34:29 -0400
Received: from p54A09AEC.dip0.t-ipconnect.de ([84.160.154.236]:1524 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262675AbVGHOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:33:00 -0400
Message-ID: <42CE8E96.1040905@trash.net>
Date: Fri, 08 Jul 2005 16:32:54 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
References: <42CE86B5.2080705@gentoo.org>
In-Reply-To: <42CE86B5.2080705@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> When retrying the telnet test, this appears in the logs:
> 
> Jul  8 14:53:04 dsd inv IN=lo OUT=
> MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1
> LEN=40 TOS=0x10 PREC=0x00 TTL=64 ID=15 DF PROTO=TCP SPT=80 DPT=58950 WINDOW=0
> RES=0x00 ACK RST URGP=0
> 
> Does this mean that the kernel thinks its own ACK RST packet is invalid?

I think I know what happens. In 2.6.12 we started dropping the conntrack
reference when a packet leaves IP, so packets on loopback are tracked
twice (LOCAL_OUT/PRE_ROUTING). TCP connection tracking destroys a
conntrack entry when the only reply is an RST. So when the packet is
tracked for the second time in PRE_ROUTING, the conntrack entry can't
be found anymore and the packet is considered invalid.

You could confirm this theory by logging invalid packets in LOCAL_OUT
and in PRE_ROUTING - only PRE_ROUTING should trigger. I'm going to
think about a solution meanwhile.

Regards
Patrick

