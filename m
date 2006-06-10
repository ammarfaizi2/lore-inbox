Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWFJTLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWFJTLE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWFJTLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:11:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751679AbWFJTLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:11:01 -0400
Message-ID: <448B1707.4090000@suse.com>
Date: Sat, 10 Jun 2006 15:01:27 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: How long can an inode structure reside in the inode_cache?
References: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>	 <20060610121318.GQ1651@parisc-linux.org> <4ae3c140606101012y6668fd5co7b7d2d453bb02397@mail.gmail.com>
In-Reply-To: <4ae3c140606101012y6668fd5co7b7d2d453bb02397@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xin Zhao wrote:
> No. I guess I didn't make my question clear.
> 
> My question is: Will an inode be released after the last file refers
> to this is closed? If so, this could bring a performance issue.
> Consider this case: a process open a file, read it, close it, then
> reopen this file, read it, close it. For every open,  the inode has to
> be read from disk again, which make hurt performance.
> 
> So I think inode should stay in inode_cache for a while, not released
> right after the last file stops referring it. I just want to know
> whether my guess is right. If it is, when will kernel release the
> inode, since an inode cannot stay in memory forever.

That's pretty much exactly what happens. The kernel caches inodes and
dentries when memory usage allows. When the last reference to an inode
is dropped and the file system is still in use, the inode goes on the
unused_inode list. It remains linked to the inode hash table. When a
inode is requested, the hash table is checked before trying to read it
back from disk. Check out generic_forget_inode() and ifind().

When there is memory pressure, the VM system will shrink these caches.
inode_init() registers a callback for the VM to call
shrink_icache_memory () which will finally free the memory. Check out
mm/vmscan.c and fs/inode.c for more detailed information.

- -Jeff

- --
Jeff Mahoney
SUSE Labs


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEixcGLPWxlyuTD7IRAn1SAJ4yjgtJ9YL321W/18a7nttlaEc9pACeIMJX
yNUuC/impK4eZpHpLkwtCOQ=
=ykbS
-----END PGP SIGNATURE-----
