Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWDEVW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWDEVW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWDEVW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:22:28 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:33551
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S1751178AbWDEVW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:22:27 -0400
From: David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17460.13568.175877.44476@dl2.hq2.avtrex.com>
Date: Wed, 5 Apr 2006 14:22:08 -0700
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: pgf@foxharp.boston.ma.us
CC: freek@macfreek.nl
Subject: [PATCH] net: Broadcast ARP packets on link local addresses (Version2).
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Daney

Here is a new version of the patch I sent March 31.  For background,
this is my description from the first patch:

> When an internet host joins a network where there is no DHCP server,
> it may auto-allocate an IP address by the method described in RFC
> 3927.  There are several user space daemons available that implement
> most of the protocol (zcip, busybox, ...).  The kernel's APR driver
> should function in the normal manner except that it is required to
> broadcast all ARP packets that it originates in the link local address
> space (169.254.0.0/16).  RFC 3927 section 2.5 explains the requirement.

> The current ARP code is non-compliant because it does not broadcast
> some ARP packets as required by RFC 3927.

> This patch to net/ipv4/arp.c checks the source address of all ARP
> packets and if the fall in 169.254.0.0/16, they are broadcast instead
> of unicast.

All of that is still true.

The changes in this version are that it tests the source IP address
instead of the destination.  The test now matches the test described
in the RFC.  Also a small cleanup as suggested by Herbert Xu.

Some comments on the first version of the patch suggested that I do
'X' instead.  Where 'X' was behavior different than that REQUIRED by
the RFC (the RFC's always seem to capitalize the word 'required').

The reason that I implemented the behavior required by the RFC is so
that a device running the kernel can pass compliance tests that
mandate RFC compliance.

If the patch is deemed good and correct, great, please apply it.

Othwise comments about how to improve it are always welcome.  But keep
in mind that I would like to end up with something that complies with
the RFC.

This patch is against 2.6.16.1

Signed-off-by: David Daney <ddaney@avtrex.com>

---

--- net/ipv4/arp.c.orig	2006-03-31 13:44:50.000000000 -0800
+++ net/ipv4/arp.c	2006-04-05 13:33:19.000000000 -0700
@@ -690,6 +690,11 @@ void arp_send(int type, int ptype, u32 d
 	if (dev->flags&IFF_NOARP)
 		return;
 
+        /* If link local address (169.254.0.0/16) we must broadcast
+         * the ARP packet.  See RFC 3927 section 2.5 for details. */
+	if ((src_ip & htonl(0xFFFF0000UL)) == htonl(0xA9FE0000UL))
+		dest_hw = NULL;
+
 	skb = arp_create(type, ptype, dest_ip, dev, src_ip,
 			 dest_hw, src_hw, target_hw);
 	if (skb == NULL) {
