Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVGHJfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVGHJfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVGHJfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:35:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262391AbVGHJfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:35:33 -0400
Date: Fri, 8 Jul 2005 02:34:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, grant_lkml@dodo.com.au, linux@rainbow-software.org,
       andre@tomt.net, a1426z@gawab.com, linux-kernel@vger.kernel.org,
       slpratt@austin.ibm.com
Subject: Re: [git patches] IDE update
Message-Id: <20050708023430.6a903e55.akpm@osdl.org>
In-Reply-To: <20050708092422.GC7050@suse.de>
References: <1120567900.12942.8.camel@linux>
	<42CA84DB.2050506@rainbow-software.org>
	<1120569095.12942.11.camel@linux>
	<42CAAC7D.2050604@rainbow-software.org>
	<20050705142122.GY1444@suse.de>
	<6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
	<Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
	<nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com>
	<Pine.LNX.4.58.0507052209180.3570@g5.osdl.org>
	<20050708084817.GB7050@suse.de>
	<20050708092422.GC7050@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Some more investigation - it appears to be broken read-ahead, actually.
>  hdparm does repeated read(), lseek() loops which causes the read-ahead
>  logic to mark the file as being in cache (since it reads the same chunk
>  every time). Killing the INCACHE check (attached) makes it work fine for
>  me, Grant can you test if it "fixes" it for you as well?
> 
>  No ideas how to fix the read-ahead logic right now, I pondered some
>  depedency on sequential but I don't see how it can work correctly for
>  other cases. Perhaps handle_ra_miss() just isn't being called
>  appropriately everywhere?
> 
>  --- mm/readahead.c~	2005-07-08 11:16:14.000000000 +0200
>  +++ mm/readahead.c	2005-07-08 11:17:49.000000000 +0200
>  @@ -351,7 +351,9 @@
>   		ra->cache_hit += nr_to_read;
>   		if (ra->cache_hit >= VM_MAX_CACHE_HIT) {
>   			ra_off(ra);
>  +#if 0
>   			ra->flags |= RA_FLAG_INCACHE;
>  +#endif
>   			return 0;
>   		}
>   	} else {

Interesting.  We should be turning that back off in handle_ra_miss() as
soon as hdparm seeks away.  I'd be suspecting that we're not correctly
undoing the resutls of ra_off() within handle_ra_miss(), except you didn't
comment that bit out.

Or the readahead code is working as intended, and hdparm is doing something
really weird which trips it up.

hdparm should also be misbehaving when run against a regular file, but it
looks like hdparm would need some alterations to test that.
