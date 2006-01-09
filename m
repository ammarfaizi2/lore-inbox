Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWAIWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWAIWmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWAIWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:42:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751589AbWAIWmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:42:12 -0500
Date: Mon, 9 Jan 2006 22:42:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@PACBELL.NET>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support V3
Message-ID: <20060109224204.GH19131@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	linux-kernel@vger.kernel.org,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux@arm.linux.org.uk, ext David Brownell <david-b@PACBELL.NET>,
	Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
References: <43C2E0A2.3090701@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2E0A2.3090701@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 06:16:02PM -0400, Anderson Briglia wrote:
> +	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
> +	if (!dev)
> +		goto error;
> +	card = dev_to_mmc_card(dev);
> +	
> +	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
> +               if (mmc_card_locked(card)) {
> +                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
> +                       mmc_remove_card(card);
> +                       mmc_register_card(card);
> +               }
> +	       else
> +		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);

I really don't like this - if the MMC card is not locked, we set a
password on it.  If it's locked, we unlock it.

That's a potential race condition if you're trying to unlock a card
and the card is changed beneath you while you slept waiting for
memory - you end up setting that password on the new card.

It's far better to have separate "unlock this card" and "set a
password on this card" commands rather than trying to combine the
two operations.

Also, removing and re-registering a card is an offence.  These
things are ref-counted, and mmc_remove_card() will drop the last
reference - so the memory associated with it will be freed.  Then
you re-register it.  Whoops.

If you merely want to try to attach a driver, use device_attach()
instead.

Also, what if you have multiple MMC cards?  I have a board here
with two MMC slots.  I'd rather not have it try to set the same
password on both devices.


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
