Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbRGZPeP>; Thu, 26 Jul 2001 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbRGZPeG>; Thu, 26 Jul 2001 11:34:06 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:59404 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268026AbRGZPd5>; Thu, 26 Jul 2001 11:33:57 -0400
Message-ID: <3B6039FB.2294D48E@zip.com.au>
Date: Fri, 27 Jul 2001 01:40:43 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: chattr/lsattr +DS? was: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au>, <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <3B602494.784F0315@zip.com.au>,
		<3B602494.784F0315@zip.com.au> <20010726170744.T17244@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Matthias Andree wrote:
> 
> On Fri, 27 Jul 2001, Andrew Morton wrote:
> 
> > > Would you deem it
> > > possible to get such an option done before ext3fs 1.0.0?
> >
> > We'd prefer not - we're trying to stabilise things quite
> > sternly at present. However that doesn't prevent work
> > on 1.1.0 :)
> >
> > Seems like a worthwhile thing to do - I'll cut a branch
> > and do this.  It'll take a couple of weeks - as usual, most
> > of the work is in development and use of test tools...
> > But I can't predict at this time when we'll merge it into
> > the mainline fs.
> 
> So the summary of all this is, as I understand it: for ext3fs 1.0, treat
> it with chattr +S and the like as if it was ext2fs, it may or may not be
> faster with "mount -o data=journalled" and is well worthwhile for an MTA
> to try, a weaker sync option may be introduced after ext3fs 1.0.
> 
> Sounds good.
> 
> I'm dropping the ext3-users mailing list for now since this is getting
> more general.
> 
> However, since the ReiserFS team also showed interest in a similar
> functionality, and they don't yet support chattr, would it be useful to
> specify a "D" option for chattr already?

chattr is an ext[23]-specific thing.  reiserfs could certainly
support a similar thing if they have a few bits spare in the
inode.

> I have a suggestion: if D is set, but S isn't, no effect. If S is set,
> but D is unset, treat S as in the past. If S is set, and D is set,
> directory updates are synchronous like with S, but data updates are
> asynchronous in spite of S.

I don't think this would be needed until really proven necessary - for
data, fsync() should work for all filesystems.

There would be one benefit in splitting sync from datasync,
and that is for applications which do not write() their
data in large enough chunks.

When I fix the get_block thing, O_SYNC, `chattr +S' and `mount
-o sync' will provide good, fast synchronous write()s - the
fs will run a commit at the end of the write().  That's just fine as long
as the app is writing its data in goodly chunks.  If it is is using 4k
or 8k chunks (eg: default stdio) then throughput will suffer.  That
would be rather silly of it though.

-
