Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUB0LcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUB0LcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:32:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:28420 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261223AbUB0LcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:32:17 -0500
Date: Fri, 27 Feb 2004 11:32:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linus@osdl.org,
       anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-ID: <20040227113202.A31176@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linus@osdl.org,
	anton@samba.org, paulus@samba.org, axboe@suse.de,
	piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040123163504.36582570.sfr@canb.auug.org.au> <20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au> <20040226095156.GA25423@lst.de> <20040227120451.0e3c43bd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040227120451.0e3c43bd.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Fri, Feb 27, 2004 at 12:04:51PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it to the maximum value and then reset it in a magic even handler?
> > I think that logic needs some clarification.
> 
> The "magic event handler" is synchronous with the probe_disk routine.  I
> agree it is a bit confusing, but, at least I have the comment there about
> the side effects of the probe_disk routine.  Changed slightly.

The code that is in Linus' tree is still b0rked:

 - you set viodasd_max_disk in viodasd_open which looks completely bogus:
    o the value is never used after module_init, and as long as module_init
      and blkdev ->open under BKL they are serialized.
    o even if they weren't you wouldn't ever get an open call for a device
      > viodasd_max_disk
    o that means if you actually got there it would either be the same or
      decreased
    o if it was decreased in parallel to module_init your loop in
      module_init would be totally screwed.
  - now to that loop in module_init:
    o they only thing that it actually archives is that it breaks out of
      the loop if a probe_disk fails - but you could archive that much
      more easier by just returning an error from the probe_disk and
      use a break out of the loop.  The >= MAX_DISKNO check could then
      easily happen on the i used as loop counter.

> > for lowend configurations (remember we have a 32bit dev_t now)
> 
> Can I leave this for now?

It's really awkwards.  And IBM will most likely want lots of disks soon
anyway :)

