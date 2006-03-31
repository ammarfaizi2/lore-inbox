Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWCaX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWCaX0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWCaX0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:26:12 -0500
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:22558
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S1751431AbWCaX0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:26:11 -0500
From: David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <17453.47752.914390.692779@dl2.hq2.avtrex.com>
Date: Fri, 31 Mar 2006 15:26:00 -0800
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: freek@macfreek.nl
CC: pgf@foxharp.boston.ma.us
Subject: [PATCH] net: Broadcast ARP packets on link local addresses
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Daney

Greetings,

When an internet host joins a network where there is no DHCP server,
it may auto-allocate an IP address by the method described in RFC
3927.  There are several user space daemons available that implement
most of the protocol (zcip, busybox, ...).  The kernel's APR driver
should function in the normal manner except that it is required to
broadcast all ARP packets that it originates in the link local address
space (169.254.0.0/16).  RFC 3927 section 2.5 explains the requirement.

The current ARP code is non-compliant because it does not broadcast
some ARP packets as required by RFC 3927.

This patch to net/ipv4/arp.c checks the source address of all ARP
packets and if the fall in 169.254.0.0/16, they are broadcast instead
of unicast.  I would like to thank Freek Dijkstra wrote the first
version of the patch.  He was kind enough to sign off on it in his
(off-list) e-mail to me:

>David Daney wrote:
>
>
>> For the linux kernel the requirements for contributing are quite easy.
>> All people who wrote the patch simply affirm that they are have the
>> right to contribute and that they are doing so.  See section 11 of
>> Documentation/SubmittingPatches in the kernel source tree.
>
>
> Just read. (a) and (d) apply (I wrote it, and I'm fine that you use it):
> Signed-off-by: Freek Dijkstra <freek@macfreek.nl>
>
.
.
.
>
> I hereby release the above patch in the public domain.
> (You may credit me or not, I don't think it's needed).
>
> Have fun.
> Freek

This patch is against 2.6.16.1 

Signed-off-by: David Daney <ddaney@avtrex.com>

---

--- net/ipv4/arp.c.orig	2006-03-31 13:44:50.000000000 -0800
+++ net/ipv4/arp.c	2006-03-31 13:48:26.000000000 -0800
@@ -682,6 +682,7 @@ void arp_send(int type, int ptype, u32 d
 	      unsigned char *target_hw)
 {
 	struct sk_buff *skb;
+	int lla;
 
 	/*
 	 *	No arp on this interface.
@@ -690,8 +691,13 @@ void arp_send(int type, int ptype, u32 d
 	if (dev->flags&IFF_NOARP)
 		return;
 
+	/* If link local address (169.254.0.0/16) we must broadcast
+         * the ARP packet.  See RFC 3927 section 2.5 for details.
+	 */
+	lla = (dest_ip & htonl(0xFFFF0000UL)) == htonl(0xA9FE0000UL);
+
 	skb = arp_create(type, ptype, dest_ip, dev, src_ip,
-			 dest_hw, src_hw, target_hw);
+			 lla ? NULL : dest_hw, src_hw, target_hw);
 	if (skb == NULL) {
 		return;
 	}
