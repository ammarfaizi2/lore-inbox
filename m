Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVBOOv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVBOOv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVBOOv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:51:56 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:53805 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261739AbVBOOvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:51:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Bc74fqNE//qCfyn93Xlt5keuvU87pINy+EXr8kZpyEZj6hFhlmOm5bGY44veB+8Dlupxj8C1kGY7Zr67AX2N0QBv3gD6yA6jryO+Qczs3AfvFs5N7QtG7xNgneUeEYpyGpipZqgvFX5uBKYXC6CE++txP8VRCLD0y6bV7y90vdE=
Message-ID: <d120d500050215065115706773@mail.gmail.com>
Date: Tue, 15 Feb 2005 09:51:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RCF/RFT] Fix race timer race in gameport-based joystick drivers
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215140501.GF7250@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502150042.32564.dtor_core@ameritech.net>
	 <20050215140501.GF7250@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 15:05:01 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Feb 15, 2005 at 12:42:31AM -0500, Dmitry Torokhov wrote:
> > Hi,
> >
> > There seems to be a race WRT to timer handling in all gameport-based
> > joystick drivers. open() and close() methods are used to start and
> > stop polling timers on demand but counter and the timer itself is not
> > protected in any way so if several clients will try to open/close
> > corresponding input device node they could up with timer not running
> > at all or running while nobody has the node open. Plus it is possible
> > that disconnect will run and free driver structure while timer is running
> > on other CPU.
> >
> > I have moved timer and counter down into gameport structure (I think it
> > is ok because on the one hand joysticks are the only users of gameport
> > and on the other hand polling timer can be useful to other clients if
> > ever writen), and added helper functions to manipulate it:
> >
> >       - gameport_start_polling(gameport)
> >       - gameport_stop_polling(gameport)
> >       - gameport_set_poll_handler(gameoirt, handler)
> >       - gameport_set_poll_interval(gameport, msecs)
> >
> > gameport_{start|stop}_poll handler are using spinlock to guarantee that
> > timer updated properly. Also, gameport_close deletes (synchronously) timer
> > to make sure there is no surprises since gameport_stop_poling does del_timer
> > and thus may leave timer scheduled. Timer routine also checks the counter
> > and does not restart it if there are no users.
> >
> > Please let me know what you think.
> 
> I'm not really sure if I really want to move the polling into the
> gameport layer. It's useful, but without it, gameport is considered
> strictly a passive device which can't generate callbacks (other than
> open/close/connect/disconnect).
> 
> The new polling interface isn't much simpler than what Linux timers
> offer, only it provides additional locking.

Yes, that was the goal. I looked over the drivers and it was either
writing the exactly same code 10 times or moving it down.
 
> Probably protecting open/close calls in gameport.c with a spinlock would
> allow to work without explicit locking in the drivers.

Hmm, you got me a bit confused here - open and close in gameport are
already (indirectly) serialized with gameport_sem. It is input device
open and close in joystick drivers that needs treatment - these are
initiated from userspace and weren't hitting gameport code at all. And
they need to be protected otherwise the counter and timer will get out
of whack.

-- 
Dmitry
