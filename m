Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTLDQqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTLDQqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:46:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:62153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262914AbTLDQpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:45:51 -0500
Date: Thu, 4 Dec 2003 08:45:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nathan Scott <nathans@sgi.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mihai RUSU <dizzy@roedu.net>, Jens Axboe <axboe@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: kernel BUG at mm/filemap.c:332!
In-Reply-To: <Pine.LNX.4.56L0.0312041645560.7551@ahriman.bucharest.roedu.net>
Message-ID: <Pine.LNX.4.58.0312040834480.2055@home.osdl.org>
References: <Pine.LNX.4.56L0.0312041645560.7551@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,
 you're not off the hook yet. This is a smoking gun on XFS, and this time
with a big clue: large directories, and a low-memory situation.

Mihai RUSU <dizzy@roedu.net> wrote:
>
> It seems that this bug is related to a directory found on a xfs partition
> with lots of entries (several thousands). I didnt got any message like
> thos on some other systems which dont have such directories with many file
> entries. Any 'ls' I try in that directory and any other process trying to
> list its contents gets stuck in 'D' state.

Also, this time the config file doesn't have any MD/RAID support according
to the attachment:

	# Multi-device support (RAID and LVM)
	#
	# CONFIG_MD is not set

so it looks like the XFS and MD issues really are totally unrelated.

Basically, as far as I can see a pattern, we have:

 - MD/RAID causes a double bio free, and as a result we see the reports of
   slab corruption from people who have slab debugging enabled.
 - the XFS case causes some kind of "struct page" corruption, and as a
   result we see the "Bad page state" messages followed by an eventual
   oops due to corrupted page lists.

Two different bugs, two different behaviours. It's just that some people
have _both_ ;)

Mihai: the oops itself is in this case not very telling, since it's just a
result of corruption of some fundamental data structures (probably
somebody using a page cache page after having free'd it - and it probably
only shows up when memory gets low and pages have to be cleaned). Can you
tell Nathan more about the filesystem setup (block size, as much as
possible about the affected directory, etc).

		Linus

----
On Thu, 4 Dec 2003, Mihai RUSU wrote:
>
> I have been starting to get some of the machines here on 2.6.0 (curently
> test11). On one of them I got this kernel message:
>
> Bad page state at free_hot_cold_page
> flags:0x01020005 mapping:00000000 mapped:0 count:0
> Backtrace:
> Call Trace:
>  [<c0135172>] bad_page+0x46/0x6c
>  [<c01356ac>] free_hot_cold_page+0x60/0xec
>  [<c013573f>] free_hot_page+0x7/0x8
>  [<c013a23b>] __page_cache_release+0xa7/0xac
>  [<c013a9a2>] invalidate_complete_page+0xba/0xc4
>  [<c013ac9b>] invalidate_mapping_pages+0x73/0xd4
>  [<c014e617>] remove_inode_buffers+0x13/0x94
>  [<c013ad0a>] invalidate_inode_pages+0xe/0x14
>  [<c0163e09>] prune_icache+0x11d/0x260
>  [<c0163f61>] shrink_icache_memory+0x15/0x20
>  [<c013afec>] shrink_slab+0x110/0x168
>  [<c013c561>] balance_pgdat+0x13d/0x1e8
>  [<c013c70f>] kswapd+0x103/0x108
>  [<c013c60c>] kswapd+0x0/0x108
>  [<c011bdd8>] autoremove_wake_function+0x0/0x40
>  [<c011bdd8>] autoremove_wake_function+0x0/0x40
>  [<c0107011>] kernel_thread_helper+0x5/0xc
>
> Trying to fix it up, but a reboot is needed
> - ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:332!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0131fff>]    Not tainted
> EFLAGS: 00010246
> EIP is at unlock_page+0x1b/0x3c
> eax: 00000000   ebx: c14ecdc0   ecx: 00000016   edx: c1780120
> esi: c1781728   edi: 00000001   ebp: efd0be6c   esp: efd0be04
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 13, threadinfo=efd0a000 task=efd226b0)
> Stack: c14ecdc0 00000002 c013aca8 d4048c24 d4048c2c efd0a000 efd0a000 00000002
>        00000003 00000000 c1726f28 c14ecdc0 c1743290 efd0bec8 efd0bf14 c02f8900
>        000000fa 00000000 00000001 efd0be70 efd0be68 000000fb 000000fa d48f0704
> Call Trace:
>  [<c013aca8>] invalidate_mapping_pages+0x80/0xd4
>  [<c014e617>] remove_inode_buffers+0x13/0x94
>  [<c013ad0a>] invalidate_inode_pages+0xe/0x14
>  [<c0163e09>] prune_icache+0x11d/0x260
>  [<c0163f61>] shrink_icache_memory+0x15/0x20
>  [<c013afec>] shrink_slab+0x110/0x168
>  [<c013c561>] balance_pgdat+0x13d/0x1e8
>  [<c013c70f>] kswapd+0x103/0x108
>  [<c013c60c>] kswapd+0x0/0x108
>  [<c011bdd8>] autoremove_wake_function+0x0/0x40
>  [<c011bdd8>] autoremove_wake_function+0x0/0x40
>  [<c0107011>] kernel_thread_helper+0x5/0xc
>
> Code: 0f 0b 4c 01 d3 d0 2b c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03
>
> It seems that this bug is related to a directory found on a xfs partition
> with lots of entries (several thousands). I didnt got any message like
> thos on some other systems which dont have such directories with many file
> entries. Any 'ls' I try in that directory and any other process trying to
> list its contents gets stuck in 'D' state.
>
> I have attached .config file and here is what ver-linux says:
> Linux status 2.6.0-test11 #1 SMP Tue Dec 2 17:19:31 EET 2003 i686 unknown
>
> Gnu C                  2.95.3
> Gnu make               3.79.1
> util-linux             2.11r
> mount                  2.11r
> module-init-tools      implemented
> e2fsprogs              1.27
> jfsutils               1.0.18
> reiserfsprogs          3.x.1b
> xfsprogs               2.0.3
> quota-tools            3.06.
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.16
> Net-tools              1.60
> Kbd                    1.06
> Sh-utils               2.0
>
> Please help, thanks!
>
> - --
> Mihai RUSU                                    Email: dizzy@roedu.net
> GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
>                        "Linux is obsolete" -- AST
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
>
> iD8DBQE/z0vAPZzOzrZY/1QRAi0jAKDhTGbfetbch5XBOV31+0sMAtjBwQCfbdFb
> DCeSCZHDSVQZqaZfhUI6sbo=
> =oFXW
> -----END PGP SIGNATURE-----
