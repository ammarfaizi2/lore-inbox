Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRGZLgN>; Thu, 26 Jul 2001 07:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbRGZLgE>; Thu, 26 Jul 2001 07:36:04 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49413 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267184AbRGZLfw>; Thu, 26 Jul 2001 07:35:52 -0400
Message-ID: <3B60022D.C397D80E@zip.com.au>
Date: Thu, 26 Jul 2001 21:42:37 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>,
		<3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Matthias Andree wrote:
> 
> On Thu, 26 Jul 2001, Andrew Morton wrote:
> 
> > data=journal
> >
> >   All data (as well as to metadata) is written to the journal
> >   before it is released to the main fs for writeback.
> >
> >   This is a specialised mode - for normal fs usage you're better
> >   off using ordered data, which has the same benefits of not corrupting
> >   data after crash+recovery.  However for applications which require
> >   synchronous operation such as mail spools and synchronously exported
> >   NFS servers, this can be a performance win.  I have seen dbench
> 
> In ordered and journal mode, are meta data operations, namely creating a
> file, rename(), link(), unlink() "synchronous" in the sense that after
> the call has returned, the effect of this call is never lost, i. e., if
> link(2) has returned and the machine crashes immediately, will the next
> recovery ALWAYS recover the link?

No, they're not synchronous by default.  After recovery they
will either be wholly intact, or wholly absent.

> Or will ext3 still need chattr +S?

Yes, if the app doesn't support O_SYNC or fsync().  I believe
that MTA's *do* support those things.
 
> Does it still support chattr +S at all?

Yes.

> Synchronous meta data operations are crucial for mail transfer agents
> such as Postfix or qmail. Postfix has up until now been setting
> chattr +S /var/spool/postfix, making original (esp. soft-updating) BSD
> file systems significantly faster for data (payload) writes in this
> directory than ext2.

If postfix is capable of opening the files O_SYNC or of doing
fsync() on them then the `chattr +s' is no longer necessary - unlike
ext2, when the O_SYNC write() or the fsync() return, the directory
contents (as well as the inode, bitmaps, data, etc) will all be tight on
disk and will be restored after a crash.

This should speed things up considerably, especially with journalled-data
mode.  I need to test and characterise this some more to come up with some
quantitative results and configuration recommendations.


BTW, if you have more-than-modest throughput requirements, don't
even *think* of mounting the fs with `mount -o sync'. Our performance
in this mode is terrible :(

I have a hack somewhere which fixes this as much as it can be fixed, but
I didn't even bother committing it.  It's feasible, but tiresome.

A better solution is to fix some lock inversion problems in the core
kernel which prevent optimal implementation of data-journalling
filesystems.  I don't really expect this to occur medium-term or ever.

A middle-ground solution may be to add an fs-private `osync' mount
option, so all files are treated similarly to O_SYNC, which would
work well.

-
