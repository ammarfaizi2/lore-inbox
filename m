Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265486AbUFCDrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbUFCDrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUFCDrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:47:25 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:62337
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S265486AbUFCDqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:46:46 -0400
Date: Wed, 2 Jun 2004 20:44:59 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Pedro Ramalhais <ramalhais@serrado.net>
Cc: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa	support
Message-ID: <20040603034458.GD7548@jm.kir.nu>
Mail-Followup-To: Pedro Ramalhais <ramalhais@serrado.net>,
	Netdev <netdev@oss.sgi.com>, hostap@shmoo.com,
	prism54-devel@prism54.org, Jeff Garzik <jgarzik@pobox.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040602071449.GJ10723@ruslug.rutgers.edu> <20040602132313.GB7341@jm.kir.nu> <20040602155542.GC24822@ruslug.rutgers.edu> <20040603014000.GA7548@jm.kir.nu> <1086230284.7604.38.camel@rootix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086230284.7604.38.camel@rootix>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 03:38:05AM +0100, Pedro Ramalhais wrote:

> As you may know (or not), the ipw2100 driver is somewhat based on hostap
> code. We use some code from hostap in the ipw2100 driver, and use the
> hostap driver externally as a way to provide WEP.
> I'm currently working on turning hostap_crypt* into ieee80211_crypt* in
> such a way that could be used in a generic way by all drivers that need
> host based WEP (and TKIP/CCMP). I basically renamed the hostap_crypt* to
> ieee80211_crypt* and search&replaced hostap with ieee80211. Also made
> hostap_crypt.c into a module (instead of having to rely on hostap.o).

I do not understand what kind of changes you think are required.
Renaming the functions/structures is not really changing anything and
hostap_crypt.o used to be a separate module (and it should still be
possible to compile it as such by defining HOSTAP_CRYPT_MODULE when
compiling the Host AP code).

It sounds like your changes are just making it more difficult to
maintain generic code because of making it require more work to merge
changes back. With the changes to use crypto API, there's already couple
of different versions of the crypto code for Host AP. I would rather not
bring in more versions. The improvements should go to the wireless-2.6
tree.

As far as I can tell, the version that I submitted couple of days ago
for wireless-2.6 (and potentially linus-2.5) trees, should be usable as
is from other drivers. Yes, hostap module will include some extra
functionality that is not needed, but it does not make it any more
difficult to use the encryption part which should be fully hardware
independent. This can be easily (again) extracted, if it looks like this
code will be used from multiple drivers.

> I have WEP working and a Makefile that can be used in the kernel or
> externally. I took a look at the TKIP and CCMP source files and it is
> somewhat tied up to ioctls and headers (just took a quick look correct
> me if i'm wrong) from hostap. This makes it somewhat difficult to turn
> them into code that compiles without hostap code.

Tied to ioctls?? There is no ioctl processing in the Host AP crypto
code. The header files are mainly for defining the IEEE 802.11 header.
In addition, Host AP code can already be used in the kernel and
externally..

> Besides this, the ipw2100 code also has an attempt at a somewhat generic
> ieee80211 interface for drivers. ieee80211_rx.c is mostly based on
> hostap_hw.c code (which looks like is now in CVS as hostap_80211_rx.c )
> and there's also ieee80211_tx.c which i think was created from scratch
> by James Ketrenos (ipw2100 main developer @intel).

This sounds similar to what the current Host AP driver uses
hostap_80211_{rx,tx}.c.

> My question is: would it be interesting to try and merge code from
> hostap, ipw2100 and possibly other drivers to try to create generic code
> for 80211 and 80211_crypt?

Yes and this is what has been discussed on netdev and (admittedly,
slowly so far) started with wireless-2.6.

> developers (hostap, prism54, atmel, etc...). I'm asking this because
> AFAICS, the hostap driver always had an history of more focus on new
> features, functionality, bug fixes, than "standard" APIs, etc... and i
> completely understand that and thank god it has been like this because
> the final result was a really nice driver.

I believe that one needs to first experiment with the features/design
before being able to design a standard API. There has already been quite
many versions of Linux wireless extensions and I would rather first see
what would be a common design that could work with most wireless cards
and then design an API for this. For many functions, we are starting to
have all the needed information to actually to this successfully.

> Would you accept patches at least for now to make hostap_crypt* into
> ieee80211_crypt*?

Sure, if there is something that really improves the current situation
in some way. I don't think that just renaming the functions would be
very useful at that point. Of course it can be done, but I would prefer
to see a bit more design on the other parts of the IEEE 802.11 support
and its place in the Linux net stack.

> PS: Comments, ideas, proposals, etc are welcome for discussion.(What is
> the best way to discuss this matter? There's a large number of
> developers involved. Maybe netdev?)

netdev

-- 
Jouni Malinen                                            PGP id EFC895FA
