Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUIIQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUIIQnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUIIQnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:43:22 -0400
Received: from [69.25.196.29] ([69.25.196.29]:25311 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266233AbUIIQgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:36:53 -0400
Date: Thu, 9 Sep 2004 08:57:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The Serial Layer
Message-ID: <20040909125705.GA5658@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1094582980.9750.12.camel@localhost.localdomain> <1094587598.2801.24.camel@laptop.fenrus.com> <1094584456.9745.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094584456.9745.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:14:20PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 21:06, Arjan van de Ven wrote:
> > On Tue, 2004-09-07 at 20:49, Alan Cox wrote:
> > > Is anyone currently looking at fixing this before I start applying
> > > extreme violence ? In particular to start trying to do something about
> > > the races in TIOCSTI, line discipline setting, hangup v receive, drivers
> > > abusing the API and calling ldisc.receive_buf direct ?

Calling ldisc.receive_buf directly() should be OK as long as you're
not in an interrupt handler.  (For example the comtrol driver polls in
a timer bottom-half, so it's OK to call ldisc.receive_buf).
Unfortunately, some drivers don't quite follow the rules.

> > don't you mean the TTY layer instead of the serial layer ?
> 
> Both. A lot of hangup/receive races are in the serial drivers themselves
> doing things like
> 
> 	hangup
> 	[close ldisc]
> 	send bytes to the ldisc
> 	[Boom!]

The hangup handling needs to be completely redone, so that we don't
force serial drivers to do a completely shutdown of the port in an
interrupt context.  If the drivers are careful, it can be safe, but
it's too hard to handle hangup correctly.  

If you have time to work on the tty layer (sucker!!!), please go ahead
and start work by all means.  I was hoping to have time to clean up
some of the more egregious problems sometime next year (after I escape
back into development), but getting this fixed sooner rather the later
would be a definitely Good Thing.

						- Ted
