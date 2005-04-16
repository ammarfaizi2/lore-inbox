Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVDPTWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVDPTWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 15:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVDPTWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 15:22:55 -0400
Received: from waste.org ([216.27.176.166]:10204 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262738AbVDPTWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 15:22:52 -0400
Date: Sat, 16 Apr 2005 12:22:35 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux@horizon.com
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: Fortuna
Message-ID: <20050416192235.GC21897@waste.org>
References: <20050416154625.GD17029@certainkey.com> <20050416171622.12751.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416171622.12751.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 05:16:22PM -0000, linux@horizon.com wrote:
> > "How does the entropy estimator measure entropy of the event?" becomes a
> > crucial concern here.  What if, by your leading example, there is 1/2 bit
> > of entropy in each event?  Will the estimator even account for 1/2 bits?
> > Or will it see each event as 3 bits of entropy?  How much of a margin
> > of error can we tolerate?
> 
> H'm... the old code *used* to handle fractional bits, but the new code
> seems to round down to the nearest bit.  May have to get fixed to
> handle low-rate inputs.

I don't believe that was ever true, though it can fairly trivially be added.
JLC, please note that entropy estimation is much more conservative now
than it was a month ago.

> As for margin of error, any persistent entropy overestimate is Bad.
> a 6-fold overestimate is disastrous.
> 
> What we can do is refuse to drain the main pool below, say, 128 bits of
> entropy.  Then we're safe against any *occasional* overestimates
> as long as they don't add up to 128 bits.

I've been moving in that direction already, most of the infrastructure
is already in place.

> > /dev/random will output once it has at least 160 bits of entropy
> > (iirc), 1/2 bit turning into 3 bits would mean that 160bits of output
> > it effectively only 27 bits worth of true entropy (again, assuming the
> > catastrophic reseeder and output function don't waste entropy).
> > 
> > It's a lot of "ifs" for my taste.
> 
> /dev/random will output once it has as many bits of entropy as you're
> asking for.  If you do a 20-byte read, it'll output once it has 160
> bits.  If you do a 1-byte read, it'll output once it has 8 bits.

That's not quite right. It needs 8 bits in the relevant output pool.
Failing that, it needs 64 bits in the input pool to reseed the output
pool. In the case of /dev/urandom, it needs 128 bits in the input
pool, it always leaves enough for /dev/random to reseed.

-- 
Mathematics is the supreme nostalgia of our time.
