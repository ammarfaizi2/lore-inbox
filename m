Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRBNT2P>; Wed, 14 Feb 2001 14:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131065AbRBNT2F>; Wed, 14 Feb 2001 14:28:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64526 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130766AbRBNT1u>; Wed, 14 Feb 2001 14:27:50 -0500
Date: Wed, 14 Feb 2001 15:38:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Lord <lord@sgi.com>
cc: simon@baydel.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: File IO performance 
In-Reply-To: <200102141744.f1EHib628724@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.21.0102141438470.31465-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Feb 2001, Steve Lord wrote:

<snip>

> > However, we may still optimize readahead a bit on Linux 2.4 without too
> > much efforts: an IO read command which fails (and returns an error code
> > back to the caller) if merging with other requests fail. 
> > 
> > Using this command for readahead pages (and quitting the read loop if we
> > fail) can "fix" the logically!=physically contiguous problem and it also
> > fixes the case were we sleep and the previous IO commands have been
> > already sent to disk when we wakeup. This fix ugly and not as good as the
> > IO clustering one, but _much_ simpler and thats all we can do for 2.4, I
> > suppose.
> 
> We could break the loop apart somewhat and grab pages first, map them,
> then submit all the I/Os together. 
>
> This has other costs assoiated with it, the earlier pages in the
> readahead - the ones likely to be used first, will be delayed by the
> setup of the other pages. So the calling thread is less likely to find
> the first of these pages in cache next time it somes around looking
> for them. Of course, most of the time, the thread doing the setup of
> readahead is the thread doing the reading, so it gets to wait anyway.
> 
> I am not sure that the fact we do readahead on non contiguous data matters,
> since that is the data the user will want anyway. 

Hum, yes. 

> A break in the on disk mapping of data could be used to stop readahead
> I suppose, especially if getting that readahead page is going to
> involve evicting other pages. I suspect that doing this time of thing
> is probably getting too complex for it's own good though.
>
> Try breaking the readahead loop apart, folding the page_cache_read into
> the loop, doing all the page allocates first, and then all the readpage
> calls. 

Its too dangerous it seems --- the amount of pages which are
allocated/locked/mapped/submitted together must be based on the number of
free pages otherwise you can run into an oom deadlock when you have a
relatively high number of pages allocated/locked. 

> I suspect you really need to go a bit further and get the mapping of
> all the pages fixed up before you do the actual reads.

Hum, also think about a no-buffer-head deadlock when we're under a
critical number of buffer heads while having quite a few buffer heads
locked which are not going to be queued until all needed buffer heads are 
allocated. 

