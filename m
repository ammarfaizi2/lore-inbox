Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVBOPFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVBOPFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVBOPFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:05:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:25230 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261745AbVBOPFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:05:25 -0500
Date: Tue, 15 Feb 2005 16:06:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RCF/RFT] Fix race timer race in gameport-based joystick drivers
Message-ID: <20050215150606.GA8560@ucw.cz>
References: <200502150042.32564.dtor_core@ameritech.net> <20050215140501.GF7250@ucw.cz> <d120d500050215065115706773@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050215065115706773@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 09:51:52AM -0500, Dmitry Torokhov wrote:
> On Tue, 15 Feb 2005 15:05:01 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Feb 15, 2005 at 12:42:31AM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > >
> > > There seems to be a race WRT to timer handling in all gameport-based
> > > joystick drivers. open() and close() methods are used to start and
> > > stop polling timers on demand but counter and the timer itself is not
> > > protected in any way so if several clients will try to open/close
> > > corresponding input device node they could up with timer not running
> > > at all or running while nobody has the node open. Plus it is possible
> > > that disconnect will run and free driver structure while timer is running
> > > on other CPU.
> > >
> > > I have moved timer and counter down into gameport structure (I think it
> > > is ok because on the one hand joysticks are the only users of gameport
> > > and on the other hand polling timer can be useful to other clients if
> > > ever writen), and added helper functions to manipulate it:
> > >
> > >       - gameport_start_polling(gameport)
> > >       - gameport_stop_polling(gameport)
> > >       - gameport_set_poll_handler(gameoirt, handler)
> > >       - gameport_set_poll_interval(gameport, msecs)
> > >
> > > gameport_{start|stop}_poll handler are using spinlock to guarantee that
> > > timer updated properly. Also, gameport_close deletes (synchronously) timer
> > > to make sure there is no surprises since gameport_stop_poling does del_timer
> > > and thus may leave timer scheduled. Timer routine also checks the counter
> > > and does not restart it if there are no users.
> > >
> > > Please let me know what you think.
> > 
> > I'm not really sure if I really want to move the polling into the
> > gameport layer. It's useful, but without it, gameport is considered
> > strictly a passive device which can't generate callbacks (other than
> > open/close/connect/disconnect).
> > 
> > The new polling interface isn't much simpler than what Linux timers
> > offer, only it provides additional locking.
> 
> Yes, that was the goal. I looked over the drivers and it was either
> writing the exactly same code 10 times or moving it down.

> > Probably protecting open/close calls in gameport.c with a spinlock would
> > allow to work without explicit locking in the drivers.
> 
> Hmm, you got me a bit confused here - open and close in gameport are
> already (indirectly) serialized with gameport_sem. It is input device
> open and close in joystick drivers that needs treatment - these are
> initiated from userspace and weren't hitting gameport code at all. And
> they need to be protected otherwise the counter and timer will get out
> of whack.

Sorry, I was indeed a bit confused - the input open serialization would
be needed, but still the timer could race.

Thinking more about it I agree with your change. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
