Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311743AbSCTHzZ>; Wed, 20 Mar 2002 02:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311745AbSCTHzQ>; Wed, 20 Mar 2002 02:55:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311743AbSCTHy7>;
	Wed, 20 Mar 2002 02:54:59 -0500
Date: Wed, 20 Mar 2002 08:54:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020320075431.GG25171@suse.de>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de> <3C9230C6.4119CB4C@pp.inet.fi> <20020318191352.GF28487@suse.de> <3C97C924.A9A256F6@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20 2002, Jari Ruusu wrote:
> Jens Axboe wrote:
> > On Fri, Mar 15 2002, Jari Ruusu wrote:
> > > If there is any chance of being merged to mainline kernel, I will fix these
> > > "hurt the eyes" formatting issues.
> > 
> > I think there is. At least I can safely say there's no chance it will be
> > merged if these things aren't fixed. So take your pick :-)
> 
> OK, I have fixed above mentioned formatting issues. A patch is attached.

Super!

> And, about sleeping in loop_make_request(), I have also changed the code in
> such way that it defaults to code that may sleep in loop_make_request(). But
> non-sleeping code is still present (but not currently used), like this:
> 
> #if 1
>     may-sleep-in-loop_make_request-code-here
> #else
>     non-sleeping-loop_make_request-code-here
> #endif

The solution I prefer is to have loop_make_request() block when we run
out of pre-allocated buffers, ie similar to "normal" block drivers when
they run out of request slots. This provides a nice throttling mechanism
and makes sure that loop doesn't eat into the memory polls too heavily.

In any way, do it one way and remove the other.

> > > > BTW, it looks like you are killing LO_FLAGS_BH_REMAP?! Why? This is a
> > > > very worthwhile optimization.
> > >
> > > Removing it simplified the code a lot. Doing remap direcly from
> > > loop_make_request() would probably be more effective. Just remap and return
> > 
> > LOTS more effective. Please don't kill this functionality. I don't buy
> > the simplification argument.
> 
> This new patch does not remove LO_FLAGS_BH_REMAP optimization.

Good.

> > > 1 from loop_make_request() like LVM code does.
> > 
> > And like loop currently does...
> 
> 2.4.19-pre3 loop code wanders to loop_get_buffer() and transfer function in
> LO_FLAGS_BH_REMAP optimization case.
> 
> My version is simpler than yours:
> 
>         if (lo->lo_flags & LO_FLAGS_BH_REMAP) {
>                 rbh->b_rsector += (lo->lo_offset >> 9);
>                 rbh->b_rdev = lo->lo_device;
>                 return 1;
>         }               

So the 'new' version does exactly the same, but doesn't do it in
loop_get_buffer().

-- 
Jens Axboe

