Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTIXWwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTIXWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:52:49 -0400
Received: from pop.gmx.net ([213.165.64.20]:50327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261236AbTIXWwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:52:46 -0400
Date: Thu, 25 Sep 2003 00:52:45 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, devik@cdi.cz
MIME-Version: 1.0
Subject: [OOPS] [2.6.0-test5] HTB QoS crash...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <16014.1064443965@www46.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bring my ppp0 interface up, setup various traffic shaping and policing
filters [1] (Bert Hubert's excellent 'wondershaper').

When I 'killall pppd', the kernel crashes [2].

--- [1]

DOWNLINK=440
UPLINK=210
DEV=ppp0

tc qdisc add dev $DEV root handle 1: htb default 20
tc class add dev $DEV parent 1: classid 1:1 htb rate ${UPLINK}kbit \
   burst 6k
tc class add dev $DEV parent 1:1 classid 1:10 htb rate ${UPLINK}kbit \
   burst 6k prio 1
tc class add dev $DEV parent 1:1 classid 1:20 htb rate $[9*$UPLINK/10]kbit \
   burst 6k prio 2
tc class add dev $DEV parent 1:1 classid 1:30 htb rate $[8*$UPLINK/10]kbit \
   burst 6k prio 2
tc qdisc add dev $DEV parent 1:10 handle 10: sfq perturb 10
tc qdisc add dev $DEV parent 1:20 handle 20: sfq perturb 10
tc qdisc add dev $DEV parent 1:30 handle 30: sfq perturb 10
tc filter add dev $DEV parent 1:0 protocol ip prio 10 u32 \
      match ip tos 0x10 0xff  flowid 1:10
tc filter add dev $DEV parent 1:0 protocol ip prio 10 u32 \
        match ip protocol 1 0xff flowid 1:10
tc filter add dev $DEV parent 1: protocol ip prio 10 u32 \
   match ip protocol 6 0xff \
   match u8 0x05 0x0f at 0 \
   match u16 0x0000 0xffc0 at 2 \
   match u8 0x10 0xff at 33 \
   flowid 1:10
tc filter add dev $DEV parent 1: protocol ip prio 18 u32 \
   match ip dst 0.0.0.0/0 flowid 1:20
tc qdisc add dev $DEV handle ffff: ingress
tc filter add dev $DEV parent ffff: protocol ip prio 50 u32 match ip src \
   0.0.0.0/0 police rate ${DOWNLINK}kbit burst 10k drop flowid :1

--- [2]

Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02d2314>]    Not tainted
EFLAGS: 00010282
EIP is at htb_unbind_filter+0x49/0x6b
eax: 00000000   ebx: dc246078   ecx: da60e004   edx: dc246004
esi: da60e004   edi: df4ffef8   ebp: da5ede0c   esp: da5eddf4
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 1078, threadinfo=da5ec000 task=da711000)
Stack: c1001040 00000000 c141f280 00000000 df4ffeac db3315fc da5ede20
c02da54e
       dc246004 da60e004 00000000 da5ede3c c02da7e7 df4ffef8 df4ffeac
db3315fc
       db3315a4 df4ffef8 da5ede58 c02da826 df4ffef8 db3315fc dc2463b0
db3315a4
Call Trace:
 [<c02da54e>] u32_destroy_key+0x6a/0x6c
 [<c02da7e7>] u32_clear_hnode+0x2e/0x48
 [<c02da826>] u32_destroy_hnode+0x25/0x86
 [<c02da955>] u32_destroy+0xce/0xec
 [<c02d148a>] htb_destroy_filters+0x1d/0x29
 [<c02d169d>] htb_destroy+0x67/0xd2
 [<c02c3fd4>] qdisc_destroy+0x81/0x92
 [<c02c4705>] dev_shutdown+0xaa/0x245
 [<c0138e4c>] wakeme_after_rcu+0x0/0xc
 [<c02b7d0c>] unregister_netdevice+0xdb/0x335
 [<c02bf84a>] rtnl_lock+0x22/0x37
 [<c0233ba7>] unregister_netdev+0x19/0x26
 [<c0239e26>] ppp_shutdown_interface+0x21e/0x3ba
 [<c0182376>] dput+0x23/0x685
 [<c0163e34>] __fput+0x7c/0xcd
 [<c0234011>] ppp_release+0x5f/0x61
 [<c0163e73>] __fput+0xbb/0xcd
 [<c0161f1d>] filp_close+0x57/0x81
 [<c016204b>] sys_close+0x104/0x228
 [<c010a34b>] syscall_call+0x7/0xb

Code: 83 ae 58 01 00 00 01 8b 5d f8 8b 75 fc 89 ec 5d c3 83 ab 3c
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

