Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUBPQdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBPQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:33:39 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:36736 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265636AbUBPQdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:33:36 -0500
Date: Mon, 16 Feb 2004 16:43:34 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402161643.i1GGhYLe000948@81-2-122-30.bradfords.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Valdis.Kletnieks@vt.edu, Eduard Bloch <edi@gmx.de>,
       Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, john@grabjohn.com
In-Reply-To: <20040216154851.GM8858@parcelfarce.linux.theplanet.co.uk>
References: <200402121655.39709.robin.rosenberg.lists@dewire.com>
 <20040213003839.GB24981@mail.shareable.org>
 <200402130216.53434.robin.rosenberg.lists@dewire.com>
 <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
 <20040213032305.GH25499@mail.shareable.org>
 <20040214150934.GA5023@zombie.inka.de>
 <20040215010150.GA3611@mail.shareable.org>
 <20040216140338.GA2927@zombie.inka.de>
 <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
 <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
 <20040216154851.GM8858@parcelfarce.linux.theplanet.co.uk>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from viro@parcelfarce.linux.theplanet.co.uk:
> On Mon, Feb 16, 2004 at 03:46:21PM +0000, John Bradford wrote:
> > The current situation is that so many applications simply treat
> > filenames as arbitrary sequences of bytes.  With many encodings, this
> > simply happens to work, and an encoding mis-match will result in some
> > incorrect characters being displayed for byte values > 127.  However,
> > some encodings, such as UTF-8, are simply _not_ compatible with the
> > 'you can also treat it like an arbitrary byte string model', and there
> 
> Excuse me?  Would you fscking mind explaining what, in your opinion,
> UTF-8 is

Read the UTF-8 manual page.

> and what makes "simply _not_ compatible" with aforementioned
> model?

Byte values > 127 in UTF-8 don't map to single characters, but instead
many of them form part of an escape to a larger set of values.

The net effect is that if you have filenames in an existing 8-bit
encoding, such as any of the ISO-8859- encodings, and treat them as
being in another, similar encoding, you may get some incorrect
characters.  This is not ideal, of course, but it is not very
confusing for end users.  You can more or less store arbitrary bytes
in the filename, and usually at least get a displayable, re-typeable,
somewhat usable result out.

Note that _many_ current applications expect to be able to do just
that.

However, with UTF-8, random bytes > 127 may not map to any valid
character sequence at all, or may map to a sequence that is not
permitted by the spec, but which is, for example, a 31-bit
representation of a value < 128.  These are a potential source of
security vulnerabilities for badly written decoders.

Now, this problem is not limited to UTF-8 - many 16 bit encodings may
have similar issues with 'random' byte streams.

However, with my proposed solution, Unicode-aware applications can be
adapted to write their filenames as UCS-4, and existing applications
which continue to see 8-bit byte streams which they can interpret as
they like, will see 7-bit ascii for characters which can be
represented in it, and a random character for those which can't.
Assuming that those applications treat the byte sequence as an
ISO-8859- type character set, (not UTF-8, or a 16-bit character set),
this shouldn't be too much of a problem, except where the low byte of
the UCS-4 character is \0 or /.  We can work around this by replacing
such bytes with another character in the 8-bit read routine, (which
isn't expected to deal with anything other than 7-bit ASCII 100%
correctly, (which is no worse than what we have at the moment, as far
as I can see)).

Applications which do treat the 8-bit byte stream as UTF-8 or an
existing 16-bit encoding should have only one additional thing to deal
with over what they have to deal with today, and that is the potential
for a filename created from truncated 32-bit UCS-4 values to contain
\0 or /.  I suggested above that the kernel could deal with that by
substituting another value, but obviously UTF-8 and 16-bit encodings
are more sensitive to what that substitute value is, than ISO-8859-
type encodings are.

John.
