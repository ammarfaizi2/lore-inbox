Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267987AbRGZOCx>; Thu, 26 Jul 2001 10:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRGZOCn>; Thu, 26 Jul 2001 10:02:43 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:15379 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267971AbRGZOCh>; Thu, 26 Jul 2001 10:02:37 -0400
Message-ID: <3B602494.784F0315@zip.com.au>
Date: Fri, 27 Jul 2001 00:09:24 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au>,
		<3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Matthias Andree wrote:
>  
> A much better file system for an MTA might be ext3fs with
> data=journalled and dirsync mount/chattr option.

OK, I've taken a closer look at this.  ext3 has picked up some
cruft from ext2's sync handling which it does not need in the
least.

It will be fairly straightforward and a useful cleanup to
provide the following semantics for either synchronous
mounts or `chattr +S' directories:

* All metadata operations (rename, unlink, link, symlink, etc)
  will be synchronous.  So when the system call returns, the data
  is crash-proofed.

* All write()s will be synchronous.  So when the write() system
  call returns, the data written and all associated metadata
  will be crash-proofed.

  O_SYNC and fsync() will not be necessary - in fact they'll
  slow things down slightly by forcing an unnecessary and
  probably empty commit.

If you crash in the middle of a write, you may end up with a truncated
file on recovery.

This is in fact the behaviour right now, but the performance is
not good.

The performance problem at present is that large write()s have unnecessary
commits in the middle of them.  This is due to the abovementioned
cruft in ext3_get_block() and the things it calls.

> Would you deem it
> possible to get such an option done before ext3fs 1.0.0?

We'd prefer not - we're trying to stabilise things quite
sternly at present. However that doesn't prevent work
on 1.1.0 :)

Seems like a worthwhile thing to do - I'll cut a branch
and do this.  It'll take a couple of weeks - as usual, most
of the work is in development and use of test tools...
But I can't predict at this time when we'll merge it into
the mainline fs.

> I hope this makes the requirements of this particular group of
> applications clear.

Yes, it was useful - thanks.

-
