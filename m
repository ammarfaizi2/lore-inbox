Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266694AbUBMDPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUBMDPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:15:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:25474 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266694AbUBMDPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:15:07 -0500
Date: Fri, 13 Feb 2004 03:15:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213031502.GG25499@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121906.54699.robin.rosenberg.lists@dewire.com> <200402121908.i1CJ86NC000167@81-2-122-30.bradfords.org.uk> <200402122039.19143.robin.rosenberg.lists@dewire.com> <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402122113.i1CLDqoB000179@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> in the real world don't you think that there will be a lot of
> decoders which decode the multi-byte sequence back, rather than
> report an error?

There will be decoders which convert ASCII "a" to "A" too.  We can't
fix broken code; at least we can make it clear to anyone writing a
decoder what is acceptable, and that being "liberal" in what's decoded
is not acceptable and considered a security flaw.

An app author only writes the UTF-8 decoder once; it isn't at all hard
to convert non-minimal forms to the replacement char U+FFFD.
(Although that could be a security hole in some cases, it's much
better than allowing non-zero characters to decoder to NUL or "/" or
".").  Rejecting a non-minimal form is often hard, because the UTF-8
decoder is often used in a place which cannot flag errors.

> Imagine you have two files, with the following filename bytes:
> 
> 11000001 10000001 00000000
> 01000001 00000000
> 
> ..and a _real world_ application, which is not necessarily completely
> UTF-8 conformant, tries to open the file with filename 'A'.  Which one
> is it going to open?

The one which "ls" and other programs show as "A".
The other one will typically show as "?" or a diamond or something.

> I don't think that the issue with combining characters is likely to be
> an issue, I only mentioned it as an example.  As you pointed out a
> single accented character, and a two character combination are
> distinct, and converting the combination to the corresponding single
> character in a filename would definitely be wrong, in my opinion.
> However, that doesn't mean that software won't do it.

Indeed some software will do it, and worse than that: they may look
the same in an editor or file selector.  (See recent problems with
misleading URLs for why that sort of thing can be a security hole).

The combining char problem is similar to case folding: some
filesystems and programs treat "a" and "A" as equivalent too.  If the
kernel had an encoding converter, and the filesystem stored iso-8859-1
while userspace was presented with utf-8, it is likely that several
Unicode characters would be mapped to "a", causing similar problems to
automatic case folding in filesystems.

In other words, there is no clear solution to this problem.

-- Jamie
