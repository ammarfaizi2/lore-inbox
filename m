Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUAMAYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUAMAYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:24:32 -0500
Received: from dialin-212-144-178-213.arcor-ip.net ([212.144.178.213]:896 "EHLO
	localhost") by vger.kernel.org with ESMTP id S263325AbUAMAYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:24:18 -0500
Date: Tue, 13 Jan 2004 01:17:20 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG][FBDEV] Logos are initdata (Problem known, solution wanted)
Message-ID: <20040113001720.GA1953@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

I've come upon a general bug in the implementation of the Linux Logos:
The logos  themselves are defined as  initdata, so they  are no longer
availible  when the  system  is started  up.   However, under  certain
conditions, fbcon_init() is  called when the system is  already up, so
you get an oops. An example:

Unable to handle kernel paging request at virtual address c06a083c <- logo_linux_clut->height
 printing eip:
c03a0207
*pde = 00103027
*pte = 006a0000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c03a0207>]    Not tainted
EFLAGS: 00210282
EIP is at fb_prepare_logo+0x47/0xe0
eax: 00000300   ebx: d7768000   ecx: 00000000   edx: c06a0834 <- logo_linux_clut224
esi: d7768000   edi: 00000008   ebp: c06e48a4   esp: cdcb3d84
				     ^^^^^^^^
			 con_driver_map[0]->con_init()
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 10090, threadinfo=cdcb2000 task=cb466960)
Stack: 00000030 d42c4df8 c039cb31 d7768000 cfa86ef8 d796eeb0 c0196a52 d7ff9500
       cdcb3e2c 00000030 00000080 00000001 00000000 c06ee9fc 00000100 00000080
       00000030 d7768000 d42c4df8 00000001 c06e4784 c06e48a4 c039c63f d42c4df8
Call Trace:
 [<c039cb31>] fbcon_set_display+0x4b1/0x760
 [<c0196a52>] alloc_inode+0x152/0x160
 [<c039c63f>] fbcon_init+0x3f/0x60
 [<c0320642>] visual_init+0xa2/0x100
 [<c0323dd1>] take_over_console+0x151/0x1c0
 [<c039bdff>] set_con2fb_map+0x3f/0x60
 [<c03a1119>] fb_ioctl+0x4b9/0x580
 [<c0156ea9>] kmem_cache_alloc+0x129/0x1c0
 [<c0310832>] down_tty_sem+0x12/0x40
 [<c03108da>] init_dev+0x5a/0x4c0
 [<c031b3a8>] vt_ioctl+0x1908/0x1fc0
 [<c03239cf>] con_open+0xf/0x80
 [<c0311a76>] tty_open+0x356/0x4a0
 [<c0181bf4>] cp_new_stat64+0x114/0x140
 [<c0181cca>] sys_fstat64+0x2a/0x40
 [<c018c053>] sys_ioctl+0x1d3/0x3c0
 [<c010b687>] syscall_call+0x7/0xb

Code: 39 42 08 76 14 b8 00 00 00 00 c7 05 50 fa 6e c0 00 00 00 00
 Erreur de segmentation

This  bug gets triggered  every time  one tries  to use  directfb. The
problem is that fb_prepare_logo() calls find_logo(), which returns the
pointer    to    the    already   freed    linux_logo_clut224.    Then
fb_prepare_logo() tries to access the height of the logo -> bang.

I'm not  exactly sure how  to solve this  one. One solution is  not to
make  the  logos  initdata at  all,  another  one  is to  return  from
fb_prepare_logo() immediately if  we are not in init  code, though I'm
not exactly sure how to do that.

				Tonnerre

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAAzkQygQNIN66kP8RAsIsAJ0cbAslSWgxICvylsqpv+ZVYiIJuACeMxNI
azWg5+LhfNV2vJA270ov0Vo=
=3j8X
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
