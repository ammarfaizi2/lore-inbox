Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUBQTq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUBQTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:46:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:10128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266532AbUBQTqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:46:19 -0500
Date: Tue, 17 Feb 2004 11:45:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040217192917.GA24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171134180.2154@home.osdl.org>
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Jamie Lokier wrote:
> 
> Well, the security checks on ".." which worms get past aren't in the
> kernel either.  This time _you_ made the strawman :)

Note that this is something that the kernel _can_ fix easily.

In particular, we already have flags like LOOKUP_FOLLOW and
LOOKUP_DIRECTORY that we use internally in the kernel to specify how to do
certain operations. We export _part_ of that to user space with the
O_DIRECTORY flag that says "allow open of directories".

And yes, we have security-related ones too (LOOKUP_NOALT disables the
alternamte mount-point lookup).

And it would be _trivial_ to add a LOOKUP_NODOTDOT and allow user space to
use it through a O_NODOTDOT thing. But the people who need it really need
to do it and test it, and they need to be committed enough that they say
"yes, we'd use this, even though it's not portable". Because I don't want
to add features to the kernel that people don't use, and a lot of the
users don't want to use Linux-only things..

Same goes for O_NOFOLLOW or O_NOMOUNT, to tell the kernel that it
shouldn't follow symbolic links or cross mount-points - another thing that
some software might want to use in order to check that you can't "escape"  
your subtree.

So these things would be literally trivial to add, and the only issue is 
whether people would really use them.

> What happens is that one program or library checks an incoming path
> for ".." components - that code knows nothing about UTF-8 of course.
> 
> Then it passes the string to another program which assumes the path
> has been subject to appropriate security checks, munges it in UTF-8,
> and eventually does a file operation with it.  The munging generates
> ".." components from non-minimal UTF-8 forms - if it's not obeying the
> Unicode rejection requirement (which wasn't in earlier versions), that is.

But note how my point was that YOU SHOULD NEVER EVER MUNGE A PATHNAME!

It is fundamentally _wrong_ to convert pathnames. You _cannot_ do it 
correctly. 

The rule should be:
 - convert user-input to UTF-8 early (do _nothing_ to it before the 
   conversion). Allow escape sequences here.
 - never ever convert readdir/getcwd/etc system-specified paths AT ALL. 
   They are already in "extended UTF-8" format (where the "extended" part 
   is the 'broken UTF-8' thing. I can be like MS and call my breakage 
   "extended" too ;)
 - always _always_ work on the "extended UTF-8" format, and never EVER 
   convert that to anything else (except when you need to actually print
   it, but then you encode it properly with escape sequences, the way you 
   have to _anyway_).

If you follow the above simple rules, you can't get it wrong. And in those 
rules, ".." is the BYTE SEQUENCE in the "extended UTF-8". Nothing more.

		Linus
