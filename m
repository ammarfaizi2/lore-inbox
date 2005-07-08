Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVGHJw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVGHJw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVGHJw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:52:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262418AbVGHJwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:52:23 -0400
Date: Fri, 8 Jul 2005 11:53:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, grant_lkml@dodo.com.au, linux@rainbow-software.org,
       andre@tomt.net, a1426z@gawab.com, linux-kernel@vger.kernel.org,
       slpratt@austin.ibm.com
Subject: Re: [git patches] IDE update
Message-ID: <20050708095335.GD7050@suse.de>
References: <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org> <20050708084817.GB7050@suse.de> <20050708092422.GC7050@suse.de> <20050708023430.6a903e55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708023430.6a903e55.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Some more investigation - it appears to be broken read-ahead, actually.
> >  hdparm does repeated read(), lseek() loops which causes the read-ahead
> >  logic to mark the file as being in cache (since it reads the same chunk
> >  every time). Killing the INCACHE check (attached) makes it work fine for
> >  me, Grant can you test if it "fixes" it for you as well?
> > 
> >  No ideas how to fix the read-ahead logic right now, I pondered some
> >  depedency on sequential but I don't see how it can work correctly for
> >  other cases. Perhaps handle_ra_miss() just isn't being called
> >  appropriately everywhere?
> > 
> >  --- mm/readahead.c~	2005-07-08 11:16:14.000000000 +0200
> >  +++ mm/readahead.c	2005-07-08 11:17:49.000000000 +0200
> >  @@ -351,7 +351,9 @@
> >   		ra->cache_hit += nr_to_read;
> >   		if (ra->cache_hit >= VM_MAX_CACHE_HIT) {
> >   			ra_off(ra);
> >  +#if 0
> >   			ra->flags |= RA_FLAG_INCACHE;
> >  +#endif
> >   			return 0;
> >   		}
> >   	} else {
> 
> Interesting.  We should be turning that back off in handle_ra_miss() as
> soon as hdparm seeks away.  I'd be suspecting that we're not correctly
> undoing the resutls of ra_off() within handle_ra_miss(), except you didn't
> comment that bit out.
> 
> Or the readahead code is working as intended, and hdparm is doing something
> really weird which trips it up.
> 
> hdparm should also be misbehaving when run against a regular file, but it
> looks like hdparm would need some alterations to test that.

Just use the test app I posted, it shows the problem just fine. If I use
a regular file, behaviour is identical as expected (ie equally broken
:-).

bart:/data1 # ./read_disk ./test 1
Mem Throughput: 101 MiB/sec
Mem Throughput: 103 MiB/sec
Disk Throughput: 22 MiB/sec

bart:/data1 # ./read_disk ./test
Disk Throughput: 29 MiB/sec

-- 
Jens Axboe

