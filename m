Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266503AbUBQUbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBQUbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:31:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:2181 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266503AbUBQUbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:31:08 -0500
Date: Tue, 17 Feb 2004 20:30:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217203056.GC24311@mail.shareable.org>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <Pine.LNX.4.58.0402171134180.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171134180.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And it would be _trivial_ to add a LOOKUP_NODOTDOT and allow user space to
> use it through a O_NODOTDOT thing.

Nope.  That wouldn't help for a bundle of libraries that goes:

    1. Eliminate "." and ".." components, leaving only leading ".."s.
    2. Reject path if it has a leading "..".
    3. Shove it in a string with some other text and pass to other library.

Next program does:

    4. Extract path from string.
    5. open ("/var/public/files/$PATH", ...)

O_NODOTDOT won't protect against that.

> Same goes for O_NOFOLLOW or O_NOMOUNT, to tell the kernel that it
> shouldn't follow symbolic links or cross mount-points - another thing that
> some software might want to use in order to check that you can't "escape"  
> your subtree.

( O_NOMOUNT is a good idea.  I like O_NOFOLLOW - already use it to
avoid lstat() calls. )

> But note how my point was that YOU SHOULD NEVER EVER MUNGE A PATHNAME!
> 
> It is fundamentally _wrong_ to convert pathnames. You _cannot_ do it 
> correctly. 

I know.  You know.  I think everyone else got it the first time too ;)

Have you ever written a script which takes a pathname and puts it in a
text file, and passes to another to operate on, and just skipped over
the details of what a poorly placed control character would do?

Real applications do exactly that sort of thing.  Mostly it works,
occasionally security holes are found.  Welcome to the land of dodgy
CGI scripts and program generated Makefiles.

This is the same.

>  - always _always_ work on the "extended UTF-8" format, and never EVER 
>    convert that to anything else (except when you need to actually print
>    it, but then you encode it properly with escape sequences, the way you 
>    have to _anyway_).
> 
> If you follow the above simple rules, you can't get it wrong. And in those 
> rules, ".." is the BYTE SEQUENCE in the "extended UTF-8". Nothing more.

Yup.  It works right up until you pass your string to a library which
doesn't follow that rule, and which munges malformed UTF-8 because
it's _expecting_ well formed UTF-8.  E.g. you pass a path in an XML
document; the XML parser at the other end will either munge your path
(causing a security hole), or reject it (which is good).

The right thing to do on these occasions is check and/or escape
"extended UTF-8" prior to putting it into a text context.

Practically, that means a UTF-8 aware program has to keep track of
which text is "extended UTF-8" (i.e. bytes), and which text is real UTF-8.

Practically, it means every interface where a path may be passed in a
UTF-8 string has to define whether that's an escaped path, which will
be unescaped before being used for a system call, or an unescaped path.
Then you get into what kind of escaping.

In theory all those checks and escapings will be in the right places.
In theory C programs don't have buffer overflows either.

It is exasperated because UTF-8 is often passed through middle-layer
programs and libraries that don't know anything about it, so when
assembling a whole system it's all too easy to lose track of where to
put the checks and escapings - and where not to.

Yes there _is_ a perfectly fine solution: the one you gave.

In practice it is difficult to ensure a whole system where paths are
mixed with text is consistent about that.  And that's where we get a
good selection of our Windows worms from.

-- Jamie
