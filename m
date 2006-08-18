Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWHRR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWHRR3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWHRR3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:29:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751426AbWHRR3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:29:36 -0400
Date: Fri, 18 Aug 2006 10:29:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: limit window scaling if window is clamped
Message-ID: <20060818102938.5abc1bcf@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small change allows for easy per-route workarounds for broken hosts or
middleboxes that are not compliant with TCP standards for window scaling.
Rather than having to turn off window scaling globally. This patch allows
reducing or disabling window scaling if window clamp is present.

Example: Mark Lord reported a problem with 2.6.17 kernel being unable to
access http://www.everymac.com

# ip route add 216.145.246.23/32 via 10.8.0.1 window 65535

I would argue this ought to go in stable kernel as well.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- net-2.6.19.orig/net/ipv4/tcp_output.c
+++ net-2.6.19/net/ipv4/tcp_output.c
@@ -201,6 +201,7 @@ void tcp_select_initial_window(int __spa
 		 * See RFC1323 for an explanation of the limit to 14 
 		 */
 		space = max_t(u32, sysctl_tcp_rmem[2], sysctl_rmem_max);
+		space = min_t(u32, space, *window_clamp);
 		while (space > 65535 && (*rcv_wscale) < 14) {
 			space >>= 1;
 			(*rcv_wscale)++;
