Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTKQKfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 05:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTKQKfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 05:35:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23523 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263453AbTKQKfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 05:35:37 -0500
Date: Mon, 17 Nov 2003 10:35:36 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117103536.GW24159@parcelfarce.linux.theplanet.co.uk>
References: <20031117095528.GV24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311171005160.1384-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311171005160.1384-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 10:08:45AM +0000, Tigran Aivazian wrote:
> On Mon, 17 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > EOF had been reached when read() returns 0.  Until then read() returns
> > an arbitrary amount of bytes between 1 and 'size' argument.  Since you
> > are using read(2) directly, use it correctly...
> 
> I know that for read(2) in general but I thought that the whole point of 
> using "sequential record" files (aka seq_file) is that they guarantee 
> read(2) to return a number of fixed-size records, hence the name 
> "sequential record". Especially since the ->show() function is packing 
> those records into m->buf as "whole" entities, not in "halves" or such.

No.  What you are guaranteed is that continuous reading from the stream
will not give you broken entries.  IOW, if read() gets a part of record,
subsequent reads will get the rest of _that_ _record_.

Note that behaviour you are asking for would break a *lot* of things.
Consider the following code:

	for (left = BUFSIZE; left; left -= n) {
		n = read(fd, buf + BUFSIZE - left, left);
		if (n <= 0)
			break;
	}

IOW, fill the buffer from file, until EOF/error/buffer becoming full.

With your semantics we are fscked - as soon as we have less than one
"record" left in a buffer, we are in a hopeless situation.  read()
can't return an entire record (no place to put it); it can't return
0 (that would be impossible to distinguish from EOF) and there is
no acceptable error value that would indicate such situation.  read(2)
is not getdents(2) - there we *do* have an error value for situation
like that ("buffer too small").

Pretty much anything that does buffered IO (e.g. stdio code) contains
equivalents of the above.

_If_ you want datagrams - implement datagrams and don't expect grep/cat/etc. 
to work on them.
 
> I believe you of course (as you wrote seq_file) but it still seems that as 
> long as the implementation (i.e. my module) is working with whole records 
> it is ok to assume that read() will return them as whole, i.e. not break a 
> record between two calls to read(2). Is this really not true?

It's really not true.

*NOTE*: in your case I would consider putting a cursor into task list
and moving it around on ->start() and ->stop().  That can give you
more or less accurate snapshot with multiple read(2).

However, it's not obvious that the thing is worth the effort (you'd need
to make sure that no other code scanning the list will be disturbed when
it sees your cursor).

What is *not* acceptable (regardless of the implementation, be it done via
seq_file or not): ability to get the entire list of processes in single
read(2).  User-exploitable OOM is not a good thing.  No matter how you
implement read(2), you would have to get sufficient amount of memory locked
in core - you need to hold a spinlock to generate the contents, to start
with, so no "copy to userland in chunks" scheme would work.
