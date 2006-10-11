Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWJKOQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWJKOQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWJKOQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:16:53 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40328 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030445AbWJKOQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:16:52 -0400
Date: Wed, 11 Oct 2006 08:16:51 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: most users of msleep_interruptible are broken
Message-ID: <20061011141651.GD27388@parisc-linux.org>
References: <1160570743.19143.307.camel@amol.verismonetworks.com> <1160571491.3000.372.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160571491.3000.372.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 02:58:11PM +0200, Arjan van de Ven wrote:
> > +++ linux-2.6.19-rc1/drivers/mmc/mmc.c	2006-10-11 17:57:02.000000000 +0530
> > @@ -454,7 +454,7 @@ static void mmc_deselect_cards(struct mm
> >  static inline void mmc_delay(unsigned int ms)
> >  {
> >  	if (ms < HZ / 1000) {
> > -		yield();
> > +		cond_resched();
> >  		mdelay(ms);
> 
> 
> this probably wants msleep(), especially with hrtimers comming up; there
> the sleeps are always exact...

They clearly don't care about exactness; they msleep_interruptible and
throw away the return value, so they don't know how long they slept
before they got a signal.

__must_check treatment for msleep_interruptible, anyone?  On the one hand,
that's 136 new warnings.  On the other hand, that's 136 places wheree
we may as well *delete the call* to msleep_interruptible.  Since it can
return immediately, the code must be prepared to deal with that ... right?
