Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbSJCOLn>; Thu, 3 Oct 2002 10:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJCOLn>; Thu, 3 Oct 2002 10:11:43 -0400
Received: from crowley.physik.fu-berlin.de ([160.45.33.110]:60800 "EHLO
	crowley.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S261400AbSJCOLk>; Thu, 3 Oct 2002 10:11:40 -0400
Date: Thu, 3 Oct 2002 16:16:46 +0200
From: Jens Thoms Toerring <Jens.Toerring@physik.fu-berlin.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: possible bug in 2.5.39 ISA PnP patch
Message-ID: <20021003161646.A22812@crowley.physik.fu-berlin.de>
Reply-To: Jens.Toerring@physik.fu-berlin.de
References: <15772.1423.291413.372141@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15772.1423.291413.372141@kim.it.uu.se>; from mikpe@csd.uu.se on Thu, Oct 03, 2002 at 10:53:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-03 10:53:53, Mikael Pettersson <mikpe@csd.uu.se> wrote:
> On 2002-09-27 11:16:04, Jaroslav Kysela wrote:
> >	 the read port (RDP) of ISA PnP cards must be set only when card is 
> >in the isolation phase. Bellow is a patch to follow the ISA PnP 
> >specification. Please, apply.

<patch snipped>

> Linus included this patch in 2.5.39. Unfortunately, it causes
> my ISA PnP cards to malfunction:
> - My 3c509(b?) combo TP/BNC Ethernet card stops working completely.
>	The kernel thinks the NIC is up, but the leds on its segment aren't
>	lit and no traffic can be generated.
>	Backing out this patch, or disabling ISAPNP, makes it work again.
> - My ESS sound card is a multi-function device. With this patch, some
>	sub-devices get bogus resources listed in /proc/isapnp, as if the
>	data is all-bits-one. Backing out this patch solves the problem.
> 
> I have several other ISA PnP card at another location, but I won't be
> able to test them until Saturday.
> 
> I can't comment on whether the new code in the patch correctly implements
> the specification or not, but something's definitely wrong here. Do you
> have any evidence of cards that malfunctioned with the old code?

Yes, my HP82341D GPIB card does not work at all without the patch, that's
the reason I came up with it.

> Also, the comment "to avoid malfunction when the isapnptools package is
  used"
> strikes me a bit strange. Why use isapnptools if the kernel has ISAPNP=y ?
> Is that actually supposed to work?

Of course, you are right, using isapnptools is definitely not a good
idea in this case. But too many people will do it anyway when there is
a problem with their cards, not realizing that it will lead to even
worse problems. Without the code after the "#if 1" running pnpdump may
keep not already configured cards from responding anymore and a reboot
is required to get the cards back into s sane state. And that's probably
the reason why the code was introduced in the first place...

Unfortunately, I only have one other ISAPnP card, so I couldn't test the
patch very thoroughly - it (unfortunately) worked with both cards. I have
an idea what is broken with the patch and I am trying to figure out a way
how to get it right. If I should come up with a solution would you be
prepared to help me by doing some tests with your cards?

To Jaroslav:

After rereading the standard I guess that the problem is the clearing of
the CSN - it may not clear the CSN of the card in Configuration state
only but, unfortunately, of *all* cards (except the ones in Wait state,
but at that moment all the others cards are in Sleep state since we
first had to send the isolation key and there's no way to get only a
subsets of the cards back into Wait state). This would explain the
problems Mikael is seeing.

Since we obviously can't do without clearing the CSNs of all cards
just to set the RDP of one card, we then also have to repeat the
whole isolation phase, at least that's the only way I can see at the
moment. Luckily, ISA PnP aren't hot-pluggable, so the sequence of
the cards during the isolation phase can't change and all cards will
end up with the same CSN they had before... Or do you think I got it
wrong or see any reasons why this won't work?

                                Best regards, Jens
-- 
      _  _____  _____
     | ||_   _||_   _|        Jens.Toerring@physik.fu-berlin.de
  _  | |  | |    | |
 | |_| |  | |    | |          http://www.physik.fu-berlin.de/~toerring
  \___/ens|_|homs|_|oerring
