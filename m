Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTIWTEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTIWTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:04:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:6336 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263420AbTIWTEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:04:40 -0400
Date: Tue, 23 Sep 2003 12:04:40 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
Message-ID: <20030923190440.GA5205@kroah.com>
References: <10642734271572@kroah.com> <1064273428551@kroah.com> <20030923091617.B10818@infradead.org> <20030923161929.GB4402@kroah.com> <20030923172258.B19880@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923172258.B19880@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:22:58PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 23, 2003 at 09:19:29AM -0700, Greg KH wrote:
> > Ok, from my reading of this horrible chunk of code it does the
> > following:
> > 	- if this is a isa based controller, then we check the region
> > 	  that is to be used.
> > 	- If it is already in use by someone else, then we skip it, and
> > 	  move on to the next address.
> > 	- If it is not in use, then we pass the address down to the chip
> > 	  driver and let it try to find the chip at this address (it
> > 	  will do the reserving of the address space on its own.)
> > 
> > So basically, check_region is pretty valid here, as we are trying to see
> > if something else is already at this address, to try to prevent i2c
> > drivers from stomping on each other.  I replaced this with a
> > request_region()/release_region() pair to get rid of the compiler
> > warning.
> > 
> > Is this your understanding too?  Or do you think we should just get rid
> > of the request_region() check here all together?
> 
> Yes, either we should get rid of it or move claiming the address to
> the i2c midlayer (not sure whether that's a good idea).  But an
> opencoded check_region doesn't make any more sense than an explicit
> one.  And you're also looking at the pointer it returned after it's
> already invalid again..

Heh, good point.  Ok, I dug out a box that uses a isa i2c adapter and
tested the patch below.  As the chip drivers are using request_region
properly, taking this check out of i2c-sensor.c makes sense.

thanks,

greg k-h


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Tue Sep 23 12:03:13 2003
+++ b/drivers/i2c/i2c-sensor.c	Tue Sep 23 12:03:13 2003
@@ -50,10 +50,7 @@
 		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		void *region_used = request_region(addr, 1, "foo");
-		release_region(addr, 1);
-		if ((is_isa && (region_used == NULL)) ||
-		    (!is_isa && i2c_check_addr(adapter, addr)))
+		if (!is_isa && i2c_check_addr(adapter, addr))
 			continue;
 
 		/* If it is in one of the force entries, we don't do any
