Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUBQUgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUBQUgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:36:09 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4224 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266535AbUBQUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:35:58 -0500
Date: Tue, 17 Feb 2004 20:35:22 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk, Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>, john@grabjohn.com
In-Reply-To: <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de>
 <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org>
 <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org>
 <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here on linux-kernel we're saying that if the second program accepts
> > any old byte sequence in a filename, it should preserve the byte
> > sequence exactly.  But any program whose parser-tokeniser is scanning
> > UTF-8 is very unlikely to do that - it's just too complicated to say
> > some bits of a text stream must be remembered as literal bytes, and
> > others must be scanned as multibyte characters.
> 
> So what you are saying is that conversion of invalid multibyte sequences
> into non-error wide chars followed by conversion back into UTF-8 can
> lead to trouble?  *DUH*
> 
> > The holes only arise because software which is interpreting UTF-8 is
> > mixed with software which isn't.  That's one of the most useful
> > features of UTF-8, after all - that's why we use it for filenames.
> 
> The holes only arise because software which is interpreting UTF-8 doesn't
> care to do it properly.  Software that doesn't interpret it (including the
> kernel) doesn't enter the picture at all.

So is your approach to this problem that because the security issue
isn't specifically in the kernel, we shouldn't discuss it here?
Dispite the fact that there are perfectly good ways of not only
working around the issue, but preventing it from even exising, that
could be implemented in the kernel?

Filenames _are_ arbitrary strings of bytes, I.E. binary data, and that
is how they should be.  I totally agree with that, (except that
obviously \0 and / have to be treated specially).

However, I don't see why it is any more logical to make the suggestion
that filenames generally be treated as UTF-8, IFF they are text at
all, than it is to suggest that filename should be arbitrary strings
of 32-bit words.

Why not:

* State that filenames are strings of 32-bit words.  UCS-4 should be
  the prefered format for storing text in them, but storing legacy
  encodings in the low 8 bits is acceptable, (but a Bad Thing for new
  installations).

* Let legacy applications store 8-bit values in those 32-bit words if
  they want to, but strongly recommend only 7-bit ASCII values are
  stored, not values 128-255.

* Create a divide - filesystems that support strings of 32-bit words
  in their on-disk format, and those that don't.  Those that don't can
  simulate 32-bit words for the new functions that require them, by
  padding with \0 high bytes.

* Hide all filenames with any values > 255 in them from legacy
  applications, by not returning data about them in existing legacy
  kernel functions.

* Introduce new routines to deal with 32-bit filenames, which Unicode
  applications can use when they need to store non-ASCII, (I.E. non
  7-bit).

* Note that UTF-8 stored in the low bytes is still acceptable, (but
  depreciated in favour of UCS-4).

* Note that this preserves the philosophies of:
  * No policy in the kernel
  * Filenames are arbitrary bytestreams, (but now optionally 32-bit
    ones, not just 8-bit ones!)

* Note that this is very different to my last suggestion, which was
  fundamentally broken in many ways.

John.
