Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbREVKwT>; Tue, 22 May 2001 06:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbREVKwJ>; Tue, 22 May 2001 06:52:09 -0400
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:16136 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261268AbREVKwC>; Tue, 22 May 2001 06:52:02 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200105221051.f4MApxE22279@xyzzy.clara.co.uk>
Subject: SyncPPP IPCP/LCP loop problem and patch
To: linux-kernel@vger.kernel.org
Date: Tue, 22 May 2001 11:51:59 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've hit a problem with the syncPPP module within Linux.

Under certain conditions (hard to quantify exactly, but try several 8Mbps
streams hitting a relatively slow, say 200MHz processor) the LCP/IPCP
negotiation hits the following loop.


    A side state           Packet               B side state

                                                ACK sent
                <--     LCP conf ACK
    Opened
                        IPCP conf REQ   -->

                <--     LCP conf REQ
    ACK sent
                        LCP conf ACK    -->
                                                Opened
                <--     IPCP conf REQ

                        LCP conf REQ    -->
                                                ACK sent
                <--     LCP conf ACK
    Opened
                        IPCP conf REQ   -->

                <--     LCP conf REQ
    ACK sent
                        LCP conf ACK    -->
                                                Opened
                <--     IPCP conf REQ

                        LCP conf REQ    -->
                                                ACK sent
    ...


Basically one end has reached the IPCP level before the other. When it sees
an incoming LCP packet the RFC1661 state machine drops back to LCP but the
responses generated take the other end up to the IPCP level. The result is
an endless storm of small packets back and forth generating "IPCP when still
waiting LCP finish" messages.

Flip-flopping between IPCP and LCP like this seems to defeat the normal LCP
timeouts. I've searched the archives and found several solutions none of
which I found particularly satisfying. The best was "the driver will
eventually drop a packet breaking the loop", sorry but I try not to drop
packets in my drivers :-) Most of the rest shortened LCP timeouts or did
something else that modified the timing and I guess moved the problem for a
particular system, none of them seemed general purpose.


My solution in the patch that follows is to detect the flip-flop using a
counter and then after three occurrences with no genuine IPCP traffic to
modify behavior on receipt of the LCP conf REQ. After three attempts we
acknowledge the LCP conf REQ but stay in the opened state rather than
dropping back and restarting our own LCP negotiation. This is non-RFC1661
behavior unless you consider it part of the general loop avoidance directive.

I've tested this patch against an unmodified Linux system (where I first saw
the problem), a modified system (would be no good if it didn't work against
itself), NT RRAS and a small Cisco router. Of course I can't hit all timing
variants but it looks solid to me.


--- linux/include/net/syncppp.h.orig	Mon May 21 11:01:29 2001
+++ linux/include/net/syncppp.h	Mon May 21 11:01:28 2001
@@ -48,6 +48,7 @@
 	struct timer_list	pp_timer;
 	struct net_device	*pp_if;
 	char		pp_link_state;	/* Link status */
+	char		ipcp_b4_lcp;	/* IPCP up error counter */
 };
 
 struct ppp_device
--- linux/drivers/net/wan/syncppp.c.orig	Mon May 21 11:01:28 2001
+++ linux/drivers/net/wan/syncppp.c	Mon May 21 11:01:25 2001
@@ -262,10 +262,14 @@
 			kfree_skb(skb);
 			return;
 		case PPP_IPCP:
-			if (sp->lcp.state == LCP_STATE_OPENED)
+			if (sp->lcp.state == LCP_STATE_OPENED) {
+				sp->ipcp_b4_lcp = 0;
 				sppp_ipcp_input (sp, skb);
-			else
+			}
+			else {
 				printk(KERN_DEBUG "IPCP when still waiting LCP finish.\n");
+				sp->ipcp_b4_lcp++;
+			}
 			kfree_skb(skb);
 			return;
 		case PPP_IP:
@@ -529,6 +533,16 @@
 			sppp_ipcp_open (sp);
 			break;
 		case LCP_STATE_OPENED:
+			/* If it looks like we're looping in a IPCP<->LCP flip-
+			 * flop. ACK this one and stay open. Warning this is
+			 * non-RFC1661 behaviour.
+			 */
+			if (sp->ipcp_b4_lcp > 3) {
+				printk (KERN_DEBUG "IPCP<->LCP loop avoidance\n");
+				sp->ipcp_b4_lcp = 0;
+				break;
+			}
+
 			/* Remote magic changed -- close session. */
 			sp->lcp.state = LCP_STATE_CLOSED;
 			sp->ipcp.state = IPCP_STATE_CLOSED;
-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
