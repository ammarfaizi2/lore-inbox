Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133114AbRDLO51>; Thu, 12 Apr 2001 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbRDLO5S>; Thu, 12 Apr 2001 10:57:18 -0400
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:61315 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S133114AbRDLO5J>; Thu, 12 Apr 2001 10:57:09 -0400
Message-Id: <200104121457.f3CEv8o09656@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.3.1 01/19/2001 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-488656896P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2001 10:57:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-488656896P
Content-Type: text/plain; charset=us-ascii

I've seen the same scenario about 2-3 times a week.  kswapd and one or
more processes all CPU bound, totalling to 100%.  I've had 'esdplay' hung
on several occasions, and 2-3 times it's been xscreensaver (3.29) hung.
The 'hung' processes are consistently immune to kill -9, even as root, which
indicates to me that they're hung inside a kernel call or something.

Sometimes, something *else* will exit, and everything will 'break loose'
and return to normal after a minute or so.

It *may* not be related, but I also have a lot of this in 'dmesg':

__alloc_pages: 4-order allocation failed.
__alloc_pages: 3-order allocation failed.
i810_audio: DMA overrun on send

There was a recent posting re: the i810_audio driver amounting to "I've got
one bug to fix and then I'll put up a patch" for the 'dma overrun' message.
__alloc_pages doesn't give much information on who its caller was, so
that's somewhat of a dead end...

In page_alloc.c, __alloc_pages() has a 'goto try_again;' which will
cause it to loop around and try to get more memory.  I'm wondering if
the "hung" process is entering __alloc_pages(), and gets wedged in the
'try_again' loop - which has a call to wakeup_kswapd() inside it, which
would explain the high context-switch rate.  I'm not clear on how kswapd
can end up getting stuck and failing to free up something - unless it ends
up calling __alloc_pages itself indirectly and the PF_MEMALLOC bit isn't
enough to get it the memory it needs, causing a deadlock/loop between
kswapd and __alloc_pages/wakeup_kswapd().

Unfortunately, I've just exhausted my ability to debug this one here.. ;) 

I'm running the 2.4.3 kernel, with the following patches:

Reiserfs: 2.4.3-3.6.25.quota.bz2
linux-2.4.3-knfsd-6.g.patch.gz
linux-2.4.3-reiserfs-20010327.patch.bz2

IPv6: linux24-2.4.3-usagi-20010406.patch.gz
Crypto: patch-int-2.4.3.1

am using ReiserFS-on-LVM for basically all filesystems, if that matters...

-- 
				Valdis Kletnieks
				Operating Systems Analyst
				Virginia Tech


--==_Exmh_-488656896P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Exmh version 2.2 06/16/2000

iQA/AwUBOtXCRHAt5Vm009ewEQJJ+ACfU6jpHzZau3EfkphejFcO38MwymYAnR7r
Z8JSqO3bETRgsFhxfGWN+zTE
=AQEY
-----END PGP SIGNATURE-----

--==_Exmh_-488656896P--
