Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVIBSha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVIBSha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVIBSha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:37:30 -0400
Received: from yakov.inr.ac.ru ([194.67.69.111]:51896 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750778AbVIBSh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:37:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=XSSaaPEn4u7qwRTqhmMgfImx1Wk04sUJp/Y4hon+lwKRHqUs8TPxv5J3BBN9kd1ahSVyzmecyBk2KwDJuGM/2W0tyL7lmVSkDd6w4isu9H6te44oWpi/lZA4mUIQPObyxF9SYQHj4XyAnQsgmFDHkvKy6TmMgVUkeCl053fEgQY=;
Date: Fri, 2 Sep 2005 22:36:56 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Ion Badulescu <lists@limebrokerage.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Message-ID: <20050902183656.GA16537@yakov.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is where things start going bad. The window starts shrinking from 
> 15340 all the way down to 2355 over the course of 0.3 seconds. Notice the 
> many duplicate acks that serve no purpose

These are not duplicate, TCP_NODELAY sender just starts flooding
tiny segments, and those are normal ACKs acking those segments, note
ACK field is not the same.

> Five minutes later the TCP window is still at 2355,
....
> We are kind of stumped at this point, and it's proving to be a 
> show-stopping bug for our purposes, especially over WAN links that have 
> higher latency (for obvious reasons). Any kind of assistance would be 
> greatly appreciated.

I still do not know how the value of 184 is possible in your case,
I would expect 730 as an absolute possible minumum. I see 9420 (2355*4).
Anyway, ignoring this puzzle, the following patch for 2.4 should help.


--- net/ipv4/tcp_input.c.orig	2003-02-20 20:38:39.000000000 +0300
+++ net/ipv4/tcp_input.c	2005-09-02 22:28:00.845952888 +0400
@@ -343,8 +343,6 @@
 			app_win -= tp->ack.rcv_mss;
 		app_win = max(app_win, 2U*tp->advmss);
 
-		if (!ofo_win)
-			tp->window_clamp = min(tp->window_clamp, app_win);
 		tp->rcv_ssthresh = min(tp->window_clamp, 2U*tp->advmss);
 	}
 }

