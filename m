Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJWGcq>; Wed, 23 Oct 2002 02:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJWGcp>; Wed, 23 Oct 2002 02:32:45 -0400
Received: from dp.samba.org ([66.70.73.150]:49387 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262884AbSJWGcn>;
	Wed, 23 Oct 2002 02:32:43 -0400
Date: Wed, 23 Oct 2002 16:37:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: peterc@gelato.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, dhinds@zen.standford.edu
Subject: Re: Ejecting an orinoco card causes hang
Message-ID: <20021023063704.GG1198@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
	dhinds@zen.standford.edu
References: <15797.63740.520358.783516@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15797.63740.520358.783516@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:18:52AM +1000, peterc@gelato.unsw.edu.au wrote:
> 
> Hi Davids,
>    I see the following problems with the orinoco plus cardbus plus
> yenta_socket system on 2.5.44.
> I'm using a Netgear MA401.
> 
> 1.  cardctl reset gives a warning:
>       orinoco_lock() called with hw_unavailable.
>     I added a call to dump_stack() where the message was being printed
>     out --- it's happening when pcmcia_release_configuration() calls
>     set_socket, which calls yenta_get_socket() which calls set_cis_map
>     which causes an interrupt, and then orinoco_interrupt reports the
>     problem.   So it's probably benign.

Yes, that's probably right.  In fact the hw_unavailable flag exists
specifically to stop orinoco_interrupt() and others doing anything
worse than giving a warning if called at this sort of time.  It would
certainly be bad to go ahead and access the hardware at this point.

We've already cleared the INTEN register at this point, so we're not
expecting to get an interrupt.  But I guess that interrupt line is
shared with something else.

In the long time that warning should probably disappear (we should
just do nothing safely and silently).  For now it is still usful for
tracking down real problems.

> 2.  cardctl eject gives a warning, Bad: scheduling while atomic. I
>     think this is a generic problem, not orinoco-specific ---
>     pcmcia_eject_card() disables interrupts, then calls do_shutdown()
>     which calls cs_sleep(), and cs_sleep() tries to sleep (but with
>     interrupts disabled, bad)

I think that's correct.

> 3.  Manually ejecting the card (without doing a cardctl eject first)
>     locks the machine solid.  Nothing in the logs, nothing on the
>     screen.  I suspect it's disabling interrupts then doing something
>     silly. 

I suspect this may be another PCMCIA rather than orinoco problem,
although I'm not sure.  If it's happening in the orinoco driver, I
have no idea where it could be - I've generally been careful to have
timeouts and checks to handle the device suddenly disappearing.

Do you get a hang if you ifconfig down the interface, but don't
cardctl eject the card?  I've also heard that some PCMCIA hardware
can't reliably cope with hot unplug like this.

> 4.  Transferring lots of data causes the link to collapse, and the
>     logs to fill up with `eth0: Error -110 writing Tx descriptor to
>     BAP' messages

:-( this sounds like one of the perennial problems we've had with some
cards.  The firmware falls over, and I haven't been able to figure out
what we've done to upset it.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
