Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTLDAIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLDAIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:08:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:63129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263024AbTLDAIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:08:40 -0500
Date: Wed, 3 Dec 2003 16:08:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <20031203214443.GA23693@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Jörn Engel wrote:
>
> Haven't heard about anything working yet, but it shouldn't be too hard
> to change something existing.  For jffs2, I would guesstimate one or
> two month to add the necessary bits, but jffs2 is not first choice as
> a hard drive filesystem.  Not sure about other filesystems.

Encryption is not that easy to just tack on to most existing filesystems
for one simple reason: for performance (and memory footprint) reasons,
most of the filesystems out there are doing "IO in place". In other words,
they do IO directly into and directly from the page cache.

With an encrypted filesystem, you can't do that. Or rather: you can do it
if the filesystem is read-only, but you definitely CANNOT do it on
writing. For writing you have to marshall the output buffer somewhere
else (and quite frankly, it tends to become a lot easier if you can do
that for reading too).

And that in turn causes problems. You get all kinds of interesting
deadlock schenarios when write-out requires more memory in order to
succeed. So you need to get careful. Reading ends up being the much easier
case (doesn't have the same deadlock issues _and_ you could do it in-place
anyway).

So encryption per se isn't hard. But adding the extra indirect buffer
layer _can_ be pretty nasty, and makes it nontrivial to retrofit later.

** NOTE NOTE NOTE **

If you don't need to mmap() the files, writing becomes much easier.
Because then you can make rules like "the page cache accesses always
happen with the page locked", and then the encryption layer can do the
encryption in-place.

So it is potentially much easier to make encrypted files a special case,
and disallow mmap on them, and also disallow concurrent read/write on
encrypted files. This may be acceptable for a lot of uses (most programs
still work without mmap - but you won't be able to encrypt demand-loaded
binaries, for example).

		Linus
