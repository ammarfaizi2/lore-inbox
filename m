Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWGRT2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWGRT2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGRT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:28:04 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:30336 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932364AbWGRT2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:28:03 -0400
Date: Tue, 18 Jul 2006 12:28:28 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Boutcher <boutcher@cs.umn.edu>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 33/33] Add Xen virtual block device driver.
Message-ID: <20060718192828.GB2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091958.657332000@sous-sol.org> <17596.56260.541661.919437@hound.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17596.56260.541661.919437@hound.rchland.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Boutcher (boutcher@cs.umn.edu) wrote:
> On Tue, 18 Jul 2006 00:00:33 -0700, Chris Wright <chrisw@sous-sol.org> said:
> > 
> > The block device frontend driver allows the kernel to access block
> > devices exported exported by a virtual machine containing a physical
> > block device driver.
> 
> First, I think this belongs in drivers/block (and the network driver
> belongs in drivers/net).  If we're going to bring xen to the party,
> lets not leave it hiding out in a corner.

Yeah, I think so too.

> > +	switch (backend_state) {
> > +	case XenbusStateUnknown:
> > +	case XenbusStateInitialising:
> > +	case XenbusStateInitWait:
> > +	case XenbusStateInitialised:
> > +	case XenbusStateClosed:
> 
> This actually should get fixed elsewhere, but SillyCaps???

I really don't care either way.  There's no shortage of this style
specifically for enums, in fact there's a wide variety of interesting
styles for enums.

> > +static inline int GET_ID_FROM_FREELIST(
> > +	struct blkfront_info *info)
> > +{
> > +	unsigned long free = info->shadow_free;
> > +	BUG_ON(free > BLK_RING_SIZE);
> > +	info->shadow_free = info->shadow[free].req.id;
> > +	info->shadow[free].req.id = 0x0fffffee; /* debug */
> > +	return free;
> > +}
> > +
> > +static inline void ADD_ID_TO_FREELIST(
> > +	struct blkfront_info *info, unsigned long id)
> > +{
> > +	info->shadow[id].req.id  = info->shadow_free;
> > +	info->shadow[id].request = 0;
> > +	info->shadow_free = id;
> > +}
> 
> A real nit..but why are these routines SHOUTING?

GOOD QUESTION!  I had missed that, thanks.  Seems likely it was just half
converted from macro. I see no reason not to clean that up the rest of
the way.

> > +int blkif_release(struct inode *inode, struct file *filep)
> > +{
> > +	struct blkfront_info *info = inode->i_bdev->bd_disk->private_data;
> > +	info->users--;
> > +	if (info->users == 0) {
> 
> Hrm...this strikes me as racey.  Don't you need at least a memory
> barrier here to handle SMP?
> 
> > +static struct xlbd_major_info xvd_major_info = {
> > +	.major = 201,
> > +	.type = &xvd_type_info
> > +};
> 
> I've forgotten what the current policy is around new major numbers. 

Damn, this is rather funny.  There was a number reserved, but somehow
this is the wrong one (should be 202 according to lanana[1]).  Thanks,
I'll fix that up.

thanks,
-chris

[1] http://www.lanana.org/docs/device-list/devices-2.6+.txt
