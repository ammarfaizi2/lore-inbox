Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbTDTTMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 15:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTDTTMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 15:12:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44765 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263678AbTDTTMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 15:12:32 -0400
Date: Sun, 20 Apr 2003 20:24:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030420192434.GI10374@parcelfarce.linux.theplanet.co.uk>
References: <20030420133143.GF10374@parcelfarce.linux.theplanet.co.uk> <20030420160034.GA20123@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030420160034.GA20123@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc fixed - my apologies]

On Sun, Apr 20, 2003 at 06:00:34PM +0200, Andries Brouwer wrote:
 
> So, the interface with filesystems and with userspace has dev_t.
> For kernel-internal numbers kdev_t is better than dev_t.
> 
> Of course it may be possible to avoid kernel-internal numbers altogether.
> Sometimes that is an improvement, sometimes not. Pointers are more
> complicated than numbers - they point at something that must be allocated
> and freed and reference counted. A number is like a pointer without the
> reference counting.

Sigh...   And what, pray tell, do we do with these numbers?  That's
right, at some point(s) we use them to obtain <drumroll> pointers
to driver-supplied objects.  And that's where the lack of refcounting,
locking, etc. bites you.

Let's sort that mess out for good.  Papering over this stuff won't do
us any good and will only bring more kludgy interfaces.  $DEITY witness,
we already have enough of those.

It's not about pointers vs. numbers - we certainly have enough cases when
we really deal with the latter.  However, I'd rather have clear separation
between "32bit value presented to/by userland to identify device node"
and "value in range 0--7, representing the number of channel on a multiport
card FooLink-8X".  The latter makes perfect sense for a driver.  As does
"structure that represents given instance of FooLink-8X".  The former belongs
to interaction with userland and using it outside of that context is a kludge.
Dangerous kludge in case if it masks the aforementioned complications.
It also breeds all sorts of ugliness in the code - see the crap around
reassigning ->f_op and problems with clean implementation of revoke(2)
analogs for instance.  Or a buttload of fun induced by (completely
artificial) separation into major and minor - see the mess around UNIX98
ptys implementation, etc.

By now all uses of mk_kdev()/major()/minor()/MAJOR()/MINOR() in the drivers
are either trivially removable or represent very real problems.  And it's
not that there was a lot of them - in my current tree there's ~85 instances
of kdev_t in the source.  And only one of them (->i_rdev) is widely used -
~500 instances, most of them go away as soon as CIDR patch gets merged.
The rest is part noise, part real bugs that need to be fixed anyway (~40--80
of those).
