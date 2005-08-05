Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVHELqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVHELqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 07:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbVHELqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 07:46:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262991AbVHELqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 07:46:00 -0400
To: John =?iso-8859-1?q?B=E4ckstrand?= <sandos@home.se>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Aug 2005 13:45:55 +0200
In-Reply-To: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
Message-ID: <p73ek987gjw.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bäckstrand <sandos@home.se> writes:

> I've been trying to hunt down a hard lockup issue with some hardware
> of mine, but I've possibly hit a kernel bug instead. When using
> netconsole on my e1000, if I unplug the cable and then re-plug it, the
> machine locks up hard. It manages to print the "link up" message on
> the screen, but nothing after that. Now, I wonder if this is supposed
> to be so? I tried this on 4 different configurations, 2.6.13-rc5 and
> 2.6.12 with and without "noapic acpi=off", same result on all of
> them. I've tried with 1 and 3 other NICs in the machine at the same
> time.

I ran into the same problem some time ago on e1000. The problem was
that if the link doesn't come up netconsole ends up waiting forever
for it.

The patch was for 2.6.12, did a quick untested port to 2.6.13rc5.

-Andi

Only try a limited number to send packets in netpoll

Avoids hangs on e1000 when link is not up.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/net/core/netpoll.c
===================================================================
--- linux.orig/net/core/netpoll.c
+++ linux/net/core/netpoll.c
@@ -247,9 +247,11 @@ static void netpoll_send_skb(struct netp
 {
 	int status;
 	struct netpoll_info *npinfo;
+	/* Only try 5 times in case the link is down etc. */
+	int try = 5;
 
 repeat:
-	if(!np || !np->dev || !netif_running(np->dev)) {
+	if(try-- == 0 || !np || !np->dev || !netif_running(np->dev)) {
 		__kfree_skb(skb);
 		return;
 	}
@@ -286,6 +288,9 @@ repeat:
 
 	/* transmit busy */
 	if(status) {
+		/* Don't count spinlock as try */
+		if (status == NETDEV_TX_LOCKED)
+			try++; 
 		netpoll_poll(np);
 		goto repeat;
 	}
