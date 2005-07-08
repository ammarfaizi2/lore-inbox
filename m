Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVGHJXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVGHJXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVGHJXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:23:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262368AbVGHJXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:23:10 -0400
Date: Fri, 8 Jul 2005 11:24:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Grant Coady <grant_lkml@dodo.com.au>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       slpratt@austin.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] IDE update
Message-ID: <20050708092422.GC7050@suse.de>
References: <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org> <20050708084817.GB7050@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708084817.GB7050@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08 2005, Jens Axboe wrote:
> On Tue, Jul 05 2005, Linus Torvalds wrote:
> > So my gut feel is that the reason hdparm and dd from the raw partition 
> > gives different performance is not so much the driver, but probably that 
> > we've tweaked read-ahead for file access or something like that. Maybe 
> > the maximum fs-level read-ahead changed?
> 
> I don't think this is the case. I butchered a test system here and
> successfully got it running a P2 at 375MHz (don't ask, messing with
> multipliers and FSB with slot-1 cpu's has been a while) and 2.6 was
> still faster.
> 
> But! I used hdparm -t solely, 2.6 was always ~5% faster than 2.4. But
> using -Tt slowed down the hd speed by about 30%. So it looks like some
> scheduler interaction, perhaps the memory timing loops gets it marked as
> batch or something?

Some more investigation - it appears to be broken read-ahead, actually.
hdparm does repeated read(), lseek() loops which causes the read-ahead
logic to mark the file as being in cache (since it reads the same chunk
every time). Killing the INCACHE check (attached) makes it work fine for
me, Grant can you test if it "fixes" it for you as well?

No ideas how to fix the read-ahead logic right now, I pondered some
depedency on sequential but I don't see how it can work correctly for
other cases. Perhaps handle_ra_miss() just isn't being called
appropriately everywhere?

--- mm/readahead.c~	2005-07-08 11:16:14.000000000 +0200
+++ mm/readahead.c	2005-07-08 11:17:49.000000000 +0200
@@ -351,7 +351,9 @@
 		ra->cache_hit += nr_to_read;
 		if (ra->cache_hit >= VM_MAX_CACHE_HIT) {
 			ra_off(ra);
+#if 0
 			ra->flags |= RA_FLAG_INCACHE;
+#endif
 			return 0;
 		}
 	} else {

-- 
Jens Axboe

