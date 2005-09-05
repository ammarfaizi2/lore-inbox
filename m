Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVIEO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVIEO4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVIEO4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:56:40 -0400
Received: from srv013.carpathiahost.net ([66.117.32.22]:61892 "EHLO
	srv013.carpathiahost.net") by vger.kernel.org with ESMTP
	id S1751292AbVIEO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:56:39 -0400
Message-ID: <431C5CA3.5070004@ubbcluj.ro>
Date: Mon, 05 Sep 2005 17:56:35 +0300
From: Catalin Toda <cata@ubbcluj.ro>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: promisc mode question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I appreciate what you guys are doing here, congratulations for your work.

My question is:
in promiscous mode for an ethernet card, why linux kernel is not 
accepting frames (packets ) that have other mac address diffrent from 
one that is on the card ( or set with ifconfig ). Accepting meaning that 
it can be used in a tcp connection. Anyway after many changes in sysctl 
I see the station is responding to icmp request, even to udp requests, 
but not on tcp ones.

For example:

I have 2 computers in same VLAN, one having the ip address 10.1.0.1 -> 
fatbastard eth1 ( default gw - is not that important) and other one 
10.1.7.101 -> oil eth2 - HWaddr 00:08:54:39:51:AC ( netmask 255.255.0.0 ).
I run those commands:

[root@oil root]# ifconfig eth2 promisc
fatbastard:~# arp -s 10.1.7.101 00:11:22:33:44:55
fatbastard:~# ping 10.1.7.101
PING 10.1.7.101 (10.1.7.101): 56 data bytes
64 bytes from 10.1.7.101: icmp_seq=0 ttl=64 time=1.8 ms

If thru to connect thru udp from fatbastard to oil it is working.
Now:

fatbastard:~#  telnet 10.1.7.101 22
Trying 10.1.7.101...
telnet: Unable to connect to remote host: Connection timed out

in the same time on oil:
[root@oil root]# tcpdump -nei eth2 port 22
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth2, link-type EN10MB (Ethernet), capture size 96 bytes
17:40:44.839443 00:01:02:ac:0d:bb > 00:11:22:33:44:55, ethertype IPv4 
(0x0800), length 74: IP 10.1.0.1.42341 > 10.1.7.101.ssh: S 
3504186617:3504186617(0) win 5840 <mss 1460,sackOK,timestamp 693446023 
0,nop,wscale 2>
17:40:47.840782 00:01:02:ac:0d:bb > 00:11:22:33:44:55, ethertype IPv4 
(0x0800), length 74: IP 10.1.0.1.42341 > 10.1.7.101.ssh: S 
3504186617:3504186617(0) win 5840 <mss 1460,sackOK,timestamp 693449024 
0,nop,wscale 2>
17:40:53.838684 00:01:02:ac:0d:bb > 00:11:22:33:44:55, ethertype IPv4 
(0x0800), length 74: IP 10.1.0.1.42341 > 10.1.7.101.ssh: S 
3504186617:3504186617(0) win 5840 <mss 1460,sackOK,timestamp 693455024 
0,nop,wscale 2>

The strange thing is that I have also an dvb card (skystar2), and if on 
this card I set promisc flag all packets are accepted by the kernel even 
tcp ones.

Can you tell me what can I do that oil to accept tcp packets which have 
destination mac address diffrent from the one on the card ( changing mac 
address is not a solution) ?

I already commented this but without any effect
[root@oil root]# cat /usr/src/linux-2.6.12.5/net/ipv4/ip_input.c | grep 
OTHERHOST -A1
//      if (skb->pkt_type == PACKET_OTHERHOST)
//              goto drop;

(now I am using 2.6.12.5 kernel).

Here is the list with all sysctl related to network:

/proc/sys/net/unix/max_dgram_qlen -> 10
/proc/sys/net/ipv4/ip_conntrack_max -> 8192
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_max_retrans -> 3
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_be_liberal -> 0
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_loose -> 3
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_max_retrans -> 300
/proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid -> 0
/proc/sys/net/ipv4/netfilter/ip_conntrack_generic_timeout -> 600
/proc/sys/net/ipv4/netfilter/ip_conntrack_icmp_timeout -> 30
/proc/sys/net/ipv4/netfilter/ip_conntrack_udp_timeout_stream -> 180
/proc/sys/net/ipv4/netfilter/ip_conntrack_udp_timeout -> 30
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close -> 10
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_time_wait -> 120
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_last_ack -> 30
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_close_wait -> 60
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_fin_wait -> 120
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established -> 432000
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_syn_recv -> 60
/proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_syn_sent -> 120
/proc/sys/net/ipv4/netfilter/ip_conntrack_buckets -> 1024
/proc/sys/net/ipv4/netfilter/ip_conntrack_count -> 89
/proc/sys/net/ipv4/netfilter/ip_conntrack_max -> 8192
/proc/sys/net/ipv4/conf/tap0/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/tap0/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/tap0/disable_policy -> 0
/proc/sys/net/ipv4/conf/tap0/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/tap0/arp_ignore -> 0
/proc/sys/net/ipv4/conf/tap0/arp_announce -> 0
/proc/sys/net/ipv4/conf/tap0/arp_filter -> 0
/proc/sys/net/ipv4/conf/tap0/tag -> 0
/proc/sys/net/ipv4/conf/tap0/log_martians -> 0
/proc/sys/net/ipv4/conf/tap0/bootp_relay -> 0
/proc/sys/net/ipv4/conf/tap0/medium_id -> 0
/proc/sys/net/ipv4/conf/tap0/proxy_arp -> 0
/proc/sys/net/ipv4/conf/tap0/accept_source_route -> 1
/proc/sys/net/ipv4/conf/tap0/send_redirects -> 1
/proc/sys/net/ipv4/conf/tap0/rp_filter -> 0
/proc/sys/net/ipv4/conf/tap0/shared_media -> 1
/proc/sys/net/ipv4/conf/tap0/secure_redirects -> 1
/proc/sys/net/ipv4/conf/tap0/accept_redirects -> 1
/proc/sys/net/ipv4/conf/tap0/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/tap0/forwarding -> 1
/proc/sys/net/ipv4/conf/eth3/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/eth3/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/eth3/disable_policy -> 0
/proc/sys/net/ipv4/conf/eth3/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/eth3/arp_ignore -> 0
/proc/sys/net/ipv4/conf/eth3/arp_announce -> 0
/proc/sys/net/ipv4/conf/eth3/arp_filter -> 0
/proc/sys/net/ipv4/conf/eth3/tag -> 0
/proc/sys/net/ipv4/conf/eth3/log_martians -> 0
/proc/sys/net/ipv4/conf/eth3/bootp_relay -> 0
/proc/sys/net/ipv4/conf/eth3/medium_id -> 0
/proc/sys/net/ipv4/conf/eth3/proxy_arp -> 0
/proc/sys/net/ipv4/conf/eth3/accept_source_route -> 1
/proc/sys/net/ipv4/conf/eth3/send_redirects -> 1
/proc/sys/net/ipv4/conf/eth3/rp_filter -> 0
/proc/sys/net/ipv4/conf/eth3/shared_media -> 1
/proc/sys/net/ipv4/conf/eth3/secure_redirects -> 1
/proc/sys/net/ipv4/conf/eth3/accept_redirects -> 1
/proc/sys/net/ipv4/conf/eth3/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/eth3/forwarding -> 1
/proc/sys/net/ipv4/conf/eth2/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/eth2/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/eth2/disable_policy -> 0
/proc/sys/net/ipv4/conf/eth2/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/eth2/arp_ignore -> 0
/proc/sys/net/ipv4/conf/eth2/arp_announce -> 0
/proc/sys/net/ipv4/conf/eth2/arp_filter -> 0
/proc/sys/net/ipv4/conf/eth2/tag -> 0
/proc/sys/net/ipv4/conf/eth2/log_martians -> 0
/proc/sys/net/ipv4/conf/eth2/bootp_relay -> 0
/proc/sys/net/ipv4/conf/eth2/medium_id -> 0
/proc/sys/net/ipv4/conf/eth2/proxy_arp -> 0
/proc/sys/net/ipv4/conf/eth2/accept_source_route -> 1
/proc/sys/net/ipv4/conf/eth2/send_redirects -> 1
/proc/sys/net/ipv4/conf/eth2/rp_filter -> 0
/proc/sys/net/ipv4/conf/eth2/shared_media -> 1
/proc/sys/net/ipv4/conf/eth2/secure_redirects -> 1
/proc/sys/net/ipv4/conf/eth2/accept_redirects -> 1
/proc/sys/net/ipv4/conf/eth2/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/eth2/forwarding -> 1
/proc/sys/net/ipv4/conf/eth1/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/eth1/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/eth1/disable_policy -> 0
/proc/sys/net/ipv4/conf/eth1/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/eth1/arp_ignore -> 0
/proc/sys/net/ipv4/conf/eth1/arp_announce -> 0
/proc/sys/net/ipv4/conf/eth1/arp_filter -> 0
/proc/sys/net/ipv4/conf/eth1/tag -> 0
/proc/sys/net/ipv4/conf/eth1/log_martians -> 0
/proc/sys/net/ipv4/conf/eth1/bootp_relay -> 0
/proc/sys/net/ipv4/conf/eth1/medium_id -> 0
/proc/sys/net/ipv4/conf/eth1/proxy_arp -> 0
/proc/sys/net/ipv4/conf/eth1/accept_source_route -> 1
/proc/sys/net/ipv4/conf/eth1/send_redirects -> 0
/proc/sys/net/ipv4/conf/eth1/rp_filter -> 0
/proc/sys/net/ipv4/conf/eth1/shared_media -> 1
/proc/sys/net/ipv4/conf/eth1/secure_redirects -> 1
/proc/sys/net/ipv4/conf/eth1/accept_redirects -> 1
/proc/sys/net/ipv4/conf/eth1/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/eth1/forwarding -> 1
/proc/sys/net/ipv4/conf/eth0/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/eth0/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/eth0/disable_policy -> 0
/proc/sys/net/ipv4/conf/eth0/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/eth0/arp_ignore -> 0
/proc/sys/net/ipv4/conf/eth0/arp_announce -> 0
/proc/sys/net/ipv4/conf/eth0/arp_filter -> 0
/proc/sys/net/ipv4/conf/eth0/tag -> 0
/proc/sys/net/ipv4/conf/eth0/log_martians -> 0
/proc/sys/net/ipv4/conf/eth0/bootp_relay -> 0
/proc/sys/net/ipv4/conf/eth0/medium_id -> 0
/proc/sys/net/ipv4/conf/eth0/proxy_arp -> 0
/proc/sys/net/ipv4/conf/eth0/accept_source_route -> 1
/proc/sys/net/ipv4/conf/eth0/send_redirects -> 1
/proc/sys/net/ipv4/conf/eth0/rp_filter -> 0
/proc/sys/net/ipv4/conf/eth0/shared_media -> 1
/proc/sys/net/ipv4/conf/eth0/secure_redirects -> 1
/proc/sys/net/ipv4/conf/eth0/accept_redirects -> 1
/proc/sys/net/ipv4/conf/eth0/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/eth0/forwarding -> 1
/proc/sys/net/ipv4/conf/default/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/default/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/default/disable_policy -> 0
/proc/sys/net/ipv4/conf/default/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/default/arp_ignore -> 0
/proc/sys/net/ipv4/conf/default/arp_announce -> 0
/proc/sys/net/ipv4/conf/default/arp_filter -> 0
/proc/sys/net/ipv4/conf/default/tag -> 0
/proc/sys/net/ipv4/conf/default/log_martians -> 0
/proc/sys/net/ipv4/conf/default/bootp_relay -> 0
/proc/sys/net/ipv4/conf/default/medium_id -> 0
/proc/sys/net/ipv4/conf/default/proxy_arp -> 0
/proc/sys/net/ipv4/conf/default/accept_source_route -> 1
/proc/sys/net/ipv4/conf/default/send_redirects -> 1
/proc/sys/net/ipv4/conf/default/rp_filter -> 0
/proc/sys/net/ipv4/conf/default/shared_media -> 1
/proc/sys/net/ipv4/conf/default/secure_redirects -> 1
/proc/sys/net/ipv4/conf/default/accept_redirects -> 1
/proc/sys/net/ipv4/conf/default/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/default/forwarding -> 1
/proc/sys/net/ipv4/conf/all/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/all/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/all/disable_policy -> 0
/proc/sys/net/ipv4/conf/all/disable_xfrm -> 0
/proc/sys/net/ipv4/conf/all/arp_ignore -> 0
/proc/sys/net/ipv4/conf/all/arp_announce -> 0
/proc/sys/net/ipv4/conf/all/arp_filter -> 0
/proc/sys/net/ipv4/conf/all/tag -> 0
/proc/sys/net/ipv4/conf/all/log_martians -> 0
/proc/sys/net/ipv4/conf/all/bootp_relay -> 0
/proc/sys/net/ipv4/conf/all/medium_id -> 0
/proc/sys/net/ipv4/conf/all/proxy_arp -> 0
/proc/sys/net/ipv4/conf/all/accept_source_route -> 0
/proc/sys/net/ipv4/conf/all/send_redirects -> 1
/proc/sys/net/ipv4/conf/all/rp_filter -> 0
/proc/sys/net/ipv4/conf/all/shared_media -> 1
/proc/sys/net/ipv4/conf/all/secure_redirects -> 1
/proc/sys/net/ipv4/conf/all/accept_redirects -> 0
/proc/sys/net/ipv4/conf/all/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/all/forwarding -> 1
/proc/sys/net/ipv4/conf/lo/promote_secondaries -> 0
/proc/sys/net/ipv4/conf/lo/force_igmp_version -> 0
/proc/sys/net/ipv4/conf/lo/disable_policy -> 1
/proc/sys/net/ipv4/conf/lo/disable_xfrm -> 1
/proc/sys/net/ipv4/conf/lo/arp_ignore -> 0
/proc/sys/net/ipv4/conf/lo/arp_announce -> 0
/proc/sys/net/ipv4/conf/lo/arp_filter -> 0
/proc/sys/net/ipv4/conf/lo/tag -> 0
/proc/sys/net/ipv4/conf/lo/log_martians -> 0
/proc/sys/net/ipv4/conf/lo/bootp_relay -> 0
/proc/sys/net/ipv4/conf/lo/medium_id -> 0
/proc/sys/net/ipv4/conf/lo/proxy_arp -> 0
/proc/sys/net/ipv4/conf/lo/accept_source_route -> 1
/proc/sys/net/ipv4/conf/lo/send_redirects -> 1
/proc/sys/net/ipv4/conf/lo/rp_filter -> 0
/proc/sys/net/ipv4/conf/lo/shared_media -> 1
/proc/sys/net/ipv4/conf/lo/secure_redirects -> 1
/proc/sys/net/ipv4/conf/lo/accept_redirects -> 1
/proc/sys/net/ipv4/conf/lo/mc_forwarding -> 0
/proc/sys/net/ipv4/conf/lo/forwarding -> 1
/proc/sys/net/ipv4/neigh/tap0/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/tap0/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/tap0/locktime -> 99
/proc/sys/net/ipv4/neigh/tap0/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/tap0/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/tap0/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/tap0/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/tap0/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/tap0/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/tap0/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/tap0/retrans_time -> 99
/proc/sys/net/ipv4/neigh/tap0/app_solicit -> 0
/proc/sys/net/ipv4/neigh/tap0/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/tap0/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth3/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/eth3/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/eth3/locktime -> 99
/proc/sys/net/ipv4/neigh/eth3/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/eth3/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/eth3/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/eth3/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/eth3/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/eth3/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/eth3/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/eth3/retrans_time -> 99
/proc/sys/net/ipv4/neigh/eth3/app_solicit -> 0
/proc/sys/net/ipv4/neigh/eth3/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth3/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth2/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/eth2/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/eth2/locktime -> 99
/proc/sys/net/ipv4/neigh/eth2/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/eth2/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/eth2/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/eth2/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/eth2/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/eth2/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/eth2/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/eth2/retrans_time -> 99
/proc/sys/net/ipv4/neigh/eth2/app_solicit -> 0
/proc/sys/net/ipv4/neigh/eth2/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth2/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth1/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/eth1/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/eth1/locktime -> 99
/proc/sys/net/ipv4/neigh/eth1/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/eth1/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/eth1/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/eth1/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/eth1/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/eth1/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/eth1/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/eth1/retrans_time -> 99
/proc/sys/net/ipv4/neigh/eth1/app_solicit -> 0
/proc/sys/net/ipv4/neigh/eth1/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth1/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth0/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/eth0/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/eth0/locktime -> 99
/proc/sys/net/ipv4/neigh/eth0/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/eth0/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/eth0/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/eth0/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/eth0/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/eth0/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/eth0/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/eth0/retrans_time -> 99
/proc/sys/net/ipv4/neigh/eth0/app_solicit -> 0
/proc/sys/net/ipv4/neigh/eth0/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/eth0/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/lo/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/lo/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/lo/locktime -> 99
/proc/sys/net/ipv4/neigh/lo/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/lo/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/lo/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/lo/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/lo/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/lo/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/lo/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/lo/retrans_time -> 99
/proc/sys/net/ipv4/neigh/lo/app_solicit -> 0
/proc/sys/net/ipv4/neigh/lo/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/lo/mcast_solicit -> 3
/proc/sys/net/ipv4/neigh/default/base_reachable_time_ms -> 30000
/proc/sys/net/ipv4/neigh/default/retrans_time_ms -> 1000
/proc/sys/net/ipv4/neigh/default/gc_thresh3 -> 4096
/proc/sys/net/ipv4/neigh/default/gc_thresh2 -> 2048
/proc/sys/net/ipv4/neigh/default/gc_thresh1 -> 1024
/proc/sys/net/ipv4/neigh/default/gc_interval -> 30
/proc/sys/net/ipv4/neigh/default/locktime -> 99
/proc/sys/net/ipv4/neigh/default/proxy_delay -> 79
/proc/sys/net/ipv4/neigh/default/anycast_delay -> 99
/proc/sys/net/ipv4/neigh/default/proxy_qlen -> 64
/proc/sys/net/ipv4/neigh/default/unres_qlen -> 3
/proc/sys/net/ipv4/neigh/default/gc_stale_time -> 60
/proc/sys/net/ipv4/neigh/default/delay_first_probe_time -> 5
/proc/sys/net/ipv4/neigh/default/base_reachable_time -> 30
/proc/sys/net/ipv4/neigh/default/retrans_time -> 99
/proc/sys/net/ipv4/neigh/default/app_solicit -> 0
/proc/sys/net/ipv4/neigh/default/ucast_solicit -> 3
/proc/sys/net/ipv4/neigh/default/mcast_solicit -> 3
/proc/sys/net/ipv4/tcp_bic_beta -> 819
/proc/sys/net/ipv4/tcp_tso_win_divisor -> 8
/proc/sys/net/ipv4/tcp_moderate_rcvbuf -> 1
/proc/sys/net/ipv4/tcp_bic_low_window -> 14
/proc/sys/net/ipv4/tcp_bic_fast_convergence -> 1
/proc/sys/net/ipv4/tcp_bic -> 1
/proc/sys/net/ipv4/tcp_vegas_gamma -> 2
/proc/sys/net/ipv4/tcp_vegas_beta -> 6
/proc/sys/net/ipv4/tcp_vegas_alpha -> 2
/proc/sys/net/ipv4/tcp_vegas_cong_avoid -> 0
/proc/sys/net/ipv4/tcp_westwood -> 0
/proc/sys/net/ipv4/tcp_no_metrics_save -> 0
/proc/sys/net/ipv4/ipfrag_secret_interval -> 600
/proc/sys/net/ipv4/tcp_low_latency -> 0
/proc/sys/net/ipv4/tcp_frto -> 0
/proc/sys/net/ipv4/tcp_tw_reuse -> 0
/proc/sys/net/ipv4/icmp_ratemask -> 6168
/proc/sys/net/ipv4/icmp_ratelimit -> 1000
/proc/sys/net/ipv4/tcp_adv_win_scale -> 2
/proc/sys/net/ipv4/tcp_app_win -> 31
/proc/sys/net/ipv4/tcp_rmem -> 4096     87380   174760
/proc/sys/net/ipv4/tcp_wmem -> 4096     16384   131072
/proc/sys/net/ipv4/tcp_mem -> 6144      8192    12288
/proc/sys/net/ipv4/tcp_dsack -> 1
/proc/sys/net/ipv4/tcp_ecn -> 0
/proc/sys/net/ipv4/tcp_reordering -> 3
/proc/sys/net/ipv4/tcp_fack -> 1
/proc/sys/net/ipv4/tcp_orphan_retries -> 0
/proc/sys/net/ipv4/inet_peer_gc_maxtime -> 120
/proc/sys/net/ipv4/inet_peer_gc_mintime -> 10
/proc/sys/net/ipv4/inet_peer_maxttl -> 600
/proc/sys/net/ipv4/inet_peer_minttl -> 120
/proc/sys/net/ipv4/inet_peer_threshold -> 65664
/proc/sys/net/ipv4/igmp_max_msf -> 10
/proc/sys/net/ipv4/igmp_max_memberships -> 20
/proc/sys/net/ipv4/route/secret_interval -> 600
/proc/sys/net/ipv4/route/min_adv_mss -> 256
/proc/sys/net/ipv4/route/min_pmtu -> 552
/proc/sys/net/ipv4/route/mtu_expires -> 600
/proc/sys/net/ipv4/route/gc_elasticity -> 8
/proc/sys/net/ipv4/route/error_burst -> 5000
/proc/sys/net/ipv4/route/error_cost -> 1000
/proc/sys/net/ipv4/route/redirect_silence -> 20480
/proc/sys/net/ipv4/route/redirect_number -> 9
/proc/sys/net/ipv4/route/redirect_load -> 20
/proc/sys/net/ipv4/route/gc_interval -> 60
/proc/sys/net/ipv4/route/gc_timeout -> 300
/proc/sys/net/ipv4/route/gc_min_interval_ms -> 500
/proc/sys/net/ipv4/route/gc_min_interval -> 0
/proc/sys/net/ipv4/route/max_size -> 16384
/proc/sys/net/ipv4/route/gc_thresh -> 1024
/proc/sys/net/ipv4/route/max_delay -> 10
/proc/sys/net/ipv4/route/min_delay -> 2
/proc/sys/net/ipv4/icmp_errors_use_inbound_ifaddr -> 0
/proc/sys/net/ipv4/icmp_ignore_bogus_error_responses -> 0
/proc/sys/net/ipv4/icmp_echo_ignore_broadcasts -> 0
/proc/sys/net/ipv4/icmp_echo_ignore_all -> 0
/proc/sys/net/ipv4/ip_local_port_range -> 1024  4999
/proc/sys/net/ipv4/tcp_max_syn_backlog -> 256
/proc/sys/net/ipv4/tcp_rfc1337 -> 0
/proc/sys/net/ipv4/tcp_stdurg -> 0
/proc/sys/net/ipv4/tcp_abort_on_overflow -> 0
/proc/sys/net/ipv4/tcp_tw_recycle -> 0
/proc/sys/net/ipv4/tcp_syncookies -> 0
/proc/sys/net/ipv4/tcp_fin_timeout -> 60
/proc/sys/net/ipv4/tcp_retries2 -> 15
/proc/sys/net/ipv4/tcp_retries1 -> 3
/proc/sys/net/ipv4/tcp_keepalive_intvl -> 75
/proc/sys/net/ipv4/tcp_keepalive_probes -> 9
/proc/sys/net/ipv4/tcp_keepalive_time -> 7200
/proc/sys/net/ipv4/ipfrag_time -> 30
/proc/sys/net/ipv4/ip_dynaddr -> 0
/proc/sys/net/ipv4/ipfrag_low_thresh -> 196608
/proc/sys/net/ipv4/ipfrag_high_thresh -> 262144
/proc/sys/net/ipv4/tcp_max_tw_buckets -> 16384
/proc/sys/net/ipv4/tcp_max_orphans -> 8192
/proc/sys/net/ipv4/tcp_synack_retries -> 5
/proc/sys/net/ipv4/tcp_syn_retries -> 5
/proc/sys/net/ipv4/ip_nonlocal_bind -> 0
/proc/sys/net/ipv4/ip_no_pmtu_disc -> 0
/proc/sys/net/ipv4/ip_autoconfig -> 0
/proc/sys/net/ipv4/ip_default_ttl -> 64
/proc/sys/net/ipv4/ip_forward -> 1
/proc/sys/net/ipv4/tcp_retrans_collapse -> 1
/proc/sys/net/ipv4/tcp_sack -> 1
/proc/sys/net/ipv4/tcp_window_scaling -> 1
/proc/sys/net/ipv4/tcp_timestamps -> 1
/proc/sys/net/core/somaxconn -> 128
/proc/sys/net/core/optmem_max -> 10240
/proc/sys/net/core/message_burst -> 10
/proc/sys/net/core/message_cost -> 5
/proc/sys/net/core/mod_cong -> 290
/proc/sys/net/core/lo_cong -> 100
/proc/sys/net/core/no_cong -> 20
/proc/sys/net/core/no_cong_thresh -> 10
/proc/sys/net/core/netdev_max_backlog -> 300
/proc/sys/net/core/dev_weight -> 64
/proc/sys/net/core/rmem_default -> 110592
/proc/sys/net/core/wmem_default -> 110592
/proc/sys/net/core/rmem_max -> 110592
/proc/sys/net/core/wmem_max -> 110592


Thank you
