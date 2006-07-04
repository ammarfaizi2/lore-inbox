Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWGDSNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWGDSNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWGDSNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 14:13:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:42557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932273AbWGDSNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 14:13:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l5bnkT0XAuBnY+hAIttZmWpVLJPvqVPPloU2St1kgA8JSCRqQ+glxLQjh+VS8CvJYQSKz3f0nGKtcRdhxPw7+7tun9pFNtEoE/VeF2G+MBMRvVT6iN+BcDLAEgdATt38zo/qRNlPDAkiPV5mdDo2Aiz7UVazKylV4Ji3sfnhy9I=
Message-ID: <5a4c581d0607041113o2993cbf5m7011b2a06e96d974@mail.gmail.com>
Date: Tue, 4 Jul 2006 20:13:21 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: [2.6.17-git22] lock debugging output
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoping gmail doesn't mess it too badly...

eth0: tg3 (BCM5751 Gbit Ethernet)
eth1: ipw2200 (Intel PRO/Wireless 2200BG)

Sequence:
 1. boot with eth0 disconnected (eth1 doesn't come up on boot)
 2. ifup eth1, bring wpa-supplicant up
 3. run 'dig' ---> <lock debug info gets printed on console>

Note that due to my very variable network setup, I had no /etc/resolv.conf
 in place at the moment I ran 'dig'. Second execution of 'dig' did not print
 any lock debug output but just (properly) stalled; then I realized I didn't
 put my home resolv.conf in place, did that and 'dig' just worked.

System appears to work and I'm actually typing this report from the
 same kernel that reported the following upon invoking 'dig' :

 =================================
 [ INFO: inconsistent lock state ]
 ---------------------------------
 inconsistent {softirq-on-W} -> {in-softirq-R} usage.
 dig/2373 [HC0[0]:SC1[2]:HE1:SE0] takes:
  (&sk->sk_dst_lock){---?}, at: [<c028cf72>] sk_dst_check+0x1b/0xe6
 {softirq-on-W} state was registered at:
   [<c0127a6a>] lock_acquire+0x60/0x80
   [<c02e151d>] _write_lock+0x19/0x28
   [<c028c0af>] sock_setsockopt+0x351/0x49c
   [<c0289d0d>] sys_setsockopt+0x5b/0x8d
   [<c028ac22>] sys_socketcall+0x148/0x186
   [<c0102699>] sysenter_past_esp+0x56/0x8d
 irq event stamp: 1130
 hardirqs last  enabled at (1130): [<c01161ed>] local_bh_enable_ip+0xb2/0xbb
 hardirqs last disabled at (1129): [<c011618e>] local_bh_enable_ip+0x53/0xbb
 softirqs last  enabled at (1120): [<c029423c>] dev_queue_xmit+0x205/0x211
 softirqs last disabled at (1121): [<c01040e6>] do_softirq+0x4d/0xac

 other info that might help us debug this:
 2 locks held by dig/2373:
  #0:  (sk_lock-AF_INET6){--..}, at: [<f8cf1168>]
udpv6_sendmsg+0x546/0x818 [ipv6]
  #1:  (slock-AF_INET6){-...}, at: [<f8cf3228>] icmpv6_send+0x222/0x549 [ipv6]

 stack backtrace:
  [<c0102e44>] show_trace+0xd/0x10
  [<c010335e>] dump_stack+0x19/0x1b
  [<c01260e1>] print_usage_bug+0x1cc/0x1d9
  [<c01265e2>] mark_lock+0x193/0x360
  [<c01271ee>] __lock_acquire+0x3b7/0x969
  [<c0127a6a>] lock_acquire+0x60/0x80
  [<c02e15ff>] _read_lock+0x19/0x28
  [<c028cf72>] sk_dst_check+0x1b/0xe6
  [<f8ce1305>] ip6_dst_lookup+0x31/0x16d [ipv6]
  [<f8cf3338>] icmpv6_send+0x332/0x549 [ipv6]
  [<f8cf09a1>] udpv6_rcv+0x4ab/0x4d6 [ipv6]
  [<f8ce2900>] ip6_input+0x19c/0x228 [ipv6]
  [<f8ce2d61>] ipv6_rcv+0x188/0x1b7 [ipv6]
  [<c02925b7>] netif_receive_skb+0x18d/0x1d8
  [<c0293d6a>] process_backlog+0x80/0xf9
  [<c0293f43>] net_rx_action+0x80/0x174
  [<c01162fd>] __do_softirq+0x46/0x9c
  [<c01040e6>] do_softirq+0x4d/0xac
  =======================
  [<c0116117>] local_bh_enable+0xc8/0xec
  [<c029423c>] dev_queue_xmit+0x205/0x211
  [<c0298a8b>] neigh_resolve_output+0x1db/0x207
  [<f8ce0bee>] ip6_output2+0x1e4/0x202 [ipv6]
  [<f8ce12aa>] ip6_output+0x69e/0x6c8 [ipv6]
  [<f8ce1706>] ip6_push_pending_frames+0x2c5/0x377 [ipv6]
  [<f8cefd8e>] udp_v6_push_pending_frames+0x154/0x176 [ipv6]
  [<f8cf122a>] udpv6_sendmsg+0x608/0x818 [ipv6]
  [<c02c6b1d>] inet_sendmsg+0x3b/0x48
  [<c02894f9>] sock_sendmsg+0xe8/0x103
  [<c0289b18>] sys_sendmsg+0x14f/0x1aa
  [<c028ac45>] sys_socketcall+0x16b/0x186
  [<c0102699>] sysenter_past_esp+0x56/0x8d


Hope this may be useful to lock debug devs / netdev folks...


Ciao,

--alessandro

 "I can't change what makes me high and I can't change what I believe in"
     (Heather Nova, "My Fidelity")
