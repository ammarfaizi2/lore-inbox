Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTKDWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTKDWM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:12:56 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:35464 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S261267AbTKDWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:12:48 -0500
Message-ID: <3FA8245B.8030302@davehollis.com>
Date: Tue, 04 Nov 2003 17:12:43 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops in __xfrm4_state_lookup when setting up an IPSEC tunnel
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to setup an IPV4 IPSEC tunnel between two systems with the 
following topology:

192.168.1.0/24
      |
gw1 (2.6.0-test9-bk7)
      |
 66.22.66.22
      |
  Internet
      |
 44.33.44.33
      |
gw2 (2.6.0-test9-bk9)
      |
172.16.100.100/24

Both firewalls are RedHat 9 based installs, running stock 2.6.0-test9 
kernels (note the variance on bk7 and bk9).  Both are running Shorewall 
1.4.7c to setup iptables/netfilter firewalling.

If I configure the SAD and SPDs on gw2, than setup them up on gw1, gw2 
Oops hard on __xfrm4_state_lookup.  I have not yet hand copied the 
entire dump but have the initial pertinent
info:

EIP is at __xfrm4_state_lookup+0x6f/0xa0

Call Stack is:
xfrm_state_lookup
xfrm_rcv_encap
match  [ ipt_conntrack ]
match  [ ipt_state ]
ipt_do_table [ ip_tables ]
ip_local_deliver
ipt_hook [ iptable_filter]
xfrm4_rcv
ip_local_deliver_finish
ip_local_deliver_finish
nf_hook_slow
ip_load_deliver_finish
ip_local_deliver
ip_local_deliver_finish
ip_rcv_finish
ip_rcv_finish
nf_hook_slow


Between reproductions of the crash (which are easy to repeat - that's 
good.... I guess..) the constant is that it's dying in the 
xfrm_state_lookup area.  gw1 (the bk7 system) has not crashed in any way.  

tcpdump output on gw2 watching traffic to/from gw1 right at a crash:

17:02:42.147923 66.22.66.22 > 44.33.44.33: ESP(spi=0x00000201,seq=0x1) (DF)
17:02:42.147923 truncated-ip - 16 bytes missing! 66.22.66.22 > 
69.0.0.84: truncated-ip - 16268 bytes missing! 44.33.44.33 > 69.0.0.84: 
xns-idp (frag 13060:16352@30720) (ipip-proto-4)
17:02:43.147660 66.22.66.22 > 44.33.44.33: ESP(spi=0x00000201,seq=0x2) (DF)
17:02:43.147660 truncated-ip - 16 bytes missing! 66.22.66.22 > 
69.0.0.84: bad-hlen 0 (ipip-proto-4)
 
17:02:44.146738 66.22.66.22 > 44.33.44.33: ESP(spi=0x00000201,seq=0x3) (DF)
17:02:44.146738 truncated-ip - 16 bytes missing! 66.22.66.22 > 
69.0.0.84: bad-hlen 8 (ipip-proto-4)

/sbin/lsmod:

Module                  Size  Used by
xfrm_user              15300  -
md5                     3936  -
aes                    32544  -
des                    11616  -
ah4                     7776  -
esp4                   10496  -
af_key                 32848  -
autofs                 15456  -
serial_cs               8136  -
8250                   20960  -
serial_core            22240  -
3c574_cs               13804  -
parport_pc             27240  -
parport                43016  -
ipt_ULOG                6440  -
ipt_ttl                 1824  -
ipt_TOS                 2432  -
ipt_tos                 1504  -
ipt_TCPMSS              4224  -
ipt_tcpmss              2176  -
ipt_state               1824  -
ipt_REJECT              6816  -
ipt_REDIRECT            2080  -
ipt_recent             10668  -
ipt_pkttype             1504  -
ipt_physdev             2064  -
ipt_owner               3104  -
ipt_multiport           1920  -
ipt_MASQUERADE          3584  -
ipt_MARK                1984  -
ipt_mark                1568  -
ipt_mac                 1856  -
ipt_LOG                 5472  -
ipt_limit               2272  -
ipt_length              1600  -
ipt_helper              2048  -
ipt_esp                 1856  -
ipt_ECN                 3200  -
ipt_ecn                 2112  -
ipt_DSCP                2464  -
ipt_dscp                1568  -
ipt_conntrack           2432  -
ipt_ah                  1856  -
ip_queue               10584  -
ip_nat_tftp             3344  -
ip_nat_snmp_basic      11588  -
ip_nat_irc              4112  -
ip_nat_ftp              4752  -
ip_nat_amanda           2940  -
ip_conntrack_tftp       3508  -
ip_conntrack_irc       71220  -
ip_conntrack_ftp       72084  -
ip_conntrack_amanda    69796  -
arpt_mangle             2336  -
arptable_filter         1984  -
arp_tables             12512  -
iptable_nat            21964  -
ip_conntrack           31536  -
iptable_mangle          2720  -
iptable_filter          2688  -
ip_tables              16128  -
hid                    24992  -
uhci_hcd               31184  -
usbcore               107772  -


My manual tunnel config:

#!/sbin/setkey -f
 
# Flush the SAD and SPD
flush;
spdflush;
 
# ESP SAs doing encryption using 192 bit long keys (168 + 24 parity)
# and authentication using 128 bit long keys
add 66.22.66.22 44.33.44.33 esp 0x201 -m tunnel -E 3des-cbc 
0x12d49767b12e4565d5fb95bf1d5248db93c60a90d7602a44 -A hmac-md5 
0x2013c28f56dea12fae2835b3654d60a2;
 
add 44.33.44.33 66.22.66.22 esp 0x301 -m tunnel -E 3des-cbc 
0x40127f0a79fda7311b3c5344f5d5bd9a0fcd8bd926caae5f -A hmac-md5 
0xd1b9a27cb7ab9562a0c8ad21f82be8b8;
 
# Security policies
spdadd 192.168.1.0/24 172.16.100.0/24 any -P out ipsec
           esp/tunnel/66.22.66.22-44.33.44.33/require;
spdadd 172.16.100.0/24 192.168.1.0/24 any -P in ipsec
           esp/tunnel/44.33.44.33-66.22.66.22/require;


/sbin/setkey -D:
44.33.44.33 66.22.66.22
        esp mode=tunnel spi=769(0x00000301) reqid=0(0x00000000)
        E: 3des-cbc  40127f0a 79fda731 1b3c5344 f5d5bd9a 0fcd8bd9 26caae5f
        A: hmac-md5  d1b9a27c b7ab9562 a0c8ad21 f82be8b8
        seq=0x00000000 replay=0 flags=0x00000000 state=mature
        created: Nov  4 16:43:39 2003   current: Nov  4 16:44:35 2003
        diff: 56(s)     hard: 0(s)      soft: 0(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=1 pid=3930 refcnt=0
66.22.66.22 44.33.44.33
        esp mode=tunnel spi=513(0x00000201) reqid=0(0x00000000)
        E: 3des-cbc  12d49767 b12e4565 d5fb95bf 1d5248db 93c60a90 d7602a44
        A: hmac-md5  2013c28f 56dea12f ae2835b3 654d60a2
        seq=0x00000000 replay=0 flags=0x00000000 state=mature
        created: Nov  4 16:43:39 2003   current: Nov  4 16:44:35 2003
        diff: 56(s)     hard: 0(s)      soft: 0(s)
        last:                           hard: 0(s)      soft: 0(s)
        current: 0(bytes)       hard: 0(bytes)  soft: 0(bytes)
        allocated: 0    hard: 0 soft: 0
        sadb_seq=0 pid=3930 refcnt=0

/sbin/setkey -D -P:
172.16.100.0/24[any] 192.168.1.0/24[any] any
        in ipsec
        esp/tunnel/44.33.44.33-66.22.66.22/require
        created: Nov  4 16:43:39 2003  lastused:
        lifetime: 0(s) validtime: 0(s)
        spid=8 seq=1 pid=3931
        refcnt=1
192.168.1.0/24[any] 172.16.100.0/24[any] any
        out ipsec
        esp/tunnel/66.22.66.22-44.33.44.33/require
        created: Nov  4 16:43:39 2003  lastused:
        lifetime: 0(s) validtime: 0(s)
        spid=1 seq=0 pid=3931
        refcnt=1


