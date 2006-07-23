Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWGWVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWGWVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWGWVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:00:14 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:38366 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1751320AbWGWVAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:00:13 -0400
Date: Sun, 23 Jul 2006 17:00:39 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: pageexec@freemail.hu
Cc: grsecurity@grsecurity.net, linux-kernel@vger.kernel.org
Subject: Re: [grsec] kdeinit causes scheduling while atomic
Message-ID: <20060723210039.GC30515@ele.uri.edu>
References: <20060718135817.GA21666@ele.uri.edu> <44C382C9.4760.1D4085C8@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <44C382C9.4760.1D4085C8@pageexec.freemail.hu>
User-Agent: Mutt/1.5.11 [Linux 2.6.17.6-grsec-b0rg i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:08 Sun 23 Jul     , pageexec@freemail.hu wrote:
> On 18 Jul 2006 at 9:58, Will Simoneau wrote:
> > A scheduling while atomic just started showing up in the kernel log on
> > my machine, which unfortunately is running an odd combination of
> > non-vanilla patches. Maybe someone who knows at least some of the code
> > can give me some hints tracking this down? Or maybe the grsecurity folks
> > have an idea?
>=20
> given that probably neither side is familiar with  the other's patches,
> you should try to reproduce this with only one patch first. in the meanti=
me,
> it'd help to find out what gets called at copy_process+0x614/0xdea, there=
's
> probably a 'call' insn around copy_process+60f, you can use objdump to fi=
nd
> out who the target is.

objdump -d:

   c014838a:   be 00 f0 ff ff          mov    $0xfffff000,%esi
   c014838f:   8b bb a0 00 00 00       mov    0xa0(%ebx),%edi
   c0148395:   21 e6                   and    %esp,%esi
   c0148397:   8b 06                   mov    (%esi),%eax
   c0148399:   85 ff                   test   %edi,%edi
   c014839b:   0f b7 40 2c             movzwl 0x2c(%eax),%eax
   c014839f:   66 89 43 2c             mov    %ax,0x2c(%ebx)
   c01483a3:   74 51                   je     c01483f6 <copy_process+0x660>
-> c01483a5:   e8 a7 ab 0f 00          call   c0242f51 <gr_handle_brute_che=
ck>
   c01483aa:   8b 83 ac 00 00 00       mov    0xac(%ebx),%eax
   c01483b0:   05 b0 00 00 00          add    $0xb0,%eax
   c01483b5:   8b 4c 24 0c             mov    0xc(%esp),%ecx

>=20
> > Patches applied on top of 2.6.17.6:
> > grsecurity-2.1.9-2.6.17.4-200607120947
> > suspend2-2.2.7-for-2.6.17 (without 9920-linus-basic-trace - that plus
> > grsecurity gives rejects on vmlinux.lds.S)
>=20
> from what i see, it's a trivial reject, you can apply it by hand after RO=
DATA.
>=20
> > ---cut here---
> > PAX: execution attempt in: <NULL>, 00000000-00000000 00000000
> > PAX: terminating task: /usr/kde/3.5/bin/konqueror(konqueror):21177, uid=
/euid: 1000/1000, PC: 00000010, SP: 5953cf80
> > PAX: bytes at PC: ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??=
 ?? ??=20
> > PAX: bytes at SP-4: 00000010 00000003 5953cfb0 00000000 0000000a 000000=
1c 40488ef8 0000001d 5618e6e0 40083d30 00000000 00000003 55efdb83 40189c00 =
56108d92 56b09377 5618e6e0 5953d000 00000006 404eadb8 55f2bef8=20
> > ---end cut----
> >=20
> > Call of a null function pointer?
>=20
> it's interesting that at esp-4 you have 0x10, which happens to be the
> faulting eip value as well. this can occur if the fault occured not
> due to a 'call' but rather a 'retn' insn, that is, a function was trying
> to return to its caller, but the return address got overwritten on the
> stack. now whether that happened due to some programming error or a
> gcc/ssp bug is a good question. i'd first try to recompile it (and all
> related libraries!) w/o ssp, it's known to have code generation bugs for
> c++ code. if that cures the problem, you should enter it into the gentoo
> bugzilla.

It's caused by qt, with -fstack-protector(-all?) enabled. Version is
x11-libs/qt-3.3.6-r1 from portage. Without ssp, going to wikipedia in
konqueror works fine. Will file at bugs.gentoo.org when I get a chance.

>=20
> > Sometimes konqueror is killed by PaX, sometimes it dies on its own (I
> > think with a segfault). I can reproduce this 100% of the time by firing
> > up Konqueror and going to www.wikipedia.org, just before the front page
> > loads the window dissapears and leave those traces behind. Other sites
> > seem to work fine. The process either segfaults or is killed by PaX
> > immediately after causing the scheduling while atomic.
>=20
> you mean, the first mentioned schedule BUG triggered in kdeinit is related
> to this crash in konqueror? or are you getting a schedule BUG in konqueror
> as well? in any case, eliminating one variable at a time (like ssp) should
> help you nail the bug(s) down.
>=20

I'm not sure what's happening with the scheduling while atomic now.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFEw+N3LYBaX8VDLLURAjKqAJwPdaEb8eA7/zGMpVzkrsQ0nNyDZwCfWYVu
TVjOvx46zijHcZg9hrJl2eQ=
=KTha
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
