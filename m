Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbTJBKfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 06:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbTJBKfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 06:35:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46288 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263329AbTJBKfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 06:35:51 -0400
Date: Thu, 2 Oct 2003 11:35:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
Message-ID: <20031002103550.GB7665@parcelfarce.linux.theplanet.co.uk>
References: <1064936688.4222.14.camel@localhost.localdomain> <200309302006.32584.vitaly@namesys.com> <1065019441.4226.1.camel@localhost.localdomain> <16251.5348.570797.101912@laputa.namesys.com> <20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk> <16251.63770.622805.143036@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16251.63770.622805.143036@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 02:08:26PM +0400, Nikita Danilov wrote:
> What about creating fake struct vfsmount for /proc/fs/reiserfs/<devname>
> and attaching it to the super block of /<mountpoint>? After all
> /proc/fs/reiserfs/<devname> is just a view into /<mountpoint>. This will
> automatically guarantee that /<mountpoint> cannot be unmounted while
> files in /proc/fs/reiserfs/<devname> are opened. Will this screw up
> dcache?

I don't see what it would buy you - you get to revalidate the pointer to
vfsmount instead of revalidating pointer to superblock, which is not easier.
sget()-based revalidation actually works OK - see previous reply for details.
With optimistic sget() (which we should've done a long time ago) it's
actually cheaper than your original "search by dev_t" - you are looking
only through reiserfs superblocks instead of all superblocks in system.
 
> Yes, possible. I had similar problem in reiser4 also: for some seq_file,
> x_start() allocated some data structure (struct x_struct) that is used
> by x_next(), x_show(), and is deallocated in x_stop(). As x_struct is
> per read invocation rather than per file it cannot be stored in seq_file
> itself. I had to resort to returning x_struct from x_start() and passing
> it without change through x_next()'s. Thing actually changed by x_next()
> was embedded in x_struct. Last x_next() had to deallocate x_struct and
> to return NULL (much like your example above).

Umm...  And what's the problem with that?  If your context is created by
->start() and is needed by ->next() and ->stop(), the above is obvious
solution - you are already passing opaque pointer through that sequence,
so that's about as straightforward as it gets...
