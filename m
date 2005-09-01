Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVIASQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVIASQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVIASQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:16:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:992 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030279AbVIASQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:16:50 -0400
Date: Thu, 1 Sep 2005 19:16:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Whither klists?
Message-ID: <20050901181645.GA7440@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Greg KH <greg@kroah.com>, Daniel Ritz <daniel.ritz@gmx.ch>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0509011351400.5533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0509011351400.5533-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 02:09:19PM -0400, Alan Stern wrote:
> Patrick and Greg:
> 
> To put it baldly: Should klists be replaced with regular lists, each 
> protected by an rwsem (or even a mutex)?
> 
> The advantage of klists is that threads can remove or add nodes while 
> other threads iterate through the list.  With an rwsem, only one thread 
> would be able to add or remove a node at a time, and only when no other 
> thread was using the list.  Considering that klists are currently used 
> to hold:
> 
> 	the set of all devices on a bus,
> 
> 	the set of all drivers for a bus, and
> 
> 	the set of all children of a device,
> 
> 	(not counting the set of all devices bound to a driver, since
> 	there's already a patch to replace that with a mutex-protected
> 	regular list)
> 
> this limitation on adding or removing doesn't seem significant.  There
> aren't many places where these lists are iterated over or altered.  We
> could remove most of the overhead associated with klists and get rid of an
> extra API for people to learn.
> 
> Note that this would be very different from the old bus subsystem rwsem.  
> That protected too much -- everything associated with the bus subsystem -- 
> making it a pronounced chokepoint.  My suggestion involves a separate 
> rwsem for each of these lists, so that none of them would be subject to 
> much contention.

Might also be worth to do a micro-benchmark for it (maybe in userland).
The current klist code is far too complex for it's own good.

