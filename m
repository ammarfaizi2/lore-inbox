Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUAPFAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUAPFAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:00:20 -0500
Received: from palrel13.hp.com ([156.153.255.238]:48005 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263903AbUAPFAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:00:08 -0500
Date: Thu, 15 Jan 2004 21:00:59 -0800
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040116050059.GA13222@cup.hp.com>
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116003224.GF23253@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 04:32:25PM -0800, Greg KH wrote:
> It looks ok, but it would really be good if we could indicate if the
> read actually was successful.  Right now some platforms can detect
> faults and do not have a way to get that error back to the driver in a
> sane manner.  If we were to change the read* functions to look something
> like:
> 	int readb(void *addr, u8 *data);
> it would be a world easier.

I've worked on systems with that kind of an interface and it
really makes a mess of the code. And many of the drivers just
ignored the read return value.

> Now I'm not saying I want to change the existing interfaces to support
> this, that's too much code to change for even me (and is a 2.7 thing.)

I think you'll find it's extremely invasive if it's going to be useful.
The drivers have to be rewritten to check each PIO return value
and then do something intelligent at that point. HPUX had drivers
that did this for "Host Power Fail" support 10 years ago but
it's *very* difficult to get all the error handling right in
each of the code pathes.

My preference is the driver register a "clean up all pending IO and
free related data structures" so it's back to a state as if it hadn't
been started. Then when a PIO read (or write) fails, the mechanism for
detecting the read failure doesn't depend on synchronous errors being
reported/checked by software on each read. ie the mechanism for
detecting the failure *can* be in the PIO read code path but
doesn't have to be if HW has facilities to detect failures.
(I'm thinking of parisc HPMC and ia64 MCA handling).

> Just wanted to put this idea in people's heads that we need to start
> planning for something like it.

yeah - getting to the next level of availability on higher end systems
is hard. I'm not totally convinced it's the right thing for linux
to do, but if someone wants to fund the work, it'll be interesting
to work on.

grant
