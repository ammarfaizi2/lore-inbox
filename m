Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWGWUp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWGWUp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWGWUp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:45:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50652 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751303AbWGWUp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:45:26 -0400
Message-ID: <44C3E041.1020909@suse.com>
Date: Sun, 23 Jul 2006 16:46:57 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com>
In-Reply-To: <44C32348.8020704@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> I just got an email from the programmer who wrote the MythTV bug saying
> that he is just too busy to bother fixing the bug in his code.....  so
> my response is that a Namesys programmer is going to fix it on Monday.


Hans -

I'll accept blame when it's my bug, but the MythTV one isn't. I've been
working with the bitmap code and did the analysis to track down what was
happening, but that doesn't make it a bug in my code.

That particular bug isn't in the bitmap scanning code, it's a side
effect of the write batching higher up. It's looking for a window of 32
blocks, and there's just no window that large available. It ends up
scanning all the bitmaps looking for the window, and then backs off to
single block allocations. The scanning code works fine, and it does skip
where there aren't enough free blocks available in a particular bitmap.

It's a pathological case when the file system is seriously fragmented. A
quick fix would be to set a flag indicating that future writes shouldn't
bother trying to find a window that large, but that's a hack. A better
allocation algorithm would keep track of free space extents in memory,
subject to getting dropped by memory pressure. Since that information
would be separate from the bitmaps themselves, we could get rid of that
nasty "is this block free, but in the journal?" check that we need to do
as well. It's invasive, and a quicker fix would just be to track the
largest window, and rescan when it gets used or a block in that bitmap
gets freed.

That said, I actually did start work on a fix for this one, but I really
just don't have the time right now.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEw+BBLPWxlyuTD7IRAtG8AKCOWW/AH3NAen6gd6BToJGVfzdnNACfYkVS
j2/6yAAeWKAhs4ng9fdGW0Y=
=gB+v
-----END PGP SIGNATURE-----
