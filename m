Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRHTWkz>; Mon, 20 Aug 2001 18:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHTWkp>; Mon, 20 Aug 2001 18:40:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2052 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269740AbRHTWke>; Mon, 20 Aug 2001 18:40:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Tue, 21 Aug 2001 00:47:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108201841400.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108201841400.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820224041Z16363-32383+593@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 11:44 pm, Rik van Riel wrote:
> On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > On August 20, 2001 09:12 pm, Marcelo Tosatti wrote:
> > > Find riel's message with topic "VM tuning" to linux-mm, then take a look
> > > at the 4th aging option.
> > >
> > > That one _should_ be able to make us remove all kinds of "hacks" to do
> > > drop behind, and also it should keep hot/warm active memory _in cache_
> > > for more time.
> >
> > I looked at it yesterday.  The problem is, it loses the
> > information about *how* a page is used: pagecache lookup via
> > readahead has different implications than actual usage.
> 
> - How is that different from your use-once thing ?

I presume that new pages start on the active list with age=2.  So they will
survive two complete scans before being deactivated.  This by itself is a
big difference.  The other difference is, you don't distinguish between page 
references caused by readahead and page references caused by actual use.  
This is not to say that your strategy is bad, only that it is different.  In 
the end, measured performance is the only important difference.  

> - Where do we do "pagecache lookup via readahead"
>   without "actual usage" of the page ?

Both in do_generic_file_read and do_swap_page.  Usually, we use all the 
readahead pages, yes, but not always, especially in the case of swap or 
random IO.

> > The other thing that looks a little problematic, which Rik also
> > pointed out, is the potential long lag before the inactive page
> > is detected. A lot of IO can take place in this time, filling up
> > the active list with pages that we could have evicted much
> > earlier.
> 
> The lag I described to you had to do with the different
> kinds of page aging used and with the time it takes for
> previously "hot" pages to cool down and become inactive
> pages.
> 
> I think you have things mixed up here ;)

OK, just strike the "which Rik pointed out".  It's still quite a lot more lag 
than we get when the page just moves from one end of the inactive queue to 
the other.  The lag you mentioned had more to do with replacing an entire 
working set, an orthogonal problem.

--
Daniel
