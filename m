Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271381AbTHMELv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 00:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271383AbTHMELv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 00:11:51 -0400
Received: from waste.org ([209.173.204.2]:11216 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271381AbTHMELs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 00:11:48 -0400
Date: Tue, 12 Aug 2003 23:06:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@intercode.com.au>,
       Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030813040614.GP31810@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813032038.GA1244@think>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:20:38PM -0400, Theodore Ts'o wrote:
> On Sun, Aug 10, 2003 at 12:45:28PM -0500, Matt Mackall wrote:
> > I suppose the comment you deleted was a little light on details, sigh.
> > 
> > The idea with the folding was that we can cover up any systemic
> > patterns in the returned hash by xoring the first half of the hash
> > with the second half of the hash. While this might seem like a good
> > technique intuitively, it's mathematically flawed.
> 
> No, that's not why the folding was done.  You could have asked me
> first....

Didn't think you were terribly interested, considering your lack of
response to the accounting problems.

> First of all, I wasn't worried about simple correlations.  There are
> enough statistical tests done that we don't need to worry about xor
> causing problems.

The argument applies to any and all structure. If X and Y are n-bit
words and some pairs (X,Y) are more likely than others even though X
and Y are perfectly distributed when looked at normally, the
distribution (and hence the entropy) of X^Y will be less ideal than X
or Y taken alone. No statistical tests will catch the case of
X=hash(a) and Y=hash(~a).

> The real issue is discarding information.  By folding, we hide
> information about the output of the SHA hash that will hopefully deny
> information that a Very Sophisticated Attacker (say, at the level of a
> certain agency that designed the SHA algorithm) that might make it
> easier for them to attack the SHA algorithm.

I'll buy that. However simply dropping the data would serve this
purpose better. As would hashing less than the entire pool on each
read. 

Currently we have: 
  hash (1024 or 4096) bits down to 160, mix back in (16 or 64), return 80

The patch I'm fiddling with for cryptoapi comparitive benchmarking does:
  hash 512 to 160, mix back in 160, return 160

More ideal would be something like:
  hash 512 to 160, mix back in 32, return other 128

Actually, I can simply set a return/mix-back ratio per pool, now that
I've added a third one for urandom and then we can raise the tinfoil
factor on /dev/random. Seem reasonable?

> > just x. With the former, every bit of input goes through SHA1 twice,
> > once in the input pool, and once in the output pool, along with lots
> > of feedback to foil backtracking attacks. In the latter, every output
> > bit is going through SHA four times, which is just overkill. 
> 
> Speed really doesn't matter here.  /dev/random is supposed to produce
> somethign which is close to true randomness, not crypto
> psuedo-randomness.  So overkill is a good thing.  It should only be
> used for generating long-term keys, so speed is really not a concern. 

Mostly agreed. But I would also like to:

a) cat /dev/urandom > /dev/hda and not have it take all day
b) enable syncookies with less of a performance penalty
c) generate other short-term keys, cookies, and UUIDs rapidly
d) not disable preemption for long stretches while hashing (a
   limitation of cryptoapi)

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
