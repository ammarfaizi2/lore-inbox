Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVBBTVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVBBTVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVBBTRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:17:21 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:17551 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262774AbVBBTLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:11:21 -0500
Date: Wed, 2 Feb 2005 20:11:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202191135.GA3189@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <20050202102033.GA2420@ucw.cz> <20050202085628.49f809a0@localhost.localdomain> <20050202170727.GA2731@ucw.cz> <20050202095851.27321bcf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202095851.27321bcf@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:58:51AM -0800, Pete Zaitcev wrote:
> On Wed, 2 Feb 2005 18:07:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Wed, Feb 02, 2005 at 08:56:28AM -0800, Pete Zaitcev wrote:
> > > On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > 
> > > > Well, you removed the scaling to the touchpad resolution, which will
> > > > cause ALPS touchpad to be significantly slower than Synaptics touchpads.
> > > > Similarly, the screen size used to be taken into account, but probably
> > > > that was a mistake, since the value is usually left at default and
> > > > doesn't correspond to the real screen size.
> > > 
> > > Exactly. And it works much better now.
> >  
> > With a Synaptics I suppose? You wouldn't like it with an ALPS.
> 
> No, it's a Dualpoint, and so ALPS. But never mind that, I think I see
> your point.
> 
> However, while I see a possibility of serious regressions with the other
> variety, but isn't it striking that result is so radical? With all the
> arithmetics still in place I can move my finger all across the pad without
> causing any motions. We are not talking about ballistics or any fine tuning,
> simply the calculations are wrong.

Sorry for that. It's not my code (except to the pad resolution scaling). ;)

> Let me add more, too. As long as the touchpad code in mousedev.c converts
> absolute mode data into relative events, there's no reason to scale
> _to the size of the screen_.

Well, there is a reason. You usually want to be able to get to the other
edge of the screen with a few moves of the finger. So the preferred
final sensitivity depends on the screen size.

But, since we don't know the screen size, we can't do this properly and
thus it's better not to do it at all.

> Don't you see? User needs a scaling to
> the sensitivity, not the screen size. I have never seen a touchpad which
> allowed you to cross the screen in one motion if you moved it slowly,
> this is why acceleration feature exists. It's completely bogus.

I agree. We should give it the same perceived resolution as a standard
400 DPI mouse (which is what the firmware does in mouse emulation mode)
regardless of the screen size. That's actually the only way how it can
mix with normal mouse data properly.

> Scaling to the size of the screen would have made sense if we used touchpad
> to generate absolute events, as some sort of a miniature Wacom pad. In such
> a case, you wouldn't be able to reach corners of the screen without scaling.
> But a touchpad is operated in entirely different way.
> 
> If Synaptics delivers much bigger deltas for small motions,

It's different hardware. While the ALPS pad delivers X axis in the range
of 0 to 1000, the Synaptics pad will give X axis values from approx 1500
to approx 5500. This is four times the resolution - the size of the pad
is mostly the same.

Synaptics or ALPS don't deliver deltas in native mode. They deliver
absolute coordinates of the finger touching. That's why there is any
math delivered at all.

> it's up to the
> Synapics mode of alps.c to make them reasonable, if that.

The policy of input drivers is not to scale or otherwise modify the
data. That's why the input_dev struct contains the ranges of the axes.

Btw, what do you mean by "synaptics mode of alps"?

> There's no need
> to penalize ALPS. But I seriously doubt that Synaptics can be so broken.

Neither are broken. But mousedev.c (and similarly the X touchpad driver)
must take the pad resolution into account, otherwise the cursor will
move four times faster with Synaptics than with ALPS.

> I wish Peter tested the removal of scaling with his Synaptics. If he
> (and Dmitry) insist on running a special code in X, that's fine. But honestly,
> I expect that things will go well for them.

I added the scaling code, because my ALPS pad was *unbearably* slow.
The original code in mousedev divided by 8 (instead of 2), because it
was tuned for Synaptics.

We need to divide by 2 for ALPS and by 8 for Synaptics, and that's
basically all we need to do. But we must not do that by checking the pad
manufacturer, because when a third pad type comes in (Say Logitech
TouchPad 3), we shouldn't need to modify mousedev.c

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
