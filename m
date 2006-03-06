Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752391AbWCFS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbWCFS0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbWCFS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:26:46 -0500
Received: from mouth.voxel.net ([69.9.180.118]:29922 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S1752389AbWCFS0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:26:46 -0500
Subject: pdflush and high load
From: Andres Salomon <dilinger@debian.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ckdng4d63sc337SrO6/G"
Date: Mon, 06 Mar 2006 13:21:22 -0500
Message-Id: <1141669282.30428.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ckdng4d63sc337SrO6/G
Content-Type: multipart/mixed; boundary="=-stAyUBQnzkt8QDS2GHtA"


--=-stAyUBQnzkt8QDS2GHtA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I have a dual processor opteron system w/ a 3ware controller.  When
testing out i/o by doing a simple 'dd if=3D/dev/zero of=3D/mnt/foo bs=3D1M
count=3D1024', the load ends up hitting about 12 before the dd finishes.
This happens because 8 pdflush processes are spawned, and they all sit
in D state for most of the time.

While the load itself isn't a problem, I was tracking down other bugs
that it was potentially creating, and wondering why the load even needed
to be that high.  During the i/o, the pdflush processes look like this:

Mar  5 18:29:28 localhost kernel: pdflush       D C112D5E0     0  5698
11              5697 (L-TLB)
Mar  5 18:29:28 localhost kernel: d2e8de84 d2e8de88 c124d200 c112d5e0
00000004 f7d21550 c1922c00 c1924758
Mar  5 18:29:28 localhost kernel:        00000286 00000000 00000000
c180f440 00000001 00000000 9db0b4c0 000f44b6=20
Mar  5 18:29:28 localhost kernel:        f7d21550 f7e2d550 f7e2d678
c180fe80 d2e8de94 d2e8de94 0029545f d2e8df04
Mar  5 18:29:28 localhost kernel: Call Trace:
Mar  5 18:29:28 localhost kernel:  [schedule_timeout+111/142]
schedule_timeout+0x6f/0x8e
Mar  5 18:29:28 localhost kernel:  [process_timeout+0/9] process_timeout
0x0/0x9
Mar  5 18:29:28 localhost kernel:  [io_schedule_timeout+41/51]
io_schedule_timeout+0x29/0x33
Mar  5 18:29:28 localhost kernel:  [blk_congestion_wait+101/122]
blk_congestion_wait+0x65/0x7a
Mar  5 18:29:28 localhost kernel:  [autoremove_wake_function+0/58]
autoremove_wake_function+0x0/0x3a
Mar  5 18:29:28 localhost kernel:  [sync_sb_inodes+217/628]
sync_sb_inodes+0xd9/0x274
Mar  5 18:29:28 localhost kernel:  [autoremove_wake_function+0/58]
autoremove_wake_function+0x0/0x3a
Mar  5 18:29:28 localhost kernel:  [pdflush+0/50] pdflush+0x0/0x32
Mar  5 18:29:28 localhost kernel:  [writeback_inodes+121/204]
writeback_inodes+0x79/0xcc
Mar  5 18:29:28 localhost kernel:  [pdflush+0/50] pdflush+0x0/0x32
Mar  5 18:29:28 localhost kernel:  [background_writeout+133/148]
background_writeout+0x85/0x94
Mar  5 18:29:28 localhost kernel:  [__pdflush+231/379] __pdflush
+0xe7/0x17b
Mar  5 18:29:28 localhost kernel:  [pdflush+45/50] pdflush+0x2d/0x32
Mar  5 18:29:28 localhost kernel:  [background_writeout+0/148]
background_writeout+0x0/0x94
Mar  5 18:29:28 localhost kernel:  [kthread+124/166] kthread+0x7c/0xa6
Mar  5 18:29:28 localhost kernel:  [kthread+0/166] kthread+0x0/0xa6
Mar  5 18:29:28 localhost kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb


Basically, what ends up happening on my system is, each pdflush process
is handling background_writeout(), encountering congestion, and calling
blk_congestion_wait(WRITE, HZ/10) after every loop.
Blk_congestion_wait() does an uninterruptible sleep, and other things
get scheduled (typically of the 8 pdflush processes, 4 will be just
waiting at schedule(), 2 will actually be writing out pages in
generic_writepages(), and 2 will be off doing other random stuff like
handling softirqs or updating the wall time inside the timer irq
handler).

Is there a reason why this sleep needs to happen w/
TASK_UNINTERRUPTIBLE?  I tried setting it to TASK_INTERRUPTIBLE, and
encountered a minor performance hit (it took a few extra seconds to
write the 1GB of data); however, the pdflush processes spent most of
their time in S state, so the load on the system was much more
reasonable.

Aside from the TASK_UNINTERRUPTIBLE sleep, I think the real problem is
that the pdflush spawning metric has no way to determine whether a
pdflush process is doing actual useful work or not.  Currently, it
checks whether there's more work that needs to be done, and keeps
spawning pdflush threads (up to 8) without checking whether that would
actually help or not.  Throwing a printk inside the
background_writeout() loop showed the following work being done:

Mar  6 02:57:34 localhost kernel: background_writeout(130):
nr_dirty=3D102743, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-2681, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(5717):
nr_dirty=3D102740, nr_unstable=3D0, bg_thresh=3D26212, written=3D5,
min_pages=3D-2476, pages_skipped=3D0, nr_to_write=3D1019(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(131):
nr_dirty=3D102755, nr_unstable=3D0, bg_thresh=3D26212, written=3D11,
min_pages=3D-2318, pages_skipped=3D0, nr_to_write=3D1013(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(131):
nr_dirty=3D102742, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-2329, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(5717):
nr_dirty=3D102744, nr_unstable=3D0, bg_thresh=3D26212, written=3D3,
min_pages=3D-2481, pages_skipped=3D0, nr_to_write=3D1021(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(131):
nr_dirty=3D102741, nr_unstable=3D0, bg_thresh=3D26212, written=3D1,
min_pages=3D-2329, pages_skipped=3D0, nr_to_write=3D1023(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(130):
nr_dirty=3D102742, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-2681, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(5716):
nr_dirty=3D102743, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-1962, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(131):
nr_dirty=3D102744, nr_unstable=3D0, bg_thresh=3D26212, written=3D2,
min_pages=3D-2330, pages_skipped=3D0, nr_to_write=3D1022(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(5716):
nr_dirty=3D102744, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-1962, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1
Mar  6 02:57:34 localhost kernel: background_writeout(130):
nr_dirty=3D102744, nr_unstable=3D0, bg_thresh=3D26212, written=3D0,
min_pages=3D-2681, pages_skipped=3D0, nr_to_write=3D1024(/1024),
encountered_congestion=3D1


As you can see, they constantly encounter congestion, and constantly
have things to write out, so the background_writeout loop happens
endlessly; however, only two of the processes are actually able to get
anything useful done.  Pid #130 and #5716 cannot write anything out due
to locks, so they just keep trying and trying; pids #131 and #5717 are
actually doing useful work.  This is typically what it looks like w/ all
pdflush processes.

My solution to the problem is to keep the blk_congestion_wait() sleep as
uninterruptible, but add a check to the background_writeout() loop to
check whether the current pdflush thread is actually doing anything
useful; if it's not, just give up.  My threshold for "useful" is having
written any pages in the past 2 loop iterations.  This means that
pdflush processes that are actually working should continue working;
ones that are not will exit sooner; and ones that are temporarily not
working due to other activity on the system should exit (and new pdflush
threads should be spawned later on that will attempt to do work again).

I've attached the patch I'm using; my completely unscientific tests
shows it improving i/o speed on the 1GB file write.  Feedback on it
would be excellent.

Signed-off-by: Andres Salomon <dilinger@debian.org>


--=-stAyUBQnzkt8QDS2GHtA
Content-Disposition: attachment; filename=pdflush_suicide.patch
Content-Type: text/x-patch; name=pdflush_suicide.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL21tL3BhZ2Utd3JpdGViYWNrLmMgYi9tbS9wYWdlLXdyaXRlYmFjay5jDQpp
bmRleCA5NDU1NTlmLi45OWMyNTYxIDEwMDY0NA0KLS0tIGEvbW0vcGFnZS13cml0ZWJhY2suYw0K
KysrIGIvbW0vcGFnZS13cml0ZWJhY2suYw0KQEAgLTMxOSw2ICszMTksNyBAQCB2b2lkIHRocm90
dGxlX3ZtX3dyaXRlb3V0KHZvaWQpDQogc3RhdGljIHZvaWQgYmFja2dyb3VuZF93cml0ZW91dCh1
bnNpZ25lZCBsb25nIF9taW5fcGFnZXMpDQogew0KIAlsb25nIG1pbl9wYWdlcyA9IF9taW5fcGFn
ZXM7DQorCWxvbmcgbGFzdF93cm90ZSA9IC0xOw0KIAlzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wg
d2JjID0gew0KIAkJLmJkaQkJPSBOVUxMLA0KIAkJLnN5bmNfbW9kZQk9IFdCX1NZTkNfTk9ORSwN
CkBAIC0zMzEsNiArMzMyLDcgQEAgc3RhdGljIHZvaWQgYmFja2dyb3VuZF93cml0ZW91dCh1bnNp
Z25lZA0KIAkJc3RydWN0IHdyaXRlYmFja19zdGF0ZSB3YnM7DQogCQlsb25nIGJhY2tncm91bmRf
dGhyZXNoOw0KIAkJbG9uZyBkaXJ0eV90aHJlc2g7DQorCQlsb25nIHdyb3RlOw0KIA0KIAkJZ2V0
X2RpcnR5X2xpbWl0cygmd2JzLCAmYmFja2dyb3VuZF90aHJlc2gsICZkaXJ0eV90aHJlc2gsIE5V
TEwpOw0KIAkJaWYgKHdicy5ucl9kaXJ0eSArIHdicy5ucl91bnN0YWJsZSA8IGJhY2tncm91bmRf
dGhyZXNoDQpAQCAtMzQwLDcgKzM0MiwxMSBAQCBzdGF0aWMgdm9pZCBiYWNrZ3JvdW5kX3dyaXRl
b3V0KHVuc2lnbmVkDQogCQl3YmMubnJfdG9fd3JpdGUgPSBNQVhfV1JJVEVCQUNLX1BBR0VTOw0K
IAkJd2JjLnBhZ2VzX3NraXBwZWQgPSAwOw0KIAkJd3JpdGViYWNrX2lub2Rlcygmd2JjKTsNCi0J
CW1pbl9wYWdlcyAtPSBNQVhfV1JJVEVCQUNLX1BBR0VTIC0gd2JjLm5yX3RvX3dyaXRlOw0KKwkJ
d3JvdGUgPSBNQVhfV1JJVEVCQUNLX1BBR0VTIC0gd2JjLm5yX3RvX3dyaXRlOw0KKwkJaWYgKCFs
YXN0X3dyb3RlICYmICF3cm90ZSkNCisJCQlicmVhazsNCisJCWxhc3Rfd3JvdGUgPSB3cm90ZTsN
CisJCW1pbl9wYWdlcyAtPSB3cm90ZTsNCiAJCWlmICh3YmMubnJfdG9fd3JpdGUgPiAwIHx8IHdi
Yy5wYWdlc19za2lwcGVkID4gMCkgew0KIAkJCS8qIFdyb3RlIGxlc3MgdGhhbiBleHBlY3RlZCAq
Lw0KIAkJCWJsa19jb25nZXN0aW9uX3dhaXQoV1JJVEUsIEhaLzEwKTsNCg==


--=-stAyUBQnzkt8QDS2GHtA--

--=-ckdng4d63sc337SrO6/G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEDH2iOmXwGc/ULyYRAgqzAJ9ERgyMVez+KHkf0nlUYP4dXoAmyQCcCVsf
ZAoRT0OOtWXNojVcsZXue1U=
=kgV/
-----END PGP SIGNATURE-----

--=-ckdng4d63sc337SrO6/G--

