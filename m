Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267873AbUHSCI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267873AbUHSCI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUHSCIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:08:25 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:19174 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S267873AbUHSCIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:08:17 -0400
Message-ID: <41240B8B.9A7F6CFF@akamai.com>
Date: Wed, 18 Aug 2004 19:08:11 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: srtt and rtt_seq out of sync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   tcp_init_metrics initialises srtt from route cache.
   tcp_rtt_estimator has an assumption that
   whenerver srtt is set, rtt_seq is set.
   Invariant assumed  before(rtt_seq,snd_nxt) is
   not true most of the time while initailising from
   cache, so rttvar will  not be calcualted for this
   socket,  rto will be wrong for long time.
   The condition after(send_una, rtt_seq=0) is
   correct 50% of the time of random send_una.
   mdev check also resets the rttvar, but it will be
   slower.

   One fix is,  initialising the rtt_seq in tcp_init_metrics
   properly. Another fix is, doing the special check
   like the below to test whether the invariant has
   failed, i.e. initialised from the route cache.

 --- net/ipv4/tcp_input.c Tue Jun 15 22:19:43 2004
+++ net/ipv4/tcp_input.c Wed Aug 18 17:36:18 2004
@@ -641,7 +641,7 @@
                        if (tp->mdev_max > tp->rttvar)
                                tp->rttvar = tp->mdev_max;
                }
-               if (after(tp->snd_una, tp->rtt_seq)) {
+               if (after(tp->snd_una, tp->rtt_seq) ||
before(tp->snd_nxt, tp->rtt_seq))
                        if (tp->mdev_max < tp->rttvar)
                                tp->rttvar -=
(tp->rttvar-tp->mdev_max)>>2;
                        tp->rtt_seq = tp->snd_nxt;

Fix from Dave miller:
===== net/ipv4/tcp_input.c 1.69 vs edited =====
--- 1.69/net/ipv4/tcp_input.c   2004-08-02 17:05:30 -07:00
+++ edited/net/ipv4/tcp_input.c 2004-08-18 17:53:54 -07:00
@@ -852,8 +852,10 @@
         * to low value, and then abruptly stops to do it and starts to
delay
         * ACKs, wait for troubles.
         */
-       if (dst_metric(dst, RTAX_RTT) > tp->srtt)
+       if (dst_metric(dst, RTAX_RTT) > tp->srtt) {
                tp->srtt = dst_metric(dst, RTAX_RTT);
+               tp->rtt_seq = tp->snd_nxt;
+       }
        if (dst_metric(dst, RTAX_RTTVAR) > tp->mdev) {
                tp->mdev = dst_metric(dst, RTAX_RTTVAR);
                tp->mdev_max = tp->rttvar = max(tp->mdev, TCP_RTO_MIN);

Thanks,
Prasanna.

