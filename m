Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280807AbRKHA7O>; Wed, 7 Nov 2001 19:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280907AbRKHA7E>; Wed, 7 Nov 2001 19:59:04 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:38920 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280807AbRKHA64>; Wed, 7 Nov 2001 19:58:56 -0500
Date: Thu, 8 Nov 2001 01:58:45 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "David S. Miller" <davem@redhat.com>
cc: <adilger@turbolabs.com>, <jgarzik@mandrakesoft.com>, <andrewm@uow.edu.au>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <netdev@oss.sgi.com>, <ak@muc.de>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <20011107.164426.35502643.davem@redhat.com>
Message-ID: <Pine.LNX.4.30.0111080157180.29908-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why do they these cases that are actually in the code need to cast to
> a signed value to get a correct answer?  They are not like your
> example.
>
> Almost all of these cases are:
>
> 	(jiffies - SOME_VALUE_KNOWN_TO_BE_IN_THE_PAST) > 5 * HZ
>
> So you say if we don't cast to signed, this won't get it right on
> wrap-around?  I disagree, let's say "long" is 32-bits and jiffies
> wrapped around to "0x2" and SOME_VALUE... is 0xfffffff8.  The
> subtraction above yields 10, and that is what we want.
>
> Please show me a bad case where casting to signed is necessary.
>
> I actually ran through the tree the other night myself starting to
> convert these things, then I noticed that I couldn't even convince
> myself that the code was incorrect.
>


Please consider to change the appended ones.

Tim


--- linux-2.4.14/net/ipv4/route.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/route.c	Wed Nov  7 22:51:23 2001
@@ -395,7 +395,7 @@
 		write_unlock(&rt_hash_table[i].lock);

 		/* Fallback loop breaker. */
-		if ((jiffies - now) > 0)
+		if ((long)(jiffies - now) > 0)
 			break;
 	}
 	rover = i;
--- linux-2.4.14/net/ipv4/ipconfig.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/ipconfig.c	Wed Nov  7 23:28:47 2001
@@ -1000,7 +1000,7 @@
 #endif

 		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
-		while (jiffies < jiff && !ic_got_reply)
+		while ((long)(jiffies - jiff) < 0 && !ic_got_reply)
 			barrier();
 #ifdef IPCONFIG_DHCP
 		/* DHCP isn't done until we get a DHCPACK. */
@@ -1113,7 +1113,7 @@
  try_try_again:
 	/* Give hardware a chance to settle */
 	jiff = jiffies + CONF_PRE_OPEN;
-	while (jiffies < jiff)
+	while ((long)(jiffies - jiff) < 0)
 		;

 	/* Setup all network devices */
@@ -1122,7 +1122,7 @@

 	/* Give drivers a chance to settle */
 	jiff = jiffies + CONF_POST_OPEN;
-	while (jiffies < jiff)
+	while ((long)(jiffies - jiff) < 0)
 			;

 	/*

