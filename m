Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNVzv>; Thu, 14 Dec 2000 16:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNVzl>; Thu, 14 Dec 2000 16:55:41 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:38142 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129260AbQLNVzg>; Thu, 14 Dec 2000 16:55:36 -0500
Date: Thu, 14 Dec 2000 16:25:01 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "David S. Miller" <davem@redhat.com>
cc: <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <200012142023.MAA12823@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0012141619330.1107-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just quick feedback.

Test 1:
	Netfilter compiled into kernel. Netfilter configuration options
	as modules. Modules loaded. Using NFS, I got Oops (in fact I've
	never seen an Oops output infinitely before. Maybe it would have
	stopped if I waited.)

Test 2:
	Netfilter compiled into kernel. Netfilter configuration options
	as modules. Modules _NOT_ loaded. Can use NFS just fine. Did a
	couple of 100 MB transfers w/o problems.


I'll continue narrowing it down.


#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
....

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set


MODULES LOADED:
Module                  Size  Used by
ipt_state                800  13 (autoclean)
ipt_tos                  720   6 (autoclean)
ipt_LOG                 3248   4 (autoclean)
iptable_filter          1920   0 (autoclean) (unused)
ipt_MASQUERADE          1808   1
ip_nat_ftp              3520   0 (unused)
ip_conntrack_ftp        2336   0 [ip_nat_ftp]
iptable_nat            17440   1 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           19808   3 [ipt_state ipt_MASQUERADE ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              12320   8 [ipt_state ipt_tos ipt_LOG iptable_filter ipt_MASQUERADE iptable_nat]


On Thu, 14 Dec 2000, David S. Miller wrote:

> Meanwhile for people wanting the crashes to be fixed, please
> apply this patch.
>
> This was _always_ broken, and really what netfilter is doing
> should have never worked.  The only theory I have right now
> is that people using netfilter never had IP fragments timeout.
> :-)
>
> So the patch below restores previous behavior exactly.
> Ie. netfilter sources fragments cannot send ICMP errors
> on frag queue timeout :-)
>
> (The line numbers may be off a bit, but "patch" should still
>  eat it).
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
