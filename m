Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRHLXAI>; Sun, 12 Aug 2001 19:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269544AbRHLW77>; Sun, 12 Aug 2001 18:59:59 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:49420 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269543AbRHLW7v>; Sun, 12 Aug 2001 18:59:51 -0400
Date: Sun, 12 Aug 2001 15:59:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manuel McLure <manuel@mclure.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org>
Message-ID: <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Aug 2001, Manuel McLure wrote:
> >
> > Can you try just adding the line
> >
> > 	if (!woinst)
> > 		return;
> >
> > to the top of the function (just before the "spin_lock_irqsave()"). Does
> > that fix it for you?
> >
> > 		Linus
>
> So far so good - however I don't have a consistent way to reproduce this.
> I'll just keep running and see if the Oops happens again.

Mind trying an alternate approach: remove the "if (!woinst)" thing, and
instead move the line that initializes the tasklets down two lines
(there's two places, they look something like

                tasklet_init(&wiinst->timer.tasklet, emu10k1_wavein_bh,  (unsigned long) wave_dev);
                wave_dev->wiinst = wiinst;
                emu10k1_wavein_setformat(wave_dev, &wiinst->format);

and they _should_ do the "tasklet_init()" _after_ the other
initializations, ie move that line down a bit, like so:

                wave_dev->wiinst = wiinst;
                emu10k1_wavein_setformat(wave_dev, &wiinst->format);
                tasklet_init(&wiinst->timer.tasklet, emu10k1_wavein_bh, (unsigned long) wave_dev);

Does that also fix it?

And sure, I realize that you want to run it for a while..

		Linus

