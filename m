Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272225AbTHDVtl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272154AbTHDVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:49:40 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:17306 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S272148AbTHDVtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:49:25 -0400
Date: Mon, 4 Aug 2003 23:49:22 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Patrick Moor <pmoor@netpeople.ch>
cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
Subject: Re: time jumps (again)
In-Reply-To: <3F2E8B3B.3070003@netpeople.ch>
Message-ID: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some days ago I started noticing strange time jumps on my Athlon system.
> (Asus board, VIA chipset, AMD Athlon 650MHz processor). I haven't
> noticed them before and I am pretty sure there weren't any for the last
> few years! Uptime of the machine is now 218 days, and problems began
> appearing after 215 days approximately.
>
> What happens: when doing a
>   $ while true; do date; done
> I'm noticing time jumps _exactly_ at the beginning of a "new" second (or
> at the end of an "old" one). the jump is exactly 4294 (4295) seconds
> into the future. Example:
> ...
> Mon Aug  4 18:11:06 CEST 2003
> Mon Aug  4 18:11:06 CEST 2003
> Mon Aug  4 19:22:41 CEST 2003
> Mon Aug  4 19:22:41 CEST 2003
> Mon Aug  4 19:22:41 CEST 2003
> Mon Aug  4 18:11:07 CEST 2003
> Mon Aug  4 18:11:07 CEST 2003
> ...
>

Wild guess - does the following patch fix it?

Tim


--- linux-2.4.20/arch/i386/kernel/time.c.orig	Mon Aug  4 23:38:47 2003
+++ linux-2.4.20/arch/i386/kernel/time.c	Mon Aug  4 23:40:53 2003
@@ -274,8 +274,8 @@
 	read_lock_irqsave(&xtime_lock, flags);
 	usec = do_gettimeoffset();
 	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
+		long lost = jiffies - wall_jiffies;
+		if (lost>0)
 			usec += lost * (1000000 / HZ);
 	}
 	sec = xtime.tv_sec;

