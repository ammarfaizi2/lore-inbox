Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUBRPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUBRPgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:36:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:54675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267538AbUBRPgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:36:13 -0500
Date: Wed, 18 Feb 2004 07:35:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <4032F861.3080304@zytor.com>
Message-ID: <Pine.LNX.4.58.0402180716180.2686@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
 <c0ukd2$3uk$1@terminus.zytor.com> <Pine.LNX.4.58.0402171910550.2686@home.osdl.org>
 <4032DA76.8070505@zytor.com> <Pine.LNX.4.58.0402171927520.2686@home.osdl.org>
 <4032F861.3080304@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, H. Peter Anvin wrote:
> 
> What does "printable" mean in this context?  Typically you have to 
> convert it to UCS-4 first, so you can index into your font tables, then 
> you have to create the right composition, apply the bidirectional text 
> algorithm, and so forth.

Not all characters _have_ font entries. And even when they have font 
entries, they may need escaping for other reasons (ie you may want to 
marshall UTF-8 as plain ASCII just because you want to use a portable 
format for transfer).

Think about the simple (hex) string x0A x00. That's a well-defined UTF-8
string, yet if you want to print it as a filename on the console, you
should obviously print it as "/n" or some similar escaped sequence 
(actually, that's a bad example, since it's a special case, and it would 
probably be better to use the example string x7F x00, which would be shown 
as \u177 or something).

The same is true for a _lot_ of perfectly fine UTF-8 sequences, no?

That implies that you have to use an escaped sequence _anyway_. So as you 
go along, turning the string into something printable, you might as well 
escape the invalid UTF-8 sequences.

In other words: you walk the utf-8 string one character at a time, 
converting it to whatever format (eg UCS-4) you have for font lookup, but 
you also escape characters that you don't have font entries for or that 
aren't in proper UTF-8 format.

When converting to UCS-2, you have to check for the proper format 
_anyway_, so none of this is in any way "extra work". Instead of just 
aborting on an invalid UTF-8 character, you quote it, exactly the same way 
you'd have to quote a _valid_ one that you can't just show as a string.

> Rendering general Unicode text is complex enough that you really want it 
> layered.  What I described what the first step of that -- mostly trying 
> to show that "throwing an error" doesn't necessarily mean "produce no 
> output."  What you shouldn't do, though, is alias it with legitimate input.

Exactly. And since you need an escape sequence anyway, what's the problem?

> > And if you do things right (ie you allow user input in that same escaped 
> > output format), you can allow users to re-create the exact "broken utf-8". 
> > Which is actually important just so that the user can fix it up (ie 
> > imagine the user noticing that the filename is broken, and now needs to do 
> > a "mv broken-name fixed-name" - the user needs some way to re-create the 
> > brokenness).
> 
> Indeed.  The C language has gone with \x77 for bytes and \u7777 or 
> \U77777777 for Unicode characters (4 vs 8 hex digits respectively); I 
> think this is a good UI for shells to follow.  The \x representation 
> then doesn't stand for characters but for bytes.  It may be desirable to 
> disallow encoding of *valid* UTF-8 characters this way, though.

You need to encode even valid UTF-8, since you may not find a font entry 
for the character, or the character just isn't appropriate in that context 
(ie you can't show a newline).

But it makes perfect sense to use a policy of:
 - escape valid UTF-8 characters as '\u7777'
 - escape _invalid_ UTF-8 characters as their hex byte sequence (ie 
   '\xC0\x80\x80', whatever)
 - (and, obviously, escape the valid UTF-8 character '\' as '\\').

Don't you agree? It clearly allows all the cases, and you can re-generate 
the _exact_ original stream of bytes from the above (ie it is nicely 
reversible, which in my opinion is a requirement).

		Linus
