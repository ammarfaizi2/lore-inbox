Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030885AbWKOTCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030885AbWKOTCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030884AbWKOTCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:02:11 -0500
Received: from tapsys.com ([72.36.178.242]:62646 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1030883AbWKOTCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:02:08 -0500
Message-ID: <455B63EC.8070704@madrabbit.org>
Date: Wed, 15 Nov 2006 11:01:00 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>, Bcm43xx-dev@lists.berlios.de,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Andrew Morton <akpm@osdl.org>
Subject: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I ran 2.6.19-rc3 for almost two weeks or so with no difficulties (none related
to the bcm43xx driver, at least). However, Andrew asked me to double check the
latest release to see if my problem report against 2.6.18 (hard locks) was
fixed. Good news is that it still is fixed. Bad news is that 2.6.19-rc5 is
worse than rc3 in other ways.

I've come back to my laptop being mostly dead after hours of it being off on
its own (twice now). Mostly dead meaning the keyboard is nearly
non-responsive, but the mouse works great (I'm in X, of course). I say 'nearly
dead' as sysrq-t,b works, so I'm sorta stumped there. (x-session seems to use
netlink, so perhaps that's the connection? ctrl-alt-f[1-7] don't do anything,
however.)

It seems to be a locking problem, though lockdep isn't catching it. I'll let
you guys decide though.

Regardless, here's what's I can see. My logs start filling with:

$ grep 'NETDEV WATCHDOG:' /var/log/messages |  cut -d '[' -f 2- | head
50025.388173] NETDEV WATCHDOG: eth1: transmit timed out
50029.019574] NETDEV WATCHDOG: eth1: transmit timed out
50030.835313] NETDEV WATCHDOG: eth1: transmit timed out
50032.651049] NETDEV WATCHDOG: eth1: transmit timed out
50034.466785] NETDEV WATCHDOG: eth1: transmit timed out
50036.282523] NETDEV WATCHDOG: eth1: transmit timed out
50038.098237] NETDEV WATCHDOG: eth1: transmit timed out
50039.913974] NETDEV WATCHDOG: eth1: transmit timed out
50041.729709] NETDEV WATCHDOG: eth1: transmit timed out
50043.545447] NETDEV WATCHDOG: eth1: transmit timed out
(...1249 of these, so it doesn't fix itself.)

and then the system becomes pretty worthless. (Full /var/log/messages with
sysrq-t at: http://madrabbit.org/~ray/messages.gz ).

Interesting bits of that:

$ grep -B5 -A10 'Nov 13 01:5.*mutex' /var/log/messages | cut -d ']' -f2-
 DWARF2 unwinder stuck at child_rip+0xa/0x12

 Leftover inexact backtrace:

  [restore_args+0/48] restore_args+0x0/0x30
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [kthread+0/272] kthread+0x0/0x110
  [child_rip+0/18] child_rip+0x0/0x12

 khelper       S ffff810037fbe318     0     5      1             6     4 (L-TLB)
  ffff810037907e60 0000000000000046 ffff810037907e70 ffff810037fbe140
  ffff81001095f140 0000000000003b5d ffff810001e3e668 0000000000000286
  ffff810037907e40 ffffffff8026bbb2 ffff810037907e70 ffff810001e3e600
 Call Trace:
  [worker_thread+236/352] worker_thread+0xec/0x160
  [kthread+211/272] kthread+0xd3/0x110
--
 DWARF2 unwinder stuck at child_rip+0xa/0x12

 Leftover inexact backtrace:

  [restore_args+0/48] restore_args+0x0/0x30
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [kthread+0/272] kthread+0x0/0x110
  [child_rip+0/18] child_rip+0x0/0x12

 kthread       S ffff810037fad218     0     6      1    25    2129     5 (L-TLB)
  ffff810037f01e60 0000000000000046 ffff810037f01e70 ffff810037fad040
  ffff81002b3df140 000000000000062b ffff810001e3e468 0000000000000286
  ffff810037f01e40 ffffffff8026bbb2 ffff810037f01e70 ffff810001e3e400
 Call Trace:
  [worker_thread+236/352] worker_thread+0xec/0x160
  [kthread+211/272] kthread+0xd3/0x110
--
 DWARF2 unwinder stuck at child_rip+0xa/0x12

 Leftover inexact backtrace:

  [restore_args+0/48] restore_args+0x0/0x30
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [kthread+0/272] kthread+0x0/0x110
  [child_rip+0/18] child_rip+0x0/0x12

 kblockd/0     S ffff810037989318     0    25      6            26       (L-TLB)
  ffff81003798fe60 0000000000000046 ffff81003798fe70 ffff810037989140
  ffff8100379a5100 000000000000078b ffff810037fa2468 0000000000000286
  ffff81003798fe40 ffffffff8026bbb2 ffff81003798fe70 ffff810037fa2400
 Call Trace:
  [worker_thread+236/352] worker_thread+0xec/0x160
  [kthread+211/272] kthread+0xd3/0x110
--
 NetworkManage D ffff810037943258     0  4833      1          4853  4809 (NOTLB)
  ffff81002bfefbe8 0000000000000046 ffff81002bfefb98 ffff810037943080
  ffff81002e6d2100 00000000000122a6 ffffffff8062ce80 0000000000000046
  0000000000000246 ffff810037943080 ffff81002e47b3f0 ffff81002e47b3a0
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [_end+126343345/2126632680] :bcm43xx:bcm43xx_wx_get_mode+0x29/0x60
  [ioctl_standard_call+139/944] ioctl_standard_call+0x8b/0x3b0
  [wireless_process_ioctl+260/976] wireless_process_ioctl+0x104/0x3d0
  [dev_ioctl+854/944] dev_ioctl+0x356/0x3b0
  [sock_ioctl+576/624] sock_ioctl+0x240/0x270
  [do_ioctl+49/160] do_ioctl+0x31/0xa0
  [vfs_ioctl+683/720] vfs_ioctl+0x2ab/0x2d0
  [sys_ioctl+106/160] sys_ioctl+0x6a/0xa0
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83
--
 x-session-man D ffff81002ef02298     0  5625   4565  5672          4586 (NOTLB)
  ffff810028a1fad8 0000000000000046 ffffffff8062c500 ffff81002ef020c0
  ffff8100249a6040 0000000000008c5d 0000000000000000 0000000000000046
  0000000000000246 ffff81002ef020c0 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

--
 gweather-appl D ffff810023b43218     0  7198      1          7199  3540 (NOTLB)
  ffff810033315ad8 0000000000000046 0000000000000000 ffff810023b43040
  ffff81001f47a0c0 000000000001215f 0000000000000000 0000000000000046
  0000000000000246 ffff810023b43040 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

--
 gweather-appl D ffff81001f47a298     0  7199      1          7200  7198 (NOTLB)
  ffff8100338efad8 0000000000000046 0000000000000000 ffff81001f47a0c0
  ffff81000eee2040 0000000000009ce2 0000000000000000 0000000000000046
  0000000000000246 ffff81001f47a0c0 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

--
 gweather-appl D ffff81000eee2218     0  7200      1          9252  7199 (NOTLB)
  ffff810019d3dad8 0000000000000046 0000000000000000 ffff81000eee2040
  ffff81002178d0c0 000000000000cb7b ffffffff8062ce80 0000000000000046
  0000000000000246 ffff81000eee2040 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

--
 wpa_supplican D ffff810026e9a218     0  8058      1         19402  6666 (NOTLB)
  ffff81001bf81ad8 0000000000000046 0000000000000002 ffff810026e9a040
  ffff8100072e4140 000000000001b54f 0000000000000000 0000000000000046
  0000000000000246 ffff810026e9a040 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

--
 dhclient      D ffff8100353092d8     0  9218   4784                     (NOTLB)
  ffff810007811d28 0000000000000046 00000000000000e2 ffff810035309100
  ffffffff80518520 000000000000920c 0000000000000000 0000000000000046
  0000000000000246 ffff810035309100 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnl_lock+16/32] rtnl_lock+0x10/0x20
  [dev_ioctl+53/944] dev_ioctl+0x35/0x3b0
  [sock_ioctl+576/624] sock_ioctl+0x240/0x270
  [do_ioctl+49/160] do_ioctl+0x31/0xa0
  [vfs_ioctl+683/720] vfs_ioctl+0x2ab/0x2d0
  [sys_ioctl+106/160] sys_ioctl+0x6a/0xa0
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

 Leftover inexact backtrace:
--
 ip            D ffff8100072e4318     0  9221   4809                     (NOTLB)
  ffff8100073e5ad8 0000000000000046 ffff810037bcbbf8 ffff8100072e4140
  ffffffff80518520 000000000002322b 0000000000000000 0000000000000046
  0000000000000246 ffff8100072e4140 ffffffff805505b0 ffffffff80550560
 Call Trace:
  [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
  [mutex_lock+9/16] mutex_lock+0x9/0x10
  [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
  [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
  [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
  [netlink_unicast+536/592] netlink_unicast+0x218/0x250
  [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
  [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
  [sys_sendto+273/320] sys_sendto+0x111/0x140
  [system_call+126/131] system_call+0x7e/0x83
 DWARF2 unwinder stuck at system_call+0x7e/0x83

[...]
52234.341105] Showing all locks held in the system:
52234.341113]
52234.341114] =============================================
52234.341115]
52234.394782] NETDEV WATCHDOG: eth1: transmit timed out
52236.210364] NETDEV WATCHDOG: eth1: transmit timed out
52238.026024] NETDEV WATCHDOG: eth1: transmit timed out
[...more of these, 'til I reboot with sysrq-b]


Notice that 'all locks held in the system' is empty.


There were three changes between rc3 and rc5:

$ hg log -rv2.6.19-rc3:v2.6.19-rc5 -I drivers/net/wireless/bcm43xx/
changeset:   40500:4ef6746b2f06
user:        Al Viro <viro@ftp.linux.org.uk>
date:        Wed Oct 25 12:01:11 2006 +0700
summary:     [PATCH] missing include of dma-mapping.h

changeset:   40964:ca97546422bd
user:        Michael Buesch <mb@bu3sch.de>
date:        Wed Nov 01 08:15:40 2006 +0500
summary:     [PATCH] bcm43xx: Fix low-traffic netdev watchdog TX timeouts

changeset:   40965:f5021f3521c2
user:        Larry Finger <Larry.Finger@lwfinger.net>
date:        Wed Nov 01 08:15:41 2006 +0500
summary:     [PATCH] bcm43xx: fix unexpected LED control values in BCM4303 sprom


Of those, the middle one is the most suspicious.

ray@phoenix:~/work/kernel/linux-2.6$ hg log -v -p -r 40964
changeset:   40964:ca97546422bd9a52a7000607d657ca2915f31104
user:        Michael Buesch <mb@bu3sch.de>
date:        Wed Nov 01 08:15:40 2006 +0500
files:       drivers/net/wireless/bcm43xx/bcm43xx_main.c
description:
[PATCH] bcm43xx: Fix low-traffic netdev watchdog TX timeouts

This fixes a netdev watchdog timeout problem.
The software needs to call netif_tx_disable before running the
hardware calibration code. The problem condition can be shown by the
following timegraph.

|---5secs - ~10 jiffies time---|---|OOPS
^                              ^
last real TX                   periodic work stops netif

At OOPS, the following happens:
The watchdog timer triggers, because the timeout of 5secs
is over. The watchdog first checks for stopped TX.
_Usually_ TX is only stopped from the TX handler to indicate
a full TX queue. But this is different. We need to stop TX here,
regardless of the TX queue state. So the watchdog recognizes
the stopped device and assumes it is stopped due to full
TX queues (Which is a _wrong_ assumption in this case). It then
tests how far the last TX has been in the past. If it's more than
5secs (which is the case for low or no traffic), it will fire
a TX timeout.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

committer: John W. Linville <linville@laptop.(none)> 1162350940 -0500


diff -r 41ff0150cbadd56e692f148adb1bfd4ca420e3e0 -r
ca97546422bd9a52a7000607d657ca2915f31104
drivers/net/wireless/bcm43xx/bcm43xx_main.c
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c       Wed Nov 01 08:15:39
2006 +0500
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c       Wed Nov 01 08:15:40
2006 +0500
@@ -3163,9 +3163,11 @@ static void bcm43xx_periodic_work_handle
 static void bcm43xx_periodic_work_handler(void *d)
 {
        struct bcm43xx_private *bcm = d;
+       struct net_device *net_dev = bcm->net_dev;
        unsigned long flags;
        u32 savedirqs = 0;
        int badness;
+       unsigned long orig_trans_start = 0;

        mutex_lock(&bcm->mutex);
        badness = estimate_periodic_work_badness(bcm->periodic_state);
@@ -3173,7 +3175,18 @@ static void bcm43xx_periodic_work_handle
                /* Periodic work will take a long time, so we want it to
                 * be preemtible.
                 */
-               netif_tx_disable(bcm->net_dev);
+
+               netif_tx_lock_bh(net_dev);
+               /* We must fake a started transmission here, as we are going to
+                * disable TX. If we wouldn't fake a TX, it would be possible to
+                * trigger the netdev watchdog, if the last real TX is already
+                * some time on the past (slightly less than 5secs)
+                */
+               orig_trans_start = net_dev->trans_start;
+               net_dev->trans_start = jiffies;
+               netif_stop_queue(net_dev);
+               netif_tx_unlock_bh(net_dev);
+
                spin_lock_irqsave(&bcm->irq_lock, flags);
                bcm43xx_mac_suspend(bcm);
                if (bcm43xx_using_pio(bcm))
@@ -3198,6 +3211,7 @@ static void bcm43xx_periodic_work_handle
                        bcm43xx_pio_thaw_txqueues(bcm);
                bcm43xx_mac_enable(bcm);
                netif_wake_queue(bcm->net_dev);
+               net_dev->trans_start = orig_trans_start;
        }
        mmiowb();
        spin_unlock_irqrestore(&bcm->irq_lock, flags);

...so, could someone with more of a clue than I review the locking here?

In the meantime, I could try to revert this and run with the changed kernel,
but I've only had this happen twice in the past four days (dunno how to
trigger it other than walking away from the laptop). As rc3 didn't give me any
troubles for the 13 some-odd days I ran it, I think it's safe to say this is a
new behavior with rc5 vs rc3.

Suggestions? Requests for <shudder> even more info?

Ray
