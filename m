Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268056AbRG2QAB>; Sun, 29 Jul 2001 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268057AbRG2P7w>; Sun, 29 Jul 2001 11:59:52 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:61202 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268056AbRG2P7h>;
	Sun, 29 Jul 2001 11:59:37 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107291559.TAA15413@ms2.inr.ac.ru>
Subject: Re: missing icmp errors for udp packets
To: pekkas@netcore.fi (Pekka Savola)
Date: Sun, 29 Jul 2001 19:59:11 +0400 (MSK DST)
Cc: therapy@endorphin.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        davem@redhat.com (Dave Miller)
In-Reply-To: <Pine.LNX.4.33.0107290739370.2081-100000@netcore.fi> from "Pekka Savola" at Jul 29, 1 07:57:48 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> So in conclusion:
> 
> with net.ipv4.icmp_echoreply_rate=0:

Congratulations! That's why I do not see this, forgot to ping before. :-)

The patch is enclosed.

Alexey


--- ../dust/vger3-010728/linux/net/ipv4/icmp.c	Thu Jun 14 22:49:44 2001
+++ linux/net/ipv4/icmp.c	Sun Jul 29 19:52:55 2001
@@ -240,12 +240,15 @@
 int xrlim_allow(struct dst_entry *dst, int timeout)
 {
 	unsigned long now;
+	static int burst;
 
 	now = jiffies;
 	dst->rate_tokens += now - dst->rate_last;
 	dst->rate_last = now;
-	if (dst->rate_tokens > XRLIM_BURST_FACTOR*timeout)
-		dst->rate_tokens = XRLIM_BURST_FACTOR*timeout;
+	if (burst < XRLIM_BURST_FACTOR*timeout)
+		burst = XRLIM_BURST_FACTOR*timeout;
+	if (dst->rate_tokens > burst)
+		dst->rate_tokens = burst;
 	if (dst->rate_tokens >= timeout) {
 		dst->rate_tokens -= timeout;
 		return 1;
