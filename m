Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVLEWjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVLEWjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 17:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVLEWjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 17:39:48 -0500
Received: from pat.uio.no ([129.240.130.16]:33703 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964839AbVLEWjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 17:39:47 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
References: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
Content-Type: multipart/mixed; boundary="=-2Sph9BjmemsD6od2DSwI"
Date: Mon, 05 Dec 2005 17:39:27 -0500
Message-Id: <1133822367.8003.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.997, required 12,
	autolearn=disabled, AWL 1.82, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Sph9BjmemsD6od2DSwI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Gah... This is the problem:


[  125.263017] rpciod/2      D 00000004     0  2772     15          2773
2771 (L-TLB)
[  125.271338] f70ccaa8 f70cca98 00000004 00000004 ffffffce f70cca74
c0117800 00000002 
[  125.279560]        c221f560 c2330030 05f561fa 0000000e 00000202
c221ffe0 f70ccabc 00000202 
[  125.288692]        c221ffe0 f70ccabc c221f560 00000002 00000143
2b8c50f7 0000001d c2330030 
[  125.297821] Call Trace:
[  125.300636]  [<c04086e1>] schedule_timeout+0x54/0xa5
[  125.305931]  [<c040866e>] io_schedule_timeout+0x29/0x33
[  125.311495]  [<c02880c4>] blk_congestion_wait+0x70/0x85
[  125.317058]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
[  125.322720]  [<c014714d>] shrink_zone+0xe0/0xfa
[  125.327560]  [<c01471d4>] shrink_caches+0x6d/0x6f
[  125.332581]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
[  125.338056]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
[  125.343258]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
[  125.348281]  [<c03d4666>] inet_sendmsg+0x48/0x53
[  125.353212]  [<c0388716>] sock_sendmsg+0xb8/0xd3
[  125.358147]  [<c0388773>] kernel_sendmsg+0x42/0x4f
[  125.363259]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
[  125.368556]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
[  125.374306]  [<c03ed4c5>] xprt_transmit+0x4f/0x20b
....

If a process is blocking in an OOM situation in the socket layer, then
you are hosed.

Argh... Not sure entirely how to deal with that... We definitely don't
want the thing futzing around inside throttle_vm_writeout(), 'cos
writeout isn't going to happen while the socket blocks.

...OTOH, I'm not entirely sure we want to use GFP_ATOMIC and risk
bleeding the emergency pools dry: we also need those in order to receive
replies from the server.

Ah, well... Try GFP_ATOMIC first, and see if that helps.

Cheers,
 Trond


--=-2Sph9BjmemsD6od2DSwI
Content-Disposition: inline; filename=linux-2.6.15-fix_sock_allocation.dif
Content-Type: text/plain; name=linux-2.6.15-fix_sock_allocation.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

RPC: Do not block on skb allocation

 If we get something like the following,
 [  125.300636]  [<c04086e1>] schedule_timeout+0x54/0xa5
 [  125.305931]  [<c040866e>] io_schedule_timeout+0x29/0x33
 [  125.311495]  [<c02880c4>] blk_congestion_wait+0x70/0x85
 [  125.317058]  [<c014136b>] throttle_vm_writeout+0x69/0x7d
 [  125.322720]  [<c014714d>] shrink_zone+0xe0/0xfa
 [  125.327560]  [<c01471d4>] shrink_caches+0x6d/0x6f
 [  125.332581]  [<c01472a6>] try_to_free_pages+0xd0/0x1b5
 [  125.338056]  [<c013fa4b>] __alloc_pages+0x135/0x2e8
 [  125.343258]  [<c03b74ad>] tcp_sendmsg+0xaa0/0xb78
 [  125.348281]  [<c03d4666>] inet_sendmsg+0x48/0x53
 [  125.353212]  [<c0388716>] sock_sendmsg+0xb8/0xd3
 [  125.358147]  [<c0388773>] kernel_sendmsg+0x42/0x4f
 [  125.363259]  [<c038bc00>] sock_no_sendpage+0x5e/0x77
 [  125.368556]  [<c03ee7af>] xs_tcp_send_request+0x2af/0x375
 then the socket is blocked until memory is reclaimed, and no
 progress can ever be made.

 Try to access the emergency pools by using GFP_ATOMIC.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 net/sunrpc/xprtsock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0a51fd4..77e8800 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -990,6 +990,7 @@ static void xs_udp_connect_worker(void *
 		sk->sk_data_ready = xs_udp_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
 		sk->sk_no_check = UDP_CSUM_NORCV;
+		sk->sk_allocation = GFP_ATOMIC;
 
 		xprt_set_connected(xprt);
 
@@ -1074,6 +1075,7 @@ static void xs_tcp_connect_worker(void *
 		sk->sk_data_ready = xs_tcp_data_ready;
 		sk->sk_state_change = xs_tcp_state_change;
 		sk->sk_write_space = xs_tcp_write_space;
+		sk->sk_allocation = GFP_ATOMIC;
 
 		/* socket options */
 		sk->sk_userlocks |= SOCK_BINDPORT_LOCK;

--=-2Sph9BjmemsD6od2DSwI--

