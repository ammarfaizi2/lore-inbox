Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWI3AGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWI3AGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWI3AFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:05:53 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:29125
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422855AbWI3AFm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:05:42 -0400
Message-Id: <200609300001.k8U01sPI004389@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Jean Tourrilhes <jt@hpl.hp.com>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Fri, 29 Sep 2006 12:45:58 PDT."
             <20060929124558.33ef6c75.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu>
            <20060929124558.33ef6c75.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159574514_2769P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 20:01:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159574514_2769P
Content-Type: text/plain; charset=us-ascii

On Fri, 29 Sep 2006 12:45:58 PDT, Andrew Morton said:

(Adding a bunch of people to the cc: list now that I have a clue what is
going on....)

> I'd expect it's the same bug - slab data structures have gone bad.

*bing*! We have a winner.  A quick check showed the kernel wasn't built with
slab debugging enabled, so I turned on the more obvious options, and got
rewarded with a traceback..

> Again: how come nobody else is hitting this?  Something's different.

gkrellm and wireless (specifically, gkrellm-wifi-0.9.12-3.fc6 from Fedora
Core extras-development).  Kernel is still a 2.6.18 with *only* the
origin.patch from -mm2 applied. Note that the gkrellm plugin hasn't had
a change in the code since 01/03/2004 - hopefully there's been no unintentional
API change on the kernel side since then...

Here's the traceback I got:

slab error in verify_redzone_free(): cache `size-32': memory outside object was overwritten
[<c0103ad2>] dump_trace+0x64/0x1cd
[<c0103c4d>] show_trace_log_lvl+0x12/0x25
[<c010415f>] show_trace+0xd/0x10
[<c01041fc>] dump_stack+0x19/0x1b
[<c014c796>] __slab_error+0x17/0x1c
[<c014cdac>] cache_free_debugcheck+0xaf/0x230
[<c014d43e>] kfree+0x59/0x8c
[<c02dc04a>] ioctl_standard_call+0x1da/0x218
[<c02dc275>] wireless_process_ioctl+0x55/0x312
[<c02d3750>] dev_ioctl+0x45f/0x49a
[<c02c92aa>] sock_ioctl+0x1b3/0x1c6
[<c0160322>] do_ioctl+0x22/0x67
[<c01605a5>] vfs_ioctl+0x23e/0x251
[<c01605ff>] sys_ioctl+0x47/0x64
[<c0102cd3>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb

Leftover inexact backtrace:

=======================
de57e16c: redzone 1:0x170fc2a5, redzone 2:0x170fc200.

Repeated, over and over, just about once a second.

A quick strace of gkrellm finds these likely ioctl's causing the problem:

% grep ioctl /tmp/foo2 | sort -u | more
ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0
ioctl(13, SIOCGIWRANGE, 0xbfbcdbdc)     = 0
ioctl(13, SIOCGIWRATE, 0xbfbcdbbc)      = 0

Since I'm using an orinoco-based card, these 2 look like the most likely
candidates.  WE-21 was merged between -mm1 and -mm2, which is why -mm1 was
stable for me. I'll let somebody else argue over what path these took that
I never tripped over them in an earlier -mm before they hit Linus's tree...

commit baef186519c69b11cf7e48c26e75feb1e6173baa
Author: John W. Linville <linville@tuxdriver.com>
Date:   Fri Sep 8 16:04:05 2006 -0400

    [PATCH] WE-21 support (core API)

    This is version 21 of the Wireless Extensions. Changelog :
        o finishes migrating the ESSID API (remove the +1)
        o netdev->get_wireless_stats is no more
        o long/short retry

    This is a redacted version of a patch originally submitted by Jean
    Tourrilhes.  I removed most of the additions, in order to minimize
    future support requirements for nl80211 (or other WE successor).

    CC: Jean Tourrilhes <jt@hpl.hp.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

commit eeec9f1a931262d69811135092c8447d6dccc3e6
Author: Jean Tourrilhes <jt@hpl.hp.com>
Date:   Tue Aug 29 18:02:31 2006 -0700

    [PATCH] WE-21 for orinoco

    Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>




--==_Exmh_1159574514_2769P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHbPycC3lWbTT17ARAiOOAKD4wl4bi3riiRlgMZUKBZ81Kxn+oQCg7Px3
MutPxVqEPb1td+rlG2HCxRw=
=+5Li
-----END PGP SIGNATURE-----

--==_Exmh_1159574514_2769P--
