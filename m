Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRBUBDR>; Tue, 20 Feb 2001 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129647AbRBUBDI>; Tue, 20 Feb 2001 20:03:08 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:58866 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129609AbRBUBCv>; Tue, 20 Feb 2001 20:02:51 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102210101.f1L11xC15910@webber.adilger.net>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <Pine.LNX.4.10.10102201618520.31530-100000@penguin.transmeta.com>
 from Linus Torvalds at "Feb 20, 2001 04:22:48 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 20 Feb 2001 18:01:58 -0700 (MST)
CC: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> On Tue, 20 Feb 2001, Daniel Phillips wrote:
> > You mean full_name_hash?  I will un-static it and try it.  I should have
> > some statistics tomorrow.
> 
> I was more thinking about just using "dentry->d_name->hash" directly, and
> not worrying about how that hash was computed. Yes, for ext2 it will have
> the same value as "full_name_hash" - the difference really being that
> d_hash has already been precomputed for you anyway.

I _thought_ that's what you meant, but then I was also thinking that the
dentry hash was on the full path name and not just the filename?  This
wouldn't be any good for use in the directory index, in case the directory
is renamed.  If this is _not_ the case, then it is a definite candidate.

> Note that dentry->d_name->hash is really quick (no extra computation), but
> I'm not claiming that it has anything like a CRC quality. And it's
> probably a bad idea to use it, because in theory at least the VFS layer
> might decide to switch the hash function around.

I was thinking about this as well.  Since the setup Daniel has allows us
to store a hash version, we could run the hash function on a fixed string
at SB init time to give us a hash "version" number.  If the hash function
changes we will get a new hash "version".  We could inline each new dentry
hash function into the ext2 code (so we can unpack the directories), or
as a cop-out if any directory has a hash version not equal to the current
one we re-hash all the entries in the directory.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
