Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbULFUx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbULFUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULFUx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:53:56 -0500
Received: from quickstop.soohrt.org ([81.2.155.147]:28870 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261643AbULFUxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:53:11 -0500
Date: Mon, 6 Dec 2004 21:53:05 +0100
From: Karsten Desler <kdesler@soohrt.org>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: _High_ CPU usage while routing (mostly) small UDP packets
Message-ID: <20041206205305.GA11970@soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running a dual Opteron 244 router with two active e1000 interfaces,
that mostly deals with small (<200b) udp packets.
I'm using Linux 2.6.10-rc3 (32bit), but I tried 64bit with early 2.6.9-rc
versions, and it didn't make much of a difference.

The irq of eth0 is bound to cpu1 while eth1 is bound to cpu0.
NAPI is enabled.
Current packetload on eth0 (and reversed on eth1):
  115kpps tx
  135kpps rx

There are about 200 iptables rules, but the common packet only has to
traverse about 20.
conntrack is not loaded.

eth0 and eth1 are running on the same 66MHz/64bit PCI bus.

Kernel-Profiling is running, I don't know how much that contributes to the
overall load.

I don't know if that has anything to do with it, but the systemclock is
getting out of sync _fast_ (openntpd can't keep up).
ntpdate -b ntp.soohrt.org; sleep 60; ntpdate ntp.soohrt.org:
 6 Dec 21:40:39 ntpdate[30146]: adjust time server 134.100.177.5 offset 0.000092 sec
 6 Dec 21:41:39 ntpdate[30218]: adjust time server 134.100.177.5 offset 0.006971 sec


Is that the expected cpu usage?
I'd appreciate _any_ pointers, thanks in advance,
 Karsten

Current cpu usage:
 Cpu0 :  0.0% us,  0.0% sy,  0.0% ni, 46.3% id,  0.0% wa,  0.0% hi, 53.7% si
 Cpu1 :  0.0% us,  0.0% sy,  0.0% ni, 21.4% id,  0.0% wa,  0.0% hi, 78.6% si

vmstat 5:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 1804612 100488 104464    0    0     0    32 5965   167  3 68 30  0
 0  1      0 1804548 100488 104464    0    0     0   157 5994    18  0 67 33  0
 1  1      0 1804684 100488 104464    0    0     0    63 5998    19  0 67 33  0
 0  1      0 1804684 100492 104460    0    0     0     4 5985    10  0 68 33  0
 0  1      0 1804620 100492 104460    0    0     0    12 6032    15  0 68 32  0

lspci -vt:
-[00]-+-06.0-[03]--+-00.0  Advanced Micro Devices [AMD] AMD-8111 USB
      [...]
      +-0a.1  Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
      +-0b.0-[01]--+-01.0  Intel Corp. 82545EM Gigabit Ethernet Controller (Fiber) <- eth0
      |            +-03.0  Intel Corp. 82546GB Gigabit Ethernet Controller <- eth1
      |            \-03.1  Intel Corp. 82546GB Gigabit Ethernet Controller

arp -n|grep -c incomplete:
73

arp -n|grep -vc incomplete:
778

iptables -nL|grep -v Chain|grep -vc source:
199

readprofile -r; sleep 60; readprofile|sort -n +2:
    76 __do_softirq                               0.3654
    73 dst_alloc                                  0.4148
   489 ip_rcv                                     0.4187
    96 fib_semantic_match                         0.4615
    15 memset                                     0.4688
     8 _write_lock                                0.5000
    37 match                                      0.5781
    72 handle_IRQ_event                           0.6429
   138 fn_hash_lookup                             0.7188
   401 qdisc_restart                              0.7371
    13 _read_unlock                               0.8125
    28 _spin_lock_bh                              0.8750
    70 e1000_rx_checksum                          0.8750
   536 ip_rcv_finish                              0.9306
    33 kfree_skbmem                               1.0312
   248 e1000_intr                                 1.0333
    30 _read_lock                                 1.8750
  1198 ip_forward                                 1.9199
   910 ip_finish_output2                          1.9612
   282 rt_hash_code                               2.2031
   286 pfifo_fast_enqueue                         2.2344
    36 _spin_unlock                               2.2500
  1657 dev_queue_xmit                             2.3014
   230 ip_output                                  2.3958
   905 netif_receive_skb                          2.4592
  2852 e1000_clean_rx_irq                         2.6213
   697 nf_hook_slow                               2.7227
   674 e1000_alloc_rx_buffers                     2.8083
   228 ip_forward_finish                          2.8500
   187 ipt_hook                                   3.8958
   346 kmem_cache_free                            4.3250
   357 pfifo_fast_dequeue                         4.4625
   626 local_bh_enable                            4.8906
   250 e1000_irq_enable                           5.2083
   425 kmem_cache_alloc                           5.3125
  3100 e1000_clean_tx_irq                         5.6985
  1014 nf_iterate                                 5.7614
   284 ipt_route_hook                             5.9167
   701 kfree                                      6.2589
  1063 __kmalloc                                  8.3047
  1605 skb_release_data                          10.0312
  2692 eth_type_trans                            11.2167
  4013 __kfree_skb                               15.6758
  4554 alloc_skb                                 18.9750
 20017 ipt_do_table                              24.0589
 10700 ip_route_input                            30.3977
  1341 _spin_lock                                83.8125
  1483 _read_unlock_bh                           92.6875
  3345 _read_lock_bh                            104.5312
  3185 _spin_unlock_irqrestore                  199.0625
 44402 default_idle                             693.7812
