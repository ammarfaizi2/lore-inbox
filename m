Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTIIA0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTIIA0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:26:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:2470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263835AbTIIA0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:26:49 -0400
Date: Mon, 8 Sep 2003 17:09:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: fedor@karpelevitch.net, abz@frogfoot.net, linux-kernel@vger.kernel.org
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
Message-Id: <20030908170902.66f85c38.akpm@osdl.org>
In-Reply-To: <3F5D17EA.4010502@pobox.com>
References: <20030904180554.GA21536@oasis.frogfoot.net>
	<200309071217.03470.fedor@karpelevitch.net>
	<20030907191552.GA26123@oasis.frogfoot.net>
	<200309080943.26254.fedor@karpelevitch.net>
	<20030908172641.GB21226@gtf.org>
	<20030908133220.66676107.akpm@osdl.org>
	<3F5D17EA.4010502@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > diff -puN include/linux/netdevice.h~ifdown-lockup-fix include/linux/netdevice.h
> > --- 25/include/linux/netdevice.h~ifdown-lockup-fix	Mon Sep  8 13:20:28 2003
> > +++ 25-akpm/include/linux/netdevice.h	Mon Sep  8 13:20:34 2003
> > @@ -854,7 +854,7 @@ static inline void netif_rx_complete(str
> >  
> >  static inline void netif_poll_disable(struct net_device *dev)
> >  {
> > -	while (test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
> > +	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
> >  		/* No hurry. */
> >  		current->state = TASK_INTERRUPTIBLE;
> >  		schedule_timeout(1);
> > 
> 
> 
> no that breaks other things.
> 

The only thing it can break is tg3, which appears to be placing a competing
interpretation upon the handling of this flag.

Given that tg3_netif_stop() will set __LINK_STATE_RX_SCHED and dev_close()
will then loop on it getting cleared again there appears to be a risk that
a dev_close() against tg3 will lock up.

It's all very unclear.  And uncommented, but that is experientially the
same thing :(

