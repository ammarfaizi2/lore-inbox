Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268618AbRG3OjF>; Mon, 30 Jul 2001 10:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268800AbRG3Oiz>; Mon, 30 Jul 2001 10:38:55 -0400
Received: from egghead.curl.com ([216.230.83.4]:7429 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S268618AbRG3Oio>;
	Mon, 30 Jul 2001 10:38:44 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mason@suse.com (Chris Mason), cw@f00f.org (Chris Wedgwood),
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <E15RDVj-0003oi-00@the-village.bc.nu>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 30 Jul 2001 10:38:52 -0400
In-Reply-To: <E15RDVj-0003oi-00@the-village.bc.nu>
Message-ID: <s5g8zh6pjlv.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Chris Mason <mason@suse.com> writes:
> > 
> > > Correct, in the current 2.4.x code, its a quirk.  fsync(any object) ==
> > > fsync(all pending metadata, including renames).
> > 
> > This does not help.  The MTAs are doing fsync() on the temporary file
> > and then using the *subsequent* rename() as the committing operation.
> 
> Which is quaint, because as we've pointed out repeatedly to you rename
> is not an atomic operation. Even on a simple BSD or ext2 style fs it can
> be two directory block writes,  metadata block writes, a bitmap write
> and a cylinder group write.

But not on a journalling filesystem.  I assume that a journal "commit"
is atomic.  If it is not, then fsync() on the directory does not solve
the problem either.

Put another way, I am suggesting a mount-time or directory option to
effectively cause rename() and link() to automatically be followed by
an fsync() of the containing directory.  (Actually, from this
perspective, maybe you could fix the MTA in user space with LD_PRELOAD
hackery or somesuch.  Hm...)

> > It would be nice to have an option (on either the directory or the
> > mountpoint) to cause all metadata updates to commit to the journal
> > without causing all operations to be fully synchronous.  This would
> 
> You mean fsync() on the directory. 

In other words, "Get the MTA authors to change their code."  That is a
nice little war, but it is fought at the expense of users who just
want to use the code provided by their vendor and have it work.

The situation is this:

  The relevant standards (POSIX, SuS, etc.) provide no way to perform
  reliable transactions on a file system.

  BSD provides one solution, which is synchronous metatdata.  (I am
  assuming modern BSDs already deal with the multiple-disk-block
  problem to make these transactions properly atomic.  Is this
  assumption false?)

  Linux provides a different solution, which is fsync() on the
  directory.

  All MTAs, and other apps besides, currently use the BSD solution for
  reliable transactions.

Is it really so absurd to ask Linux to provide efficient support of
the BSD semantics as an option?

 - Pat
