Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUB0MNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUB0MNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:13:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:51972 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261806AbUB0MNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:13:42 -0500
Date: Fri, 27 Feb 2004 12:13:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, akpm@osdl.org,
       linus@osdl.org, anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040227121300.B31544@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, hch@lst.de, akpm@osdl.org,
	linus@osdl.org, anton@samba.org, paulus@samba.org, axboe@suse.de,
	piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au> <20040226095156.GA25423@lst.de> <20040227120451.0e3c43bd.sfr@canb.auug.org.au> <20040227113202.A31176@infradead.org> <20040227225716.5b29c690.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040227225716.5b29c690.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Fri, Feb 27, 2004 at 10:57:16PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In theory you can hot add virtual disks to an iSeries partition (up to 64
> disks per partition).  We used to support that by registering all 32 disks
> with Linux and then probing the hypervisor when any disk was opened at
> which point the hypervisor lets us know that the value of viod_max_disk
> should be increased.  I took that code out in the name of simplicity and
> in the hope of getting the driver accepted.  (In fact it was your comments
> that made me do it.)

Sure - above comments still stand in a hot-add enviroment.  ->open can't
happen before gendisk is registered, hot-add or not.  And the module_init
loop is bogus hot-add or not. 

> I will investigate your suggestion of using
> blk_register_region for the disks that don't exist yet over the next while
> at which point (assuming I can figure out how to do it) the value of
> viodasd_max_disk may again rise over time.

But this doesn't make the current code any better.  With hot-adding disks
you would actually need a variable like viodasd_max_disk that replaces the
current i loop iteractor in module_init with a file-wide variable, but that's
it basically.

> It doesn't break out of the loop when probe_disk fails because it is
> possible to have gaps in the list if disks (e.g. I have have disks 1 2 4 7
> and viodasd_max_disk will be 7 but probe_disk will "fail" for the other
> disks).

That's not how I read your code.  But to actually understand what it's
doing we need to know what open_data.max_disk actually is.

is this the maximum number of disks currently configured (if so the
interface would be absolutely braindead, but the current code would
match your above description although beein rather confusing).

Or does it return the currently opened disks index?
