Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRDYWZV>; Wed, 25 Apr 2001 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRDYWZL>; Wed, 25 Apr 2001 18:25:11 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:26996 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132886AbRDYWZC>; Wed, 25 Apr 2001 18:25:02 -0400
Date: Wed, 25 Apr 2001 18:24:50 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Doug McNaught <doug@wireboard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <m34rvcy73o.fsf@belphigor.mcnaught.org>
Message-ID: <Pine.LNX.4.10.10104251804180.3127-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Question: it is possible to redirect the same fs call (say read) to different
> > implementations, based on the open mode of the file descriptor ? So, if
> > you open the entry in binary, you just get the number chunk, if you open
> > it in ascii you get a pretty printed version, or a format description like
> 
> There is no distinction between "text" and "binary" modes on a file
> descriptor.  The distinction exists in the C stdio layer, but is a
> no-op on Unix systems.

of course.  but we could trivially define O_PROC_BINARY,
or an ioctl/fcntl, or even do something fancy like use lseek().

pardon my stream of consciousness here, but:

I think it's well-established that proc exists for humans,
and that there's no real sympathy for the eternal whines of 
how terribly hard it is to parse.  it's NOT hard to parse,
but would be more trivial if it were more consistent.

the main goal at this point is to make kernel proc-related 
code more efficient, easy-to-use, etc.  a purely secondary goal
is to make user-space tools more robust, efficient, and simpler.

there are three things that need to be communicated through the proc
interface, for each chunk of data: its type, it's name and its value.
it's critical that data be tagged in some way, since that's the only
way to permit back-compatibility.  that is, a tool looking for a particular
tag will naturally ignore new data with other tags.

/proc/sys is an attempt to provide tagged data; it works well, is 
easy to comprehend, but requires an open for each datum, and provides
no hints about type.

/proc/cpuinfo is another attempt: "tag : data", with no attempt to
provide types.  the tags have also mutated somewhat over time.

/proc/partitions is an example of a record-oriented file:
one line per record, and tags for the record members at the top.
still no typing information.

I have a sense that all of these could be collapsed into a single
api where kernel systems would register hierarchies of tuples of
<type,tag,callback>, where callback would be passed the tag,
and proc code would take care of "rendering" the data into 
human readable text (default), binary, or even xml.  the latter
would require some signalling mechanism like O_PROC_XML or the like.
further, programs could perform a meta-query, where they ask for
the types and tags of a datum (or hierarchy), so that on subsequent
queries, they'd now how to handle binary data.

if only one piece of code handled the rendering of /proc stuff,
it could do more, without burdoning all the disparate /proc producers.

regards, mark hahn.


