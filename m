Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTIIKfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTIIKfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:35:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:59644 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264018AbTIIKfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:35:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16221.44281.111131.741294@gargle.gargle.HOWL>
Date: Tue, 9 Sep 2003 12:35:37 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: Linux 2.6.0-test5
In-Reply-To: <3F5D0B09.1040802@pobox.com>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
	<3F5D0B09.1040802@pobox.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Note that people seeing "ifconfig down ... ifconfig up" problems need to 
 > apply this patch.  (to 2.4.23-pre, too)
 > 
 > 	Jeff
 > 
 > 
 > diff -Nru a/net/core/dev.c b/net/core/dev.c
 > --- a/net/core/dev.c	Mon Sep  8 18:14:36 2003
 > +++ b/net/core/dev.c	Mon Sep  8 18:14:36 2003
 > @@ -851,7 +851,11 @@
 >  	 * engine, but this requires more changes in devices. */
 >  
 >  	smp_mb__after_clear_bit(); /* Commit netif_running(). */
 > -	netif_poll_disable(dev);
 > +	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
 > +		/* No hurry. */
 > +		current->state = TASK_INTERRUPTIBLE;
 > +		schedule_timeout(1);
 > +	}

I independently discovered this bug in 2.4.23-pre3 last night,
where it caused my laptop to randomly lock up at suspends or
resumes. That may have been APM doing ifconfigs behind my
back, I don't know, all I got was a black screen :-(
