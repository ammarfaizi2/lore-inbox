Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTHWRUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTHWRAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:00:43 -0400
Received: from AMarseille-201-1-3-186.w193-253.abo.wanadoo.fr ([193.253.250.186]:57127
	"EHLO gaston") by vger.kernel.org with ESMTP id S262802AbTHWQ1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:27:35 -0400
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review"
	needs explaining to you?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0308221454420.2310-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061655739.786.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 18:22:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > If you want to help, take a look at drivers/pci/power.c. That file
> > should not need to exist, but if I kill it bad stuff happens after
> > resume. Killing pm_register() and friends would be nice.
> 
> I'll get there. Give me a couple of weeks.. 

Actually, on ppc, I have no problem removing that old crap. I suppose
part of the problem Pavel is having is the new code never calling PCI
save_state().

The probleme here is related to the new semantics. save_state() is
indeed meaningless now, but a bunch of drivers implemented sleep in
there because this was really what was called on suspend()... So
unless we want to remove save_state from struct pci_driver and fix all
PCI drivers that implement it, we shall call both save_state() and
suspend() from pci-driver.c suspend routine. (Patch sent separately)

> The decision to kill the level parameter came from extensive discussions
> with Benh, who convinced me that we only need to call ->suspend() once for
> any device; though we still need to somehow provide for those that need to
> power down with interrupts disabled. I suggested -EAGAIN, since it allows
> us to special case those that need it, with the minimum amount of impact.
> Ben agreed with me.

Well... I think I told you I don't like much the check on the interrupt
and tended to prefer either a separate power_down_irq callback or a
parameter, but that would mean changing prototype for drivers... I
agreed we can live with your current scheme though. 

Ben.

