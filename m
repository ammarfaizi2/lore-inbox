Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTDLN2s (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 09:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTDLN2s (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 09:28:48 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:5637 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263268AbTDLN2q (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 09:28:46 -0400
Date: Sat, 12 Apr 2003 15:40:30 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: netfilter-devel@lists.samba.org
Cc: linux-kernel@vger.kernel.org
Subject: BUG somewhere in NAT mechanism [was: my linux box does not learn
 from redirects]
Message-ID: <Pine.LNX.4.51.0304121406180.24111@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was posting linux-kernel about my linux box not learning from icmp
redirects and i was advised to see into my configuration, but today
i found that the problem is within netfilter code.
Here is the scoop:

In a nutshell:
- iptable_nat, _may_ cause the box to ignore icmp redirects (maybe other
  things too)

Host A is in a network where there is router B and router C.
Router B routes to other networks.
Router C routes to the Internet.

Host A's routing entries:
- to its network
- default via router B

When host A with this module loaded communicates with the world,
after some time the rate of icmp redirects from router A for packets to
the Internet rises enormously. Normally the host should react to the first
packet and then send all the packet through the advised router, ie. B.

The way i reproduce this bug:
# insmod ip_tables
# insmod ip_conntrack
# insmod iptable_nat

Now wait some time. After a few minutes i see in iptraf
that ICMP rate is rising, the icmp i get is about 30% of all the TCP
packets sent.

Now i remove the iptable_nat
# rmmod iptable_nat

The rate of icmp suddenly drops, as seen on iptraf stats. The rate is
less than 0.1% of all tcp traffic.

This is a 2.4.20-xfs kernel with the following patch-o-matic patches:
Already applied: submitted/01_2.4.19
                 submitted/02_2.4.20
                 submitted/04_newnat-udp-helper
                 submitted/05_REJECT-fwspotting-phrack60-fix
                 submitted/06_ftp-conntrack-msg-fix
                 submitted/07_ECN-tcpchecksum-littleendian-fix
                 submitted/08_ftp-conntrack-debugftp
                 submitted/08_mangle_input_noroutemeharder
                 submitted/09_icmp-match-all
                 submitted/10_confirm_fix
                 submitted/10_local-nat-expectfn
                 submitted/11_inner-icmp-translation-fix
                 submitted/13_ftp-conntrack-epsv-typo
                 submitted/14_hl-ipv6
                 submitted/15_ahesp6-ipv6
                 submitted/16_frag6-ipv6
                 submitted/17_ipv6header-ipv6
                 submitted/18_opts6-ipv6
                 submitted/19_route6-ipv6
                 submitted/23_REJECT-headroom-tcprst
                 submitted/ipt_ULOG-mac_len-fix
                 submitted/ipt_multiport-invfix
                 pending/06_early_drop-backwards
                 pending/24_conntrack-nosysctl
                 pending/25_natcore-nohelper
                 pending/unused_var
                 base/IPV4OPTSSTRIP
                 base/REJECT-ipv6
                 base/TTL
                 base/fuzzy
                 base/fuzzy6-ipv6
                 base/iplimit
                 base/ipt_unclean-ubit
                 base/ipv4options
                 base/mport
                 base/psd
                 base/quota
                 extra/admin-prohib
                 extra/cuseeme-nat
                 extra/ip_conntrack-timeouts
                 extra/netfilter-docbook
                 extra/string

I can supply any information required to pursue this problem.

Regards,
Maciej Soltysiak

