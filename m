Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTKTFrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTKTFrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:47:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264258AbTKTFra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:47:30 -0500
Date: Thu, 20 Nov 2003 05:47:29 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 2.6.x experimental net driver updates
Message-ID: <20031120054729.GC24159@parcelfarce.linux.theplanet.co.uk>
References: <3FBBA954.6000601@pobox.com> <20031120025423.GB24159@parcelfarce.linux.theplanet.co.uk> <3FBC4FE0.2020705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBC4FE0.2020705@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 12:23:44AM -0500, Jeff Garzik wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> >On Wed, Nov 19, 2003 at 12:33:08PM -0500, Jeff Garzik wrote:
> >
> >>Ok, Al Viro's net driver refcounting work is pretty much complete, and 
> >
> >
> >The hell it is.  We are through with legacy probes, we are through with
> >init_etherdev(), we are practically through with static struct net_device.
> 
> hehe :)  I don't mean to suggest that all is clean and pure :)
> 
> 
> >However, we still have weird allocators (I've got almost all of them
> >done by now, will submit in the next batch) and we still have struct
> >net_device embedded as a field of other structures in several drivers.
> 
> Some of that will be interesting.  ns83820 for example embedded 
> net_device on purpose...  Ben seemed to think at the time it gave him 
> some speed, a few less pointer derefs and such.

That's fine, but 83820 should be doing that the other way round.

Note that for objects allocated by alloc_netdev() we have
	(char*) dev->priv == (char *)dev + const
and constant can be found at compile time _if_ we pad in front of
net_device and add a pointer to allocated block into net_device.

So we can have exactly the same structure (modulo padding) and no extra
dereferencing.  All we need is inlined void *net_priv(struct net_device *);

That, BTW, would be a win for other drivers using alloc_...() and not
reassigning ->priv (i.e. majority of those beasts).
