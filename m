Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUELDKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUELDKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbUELDKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:10:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28059 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263301AbUELDJz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:09:55 -0400
Message-Id: <200405120309.i4C39jUZ017062@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@cs.Stanford.EDU,
       madan@cs.Stanford.EDU, "David L. Dill" <dill@cs.Stanford.EDU>
Subject: Re: [CHECKER] e2fsck writes out blocks out of order, causing root dir to be corrupted (ext3, linux 2.4.19, e2fsprogs 1.34) 
In-Reply-To: Your message of "Tue, 11 May 2004 22:45:33 EDT."
             <Pine.LNX.4.53.0405112238140.3269@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.44.0405111749290.2448-100000@elaine24.Stanford.EDU>
            <Pine.LNX.4.53.0405112238140.3269@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-423300736P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 23:09:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-423300736P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 22:45:33 EDT, "Richard B. Johnson" said:

> Question?  Is fsck specified to be able to be crashed? I'm not
> sure you could ever make a repair-tool that could do that unless
> there was some "guaranteed to save device" on an independent power
> source during the repair. Fsck can't commit partial fixes of some
> stuff because it would leave the file-system in an unrecoverable
> state. It needs to complete.

On the flip side, if you poke through the code in fs/ext2/, you'll find that
a very large percentage of the code is not actually doing directly productive
work, but merely making sure that things always go to disk in the right
order, and double checking that things haven't been changed out from under
us, and the like.

I suspect this bug is merely a special case of "your filesystem can get scrogged
if something's doing caching behind your back" - the same sort of issues
that prompted recent "flush the IDE cache on shutdown" fixes, and the
well-known issues with using journalling file systems on a file-backed loopback
device.

Having said that, I admit being surprised that their demonstration test case
is *that* simple - that's a truly small number of I/Os to get it into a repeatably
corruptible state.  I'm sure many of us have a mental image of these class of
failures as being heisenbugs, dependent on the cache contents.

> Judging by the number of Stanford people being copied, I would
> guess that this is a troll-probe?

Hardly - the class of errors is one that does (or should) concern the kernel
community - and I don't consider identifying a "your filesystem *will* be toast
if you get into this repeatable scenario" a troll.  At the very least, we can
consider what additional hardening we can do to either the kernel or userspace
to make sure that we don't re-order the blocks - note the key phrase here:

"Neither of these pay attention to the journaling constraints of EXT3 and JBD."

There seems to have been a thread about write barriers for IDE drives back in
Feb 2003, to address exactly this issue.  Has the current 2.4/2.6 tree had any
significant real improvement regarding this since the admittedly old 2.4.19
kernel that the Stanford crew was testing?  I can't remember if that thread
resulted in any committed code actually used by the filesystems....



--==_Exmh_-423300736P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoZV4cC3lWbTT17ARAnhwAKDpMhSi5QiEecA18OO5lWJ/OyKJhQCg4Z2w
xbtr9t+t45LCxMAo1Osvbew=
=QzLb
-----END PGP SIGNATURE-----

--==_Exmh_-423300736P--
