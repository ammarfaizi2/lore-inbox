Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTAUXLq>; Tue, 21 Jan 2003 18:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTAUXLq>; Tue, 21 Jan 2003 18:11:46 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:41608 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267264AbTAUXLp>;
	Tue, 21 Jan 2003 18:11:45 -0500
Date: Tue, 21 Jan 2003 18:23:03 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [alsa, pnp] more on opl3sa2
Message-ID: <20030121182303.GI26108@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
References: <20030121160228.GH26108@neo.rr.com> <Pine.LNX.4.44.0301212223550.6355-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301212223550.6355-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 10:43:43PM +0100, Jaroslav Kysela wrote:
> On Tue, 21 Jan 2003, Adam Belay wrote:
> > 1.) If a driver attaches to the pnpbios card all other card-based drivers will
> > be unable to use the pnpbios.  One will attach and cause the others to fail.  It
> > is possible for the user to have more than one pnpbios sound card but with this
> > approach such a user would only be able to use one sound device from the entire
> > pnpbios.
>
> I see. I think it's a design problem then. The rule card -> one driver is
> bad. We need something between card and device which will take care about
> drivers. Unfortunately, this information is dynamic (only driver knows
> which devices have to be attached).
>
> I think that we need to discuss this thing very carefully.

I agree that we need to discuss this carefully and that there is a need for this
change.  Here are a few ideas to get a discussion started.

How does this sound...
1.) detach pnp card service matching from the driver model, the driver model is
what is imposing this one card per driver limit.
2.) create a special pnp_driver that handles cards and forwards driver model calls
to the pnp card services, we can use attach_driver to avoid matching problems.

design goals for these changes should be as follows:
1.) multiple drivers can bind to one card
2.) pnp_attach, pnp_detach, and pnp status should be phased out and replaced with
the special card driver, in other words the driver model can take care of this.

This will solve the one device limit but I'm not sure how to handle the pnpbios
stuff yet.  I want it to be with as little overhead as possible and would prefer we
don't use fake cards, any ideas?  All that comes to mind for me is a unique pnpbios
ID that the pnp layer will interpret and grant special exceptions.

>
> > 2.) Doing so would misrepresent the pnpbios topology because it physically
> > doesn't have any cards.
> >
> > 3.) The opl3sa2 driver doesn't need a card because it is only asking for one
> > device anyway.  Using the card interface puts unnecessary overhead on both the
> > driver and the pnp layer.
>
> Yes, but IT SHOULD WORK. Although it isn't an most efficient way. (I
> personally think that it's better to keep as much IDs as possible to avoid
> clashes in future).

Hmm, I'm not sure what you mean by clashes in the future.  Nearly all of 
these isapnp devices are no longer manufactured, hence these devices will
not have many future changes.

Still I do see value in describing as many ids as possible but I worry that the
extra overhead may not be worth it.  This also needs to be further discussed.

Regards,
Adam
