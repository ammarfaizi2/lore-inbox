Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270605AbTHJRpp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 13:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTHJRpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 13:45:45 -0400
Received: from waste.org ([209.173.204.2]:42919 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270605AbTHJRpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 13:45:42 -0400
Date: Sun, 10 Aug 2003 12:45:28 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030810174528.GZ31810@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 11:18:43PM +1000, James Morris wrote:
> On Sat, 9 Aug 2003, Matt Mackall wrote:
> 
> > out. Another thing I failed to mention at 3am is that most of the
> > speed increase actually comes from the following patch which wasn't in
> > baseline and isn't cryptoapi-specific. So I expect the cryptoapi
> > version is about 30% faster once you amortize the initialization
> > stuff.
> > 
> > >>>>
> > Remove folding step and double throughput.
> 
> Why did you remove this?

I suppose the comment you deleted was a little light on details, sigh.

The idea with the folding was that we can cover up any systemic
patterns in the returned hash by xoring the first half of the hash
with the second half of the hash. While this might seem like a good
technique intuitively, it's mathematically flawed.

Let's assume the simplest case of a two bit hash xy. "Patterns" here
are going to translate into a correlation between otherwise
well-distributed x and y. A perfectly uncorrelated system xy is going
to have two bits of entropy. A perfectly correlated (or
anti-correlated) system xy is going to have only 1 bit of entropy.

Now what happens when we fold these two bits together z=x^y? In the
uncorrelated case we end up with a well-distributed z. In the
correlated case, we end up with 0 or 1, that is z=x^x=0 or z=x^-x, and
we've eliminated any entropy we once had. If correlation is less than
100%, then we get somewhere between 0 and 1 bits of entropy, but
always less than if we just returned z=x or z=y. This argument
naturally scales up to larger variables x and y.

Ok, so that explains taking out the xor. But I also return xy and not
just x. With the former, every bit of input goes through SHA1 twice,
once in the input pool, and once in the output pool, along with lots
of feedback to foil backtracking attacks. In the latter, every output
bit is going through SHA four times, which is just overkill. If we
don't trust our hash to generate uniform, non-self-correlating output,
running additional rounds does not guarantee that we aren't magnifying
the problem. And it is of course making everything twice as expensive.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
