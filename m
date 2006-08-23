Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWHWAdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWHWAdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWHWAdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:33:13 -0400
Received: from ns1.suse.de ([195.135.220.2]:64996 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751267AbWHWAdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:33:12 -0400
Message-ID: <44EBA398.5090100@suse.com>
Date: Tue, 22 Aug 2006 20:38:48 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap searching
References: <44EB1484.2040502@suse.com>	<44EB23D9.9000508@slaphack.com>	<44EB28EC.50802@suse.com>	<44EB684C.2090206@slaphack.com>	<44EB7518.5010204@suse.com> <20060822171133.72692542.akpm@osdl.org>
In-Reply-To: <20060822171133.72692542.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> I can see that the bigalloc code as-is is pretty sad, but this is a scary
> patch.  It has the potential to cause people significant performance
> problems way, way ahead in the future.
> 
> For example, suppose userspace is growing two files concurrently.  It could
> be that the bigalloc code would cause one file's allocation cursor to
> repeatedly jump far away from the second.  ie: a beneficial side-effect. 
> Without bigalloc that side-effect is lost and the two files blocks end up
> all intermingled.
>
> I don't know if that scenario is realistic, but I bet there are similar
> accidental oddities which can occur as a result of this change.
> 
> But what are they?

Bigalloc doesn't cause that effect one way or the other. You'll end up
with blocks still intermingled, just in 32 block[1] chunks. It doesn't
throw the cursor way out, just until the next 32 block free window.
Another thread writing will do the same thing, and the blocks can end up
getting intermingled in the same manner on a different part of the disk.

The behavior you're describing can only be caused by bad hinting: Two
files that are placed too close to each other. This patch changes the
part of the allocator that is *only* responsible for finding the free
bits. Where it should start looking for them is a decision made earlier
in determine_search_start().

This patch just reverts the change that Chris and I submitted ages ago
as part of a number of block allocator enhancements, not as a bug fix. I
think I traced it to the 2.5 days, but I can't find that particular
email. Neither of us anticipated the problem that MythTV users are
hitting with it. Reverting it just makes that part of the allocator
behave similarly to the ext[23] allocator where it just collects
available blocks from a starting point. For every day use, I don't think
performance should be terribly affected, and it definitely fixes the
pathological case that the MythTV users were seeing.

- -Jeff

[1]: For simplicity, I'll continue to reference 32 blocks as the chunk
size. In reality, it can be anything up to 32 blocks.

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE66OXLPWxlyuTD7IRApXFAJ9bUsrtfmRC2kOMMWcCel4BZq6/SgCfTcsV
rS6dvKc6MowiAY+r/0Jhp5A=
=MwOb
-----END PGP SIGNATURE-----
