Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbRFEHzJ>; Tue, 5 Jun 2001 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbRFEHyy>; Tue, 5 Jun 2001 03:54:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29708 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263285AbRFEHyu>; Tue, 5 Jun 2001 03:54:50 -0400
Date: Tue, 5 Jun 2001 03:18:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.33.0106050820540.867-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0106050307250.2846-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Jun 2001, Mike Galbraith wrote:

> On Mon, 4 Jun 2001, Marcelo Tosatti wrote:
> 
> > Zlatko,
> >
> > I've read your patch to remove nr_async_pages limit while reading an
> > archive on the web. (I have to figure out why lkml is not being delivered
> > correctly to me...)
> >
> > Quoting your message:
> >
> > "That artificial limit hurts both swap out and swap in path as it
> > introduces synchronization points (and/or weakens swapin readahead),
> > which I think are not necessary."
> >
> > If we are under low memory, we cannot simply writeout a whole bunch of
> > swap data. Remember the writeout operations will potentially allocate
> > buffer_head's for the swapcache pages before doing real IO, which takes
> > _more memory_: OOM deadlock.
> 
> What's the point of creating swapcache pages, and then avoiding doing
> the IO until it becomes _dangerous_ to do so?  

Its not dangerous to do the IO. Now it _is_ dangerous to do the IO without
having any sane limit on the amount of data being written out at the same
time.

> That's what we're doing right now.  This is a problem because we
> guarantee it will become one.

Its not really about swapcache pages --- its about anonymous memory. 

If you're memory is full of anonymous data, you have to push some of this
data to disk. (conceptually it does not really matter if its swapcache or
not, think about anonymous memory)

> We guarantee that the pagecache will become almost pure swapcache by
> delaying the writeout so long that everything else is consumed.

Exactly. And when we reach a low watermark of memory, we start writting
out the anonymous memory.

> In experiments, speeding swapcache pages on their way helps.  Special
> handling (swapcache bean counting) also helps. (was _really ugly_ code..
> putting them on a seperate list would be a lot easier on the stomach:)

I agree that the current way of limiting on-flight swapout can be changed
to perform better. 

Removing the amount of data being written to disk when we have a memory
shortage is not nice. 

