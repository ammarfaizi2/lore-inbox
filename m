Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264421AbTCXVMA>; Mon, 24 Mar 2003 16:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264423AbTCXVMA>; Mon, 24 Mar 2003 16:12:00 -0500
Received: from fmr02.intel.com ([192.55.52.25]:39166 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264421AbTCXVL6> convert rfc822-to-8bit; Mon, 24 Mar 2003 16:11:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: lmbench results for 2.4 and 2.5 -- updated results
Date: Mon, 24 Mar 2003 12:11:52 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401669A62@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lmbench results for 2.4 and 2.5 -- updated results
Thread-Index: AcLyQDIuwLuhgj1KQlKt1c/ppmhxBwAAHxHw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Larry McVoy" <lm@bitmover.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@transmeta.com>
X-OriginalArrivalTime: 24 Mar 2003 20:11:53.0137 (UTC) FILETIME=[9C72F210:01C2F241]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it's measuring anything useful at this point, especially with the cost of start(0) and stop(0,0) (they are eventually gettimeofday(), as far as I looked at the code) are substantial compared to page fault (sum += *end;) itself. If you move them outside the while loop, I think it's beter.

void
timeit(char *file, char *where, int size)
{
        char    *end = where + size - 16*1024;
        int     sum = 0;
        int     n = 0, usecs = 0;

        while (end > where) {
                start(0); 
                sum += *end;
                end -= 256*1024;
                usecs += stop(0,0);
                n++;
        }
        use_int(sum);
        fprintf(stderr, "Pagefaults on %s: %d usecs\n", file, usecs/n);



> -----Original Message-----
> From: Larry McVoy [mailto:lm@bitmover.com]
> Sent: Monday, March 24, 2003 12:01 PM
> To: Pallipadi, Venkatesh
> Cc: linux-kernel@vger.kernel.org; Linus Torvalds
> Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
> 
> On Mon, Mar 24, 2003 at 11:53:44AM -0800, Pallipadi, Venkatesh wrote:
> > --- LMbench/src/lat_pagefault.c.org	Mon Mar 24 10:40:46 2003
> > +++ LMbench/src/lat_pagefault.c	Mon Mar 24 10:54:34 2003
> > @@ -67,5 +67,5 @@
> >  		n++;
> >  	}
> >  	use_int(sum);
> > -	fprintf(stderr, "Pagefaults on %s: %d usecs\n", file, usecs/n);
> > +	fprintf(stderr, "Pagefaults on %s: %f usecs\n", file, (1.0 *
> > usecs) / n);
> >  }
> 
> It's been a long time since I've looked at this benchmark, has anyone
> stared at it and do you believe it measures anything useful?  If not,
> I'll drop it from a future release.  If I remember correctly what I
> was trying to do was to measure the cost of setting up the mapping
> but I might be crackin smoke.
> --
> ---
> Larry McVoy              lm at bitmover.com
> http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
