Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUBQNQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUBQNQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:16:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:49284 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265276AbUBQNQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:16:10 -0500
Date: Tue, 17 Feb 2004 13:15:59 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217131559.GA21842@mail.shareable.org>
References: <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <Pine.LNX.4.58.0402161447450.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0402161447450.30742@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So I claim (and yes, people are free to disagree with me) that a
> well-written UTF-8 program won't even have any real extra code to handle
> the "broken UTF-8" code. It's just another set of bytes that needs
> escaping, and they need escaping for _exactly_ the same reason some 
> regular utf-8 characters need escaping: because they can't be printed.

Even XML suffers from these sorts of problems: some Unicode characters
aren't allowed in XML, even as numeric references, so in theory XML
applications have to reject or escape some strings.

> So it's all the same thing - it's just the reasons for "unprintability"  
> that are slightly different.

My difficulty with directories containing non-UTF-8 filenames shows up
with web pages in Perl, and not the printability part.  Please excuse
the Perl-oriented examples; Perl has good support for UTF-8 while also
working with arbitrary byte strings, so it's a fine language to
illustrate current problems.

What do you put in a URL composed from filenames in a directory
listing page?  The obvious thing is to %-escape each byte of the
names, in fact that's what everybody does.

In a language like Perl, where strings are labelled according to their
encoding, that means when you unscape the URL you get a string
labelled as "byte string".  You shouldn't tell Perl it's a "UTF-8
string" because some of them won't be (they are strings from
directories).

That's fine if you don't do anything except use those strings
unchanged, but as soon as you want to do something else like prepend a
character with code >= 256 or apply a regex where the pattern has
Unicode characters, Perl transcodes "byte string" to "UTF-8 string"
assuming it was latin1.  That, of course, mangles the string when it's
come from a source which is "nominally UTF-8 but might not be".

Your recommendation to simply pass around bytes all the time doesn't
work well, because to maintain basic properties of strings such as
length(a) + length(b) = length(a+b), that implies you either (1)
always do indexing, lengths, splitting etc. on strings as bytes not
characters, or (2) every operation that operates on a string must be
able to accept non-UTF-8 bytes and treat them the same way.  (2) is
particularly nasty because then your program's logic can't depend on
the nice properties of UTF-8 strings.

That's why this line of Perl fails:

    for (glob "*") { rename $_, "ņi-".$_ or die "rename: $!\n"; }

(The source file, by the way, is assumed to be UTF-8-encoded text).

Perl reads each file name, and declares it to be of type "byte
string".  Then "ņi-" is prepended, which contains a character code >=
256, so the result must be UTF-8 encoded according to Perl.  The
original file name is transcoded from what was assumed to be
iso-8859-1 to UTF-8, "ņi-" is prepended, and that becomes the target
file name for rename().

This mangles the names; both UTF-8 and non-UTF-8 filenames are mangled
equally badly.

Your suggestion means that Perl should do bytewise concatenation of
the the "ņi-" (in UTF-8) and the filename (no encoding assumed).

It's a good one; it's exactly the right thing to do, and it works.

To do that in Perl, when you take a random byte string (such as from
readdir()) you must tell Perl it's a UTF-8 string, so shouldn't be
transcoded when it's combined with another UTF-8 string.  You can do
it, breaking documented rules of course (which say only do this when
you know it's valid UTF-8), with Encode::_utf8_on().

Guess what?  That actually works.  It does the filename operations
properly given any arbitrary filenames.

But remember I said "every operation that operates on a string must be
able to accept non-UTF-8 bytes and treat them the same way" earlier,
and how this is bad because it's nice to depend on UTF-8 properties?

You've just told Perl to treat an arbitrary byte sequence as UTF-8,
when sometimes it isn't.  Among other things, simple operators like
length() and substr() don't work as expected on those weird strings.

When I say don't work as expected, I mean if you had a file named
"müeller" in latin1, Perl will think it's length() is 2.  If you have
a file named "müller", Perl will not only report a length() of 1,
it'll spew a horrible error message when it calculates it.

These aren't Perl problems.  These are problems that any program will
have if it follows your suggestion of "keep everything in bytes" but
wants to combine filenames with other text or do pattern matching on
filenames.

It's not a problem if you can pass around a flag with each byte
sequence, carefully keeping readdir() results separate from text until
the point where your prepared to have a policy saying what to do with
non-UTF-8 readdir() results.

But it is a problem when you want to stuff readdir() results in a
general purpose "string" which is also used for text.

That's technically the wrong thing to do, in all programs.  In
practice, that's what programs do anyway because it's a lot easier
than having different string types for different data sources.

Most times it works out ok, but for the corners:

> It's just _hard_ to think of all the special cases, and most
> programs have bugs because somebody forgot something.

Exactly.

-- Jamie
