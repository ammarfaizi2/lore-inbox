Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292983AbSCORfn>; Fri, 15 Mar 2002 12:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292981AbSCORf2>; Fri, 15 Mar 2002 12:35:28 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:13269 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S292983AbSCORfT>; Fri, 15 Mar 2002 12:35:19 -0500
Message-ID: <3C9230C6.4119CB4C@pp.inet.fi>
Date: Fri, 15 Mar 2002 19:35:02 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314032801.C1273@dualathlon.random> <3C912ACF.AF3EE6F0@pp.inet.fi> <20020315105621.GA22169@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Mar 15 2002, Jari Ruusu wrote:
> > - No more illegal sleeping in generic_make_request().
> 
> I've told you this before -- sleeping in make_request is not illegal,
> heck it happens _all the time_. Safely sleeping requires a reserved pool
> of the units you wish to allocate, of course. In fact I think that would
> be much nicer than the path you are following here by delaying
> allocations to the loop thread (and still not using a reserved pool).

Yes, I know you have told me that before, but I'm being overcareful. See:

<quote> from device drivers book by Alessandro Rubini, chapter 12, page 331
The request function has one very important constraint: it must be atomic.
request is not usually called in direct response to user requests, and it is
not running in the context of any particular process. It can be called at
interrupt time, from tasklets, or from any number of other places. Thus, it
must not sleep while carrying out its tasks.
</quote>

> - loop_put_buffer(), it looks racy to check waitqueue_active there.

No race there. All that loop_put_buffer() cares is that helper thread wakes
up. If helper thread woke up earlier and completed its job, fine. If helper
thread wakes up later, that is fine too. If helper thread wakes up
unnecessarily, it will just go back to sleep after noticing that that there
is no work to do.

> -       if(!bh) return((struct buffer_head *)0);
> 
> eww!
> 
> - Also, please adher to the style. VaRiAbLe names can hurt the eyes, and
> stuff like
> 
>         if (something) break;
> 
>         return(val);
> 
> etc don't belong too. Could you fix that up?
> 
> That said, thanks for fixing it!

If there is any chance of being merged to mainline kernel, I will fix these
"hurt the eyes" formatting issues.

> BTW, it looks like you are killing LO_FLAGS_BH_REMAP?! Why? This is a
> very worthwhile optimization.

Removing it simplified the code a lot. Doing remap direcly from
loop_make_request() would probably be more effective. Just remap and return
1 from loop_make_request() like LVM code does.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
