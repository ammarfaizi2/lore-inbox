Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVBVWfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVBVWfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVBVWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:35:32 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:2441 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261308AbVBVWfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:35:16 -0500
Date: Tue, 22 Feb 2005 14:34:48 -0800
From: David Hinds <dhinds@sonic.net>
To: Russell King <rmk@arm.linux.org.uk>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does printk helps PCMCIA card to initialise?
Message-ID: <20050222223448.GA32644@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005, Linus Torvalds wrote:
> On Mon, 21 Feb 2005, Russell King wrote:
> >
> > In cs.c, alloc_io_space(), find the line:
> >
> > if (*base & ~(align-1)) {
> >
> > delete the ~ and rebuild. This may resolve your problem.
> 
> Unlikely. The code is too broken for words.

The original code is correct; you are misinterpreting the meaning of
the "align" variable here.  PCMCIA cards can request a specific base
IO address, and can also specify how many IO address lines they
decode.  The number of decoded lines determines a maximal alignment
restriction for a card; if it only decodes 3 lines, then it should not
reasonably ask for an IO region with more specificity than being on an
8 port boundary.  The "align" variable here holds this alignment.  The
"oddness" here is that the card is providing conflicting information,
that it needs IO ports at a specific address, but is only decoding 3
address lines (i.e. align=8).

The names of "base" and "align" have the expected meanings when a card
only specifies one or the other.  It's only for the case where both
are specified that the meaning is complicated.  Then, "base" is more
like an offset into a block that has "align" alignment

Given an "odd" request for a base=0x260 and align=8, the allocator
promotes this to align=0x400, and would allow addresses 0x260, 0x660,
0xa60, 0xe60, etc, subject to restrictions in /etc/pcmcia/config.opts.

The real problem here is that all the IO address ranges the card
claims to support were unavailable.  I'd first try adding:

  include port 0x0600-0x07ff

to /etc/pcmcia/config.opts to give the allocator more flexibility in
choosing port ranges.  

-- Dave
