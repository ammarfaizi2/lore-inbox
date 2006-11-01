Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946549AbWKAFqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946549AbWKAFqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946547AbWKAFqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:46:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2781 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946548AbWKAFp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:45:56 -0500
Message-Id: <20061101054600.602158000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:38 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH 58/61] tcp: cubic scaling error
Content-Disposition: inline; filename=tcp-cubic-scaling-error.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

Doug Leith observed a discrepancy between the version of CUBIC described
in the papers and the version in 2.6.18. A math error related to scaling
causes Cubic to grow too slowly.

Patch is from "Sangtae Ha" <sha2@ncsu.edu>. I validated that
it does fix the problems.

See the following to show behavior over 500ms 100 Mbit link.

Sender (2.6.19-rc3) ---  Bridge (2.6.18-rt7) ------- Receiver (2.6.19-rc3)
                    1G      [netem]           100M

	http://developer.osdl.org/shemminger/tcp/2.6.19-rc3/cubic-orig.png
	http://developer.osdl.org/shemminger/tcp/2.6.19-rc3/cubic-fix.png

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv4/tcp_cubic.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18.1.orig/net/ipv4/tcp_cubic.c
+++ linux-2.6.18.1/net/ipv4/tcp_cubic.c
@@ -190,7 +190,7 @@ static inline void bictcp_update(struct 
          */
 
 	/* change the unit from HZ to bictcp_HZ */
-        t = ((tcp_time_stamp + ca->delay_min - ca->epoch_start)
+        t = ((tcp_time_stamp + (ca->delay_min>>3) - ca->epoch_start)
 	     << BICTCP_HZ) / HZ;
 
         if (t < ca->bic_K)		/* t - K */
@@ -259,7 +259,7 @@ static inline void measure_delay(struct 
 	    (s32)(tcp_time_stamp - ca->epoch_start) < HZ)
 		return;
 
-	delay = tcp_time_stamp - tp->rx_opt.rcv_tsecr;
+	delay = (tcp_time_stamp - tp->rx_opt.rcv_tsecr)<<3;
 	if (delay == 0)
 		delay = 1;
 
@@ -366,7 +366,7 @@ static int __init cubictcp_register(void
 
 	beta_scale = 8*(BICTCP_BETA_SCALE+beta)/ 3 / (BICTCP_BETA_SCALE - beta);
 
-	cube_rtt_scale = (bic_scale << 3) / 10;	/* 1024*c/rtt */
+	cube_rtt_scale = (bic_scale * 10);	/* 1024*c/rtt */
 
 	/* calculate the "K" for (wmax-cwnd) = c/rtt * K^3
 	 *  so K = cubic_root( (wmax-cwnd)*rtt/c )

--
