Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTESS6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTESS57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:57:59 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:29330 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S262538AbTESS55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:57:57 -0400
Date: Mon, 19 May 2003 12:10:51 -0700
From: Simon Kirby <sim@netnation.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Route cache performance under stress
Message-ID: <20030519191051.GA13087@netnation.com>
References: <8765pshpd4.fsf@deneb.enyo.de> <20030516222436.GA6620@netnation.com> <8765oaxz2f.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765oaxz2f.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Apologies all -- I had my address incorrectly set to sim@netnation.org
  for some reason. ]

On Sat, May 17, 2003 at 01:16:08AM +0200, Florian Weimer wrote:

> > Under normal operation, it looks like most load we are seeing is in fact
> > normal route lookups.  We run BGP peering, and so there is a lot of
> > routes in the table.
> 
> You should aggregate the routes before you load them into the kernel.
> Hardly anybody seems to do this, but usually, you have much fewer
> interfaces than prefixes 8-), so this could result in a huge win.

Hmm... Looking around, I wasn't able to find an option in Zebra to do
this.  Do you know the command to do this?

> Anyway, using data structures tailored to the current Internet routing
> table, it's certainly possible to do destination-only routing using
> half a dozen memory lookups or so (or a few indirect calls, I'm not
> sure which option is cheaper).

Would this still route packets to destinations which would otherwise be
unreachable, then?  While this isn't a big issue, it would be nice to
stop unroutable traffic before it leaves our networks (mostly in the case
where a customer machine is generating bad traffic).

I did experiment with trying to increase the routing (normal, not cache)
hash table another level, but it didn't seem to have much effect.  I
believe I would have to change the algorithm somewhat to prefer falling
into larger hash buckets sooner than how it does at the moment.  I seem
to recall that it would let the hash buckets get rather large before
expanding them.  I haven't had a chance to look at this very deeply, but
the profile I linked to before does show that fn_hash_lookup() does
indeed use more CPU than any other function, so it may be worth looking
at more.  (Aggregating routes would definitely improve the situation in
any case.)

> The patch I posted won't help you as it increases the load
> considerably unless most of your flows consist of one packet.  (And
> there's no need for patching, you can go ahead and just change the
> value via /proc.)

Yes.  I have fiddled with this before, and making the changes you
suggested actually doubled the load in normal operation.  I would assume
this is putting even more pressure on fn_hash_lookup().

Simon-
