Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWAJVqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWAJVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWAJVqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:46:09 -0500
Received: from mgw-ext01.nokia.com ([131.228.20.93]:17234 "EHLO
	mgw-ext01.nokia.com") by vger.kernel.org with ESMTP id S932365AbWAJVqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:46:08 -0500
Message-ID: <43C42B00.60206@indt.org.br>
Date: Tue, 10 Jan 2006 17:45:36 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@PACBELL.NET>,
       Tony Lindgren <tony@atomide.com>, drzeus-list@drzeus.cx,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support
 V3
References: <43C2E0A2.3090701@indt.org.br> <20060109224204.GH19131@flint.arm.linux.org.uk>
In-Reply-To: <20060109224204.GH19131@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2006 21:43:54.0989 (UTC) FILETIME=[F450F1D0:01C6162E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Jan 09, 2006 at 06:16:02PM -0400, Anderson Briglia wrote:
>  
>
>>+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
>>+	if (!dev)
>>+		goto error;
>>+	card = dev_to_mmc_card(dev);
>>+	
>>+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
>>+               if (mmc_card_locked(card)) {
>>+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
>>+                       mmc_remove_card(card);
>>+                       mmc_register_card(card);
>>+               }
>>+	       else
>>+		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
>>    
>>
>
>I really don't like this - if the MMC card is not locked, we set a
>password on it.  If it's locked, we unlock it.
>
>That's a potential race condition if you're trying to unlock a card
>and the card is changed beneath you while you slept waiting for
>memory - you end up setting that password on the new card.
>
>It's far better to have separate "unlock this card" and "set a
>password on this card" commands rather than trying to combine the
>two operations.
>  
>
Ok.

>Also, removing and re-registering a card is an offence.  These
>things are ref-counted, and mmc_remove_card() will drop the last
>reference - so the memory associated with it will be freed.  Then
>you re-register it.  Whoops.
>
>If you merely want to try to attach a driver, use device_attach()
>instead.
>  
>
If we use device_attach(), the mmc_block driver is not informed about
the card's unlocking. I did some tests, using device_attach() instead of
those mmc functions and seems that the mmc_block driver tries to use a
invalid device reference. What do you suggest on this case?

>Also, what if you have multiple MMC cards?  I have a board here
>with two MMC slots.  I'd rather not have it try to set the same
>password on both devices.
>  
>
Sorry, but this series of patches only support one mmc host. I'll update
the TODO section of the summary e-mail.

Anderson Briglia
INdT - Manaus
