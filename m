Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUBQTaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUBQTaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:30:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:62852 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266540AbUBQTaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:30:08 -0500
Date: Tue, 17 Feb 2004 19:29:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217192917.GA24311@mail.shareable.org>
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Feb 17, 2004 at 04:36:13PM +0000, Jamie Lokier wrote:
> > But the reason they cite is security: when applications allow
> > malformed UTF-8 through, there's plenty of scope for security holes
> > due to multiple encodings of "/" and "." and "\0".
> > 
> > This is a real problem: plenty of those Windows worms that attack web
> > servers get in by using multiple-escaped funny characters and
> > malformed UTF-8 to get past security checks for ".." and such.
> 
> Pardon?  For that kernel would have to <drumrolls> interpret the bytestream
> as UTF-8.  We do not.  So your malformed UTF-8 for .. won't be treated as
> .. by the kernel.

Well, the security checks on ".." which worms get past aren't in the
kernel either.  This time _you_ made the strawman :)

What happens is that one program or library checks an incoming path
for ".." components - that code knows nothing about UTF-8 of course.

Then it passes the string to another program which assumes the path
has been subject to appropriate security checks, munges it in UTF-8,
and eventually does a file operation with it.  The munging generates
".." components from non-minimal UTF-8 forms - if it's not obeying the
Unicode rejection requirement (which wasn't in earlier versions), that is.

A realistic example is where the second program reads files whose
paths are mentioned in a text file which is parsed as UTF-8, after the
first program has done a security check by grepping for ".."
components.

Unicode says the second program shouldn't accept malformed UTF-8,
precisely because in real scenarios (like this one) there's a mix of
programs and libraries, some aware of UTF-8, some not, and the latter
are involved in security decisions.

Here on linux-kernel we're saying that if the second program accepts
any old byte sequence in a filename, it should preserve the byte
sequence exactly.  But any program whose parser-tokeniser is scanning
UTF-8 is very unlikely to do that - it's just too complicated to say
some bits of a text stream must be remembered as literal bytes, and
others must be scanned as multibyte characters.

We can't blame the second program for allowing those dodgy paths,
because it's the _first_ program which is setting policy.  We can't
blame the first program, because it doesn't care about UTF-8.  The
second program is just obeying orders, and the first program is just
applying POSIX rules.

These type of security holes are quite real, among software which
handles UTF-8 and also deals with paths.  At the current time, that
especially means XML, HTML, URIs, web servers and things behind them.

The holes only arise because software which is interpreting UTF-8 is
mixed with software which isn't.  That's one of the most useful
features of UTF-8, after all - that's why we use it for filenames.

Understand, this isn't a kernel problems; it is simply a good reason
to reject malformed UTF-8 by programs which parse UTF-8.

-- Jamie
