Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277207AbRJINgo>; Tue, 9 Oct 2001 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277208AbRJINgf>; Tue, 9 Oct 2001 09:36:35 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:61199 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277207AbRJINgb>; Tue, 9 Oct 2001 09:36:31 -0400
Date: Tue, 9 Oct 2001 15:37:02 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
Message-ID: <20011009153702.B28423@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Kernel, Linux" <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC1D506.E68B9DB2@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC1D506.E68B9DB2@isg.de>; from lkv@isg.de on Mon, Oct 08, 2001 at 06:32:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > > The select system call doesn't return EINTR when the signal is caught
> > > prior to entry into select.
> > 
> > Your friend there is siglongjmp/sigsetjmp - the same problem was true
> > with old versions of alarm that did
> > 
> >         alarm(num)
> >         pause()
> > 
> > on a heavily loaded box.
> > 
> > Using siglongjmp cures that
> 
> Hmmm... would you say the "siglongjmp" method is better than the "self-pipe"
> method for a select on both file descriptors and signals too?
> 
> As far as I can see the trade-off is (in the non-race-condition case)
> between having to call read() on the pipe (to empty it after receiving the
> signal) for the "self-pipe" method and having to call sigsetjump() every time
> before one enters select/poll.
> 
> My assumption would be that the "self-pipe" method is cheaper... right?

Well, but you don't have to call sigsetjmp before every select; just when you
enter the loop. Than just enable volatile flag, that the handler should now
use the siglongjmp... well, you have to care about 2 signals quickly following
one another and similar nasty cases anyway, so the pipe aproach is less
error-prone. When signal arives, select either returns EINTR, or says the pipe
is ready for writing, so you can save yourself the additional select call by
checking for both conditions.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
