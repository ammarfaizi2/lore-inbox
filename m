Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRFMPao>; Wed, 13 Jun 2001 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264012AbRFMPaY>; Wed, 13 Jun 2001 11:30:24 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:2746 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S264009AbRFMPaO>; Wed, 13 Jun 2001 11:30:14 -0400
Date: Wed, 13 Jun 2001 17:29:55 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B265416.58941C3C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106131539210.28624-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Jeff Garzik wrote:

> What are you doing that you need to access all registers from userspace?

The main purpose is debugging. Some registers give you more detailed info
about what's going on; you don't need this for normal functioning, but
when you're looking for "what's wrong" it might give you additional
details (next page, transceiver manufacturer/model for hardware bugs,
etc.). That's why I proposed restricted access, a normal user shouldn't
need this info, but the sysadmin might.
Probably the same info can be taken from the card inside the kernel,
convert it to some user parsable form and give it to user through /proc or
something similar. But I think that the implementation would be much more
complicated than allowing direct access to MII registers.

One other argument: mii-diag currently allows this. ethtool would mean a
step backwards 8-)

> Right now we have quite a bit of
> deployed code using MII ioctls, and there is a gigabit MII standard; so,
> Becker's argument is that each driver should provide a set of MII
> ioctls, emulating behavior when hardware isn't exactly per spec.

I'm more-or-less supporting this oppinion. But I use Don's mii-diag
heavily in debugging media-related problems for 3c59x, so I might be
biased 8-)

> We have control over the ethtool API, and we can
> correct its deficiencies, whereas any MII spec deficiencies must be
> worked out inside the driver.

I agree that this is a problem. Even more, if you start emulating MII for
non-MII NICs, you might get into trouble when presenting the available
info in a MII-compatible way (f.e. how would you emulate "link partner
ability" ?). But the NIC specific deficiencies should be worked out inside
the driver, isn't this always the case with a common API ?

> Further, there is the question of "how much MII to implement" --
> currently the MII-ioctl-based net drivers all implement -basic- MII, but
> I guarantee that you will find per-driver(per-chip) differences in the
> MII implementation... which is a flaw in the MII ioctl implementation in
> the driver, regardless of how the chip is designed.

I take that you mean by implementing basic MII that the drivers don't take
advantage of the additional info when dealing with media settings. The
drivers do allow user access to all MII registers when available.
Per-driver or per-chip differences mean that the driver author didn't do a
good job at emulating MII 8-)

> There are completeness flaws in more than one MII ioctl implementation.

IMHO, this is only because there is no agreed-upon standard. But this can
be corrected. What prevents ethtool implementations from being flawed ?

> The ethtool API doesn't have that problem.

Well, IMHO you can't directly compare the two. MII has hardware support,
so for a MII-capable NIC, you usually just handle access to the registers.
ethtool is software only and you emulate everything; if you would
also partly emulate MII (where you need to), you are in the same
situation.

> For drivers without support for either, just add ethtool support.

Well, that's my point. You need to write code in both cases. So why do you
choose ethtool ?

> For 2.5?  I don't know.  I am not a visionary.  I defer that to Linus
> and David and Donald and Jamal and Alexey and...  I am mainly a
> maintainer and merge monkey, only implementing new APIs when the needs
> are blindingly obvious.

I don't want to push anything. But when oppinions start to diverge, there
will always be (from all sides!) something like: "my version can do this,
but yours can't". So I'm all for _one_ way of doing things.

> You misunderstood the code.  The "caching" here is whatever is -already-
> being done by the driver.  Many Becker-style drivers cache the
> advertising value.  If such a driver uses the ethtool MII code, that is
> one less MII read that needs to occur.

No, I was talking mainly about 'bmcr' and 'bmsr'. I'm not aware of any
driver that caches these values currently.

> > +       if (mii->autoneg < 0)
> > +               autoneg = mii->autoneg = (bmcr & BMCR_ANENABLE) ? 1 : 0;
> > +       else    autoneg = mii->autoneg;
> >
> > You don't read anything from the hardware at this point. Why do you want
> > caching ?
>
> I don't understand your question.  Of course we have read BMCR from the
> hardware at that point, read the code...

My question was directly related to caching of 'autoneg'. You need to read
'bmcr' before, sure, but why not directly "computing" autoneg instead of
the "if" ? What do you achieve by setting autoneg to potentially something
else than the actual BMCR setting ?

> It is really up to interpretation of the individual driver author (or in
> this case mii.c author), because the net core doesn't know nor care
> about XCVR_xxx.

Yes, but it might make a difference for debugging too. For the example
that I gave, it really helps knowing which of the 2 MII transceivers on
the card is used. So, this info might need to be propagated as exactly
as possible even to user space. And probably needs to be driver-specific,
not in mii.c, anyway.

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De










