Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135842AbRD3Tc6>; Mon, 30 Apr 2001 15:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRD3Tct>; Mon, 30 Apr 2001 15:32:49 -0400
Received: from chromium11.wia.com ([207.66.214.139]:32785 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S135842AbRD3Tcb>; Mon, 30 Apr 2001 15:32:31 -0400
Message-ID: <3AEDBEB8.449D88C3@chromium.com>
Date: Mon, 30 Apr 2001 12:36:24 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0104292207530.14261-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok I fixed it, the header date timestamp is updated with every request.

Performance doesn't seem to have suffered significantly (less than 1%).

You can find the new release at:  http://www.chromium.com/X15-Alpha-2.tgz

BTW: Don't call me slime, I wasn't trying to cheat, I just didn't know that
the date stamp was required to be really up-to-date.

 - Fabio

dean gaudet wrote:

> On Sun, 29 Apr 2001, Fabio Riccardi wrote:
>
> > I can disable header caching and see what happens, I'll add an option
> > for this in the next X15 release.
>
> heh, well to be honest, i'd put the (permanent) caching of the Date header
> into the very slimy, benchmark-only trick category.  (right up there
> alongside running the HTTP and TCP stacks inside the NIC interrupt
> handler, which folks have done to get even better scores.)
>
> > Nevertheless I don't know how much this is interesting in real life,
> > since on the internet most static pages are cached on proxies. I agree
> > that the RFC asks for a date for the original response, but once the
> > response is cached what does this date mean?
>
> the Date is always the time the response was generated on the origin
> server.  (there are exceptions for clockless servers, but such servers
> have other limitations you wouldn't want -- notably they MUST NOT generate
> Last-Modified.)
>
> one example oddity you might experience with a non-increasing Date
> surrounds Last-Modified and Date, see section 13.3.3.  note that the rfc
> indicates that if Last-Modified is less than 60 seconds earlier than Date
> then Last-Modified is only a weak validator rather than a strong
> validator.  this would complicate range requests -- because weak
> validators can't be used with range requests.  if your server never
> updates the Date after the first time it serves an object then you'd
> potentially never get out of this 60 second window.
>
> (strong validators are guaranteed to change whenever the object changes...
> and Last-Modified isn't strong until some time has passed -- consider NFS
> mounted docroots, clock skew in the origin network, multiple file updates
> within a second, etc.)
>
> there are a bunch of other things that Date is used for, all of them are
> related to caching heuristics and rules.
>
> in theory you could claim that you're implementing a cache server rather
> than an origin server... i dunno what the SPEC committee will think when
> you try to submit results though :)
>
> so way back when sendfile() was being created i brought up the Date issue
> and pointed out that we needed more than a single "void *, size_t" to take
> care of headers.  eventually this discussion lead creation of TCP_CORK --
> so that a http server could use writev() to send a two element iov for the
> headers -- one element with everything that doesn't need to change, the
> next element with the Date.
>
> i also kind of expected the high performance servers to rebuild a Date:
> header every second for all of its threads to use.  (of course it's not
> that simple, you really want to keep a circular list of N dates... and
> just assume that after N seconds no thread could still be accessing an old
> Date.)
>
> is this too slow for some reason?  (does it play well with zero-copy?)
>
> -dean
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

