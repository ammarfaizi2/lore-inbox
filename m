Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbRGZMaR>; Thu, 26 Jul 2001 08:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbRGZMaI>; Thu, 26 Jul 2001 08:30:08 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:35457 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267859AbRGZM34>; Thu, 26 Jul 2001 08:29:56 -0400
Date: Thu, 26 Jul 2001 14:30:02 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726143002.E17244@emma1.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>, <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B60022D.C397D80E@zip.com.au>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Andrew Morton wrote:

> > In ordered and journal mode, are meta data operations, namely creating a
> > file, rename(), link(), unlink() "synchronous" in the sense that after
> > the call has returned, the effect of this call is never lost, i. e., if
> > link(2) has returned and the machine crashes immediately, will the next
> > recovery ALWAYS recover the link?
> 
> No, they're not synchronous by default.  After recovery they
> will either be wholly intact, or wholly absent.
> 
> > Or will ext3 still need chattr +S?
> 
> Yes, if the app doesn't support O_SYNC or fsync().  I believe
> that MTA's *do* support those things.
>  
> > Does it still support chattr +S at all?
> 
> Yes.
> 
> > Synchronous meta data operations are crucial for mail transfer agents
> > such as Postfix or qmail. Postfix has up until now been setting
...
> A middle-ground solution may be to add an fs-private `osync' mount
> option, so all files are treated similarly to O_SYNC, which would
> work well.

You seem to be missing the point, because I wasn't verbose enough, so I
will try to rephrase this and explain. This may turn out to be a feature
request. :-}

Before going into detail, MTAs do know about fsync(). ext3 synching
relevant directory parts as part of fsync() is a great achievement.
Finally, more than five years after initial complaints, Linux is SLOWLY
getting somewhere for speeding up reliable MTA operation.

But that's the smaller piece. Common MTAs such as Postfix or qmail
rename or link files into place (their queues, the mail spool). With the
advent of journalling came the atomicity of rename operations. That's
also a great achievement.

However, the remaining problem is being synchronous with respect to open
(fixed for ext3 with your fsync() as I understand it), rename, link and
unlink. With ext2, and as you write it, with ext3 as well, there is
currently no way to tell when the link/rename has been committed to
disk, unless you set mount -o sync or chattr +S or call sync() (the
former is not an option because it's far too expensive).


The official statement by Dr. Wietse Venema (who wrote Postfix) is,
Postfix REQUIRES synchronous directory updates (open, rename, link,
unlink, in order of decreasing importance). Wietse refuses to wrap all
these calls for Linux.

Similar assumptions hold for qmail.


So, what would help the common MTA? osync wouldn't, MTAs know how to use
fsync().  dirsync or bsdstyle or however it's called, as chattr and
mount options, would help. This option should make all directory
operations (open/creat/fsync, rename, link, unlink, symlink, possibly
close) synchronous in respect to affected directory and meta data while
leaving application data (payload) operations asynchronous (applications
can then choose when to call fsync() to flush the data to disk).

A much better file system for an MTA might be ext3fs with
data=journalled and dirsync mount/chattr option. Would you deem it
possible to get such an option done before ext3fs 1.0.0?

I hope this makes the requirements of this particular group of
applications clear.

Thanks again to everyone involved with the ext3fs development.

-- 
Matthias Andree
