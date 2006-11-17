Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933693AbWKQQNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933693AbWKQQNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933695AbWKQQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:13:22 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2065 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933693AbWKQQNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:13:21 -0500
Date: Fri, 17 Nov 2006 16:13:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 5/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Message-ID: <20061117161314.GF28514@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
	ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB547.5060407@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DB547.5060407@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:12:39AM -0400, Anderson Briglia wrote:
> +	if (mmc_card_locked(card) && !strncmp(data, "erase", 5)) {
> +		/* forced erase only works while card is locked */
> +		spin_lock(&mmc_lock);
> +		mmc_lock_unlock(card, NULL, MMC_LOCK_MODE_ERASE);
> +		spin_unlock(&mmc_lock);

mmc_lock_unlock can sleep; holding a spinlock while sleeping is illegal
and is a serious bug.  Inappropriate locking?  What's this lock trying
to achieve?

I don't see any requirement for locking here - mmc_lock_unlock() claims
the host, and if that succeeds, it has exclusive access via that host to
the card.  No one else will be able to talk on the bus until
mmc_lock_unlock() releases it's claim on the host.  So I suspect that
whatever locking you require is already in place.

Ditto for each other instances.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
