Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVGJNXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVGJNXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 09:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGJNXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 09:23:18 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:53453 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S261933AbVGJNXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 09:23:16 -0400
X-ME-UUID: 20050710132315876.D5DA77000084@mwinf1501.wanadoo.fr
Message-ID: <9121902.1121001795869.JavaMail.www@wwinf1513>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.14.41.206]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sun, 10 Jul 2005 15:23:15 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 09/07/05 23:02
> De : "Francois Romieu" <romieu@fr.zoreil.com>
[...]
> Can you do the same test but send the traffic from the host which
> embeds the r8169 ?
> 
> The sis190 should not be responsive during the flow. I expect that it
> will happily return to a normal state once the traffic stops.
>
Yes, no responsive at all :i could do nothing on my box during 
the tests.
The second test (link partner r8169,packet_size 60, rx_copy_break 200)
froze definitly the box.
I repeated the test about 10 times after that (the station 
returned to a normal state each time) :
- link partner r8169 or 8139too
- rx_copy_break 60, packet size 70
- rx_copy_break 200, packet size 60 - 70 - 200

I could not reproduce the issue...

Here is one result :

# cat /proc/net/pktgen/eth2
Params: count 10000000  min_pkt_size: 60  max_pkt_size: 60
     frags: 0  delay: 0  clone_skb: 1000000  ifname: eth2
     flows: 0 flowlen: 0
     dst_min: 10.169.21.21  dst_max:
     src_min:   src_max:
     src_mac: 00:40:F4:A8:70:BC  dst_mac: 00:11:2F:E9:42:70
     udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9  udp_dst_max: 9
     src_mac_count: 0  dst_mac_count: 0
     Flags:
Current:
     pkts-sofar: 10000000  errors: 9636478
     started: 1120986879778860us  stopped: 1120986948307262us idle: 14552142us
     seq_num: 10000011  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
     cur_saddr: 0x115a90a  cur_daddr: 0x1515a90a
     cur_udp_dst: 9  cur_udp_src: 9
     flows: 0
Result: OK: 68528402(c53976260+d14552142) usec, 10000000 (60byte,0frags)
  145924pps 70Mb/sec (70043520bps) errors: 9636478

However, pktgen triggers (for all tests) thoses traces on the remote :
scheduling while atomic: pktgen.conf-1-1/0x00000001/5431
 [<c02a2827>] schedule+0x947/0xbb5
 [<c016ff2d>] notify_change+0x188/0x297
 [<c0122750>] __mod_timer+0x124/0x15c
 [<c02a3296>] schedule_timeout+0x6d/0xbb
 [<c01231d1>] process_timeout+0x0/0x9
 [<e0cb48f2>] count_trail_chars+0x18/0x40 [pktgen]
 [<e0cb6636>] proc_thread_write+0x24c/0x2d7 [pktgen]
 [<c0155b8c>] vfs_write+0xc8/0x12f
 [<c0155cb2>] sys_write+0x4b/0x74
 [<c0102595>] sysenter_past_esp+0x52/0x75

So i don't know if the results are significants.
(remote= P4 HT , 2.6.11.11 #3 SMP)

I also tried a ping flood from the remote :
remote # ping -q -l 256 -s 64 -f 10.169.21.21
PING 10.169.21.21 (10.169.21.21) 64(92) bytes of data.

--- 10.169.21.21 ping statistics ---
718599 packets transmitted, 718454 received, 0% packet loss, time 44313ms
rtt min/avg/max/mdev = 0.073/6.033/13.129/4.437 ms, pipe 256, ipg/ewma 0.061/7.247 ms

remote # ping -q -l 512 -s 64 -f 10.169.21.21
PING 10.169.21.21 (10.169.21.21) 64(92) bytes of data.

--- 10.169.21.21 ping statistics ---
2481376 packets transmitted, 1163044 received, 53% packet loss, time 52550ms
rtt min/avg/max/mdev = 0.065/6.945/18.312/3.045 ms, pipe 512, ipg/ewma0.021/9.369 ms

local # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.21  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3942816 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2624629 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:417940801 (398.5 MiB)  TX bytes:278208935 (265.3 MiB)
          Interrupt:11 Base address:0xdead


> One should expect some messages to appear in the log after you forced
> the link at 10Mb/s. Do you notice anything in dmesg ?
> 
Yes :
eth0: PHY reset until link up.
eth0: mii ext = 0000.
eth0: mii lpa = c1e1.
eth0: link on 100 Mbps Full Duplex mode.


> I would be interested to know if the attached patch makes a difference
> (the patch applies on top of the current driver).
> 
No difference for "ethtool speed 10 duplex half autoneg off"

> Can you issue a simple 'ethtool -s eth0 autoneg off' and report what
> happens ?
> 
# ethtool -s eth0 autoneg off
# ethtool eth0
[...]
        Advertised auto-negotiation: No
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off

ethtool returns the same informations as long as i don't use
"ethtool -s ...".

# ethtool -s eth0  speed 10 duplex half autoneg off
# ethtool eth0
[...]
        Advertised auto-negotiation: No
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
[...]
# ethtool eth0
[...]
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
[...]
#dmesg
[...]
eth0: PHY reset until link up.
eth0: mii ext = 0000.
eth0: mii lpa = c1e1.
eth0: link on 100 Mbps Full Duplex mode.
eth0: mii ext = 0000.
eth0: mii lpa = c1e1.
eth0: link on 100 Mbps Full Duplex mode.

---
Pascal



