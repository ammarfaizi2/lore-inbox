Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWIFXPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWIFXPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWIFXOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:14:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:61131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964882AbWIFXA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:57 -0400
Date: Wed, 6 Sep 2006 15:55:21 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/37] Allow per-route window scale limiting
Message-ID: <20060906225521.GG15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="allow-per-route-window-scale-limiting.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

There are black box devices out there, routers and firewalls and
whatnot, that simply cannot grok the TCP window scaling option
correctly.

People should and do bark at the site running the device causing
the problems, but in the mean time folks do want a way to deal
with the problem.  We don't want them to turn off window scaling
completely as that hurts performance of connections that would run
just fine with window scaling enabled.

So give a way to do this on a per-route basis by limiting the
window scaling by the per-connection window clamp.  Stephen's
changelog message explains how to do this using a route metric.

[TCP]: Limit window scaling if window is clamped.

This small change allows for easy per-route workarounds for broken hosts or
middleboxes that are not compliant with TCP standards for window scaling.
Rather than having to turn off window scaling globally. This patch allows
reducing or disabling window scaling if window clamp is present.

Example: Mark Lord reported a problem with 2.6.17 kernel being unable to
access http://www.everymac.com

# ip route add 216.145.246.23/32 via 10.8.0.1 window 65535

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/tcp_output.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.11.orig/net/ipv4/tcp_output.c
+++ linux-2.6.17.11/net/ipv4/tcp_output.c
@@ -197,6 +197,7 @@ void tcp_select_initial_window(int __spa
 		 * See RFC1323 for an explanation of the limit to 14 
 		 */
 		space = max_t(u32, sysctl_tcp_rmem[2], sysctl_rmem_max);
+		space = min_t(u32, space, *window_clamp);
 		while (space > 65535 && (*rcv_wscale) < 14) {
 			space >>= 1;
 			(*rcv_wscale)++;

--
