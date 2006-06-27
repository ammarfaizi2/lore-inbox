Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWF0KQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWF0KQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWF0KQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:16:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29316 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932570AbWF0KQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:16:33 -0400
Date: Tue, 27 Jun 2006 12:16:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0606271212150.17704@scrub.home>
References: <20060624061914.202fbfb5.akpm@osdl.org>
 <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 Jun 2006, Valdis.Kletnieks@vt.edu wrote:

> Which looks like a good place to get hung in a loop for a while....
> 
> Eventually (after about 2 minutes, it finally unwedges and continues on.
> 
> Any ideas?

Could you please try the patch below?
tv_nsec can shortly become negative, but its absolute value will always be 
smaller then the current nsec offset.

bye, Roman

---
 kernel/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-06-27 11:59:19.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-06-27 12:10:28.000000000 +0200
@@ -1129,7 +1129,7 @@ static void update_wall_time(void)
 	clocksource_adjust(clock, offset);
 
 	/* store full nanoseconds into xtime */
-	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
+	xtime.tv_nsec = (s64)clock->xtime_nsec >> clock->shift;
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */
