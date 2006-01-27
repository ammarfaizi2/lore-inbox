Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWA0GJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWA0GJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWA0GJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:09:36 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:15821 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750750AbWA0GJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:09:35 -0500
Message-ID: <43D9B8A6.5020200@t-online.de>
Date: Fri, 27 Jan 2006 07:07:34 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au>
In-Reply-To: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080001010902080100020702"
X-ID: EG5XE+ZSweBgMuG6j3mdK8fXR+8Ff4N2EXT2it+ZmXYS6xdVQneurv@t-dialin.net
X-TOI-MSGID: 6440feda-114d-41d4-b940-57b71455d104
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080001010902080100020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

* Herbert Xu wrote:

>Does the problem go away if you disable conntrack by unloading its module?
>
>Please try to capture the offending ICMP packet with tcpdump and show us
>what it looks like.
>  
>
Well, there are no problems if SuSEfirewall2 is disabled. But have a look
at the loaded modules:

ipt_MASQUERADE          3968  1
pppoe                  15360  2
pppox                   4616  1 pppoe
af_packet              23240  2
ppp_generic            30740  6 pppoe,pppox
slhc                    7040  1 ppp_generic
ipt_TOS                 2816  28
ipt_TCPMSS              4800  2
ipt_LOG                 7232  55
ipt_limit               2880  55
ipt_pkttype             1984  4
ipt_state               2240  46
ip6t_LOG                8000  1
ip6t_limit              3008  1
ip6t_REJECT             5824  3
ipt_REJECT              5952  3
iptable_mangle          3200  1
iptable_nat             8836  1
iptable_filter          3264  1
ip6table_mangle         2752  0
ip_nat_ftp              3776  0
ip_nat                 18284  3 ipt_MASQUERADE,iptable_nat,ip_nat_ftp
ip_conntrack_ftp        8240  1 ip_nat_ftp
ip_conntrack           51020  6 
ipt_MASQUERADE,ipt_state,iptable_nat,ip_nat_ftp,ip_nat,ip_conntrack_ftp
ip_tables              24088  11 
ipt_MASQUERADE,ipt_TOS,ipt_TCPMSS,ipt_LOG,ipt_limit,ipt_pkttype,ipt_state,ipt_REJECT,iptable_mangle,iptable_nat,iptable_filter
ip6table_filter         3136  1
ip6_tables             25624  5 
ip6t_LOG,ip6t_limit,ip6t_REJECT,ip6table_mangle,ip6table_filter
ipv6                  271712  14 ip6t_REJECT

How should I unload ip_conntrack alone?

* Stephen Hemminger wrote:

>Does it always show up on icmp only?
>
>What are the iptables rules (iptables -L)
>
>  
>

As far as I can see, all my sky2 problems are gone with -K rx off.

So here is more information. I executed the following script:

logger Starting test
logger "Executing ethtool -K eth0 rx off"
ethtool -K eth0 rx off
logger "Executing tcpdump -i eth0 -vv > tcpdumpfile &"
tcpdump -i eth0 -vv > tcpdumpfile &
logger "Executing host www.suse.com"
host www.suse.com
logger "Sleeping 2 seconds"
sleep 2 
logger "Executing ping -c 2 195.135.220.3"
ping -c 2 195.135.220.3
logger "Sleeping 2 seconds"
sleep 2
logger "Executing ethtool -K eth0 rx on"
ethtool -K eth0 rx on
logger "Sleeping 2 seconds"
sleep 2 
logger "Executing host www.suse.com"
host www.suse.com
logger "Sleeping 2 seconds"
sleep 2 
logger "Executing ping -c 2 195.135.220.3"
ping -c 2 195.135.220.3
logger "Sleeping 2 seconds"
sleep 2 
logger "Executing ethtool -K eth0 rx off"
ethtool -K eth0 rx off
logger "Sleeping 2 seconds"
sleep 2 
logger "killall tcpdump"
killall tcpdump
logger End of test


The first host and ping worked fine, after the ethtool -K eth0 rx on
the host www.suse.com timed out  with

   ;; connection timed out; no servers could be reached

and the ping 195.135.220.3 provoked the stack traces you see in sky2syslog.

I attach the syslog for the time of the test, the output of iptables -L 
and the
output of tcpdump as the very long lines included would be hard to read
with linebreaks.

No, I did _not_ delete anything from the tcpdump file.

cu,
 Knut



--------------080001010902080100020702
Content-Type: text/plain;
 name="sky2syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sky2syslog"

Jan 27 06:29:38 linux knut: Starting test
Jan 27 06:29:38 linux knut: Executing ethtool -K eth0 rx off
Jan 27 06:29:38 linux knut: Executing tcpdump -i eth0 -vv > tcpdumpfile &
Jan 27 06:29:38 linux knut: Executing host www.suse.com
Jan 27 06:29:38 linux kernel: [  403.606906] device eth0 entered promiscuous mode
Jan 27 06:29:38 linux knut: Sleeping 2 seconds
Jan 27 06:29:40 linux knut: Executing ping -c 2 195.135.220.3
Jan 27 06:29:41 linux dhcpd: icmp.c(274): trace_write_packet with null trace type
Jan 27 06:29:42 linux dhcpd: icmp.c(274): trace_write_packet with null trace type
Jan 27 06:29:42 linux knut: Sleeping 2 seconds
Jan 27 06:29:44 linux knut: Executing ethtool -K eth0 rx on
Jan 27 06:29:44 linux knut: Sleeping 2 seconds
Jan 27 06:29:46 linux knut: Executing host www.suse.com
Jan 27 06:29:46 linux kernel: [  406.693484] SFW2-INext-DROP-DEFLT-INV IN=dsl0 OUT= MAC= SRC=217.237.150.33 DST=84.171.112.100 LEN=74 TOS=0x10 PREC=0x00 TTL=57 ID=53333 PROTO=UDP SPT=53 DPT=1076 LEN=54
Jan 27 06:29:47 linux kernel: [  407.125112] SFW2-INext-DROP-DEFLT-INV IN=dsl0 OUT= MAC= SRC=217.237.150.33 DST=84.171.112.100 LEN=116 TOS=0x10 PREC=0x00 TTL=57 ID=24213 PROTO=UDP SPT=53 DPT=1078 LEN=96
Jan 27 06:29:58 linux knut: Sleeping 2 seconds
Jan 27 06:30:00 linux knut: Executing ping -c 2 195.135.220.3
Jan 27 06:30:00 linux kernel: [  412.693613] dsl0: hw csum failure.
Jan 27 06:30:00 linux kernel: [  412.693615]  [<c0104007>] dump_stack+0x17/0x20
Jan 27 06:30:00 linux kernel: [  412.693628]  [<c03b2961>] netdev_rx_csum_fault+0x31/0x40
Jan 27 06:30:00 linux kernel: [  412.693632]  [<c03b00ea>] __skb_checksum_complete+0x5a/0x60
Jan 27 06:30:00 linux kernel: [  412.693635]  [<f88d892e>] icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 27 06:30:00 linux kernel: [  412.693644]  [<f88d5d82>] ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 27 06:30:00 linux kernel: [  412.693651]  [<c03c7347>] nf_iterate+0x57/0x90
Jan 27 06:30:00 linux kernel: [  412.693654]  [<c03c73e5>] nf_hook_slow+0x65/0x120
Jan 27 06:30:00 linux kernel: [  412.693657]  [<c03cdc76>] ip_rcv+0x286/0x510
Jan 27 06:30:00 linux kernel: [  412.693660]  [<c03b31a5>] netif_receive_skb+0x165/0x1c0
Jan 27 06:30:00 linux kernel: [  412.693663]  [<c03b3287>] process_backlog+0x87/0x110
Jan 27 06:30:00 linux kernel: [  412.693665]  [<c03b33bf>] net_rx_action+0xaf/0x100
Jan 27 06:30:00 linux kernel: [  412.693668]  [<c01232d5>] __do_softirq+0x55/0xb0
Jan 27 06:30:00 linux kernel: [  412.693671]  [<c0123363>] do_softirq+0x33/0x40
Jan 27 06:30:00 linux kernel: [  412.693674]  [<c0123453>] irq_exit+0x43/0x50
Jan 27 06:30:00 linux kernel: [  412.693676]  [<c0105218>] do_IRQ+0x38/0x70
Jan 27 06:30:00 linux kernel: [  412.693679]  [<c0103baa>] common_interrupt+0x1a/0x20
Jan 27 06:30:00 linux kernel: [  412.693682]  [<c0101147>] cpu_idle+0x87/0x90
Jan 27 06:30:00 linux kernel: [  412.693684]  [<c0100257>] rest_init+0x37/0x40
Jan 27 06:30:00 linux kernel: [  412.693686]  [<c055e845>] start_kernel+0x195/0x1e0
Jan 27 06:30:00 linux kernel: [  412.693690]  [<c0100199>] 0xc0100199
Jan 27 06:30:00 linux dhcpd: icmp.c(274): trace_write_packet with null trace type
Jan 27 06:30:01 linux kernel: [  413.121225] dsl0: hw csum failure.
Jan 27 06:30:01 linux kernel: [  413.121227]  [<c0104007>] dump_stack+0x17/0x20
Jan 27 06:30:01 linux kernel: [  413.121236]  [<c03b2961>] netdev_rx_csum_fault+0x31/0x40
Jan 27 06:30:01 linux kernel: [  413.121240]  [<c03b00ea>] __skb_checksum_complete+0x5a/0x60
Jan 27 06:30:01 linux kernel: [  413.121242]  [<f88d892e>] icmp_error+0x10e/0x1e0 [ip_conntrack]
Jan 27 06:30:01 linux kernel: [  413.121252]  [<f88d5d82>] ip_conntrack_in+0x72/0x240 [ip_conntrack]
Jan 27 06:30:01 linux kernel: [  413.121258]  [<c03c7347>] nf_iterate+0x57/0x90
Jan 27 06:30:01 linux kernel: [  413.121261]  [<c03c73e5>] nf_hook_slow+0x65/0x120
Jan 27 06:30:01 linux kernel: [  413.121264]  [<c03cdc76>] ip_rcv+0x286/0x510
Jan 27 06:30:01 linux kernel: [  413.121267]  [<c03b31a5>] netif_receive_skb+0x165/0x1c0
Jan 27 06:30:01 linux kernel: [  413.121270]  [<c03b3287>] process_backlog+0x87/0x110
Jan 27 06:30:01 linux kernel: [  413.121272]  [<c03b33bf>] net_rx_action+0xaf/0x100
Jan 27 06:30:01 linux knut: Sleeping 2 seconds
Jan 27 06:30:01 linux kernel: [  413.121275]  [<c01232d5>] __do_softirq+0x55/0xb0
Jan 27 06:30:01 linux kernel: [  413.121278]  [<c0123363>] do_softirq+0x33/0x40
Jan 27 06:30:01 linux kernel: [  413.121281]  [<c0123453>] irq_exit+0x43/0x50
Jan 27 06:30:01 linux kernel: [  413.121283]  [<c0105218>] do_IRQ+0x38/0x70
Jan 27 06:30:01 linux kernel: [  413.121286]  [<c0103baa>] common_interrupt+0x1a/0x20
Jan 27 06:30:01 linux kernel: [  413.121288]  [<c0101147>] cpu_idle+0x87/0x90
Jan 27 06:30:01 linux kernel: [  413.121291]  [<c0100257>] rest_init+0x37/0x40
Jan 27 06:30:01 linux kernel: [  413.121293]  [<c055e845>] start_kernel+0x195/0x1e0
Jan 27 06:30:01 linux kernel: [  413.121296]  [<c0100199>] 0xc0100199
Jan 27 06:30:01 linux dhcpd: icmp.c(274): trace_write_packet with null trace type
Jan 27 06:30:03 linux knut: Executing ethtool -K eth0 rx off
Jan 27 06:30:03 linux knut: Sleeping 2 seconds
Jan 27 06:30:05 linux knut: killall tcpdump
Jan 27 06:30:05 linux knut: End of test

--------------080001010902080100020702
Content-Type: text/plain;
 name="tcpdumpfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcpdumpfile"

06:29:38.899532 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 0, offset 0, flags [DF], length: 58) p54AB7064.dip.t-dialin.net.rdrmshc > www-proxy.F2.srv.t-online.de.domain: [udp sum ok]  22324+ A? www.suse.com. (30)
06:29:38.899812 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 51975, offset 0, flags [DF], length: 73) p54AB7064.dip.t-dialin.net.dab-sti-c > www-proxy.F2.srv.t-online.de.domain: [udp sum ok]  2117+ PTR? 33.150.237.217.in-addr.arpa. (45)
06:29:38.946775 PPPoE  [ses 0x385] IP (tos 0x0, ttl  57, id 16399, offset 0, flags [none], length: 74) www-proxy.F2.srv.t-online.de.domain > p54AB7064.dip.t-dialin.net.rdrmshc: [udp sum ok]  22324 q: A? www.suse.com. 1/0/0 www.suse.com. A turing.suse.de (46)
06:29:38.955734 PPPoE  [ses 0x385] IP (tos 0x0, ttl  57, id 63158, offset 0, flags [none], length: 115) www-proxy.F2.srv.t-online.de.domain > p54AB7064.dip.t-dialin.net.dab-sti-c:  2117 q: PTR? 33.150.237.217.in-addr.arpa. 1/0/0 [|domain]
06:29:38.955816 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 52031, offset 0, flags [DF], length: 73) p54AB7064.dip.t-dialin.net.dab-sti-c > www-proxy.F2.srv.t-online.de.domain: [udp sum ok]  2118+ PTR? 100.112.171.84.in-addr.arpa. (45)
06:29:39.009499 PPPoE  [ses 0x385] IP (tos 0x0, ttl  57, id 59142, offset 0, flags [none], length: 113) www-proxy.F2.srv.t-online.de.domain > p54AB7064.dip.t-dialin.net.dab-sti-c:  2118 q: PTR? 100.112.171.84.in-addr.arpa. 1/0/0 [|domain]
06:29:39.009587 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 52085, offset 0, flags [DF], length: 72) p54AB7064.dip.t-dialin.net.dab-sti-c > www-proxy.F2.srv.t-online.de.domain: [udp sum ok]  2119+ PTR? 3.220.135.195.in-addr.arpa. (44)
06:29:39.055627 PPPoE  [ses 0x385] IP (tos 0x0, ttl  57, id 39957, offset 0, flags [none], length: 100) www-proxy.F2.srv.t-online.de.domain > p54AB7064.dip.t-dialin.net.dab-sti-c:  2119 q: PTR? 3.220.135.195.in-addr.arpa. 1/0/0 3.220.135.195.in-addr.arpa. (72)
06:29:40.953234 PPPoE  [ses 0x385] IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 84) p54AB7064.dip.t-dialin.net > turing.suse.de: icmp 64: echo request seq 1
06:29:41.022500 PPPoE  [ses 0x385] IP (tos 0x0, ttl  55, id 36207, offset 0, flags [none], length: 84) turing.suse.de > p54AB7064.dip.t-dialin.net: icmp 64: echo reply seq 1
06:29:41.952973 PPPoE  [ses 0x385] IP (tos 0x0, ttl  64, id 1, offset 0, flags [DF], length: 84) p54AB7064.dip.t-dialin.net > turing.suse.de: icmp 64: echo request seq 2
06:29:42.019352 PPPoE  [ses 0x385] IP (tos 0x0, ttl  55, id 36398, offset 0, flags [none], length: 84) turing.suse.de > p54AB7064.dip.t-dialin.net: icmp 64: echo reply seq 2
06:29:42.719838 PPPoE  [ses 0x385] LCP, Echo-Request (0x09), id 56, Magic-Num 0x8a5b3542, length 8
	0x0000:  c021 0938 0008 8a5b 3542
06:29:42.761102 PPPoE  [ses 0x385] LCP, Echo-Reply (0x0a), id 56, Magic-Num 0x15c96251, length 8
	0x0000:  c021 0a38 0008 15c9 6251
06:29:46.031631 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 0, offset 0, flags [DF], length: 58) p54AB7064.dip.t-dialin.net.dab-sti-c > www-proxy.F2.srv.t-online.de.domain: [udp sum ok]  35750+ A? www.suse.com. (30)
06:29:46.078624 PPPoE  [ses 0x385] IP (tos 0x0, ttl  57, id 53333, offset 0, flags [none], length: 74) www-proxy.F2.srv.t-online.de.domain > p54AB7064.dip.t-dialin.net.dab-sti-c: [udp sum ok]  35750 q: A? www.suse.com. 1/0/0 www.suse.com. A turing.suse.de (46)
06:29:47.033244 PPPoE  [ses 0x385] IP (tos 0x10, ttl  64, id 0, offset 0, flags [DF], length: 58) p54AB7064.dip.t-dialin.net.imgames > 217.237.151.161.domain: [udp sum ok]  35750+ A? www.suse.com. (30)


--------------080001010902080100020702
Content-Type: text/plain;
 name="iptablesdump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iptablesdump"

Chain INPUT (policy DROP)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
input_ext  all  --  anywhere             anywhere            
input_int  all  --  anywhere             anywhere            
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-IN-ILL-TARGET ' 
DROP       all  --  anywhere             anywhere            

Chain FORWARD (policy DROP)
target     prot opt source               destination         
TCPMSS     tcp  --  anywhere             anywhere            tcp flags:SYN,RST/SYN TCPMSS clamp to PMTU 
TCPMSS     tcp  --  anywhere             anywhere            tcp flags:SYN,RST/SYN TCPMSS clamp to PMTU 
forward_ext  all  --  anywhere             anywhere            
forward_int  all  --  anywhere             anywhere            
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-FWD-ILL-ROUTING ' 
DROP       all  --  anywhere             anywhere            

Chain OUTPUT (policy DROP)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
LOG        icmp --  anywhere             anywhere            limit: avg 3/min burst 5 icmp time-exceeded LOG level warning tcp-options ip-options prefix `SFW2-OUT-TRACERT-ATTEMPT ' 
ACCEPT     icmp --  anywhere             anywhere            icmp time-exceeded 
ACCEPT     icmp --  anywhere             anywhere            icmp port-unreachable 
ACCEPT     icmp --  anywhere             anywhere            icmp fragmentation-needed 
ACCEPT     icmp --  anywhere             anywhere            icmp network-prohibited 
ACCEPT     icmp --  anywhere             anywhere            icmp host-prohibited 
ACCEPT     icmp --  anywhere             anywhere            icmp communication-prohibited 
DROP       icmp --  anywhere             anywhere            icmp destination-unreachable 
ACCEPT     all  --  anywhere             anywhere            state NEW,RELATED,ESTABLISHED 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-OUT-ERROR ' 

Chain forward_dmz (0 references)
target     prot opt source               destination         
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-FWDdmz-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
ACCEPT     icmp --  anywhere             anywhere            state RELATED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     all  --  anywhere             anywhere            state NEW,RELATED,ESTABLISHED 
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-FWDdmz-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain forward_ext (1 references)
target     prot opt source               destination         
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-FWDext-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
ACCEPT     icmp --  anywhere             anywhere            state RELATED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     all  --  anywhere             anywhere            state NEW,RELATED,ESTABLISHED 
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-FWDext-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain forward_int (1 references)
target     prot opt source               destination         
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-FWDint-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
ACCEPT     icmp --  anywhere             anywhere            state RELATED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     all  --  anywhere             anywhere            state NEW,RELATED,ESTABLISHED 
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-FWDint-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain input_dmz (0 references)
target     prot opt source               destination         
LOG        all  --  anywhere             anywhere            PKTTYPE = broadcast limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-DROP-BCASTd ' 
DROP       all  --  anywhere             anywhere            PKTTYPE = broadcast 
ACCEPT     icmp --  anywhere             anywhere            icmp source-quench 
ACCEPT     icmp --  anywhere             anywhere            icmp echo-request 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp time-exceeded 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp parameter-problem 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp timestamp-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp address-mask-reply 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-INdmz-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain input_ext (1 references)
target     prot opt source               destination         
LOG        all  --  anywhere             anywhere            PKTTYPE = broadcast limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-DROP-BCASTe ' 
DROP       all  --  anywhere             anywhere            PKTTYPE = broadcast 
ACCEPT     icmp --  anywhere             anywhere            icmp source-quench 
ACCEPT     icmp --  anywhere             anywhere            icmp echo-request 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp time-exceeded 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp parameter-problem 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp timestamp-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp address-mask-reply 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
LOG        tcp  --  anywhere             anywhere            tcp dpt:ident state NEW limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-INext-REJECT ' 
reject_func  tcp  --  anywhere             anywhere            tcp dpt:ident state NEW 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ssh flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ssh flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:sunrpc flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:sunrpc flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:ipp flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:ipp flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:827 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:827 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:nfs flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:nfs flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        tcp  --  anywhere             anywhere            limit: avg 3/min burst 5 tcp dpt:16273 flags:SYN,RST,ACK/SYN LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP ' 
DROP       tcp  --  anywhere             anywhere            tcp dpt:16273 flags:SYN,RST,ACK/SYN 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-INext-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain input_int (1 references)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     icmp --  anywhere             anywhere            icmp source-quench 
ACCEPT     icmp --  anywhere             anywhere            icmp echo-request 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp echo-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp destination-unreachable 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp time-exceeded 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp parameter-problem 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp timestamp-reply 
ACCEPT     icmp --  anywhere             anywhere            state RELATED,ESTABLISHED icmp address-mask-reply 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 state INVALID LOG level warning tcp-options ip-options prefix `SFW2-INint-DROP-DEFLT-INV ' 
DROP       all  --  anywhere             anywhere            state INVALID 
LOG        all  --  anywhere             anywhere            limit: avg 3/min burst 5 LOG level warning tcp-options ip-options prefix `SFW2-INint-DROP-DEFLT ' 
DROP       all  --  anywhere             anywhere            

Chain reject_func (1 references)
target     prot opt source               destination         
REJECT     tcp  --  anywhere             anywhere            reject-with tcp-reset 
REJECT     udp  --  anywhere             anywhere            reject-with icmp-port-unreachable 
REJECT     all  --  anywhere             anywhere            reject-with icmp-proto-unreachable 

--------------080001010902080100020702--
