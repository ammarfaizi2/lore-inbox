Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUIYMTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUIYMTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUIYMTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:19:32 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43927 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269192AbUIYMTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:19:20 -0400
Subject: Re: mlock(1)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrea Arcangeli <andrea@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040925010759.GA3309@dualathlon.random>
References: <41547C16.4070301@pobox.com>
	 <20040924132247.W1973@build.pdx.osdl.net>
	 <1096060045.10800.4.camel@localhost.localdomain>
	 <20040924225900.GY3309@dualathlon.random>
	 <1096069581.3591.23.camel@desktop.cunninghams>
	 <20040925010759.GA3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096114881.5937.18.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 22:21:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Sat, 2004-09-25 at 11:07, Andrea Arcangeli wrote:
> We could use the cryptoloop or dm-crypto and everything would work fine
> if we were ok to re-run mkswap after every reboot (right after choosing
> the random password). But it sounds just simpler to leave the swap
> header in cleartext. The swap header and the swap metadata in general,
> are the only thing that can be written in cleartext safely.
> 
> So when suspend kicks in, it will have only to write by hand into the
> swap device, using the a secondary password asked to the user by the
> suspend procedure. This will be the only password asked to the user.

Yes, that's exactly what I was thinking too: header & metadata in plain
text, data proper encrypted. Fits perfectly with suspend's current modus
operandi too.

> Resume will then ask the user for the same password again. It'd be also
> nice to waste 4k of swap space have a check to know if the resume
> password is ok and to avoid a kernel crash if I do a typo ;). Not being
> able to resume is still nicer than a potentially (though very unlikely)
> fs-corrupting kernel crash.

There must be some way of being able to check the password is correct
without compromising security by encrypting static text and storing it
at a known location! Darned if I know what it is though.

> This I believe should work safely. As far as suspend is concerned we
> could also use cryptoloop instead of interfacing swap directly with
> cryptoapi, then suspend should simply overwrite the swap header and
> resume should reistantiate it (could even be saved in encrypted form in
> another suspend-block), but then we'd need to run mkswap every boot and
> that's not nice. Leaving the swap metadata in cleartext sounds a lot
> nicer to avoid mkswap and to still choose random swap password at every
> reboot.

Perhaps it will help here to say that suspend plays nicely with swapping
at the moment. All of the implementations use the normal swap allocation
routines to get and free the pages they write to, and they also only
change (reverseably) the ten-character header on the header page (not
the data itself). (The SWAP-SPACE or SWAPSPACE2 sig). You thus don't
have to re-mkswap after suspending. Writing the image is done using
submit_bio, not the swapspace specific routines.

Regards,

Nigel


