Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310569AbSCGWot>; Thu, 7 Mar 2002 17:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310566AbSCGWol>; Thu, 7 Mar 2002 17:44:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310565AbSCGWna>;
	Thu, 7 Mar 2002 17:43:30 -0500
Message-ID: <3C87ECA7.FC68705A@zip.com.au>
Date: Thu, 07 Mar 2002 14:41:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87E859.427EC3C7@zip.com.au> <Pine.LNX.4.44L.0203071926340.2181-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 7 Mar 2002, Andrew Morton wrote:
> 
> > > use-once reduces the VM to FIFO order, which suffers from
> > > belady's anomaly so it doesn't matter much how much memory
> > > you throw at it
> > >
> > > drop-behind will suffer the same problem once the readahead
> > > memory is too large to keep in the system, but at least the
> > > already-used pages won't kick out readahead pages
> >
> > err..  Was there a fix in there somewhere, or are we stuck?
> 
> Imagine how TCP backoff would work if it kept old packets
> around and would drop random packets because of too many
> old packets in the buffers.
> 
> I suspect that the readahead window resizing might work
> when we throw away the already-used streaming IO pages
> before we start throwing away any pages we're about to
> use.

ewww..  You seem to be implying that when the readahead
code goes to get a new page, it's reclaiming unused
readahead pages *in preference to* already-used pages.

That would be awful, wouldn't it?

Perhaps an algorithm would be:

a) Call mark_page_accessed once against readahead pages.

b) If thrashing is detected, call mark_page_accessed
   twice against readahead pages, to move them onto the
   active list.

   The intent being to say "this page is important.  Throw
   something else away".

Seems this would delay the onset of the problem significantly?

-
