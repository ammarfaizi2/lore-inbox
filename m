Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbTIWQT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTIWQT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:19:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261803AbTIWQTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:19:54 -0400
Date: Tue, 23 Sep 2003 09:19:29 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
Message-ID: <20030923161929.GB4402@kroah.com>
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923091617.B10818@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 09:16:17AM +0100, Christoph Hellwig wrote:
> On Mon, Sep 22, 2003 at 04:30:28PM -0700, Greg KH wrote:
> >  	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
> > -		/* XXX: WTF is going on here??? */
> > -		if ((is_isa && check_region(addr, 1)) ||
> > +		void *region_used = request_region(addr, 1, "foo");
> > +		release_region(addr, 1);
> > +		if ((is_isa && (region_used == NULL)) ||
> 
> WTF??  Your papering over bugs again, this doesn't help at all.

Why?

Ok, from my reading of this horrible chunk of code it does the
following:
	- if this is a isa based controller, then we check the region
	  that is to be used.
	- If it is already in use by someone else, then we skip it, and
	  move on to the next address.
	- If it is not in use, then we pass the address down to the chip
	  driver and let it try to find the chip at this address (it
	  will do the reserving of the address space on its own.)

So basically, check_region is pretty valid here, as we are trying to see
if something else is already at this address, to try to prevent i2c
drivers from stomping on each other.  I replaced this with a
request_region()/release_region() pair to get rid of the compiler
warning.

Is this your understanding too?  Or do you think we should just get rid
of the request_region() check here all together?

thanks,

greg k-h
