Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUDVLP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUDVLP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUDVLP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:15:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263942AbUDVLP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:15:56 -0400
Date: Thu, 22 Apr 2004 13:14:24 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422111424.GC27339@devserv.devel.redhat.com>
References: <OF2D677553.6D72A833-ONC1256E7E.003D0651-C1256E7E.003D4886@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <OF2D677553.6D72A833-ONC1256E7E.003D0651-C1256E7E.003D4886@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 01:09:22PM +0200, Martin Schwidefsky wrote:
> 
> 
> 
> 
> > why? Most hardware have an alternative time source for such time stamps.
> > Timer events *won't* be delivered too late, simply *because* the timer
> said
> > "don't bother checking back for X amount of time", so when that time has
> > expired (eg the delay) then the timer comparison tells the kernel "ok
> this
> > one is due now".
> 
> Huh? You lost me there. The HZ timer is the interrupt that will trigger the
> execution of a timer event. If you say "don't bother checking back for X
> amount of time" the cpu stays in idle doing nothing. You won't get control
> to execute the timer event.

ok maybe I need to word it differently.
What I'm proposing as alternative is using the one shot mode of the timers
on most machines to do teh following:
when the timer irq hits, you do the business you need to do. And then you
check all existing timers and the scheduler when the next "virtual tick" is where
you're going to do real work. You then set the one-shot counter to that
amount. This means that in add_timer/mod_timer you will need to check if the
just added timer is before the current one-shot runs out, and if so, adjust
it. Perhaps in the scheduler too.

You *do* get back control to do the timer event, due to the one-shot timer
firing at just the right time. And this works regardless of the cpu being
idle or not, so it also wins back that 1% performance cost to HPC that
HC=1000 has etc etc because you just don't do irq's until the HPC task runs
out of it's timeslice.

You can go even a step further and introduce another request_irq flag that
makes the irq subsystem treat such marked irqs as if they were timer irqs,
eg run the timerlist and then set a new mark. That way you may even be able
to do the timers before the actual timer IRQ hits and thus avoiding it (this
does mean setting the timer IRQ to somewhat after the optimal time in order
to have a window for this to happen).


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAh6kQxULwo51rQBIRAn7kAJwMQNU+TohpRcDa7o+EtFoSqBL3sgCgp3ME
yIAZtJP/InLVGSxrvQ2x9C0=
=nM4d
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
