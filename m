Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSBJFaQ>; Sun, 10 Feb 2002 00:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289291AbSBJFaG>; Sun, 10 Feb 2002 00:30:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26628 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288677AbSBJF3x>;
	Sun, 10 Feb 2002 00:29:53 -0500
Message-ID: <3C660517.AAA7FA8@zip.com.au>
Date: Sat, 09 Feb 2002 21:28:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C65F523.FDDB7FA@zip.com.au> <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 9 Feb 2002, Andrew Morton wrote:
> >
> > This is due to BUG() calls in inline functions in headers.  The biggest
> > culprit is dget(), in dcache.h.  This causes the full path of the header file
> > to be expanded into each and every compilation unit which includes
> > dcache.h.
> 
> Hmm. Which brings up another issue: can somebody come up with an idea of
> how to make the thing not use the whole pathname, but only the basename
> relative to the top-of-tree?

This is the cue for Keith to pop up and say "fixed in kbuild 2.5".

The preprocessor is simply pasting together its -I argument and the
string from the #include statement.  There doesn't seem to be a way
of getting it to just emit "include/linux/dcache.h" or "drivers/char/serial.c".

__BASE_FILE__ seems to have been supported for a sufficiently long time.  It
will just give us "dcache.h".  I think that's OK.  We don't get full path
info for the .c files either, and I'm not aware of that causing problems - if
there's a BUG() at inode.c:1234 we seem to be able to work out which inode.c
to look at.

__BASE_FILE__ is already used a bit in spinlock.h, so I think I'll
go with that.  But I'll also take a look at all the inlined BUGs.


> 
> Note that the correct thing to do may be to un-inline a lot of things.
> We've done that before, simply because it often improves performance.
> 
> What ends up happening is that some function starts out really small, and
> then later on people add logic and debug code to it, and suddenly it's not
> really appropriate to inline any more.

I noticed :)


-
