Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUBQRwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUBQRwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:52:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266374AbUBQRwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:52:13 -0500
Date: Tue, 17 Feb 2004 17:52:09 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217163613.GA23499@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:36:13PM +0000, Jamie Lokier wrote:
> But the reason they cite is security: when applications allow
> malformed UTF-8 through, there's plenty of scope for security holes
> due to multiple encodings of "/" and "." and "\0".
> 
> This is a real problem: plenty of those Windows worms that attack web
> servers get in by using multiple-escaped funny characters and
> malformed UTF-8 to get past security checks for ".." and such.

Pardon?  For that kernel would have to <drumrolls> interpret the bytestream
as UTF-8.  We do not.  So your malformed UTF-8 for .. won't be treated as
.. by the kernel.

BTW, speaking of Plan 9, they do *NOT* reject malformed UTF-8 in pathnames.
Filtering they do is against ASCII controls - i.e. \1--\37 and \177.

All differences between our generic checks and Plan 9 generic checks (aside
of whatever checks particular fs might do) is:
	1) they allow longer pathnames (64K vs our 4K, from my reading of
9/port/chan.c)
	2) they do not allow pathnames containing any octet in range 1--31
	3) they do not allow pathnames containing DEL (octet 127)

The rest is identical:

	* Pathname is split into components by instances of octet 47 (/).
	* Component is special if it's {octet 46} or {octet 46, octet 46}
(. and .. resp.).
	* Name is terminated by octet 0 (NUL).
	* Name components are fed to filesystem drivers without any conversions
- they go as arrays of char, with no concern for encoding.

So could we please put that strawman to rest?
