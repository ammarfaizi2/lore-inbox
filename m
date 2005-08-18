Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVHRGHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVHRGHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHRGHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:07:06 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:39060 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbVHRGHE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:07:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D43+lP46K2O5wqcfW8EhBTrXvjJmPod3ZBXMHJJrNVnH+vUeT/knsF4ow3fMSjjfZ87wYSqi3Ty/FEZRJWXOag0a4v1hjRMxTmx1p7hHVbwh5/8m5xrASYVsKOfcBki9jOc3kVHr0UYF6hQB+7N7K90Yw2//pjG94dxEOnn4yxE=
Message-ID: <2cd57c90050817230735895530@mail.gmail.com>
Date: Thu, 18 Aug 2005 14:07:02 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Fri, 7 Jan 2005, Oleg Nesterov wrote:
> >
> > If i understand this patch correctly, then this code
> >
> >       for (;;)
> >               write(pipe_fd, &byte, 1);
> >
> > will block after writing PIPE_BUFFERS == 16 characters, no?
> > And pipe_inode_info will use 64K to hold 16 bytes!
> 
> Yes.
> 
> > Is it ok?
> 
> If you want throughput, don't do single-byte writes. Obviously we _could_
> do coalescing, but there's a reason I'd prefer to avoid it. So I consider
> it a "don't do that then", and I'll wait to see if people do. I can't
> think of anything that cares about performance that does that anyway:
> becuase system calls are reasonably expensive regardless, anybody who
> cares at all about performance will have buffered things up in user space.
> 
> > May be it make sense to add data to the last allocated page
> > until buf->len > PAGE_SIZE ?
> 
> The reason I don't want to coalesce is that I don't ever want to modify a
> page that is on a pipe buffer (well, at least not through the pipe buffer
> - it might get modified some other way). Why? Because the long-term plan
> for pipe-buffers is to allow the data to come from _other_ sources than
> just a user space copy. For example, it might be a page directly from the
> page cache, or a partial page that contains the data part of an skb that
> just came in off the network.
> 
> With this organization, a pipe ends up being able to act as a "conduit"
> for pretty much any data, including some high-bandwidth things like video
> streams, where you really _really_ don't want to copy the data. So the
> next stage is:
> 
>  - allow the buffer size to be set dynamically per-pipe (probably only
>    increased by root, due to obvious issues, although a per-user limit is
>    not out of the question - it's just a "mlock" in kernel buffer space,
>    after all)
>  - add per-"struct pipe_buffer" ops pointer to a structure with
>    operation function pointers: "release()", "wait_for_ready()", "poll()"
>    (and possibly "merge()", if we want to coalesce things, although I
>    really hope we won't need to)
>  - add a "splice(fd, fd)" system call that copies pages (by incrementing
>    their reference count, not by copying the data!) from an input source
>    to the pipe, or from a pipe to an output.
>  - add a "tee(in, out1, out2)" system call that duplicates the pages
>    (again, incrementing their reference count, not copying the data) from
>    one pipe to two other pipes.
> 
> All of the above is basically a few lines of code (the "splice()" thing
> requires some help from drivers/networking/pagecache etc, but it's not
> complex help, and not everybody needs to do it - I'll start off with
> _just_ a generic page cache helper to get the thing rolling, that's easy).
> 
> Now, imagine using the above in a media server, for example. Let's say
> that a year or two has passed, so that the video drivers have been updated
> to be able to do the splice thing, and what can you do? You can:
> 
>  - splice from the (mpeg or whatever - let's just assume that the video
>    input is either digital or does the encoding on its own - like they
>    pretty much all do) video input into a pipe (remember: no copies - the
>    video input will just DMA directly into memory, and splice will just
>    set up the pages in the pipe buffer)
>  - tee that pipe to split it up
>  - splice one end to a file (ie "save the compressed stream to disk")
>  - splice the other end to a real-time video decoder window for your
>    real-time viewing pleasure.
> 
> That's the plan, at least. I think it makes sense, and the thing that
> convinced me about it was (a) how simple all of this seems to be
> implementation-wise (modulo details - but there are no "conceptually
> complex" parts: no horrid asynchronous interfaces, no questions about
> hotw to buffer things, no direct user access to pages that might
> partially contain protected data etc etc) and (b) it's so UNIXy. If
> there's something that says "the UNIX way", it's pipes between entities
> that act on the data.
> 
> For example, let's say that you wanted to serve a file from disk (or any
> other source) with a header to another program (or to a TCP connection, or
> to whatever - it's just a file descriptor). You'd do
> 
>         fd = create_pipe_to_destination();
> 
>         input = open("filename", O_RDONLY);
>         write(fd, "header goes here", length_of_header);
>         for (;;) {
>                 ssize_t err;
>                 err = splice(input, fd,
>                         ~0 /* maxlen */,
>                         0 /* msg flags - think "sendmgsg" */);
>                 if (err > 0)
>                         continue;
>                 if (!err) /* EOF */
>                         break;
>                 .. handle input errors here ..
>         }
> 
> (obviously, if this is a real server, this would likely all be in a
> select/epoll loop, but that just gets too hard to describe consicely, so
> I'm showing the single-threaded simple version).
> 
> Further, this also ends up giving a nice pollable interface to regular
> files too: just splice from the file (at any offset) into a pipe, and poll
> on the result.  The "splice()" will just do the page cache operations and
> start the IO if necessary, the "poll()" will wait for the first page to be
> actually available. All _trivially_ done with the "struct pipe_buffer"
> operations.
> 
> So the above kind of "send a file to another destination" should
> automatically work very naturally in any poll loop: instead of filling a
> writable pipe with a "write()", you just fill it with "splice()" instead
> (and you can read it with a 'read()' or you just splice it to somewhere
> else, or you tee() it to two destinations....).
> 
> I think the media server kind of environment is the one most easily
> explained, where you have potentially tons of data that the server process
> really never actually wants to _see_ - it just wants to push it on to
> another process or connection or save it to a log-file or something. But
> as with regular pipes, it's not a specialized interface: it really is just
> a channel of communication.
> 
> The difference being that a historical UNIX pipe is always a channel
> between two process spaces (ie you can only fill it and empty it into the
> process address space), and the _only_ thing I'm trying to do is to have
> it be able to be a channel between two different file descriptors too. You
> still need the process to "control" the channel, but the data doesn't have
> to touch the address space any more.
> 
> Think of all the servers or other processes that really don't care about
> the data. Think of something as simple as encrypting a file, for example.
> Imagine that you have hardware encryption support that does DMA from the
> source, and writes the results using DMA. I think it's pretty obvious how
> you'd connect this up using pipes and two splices (one for the input, one
> for the output).
> 
> And notice how _flexible_ it is (both the input and the output can be any
> kind of fd you want - the pipes end up doing both the "conversion"  into a
> common format of "list of (possibly partial) pages" and the buffering,
> which is why the different "engines" don't need to care where the data
> comes from, or where it goes. So while you can use it to encrypt a file
> into another file, you could equally easily use it for something like
> 
>         tar cvf - my_source_tree | hw_engine_encrypt | splice_to_network
> 
> and the whole pipeline would not have a _single_ actual data copy: the
> pipes are channels.
> 
> Of course, since it's a pipe, the nice thing is that people don't have to
> use "splice()" to access it - the above pipeline has a perfectly regular
> "tar" process that probably just does regular writes. You can have a
> process that does "splice()" to fill the pipe, and the other end is a
> normal thing that just uses regular "read()" and doesn't even _know_ that
> the pipe is using new-fangled technology to be filled.
> 
> I'm clearly enamoured with this concept. I think it's one of those few
> "RightThing(tm)" that doesn't come along all that often. I don't know of
> anybody else doing this, and I think it's both useful and clever. If you
> now prove me wrong, I'll hate you forever ;)
> 
>                 Linus


Actually this what L4 is different from traditional micro-kernel, IMHO. Is it?

I have a long-term plan to add some messaging subsystem based on this.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
