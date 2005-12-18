Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVLRSKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVLRSKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 13:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVLRSKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 13:10:11 -0500
Received: from h80ad2567.async.vt.edu ([128.173.37.103]:48829 "EHLO
	h80ad2567.async.vt.edu") by vger.kernel.org with ESMTP
	id S932422AbVLRSKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 13:10:10 -0500
Message-Id: <200512181258.jBICwMdj003410@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm2 - kzalloc() considered harmful for debugging.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1134910701_2933P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 07:58:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1134910701_2933P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <3388.1134910683.1@turing-police.cc.vt.edu>

So I've got a (probably self-inflicted) memory leak in slab-64 and slab-32.
Rebuild the kernel with CONFIG_DEBUG_SLAB, reboot, and wait for a bit of
leak to pile up, and then echo 'slab-32 0 0 0' > /proc/slabinfo

And ta-DA! the top offender is... (drum roll): <kzalloc+0xe/0x36>

Blargh.  It's tempting to do something like this in include/linux/slab.h:

#ifdef CONFIG_SLAB_DEBUG
static inline void* kzalloc(size_t size, gfp_t flags)
{
        void *ret = kmalloc(size, flags);
        if (ret)
                memset(ret, 0, size);
        return ret;
}
#else
extern void *kzalloc(size_t, gfp_t);
#end

or maybe some ad-crock macro implementation, just so the actual calling site of
kmalloc is recorded, rather than losing the caller of kzalloc.

Only problems are that (a) changing CONFIG_DEBUG_SLAB will probably recompile
the world rather than just mm/slab.c, and (b) it's 7AM and I've been chasing this
for 6 hours and not sure how to handle the actual body in mm/util.c (wrap the
kzalloc() with a #ifndev CONFIG_DEBUG_SLAB maybe)?

--==_Exmh_1134910701_2933P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDpVztcC3lWbTT17ARAr6WAJ9HI0BI/HmPD2vokAJMDooPvdo0ewCfeT0l
7BtZfOs7hKynRxMk3/3GS6I=
=PiED
-----END PGP SIGNATURE-----

--==_Exmh_1134910701_2933P--
