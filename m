Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUCaXUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUCaXUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:20:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261915AbUCaXUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:20:32 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040331145352.23df0831.akpm@osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <20040331145352.23df0831.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080775221.1991.91.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2004 00:20:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-03-31 at 23:53, Andrew Morton wrote:
> "Stephen C. Tweedie" <sct@redhat.com> wrote:

> > Unfortunately, this seems to contradict SingleUnix requirements, which
> > state:
> >         When MS_ASYNC is specified, msync() shall return immediately
> >         once all the write operations are initiated or queued for
> >         servicing
> > although I can't find an unambiguous definition of "queued for service"
> > in the online standard.  I'm reading it as requiring that the I/O has
> > reached the block device layer

> I don't think I agree with that.  If "queued for service" means we've
> started the I/O, then what does "initiated" mean, and why did they specify
> "initiated" separately?

I'd interpret "initiated" as having reached hardware.  "Queued for
service" is much more open to interpretation: Uli came up with "the data
must be actively put in a stage where I/O is initiated", which still
doesn't really address what sort of queueing is allowed.

> What triggered all this was a dinky little test app which Linus wrote to
> time some aspect of P4 tlb writeback latency.  It sits in a loop dirtying a
> page then msyncing it with MS_ASYNC.  It ran very poorly, because MS_ASYNC
> ended up waiting on the previously-submitted I/O before starting new I/O.

Sure.  There are lots of ways an interface can be misused, though: you
only know if one use is valid or not once you've determined what the
_correct_ use is.  I'm much more concerned about getting a correct
interpretation of the spec than of making IO fast for the sake of a
memory benchmark. :-)

> One approach to improving that would be for MS_ASYNC to say "if the page is
> already under writeout then just skip the I/O".  But that's worthless,
> really - it makes the MS_ASYNC semantics too vague.

Agreed.

> Your reversion patch would mean that current applications which use
> MS_ASYNC will again suffer large latencies if the pages are under writeout.

Well, this whole issue came up precisely because somebody was seeing
exactly such a latency hit going from 2.4.9 to a later kernel.  We've
not really been consistent about it in the past.

> Sure, users could switch apps to using flags=0 to avoid that, but people
> don't know to do that.

Exactly why we need documentation for that combination, whatever
happens.

> So given that SUS is ambiguous about this, I'd suggest that we be able to
> demonstrate some real-world reason why this matters.  Why are you concerned
> about this?

Just for the reason you mentioned --- a real-world app (in-house, so
flags==0 is actually a valid solution for them) which was seeing
performance degradation when the "MS_ASYNC submits IO" was introduced in
the first place.  But it was internally written, so I've no idea at all
whether or not the app was assuming one behaviour or the other on other
Unixen.

--Stephen

