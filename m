Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBRD1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 22:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUBRD1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 22:27:12 -0500
Received: from dp.samba.org ([66.70.73.150]:51617 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261731AbUBRD1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 22:27:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.56190.639555.554525@samba.org>
Date: Wed, 18 Feb 2004 14:26:54 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402171531570.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
	<Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
	<16433.47753.192288.493315@samba.org>
	<Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
	<16434.41376.453823.260362@samba.org>
	<Pine.LNX.4.58.0402171531570.2154@home.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > For example, if you only want to be compatible with Windows, you don't 
 > have to worry about UCS-4, you only have the UCS-2 part, which means that 
 > you can do a silly array-lookup based thing or something.

Even within UCS-2 land the case-mapping table is sparse as only some
characters have a upper/lower mapping. In fact, there are just 636
characters out of 64k that have an upper/lower case mapping that isn't
the identity. That is across *all* languages that windows uses for
UCS-2.

In Samba that's not sparse enough that its worth saving the single
mmap of 128k to encode it sparsely in memory, but in UCS-4 land you
would obviously use a sparse mapping, and that mapping table would
probably be just a few k in size. If you allow for extents then I
expect you could encode it in a couple of hundred bytes.

(I experimented with using a sparse mapping in Samba, and it was a
slight loss on the machine I was testing on compared to just doing the
mmap, so I went with the mmap. Maybe someone else can do a better
sparse encoding than I did and actually get a win due to better cache
behaviour.)

 > Ugh. What a horrible kludge, and it won't work without "preparing" the 
 > filesystem at mount-time. I'd much rather leave the translation table in 
 > user space, and just give it as an argument to the "look up case 
 > insensitive" special thing.

The case mapping table must remain the same for the lifetime of the
mounted filesyste, otherwise you'd get chaos.  That's why tying it to
the filesystem (ie. hanging it off the superblock) makes sense.

 > The hard part would be negative dentries. We'd have to invalidate all
 > "case-insensitive" negative dentries when creating any new file in a
 > directory, and that would be something the generic VFS layer would have to 
 > know about

Right, the handling of negative dentries is the key. I don't think its
quite as bad as you say though, as you can do this:

1) use a filesystem provided case-insensitive hash in the dcache. If
   the filesystem provided hash isn't case-insensitive then don't try
   to do case-insensitive lookups on this filesystem.

2) you only need to potentially invalidate entries in the same hash
   bucket as the name you are creating. 

3) Even better, you don't need to invalidate entries that don't have
   the same hash value (presuming your hash values are larger than
   your truncated hash keys).

> and that might be unacceptable to Al.

yes, and I'm quite sympathentic to that point of view. I just want to
make sure that if we don't do this then we use honest reasons for not
doing it, not "that's impossible" reasons which are bogus when you
examine them.

Cheers, Tridge
