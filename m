Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966297AbWKNUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966297AbWKNUnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966300AbWKNUnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:43:11 -0500
Received: from master.altlinux.org ([62.118.250.235]:13071 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S966297AbWKNUnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:43:09 -0500
Date: Tue, 14 Nov 2006 23:42:36 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: sharyath@in.ibm.com, Pavel Emelianov <xemul@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to fixe Data Acess error in dup_fd
Message-ID: <20061114204236.GA10840@procyon.home>
References: <1163151121.3539.15.camel@legolas.in.ibm.com> <20061114181656.6328e51a.vsu@altlinux.ru> <1163530154.4871.14.camel@impinj-lt-0046>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1163530154.4871.14.camel@impinj-lt-0046>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2006 at 10:49:14AM -0800, Vadim Lobanov wrote:
> On Tue, 2006-11-14 at 18:16 +0300, Sergey Vlasov wrote:
> > On Fri, 10 Nov 2006 15:02:01 +0530 Sharyathi Nagesh wrote:
> > > --- kernel/fork.c.orig	2006-11-10 14:42:02.000000000 +0530
> > > +++ kernel/fork.c	2006-11-10 14:42:30.000000000 +0530
> > > @@ -687,6 +687,7 @@ static struct files_struct *dup_fd(struc
> > >  		 * the latest pointer.
> > >  		 */
> > >  		spin_lock(&oldf->file_lock);
> > > +		open_files =3D count_open_files(old_fdt);
> > >  		old_fdt =3D files_fdtable(oldf);
> > >  	}
>=20
> Looks like your analysis of the proposed patch's side-effects agrees
> with mine (call it independent verification, if you will :) ); I was
> expressing the very same concerns about it introducing a race condition
> on the mm-commits@ and stable@ lists. The only concern is that, although
> this patch is not correct, it does fix "something" -- it would be good
> to identify what exactly that "something" is.

Yes, very interesting (although if the problem appeared only after 72
hours of testing, it is hard to be sure that the bug is really fixed).

> [...] The open_files value that
> count_open_files() returns will always be a multiple of BITS_PER_LONG,
> so no extraneous bits will ever be copied. It's a tad confusing since
> count_open_files() does something a bit different than what its name
> suggests.

Yes, then the logic looks fine.  (The comment in count_open_files()
says "Find the last open fd", which is _almost_ what it does.)

There is also some unused code and slightly incorrect comment in
dup_fd():

	size =3D old_fdt->max_fdset;

=2E.. here "size" is not used ....

	/* if the old fdset gets grown now, we'll only copy up to "size" fds */

=2E.. here "size" is not used either ....

	size =3D (new_fdt->max_fds - open_files) * sizeof(struct file *);

The result of the first assignment to "size" is not used anywhere,
even if it is mentioned in the comment.  However, the intent to keep
the old size of fdset is noted again.

> Also, here's some extra information from the other email thread
> regarding this patch, that might aid in debugging. I'm merely
> copy-pasting it here for reference:

Thanks - I cannot find this discussion anywhere in archives...

> 0:mon> e
> cpu 0x0: Vector: 300 (Data Access) at [c00000007ce2f7f0]
>     pc: c000000000060d90: .dup_fd+0x240/0x39c
>     lr: c000000000060d6c: .dup_fd+0x21c/0x39c
>     sp: c00000007ce2fa70
>    msr: 800000000000b032
>    dar: ffffffff00000028
>  dsisr: 40000000
>   current =3D 0xc000000074950980
>   paca    =3D 0xc000000000454500
>     pid   =3D 27330, comm =3D bash
>=20
> 0:mon> t
> [c00000007ce2fa70] c000000000060d28 .dup_fd+0x1d8/0x39c (unreliable)
> [c00000007ce2fb30] c000000000060f48 .copy_files+0x5c/0x88
> [c00000007ce2fbd0] c000000000061f5c .copy_process+0x574/0x1520
> [c00000007ce2fcd0] c000000000062f88 .do_fork+0x80/0x1c4
> [c00000007ce2fdc0] c000000000011790 .sys_clone+0x5c/0x74
> [c00000007ce2fe30] c000000000008950 .ppc_clone+0x8/0xc
>=20
> The PC translates to:
>         for (i =3D open_files; i !=3D 0; i--) {
>                 struct file *f =3D *old_fds++;
>                 if (f) {
>                         get_file(f);       <-- Data access error

So we probably got a bogus "struct file" pointer...

>                 } else {
>=20
> And more info still:
>         0:mon> r
> R00 =3D ffffffff00000028   R16 =3D 00000000100e0000
> R01 =3D c00000007ce2fa70   R17 =3D 000000000fff1d38
> R02 =3D c00000000056cd20   R18 =3D 0000000000000000
> R03 =3D c000000029f40a58   R19 =3D 0000000001200011
> R04 =3D c000000029f442d8   R20 =3D c0000000a544a2a0
> R05 =3D 0000000000000001   R21 =3D 0000000000000000
> R06 =3D 0000000000000024   R22 =3D 0000000000000100
> R07 =3D 0000001000000000   R23 =3D c00000008635f5e8
> R08 =3D 0000000000000000   R24 =3D c0000000919c5448
> R09 =3D 0000000000000024   R25 =3D 0000000000000100
> R10 =3D 00000000000000dc   R26 =3D c000000086359c30
> R11 =3D ffffffff00000000   R27 =3D c000000089e5e230
> R12 =3D 0000000006bbd9e9   R28 =3D c00000000c8d3d80
> R13 =3D c000000000454500   R29 =3D 0000000000000020
> R14 =3D c00000007ce2fea0   R30 =3D c000000000491fc8
> R15 =3D 00000000fcb2e770   R31 =3D c0000000b8369b08
> pc  =3D c000000000060d90 .dup_fd+0x240/0x39c
> lr  =3D c000000000060d6c .dup_fd+0x21c/0x39c
> msr =3D 800000000000b032   cr  =3D 24242428
> ctr =3D 0000000000000000   xer =3D 0000000000000000   trap =3D  300
> dar =3D ffffffff00000028   dsisr =3D 40000000
> -----------------------
> 0:mon> di c000000000060d90 <=3D=3DPC
> c000000000060d90  7d200028      lwarx   r9,r0,r0
> c000000000060d94  31290001      addic   r9,r9,1
> c000000000060d98  7d20012d      stwcx.  r9,r0,r0
> c000000000060d9c  40a2fff4      bne     c000000000060d90        # .dup_fd=
+0x240/0x39c

 From what little I know about PowerPC, this looks like an atomic
increment of the memory word pointed to by r0, which contains
0xffffffff00000028 - definitely looks like a bogus address.  The
offset of file->f_count should be 0x28 on a 64-bit architecture, so
apparently we got f =3D=3D 0xffffffff00000000 from *old_fds.  Something
scribbled over that memory?

> c000000000060da0  48000014      b       c000000000060db4        # .dup_fd=
+0x264/0x39c
> c000000000060da4  e93b0018      ld      r9,24(r27)
> c000000000060da8  7c08482a      ldx     r0,r8,r9
> c000000000060dac  7c003878      andc    r0,r0,r7
> c000000000060db0  7c08492a      stdx    r0,r8,r9
> c000000000060db4  3b180008      addi    r24,r24,8
> c000000000060db8  7c0006ac      eieio
> c000000000060dbc  380affff      addi    r0,r10,-1
> c000000000060dc0  f97c0000      std     r11,0(r28)
> c000000000060dc4  38c60001      addi    r6,r6,1
> c000000000060dc8  3b9c0008      addi    r28,r28,8
> c000000000060dcc  7c0a07b4      extsw   r10,r0

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWio8W82GfkQfsqIRAvrIAJ0WEEqdzxHQ9W1eHjzi+ZPDKlYOngCfYlNB
DEApmqBJKaQMpyh25RImvX0=
=TYq0
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
