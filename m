Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTIIKaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTIIKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:30:20 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63995 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263997AbTIIKaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:30:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16221.43957.387148.283518@gargle.gargle.HOWL>
Date: Tue, 9 Sep 2003 12:30:13 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH][2.4.23-pre3] fix networking hangs at suspend/resume
In-Reply-To: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading my laptop from 2.4.23-pre2 to -pre3 it started
hanging hard in conjunction with APM suspend or resume. Typically
the hang occurs after 2-3 suspend/resume cycles.

After two days of working through the 2.4.23-pre2 -> 2.4.23-pre3
patch piece by piece, I traced it to this change:

 > Jeff Garzik:
 >   o [NET] move netif_* helpers from tg3 driver to linux/netdevice.h

A while-test_bit in net/core/dev.c was replaced (indirectly via a
new inline function) by a while-test_and_set_bit. This is not correct
in general, and in this code triggers semi-random hangs at suspend
or resume. I've not seen any hangs at other times, however.

This patch reverts the broken part of the cleanup.

/Mikael

--- linux-2.4.23-pre3/net/core/dev.c.~1~	2003-09-09 02:01:08.000000000 +0200
+++ linux-2.4.23-pre3/net/core/dev.c	2003-09-09 02:02:00.000000000 +0200
@@ -851,7 +851,11 @@
 	 * engine, but this requires more changes in devices. */
 
 	smp_mb__after_clear_bit(); /* Commit netif_running(). */
-	netif_poll_disable(dev);
+	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+		/* No hurry. */
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(1);
+	}
 
 	/*
 	 *	Call the device specific close. This cannot fail.
