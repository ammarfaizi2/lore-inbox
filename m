Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULHKaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULHKaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 05:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbULHKaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 05:30:22 -0500
Received: from mout1.freenet.de ([194.97.50.132]:64413 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261176AbULHKaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 05:30:02 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Date: Wed, 8 Dec 2004 11:29:48 +0100
User-Agent: KMail/1.7.1
References: <200412062339.52695.mbuesch@freenet.de> <20041208082633.GA7720@elte.hu> <200412081049.37498.mbuesch@freenet.de>
In-Reply-To: <200412081049.37498.mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, kernel@kolivas.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4012366.mpM5W03BRG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412081129.54249.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4012366.mpM5W03BRG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok, forget it all. It crashed again. :)
Must be nvidia...


Quoting Michael Buesch <mbuesch@freenet.de>:
> Quoting Ingo Molnar <mingo@elte.hu>:
> >=20
> > * Michael Buesch <mbuesch@freenet.de> wrote:
> >=20
> > > > > The two attached patches (one against vanilla kernel and one
> > > > > against ck patchset) moves the rq-lock a few lines up in
> > > > > scheduler_tick() to also protect set_tsk_need_resched().
> > > > >=20
> > > > > Is that neccessary?
> > > >=20
> > > > scheduler_tick() is a special case, 'current' is pinned and cannot
> > > > go away, nor can it get off the runqueue.
> > >
> > > Can you explain in short, why this is the case, please? I don't really
> > > get behind it. How are the two things enforced?
> >=20
> > 'current' is the currently executing task and as such it wont get moved
> > off the runqueue. The only way to leave the runqueue is to execute
> > schedule() [or to be preempted].
>=20
> Ok, I understand that.
>=20
> Someone else said to me:
> [quote]
> "another runqueue might want to touch your runqueue
> while you're in scheduler_tick" ...
> "that is far more likely to hit with many many cpus and I'd
> be surprised if you're the first person to get a race there"
> [/quote]
>=20
> What about this? Is this possible? Or did she/he/it miss a point?
>=20
>=20
> It's this scenario here:
> I frequently get oopses in cpu_idle(). In the two hours before
> I made the patch, the machine hung twice. Since I'm running
> a patched scheduler, It did not hang again. I gave em about
> 15 hours testing.
>=20
> But maybe that's all pure luck.
>=20
> >  Ingo
>=20
>=20
> Unable to handle kernel paging request at virtual address 00099108
>  printing eip:
> b01010c0
> *pde =3D 00000000
> Oops: 0000 [#1]
> SMP=20
> Modules linked in: nfs lockd sunrpc nvidia ipv6 ohci_hcd tuner tvaudio ms=
p3400 bttv video_buf firmware_class btcx_risc ehci_hcd uhci_hcd usbcore int=
el_agp agpgart evdev
> CPU:    0
> EIP:    0060:[<b01010c0>]    Tainted: P      VLI
> EFLAGS: 00010286   (2.6.10-rc2-ck2-nozeroram-findvmastat)=20
> EIP is at cpu_idle+0x31/0x3f
> eax: 00000001   ebx: 00099100   ecx: 00000000   edx: 0000001d
> esi: 00000000   edi: b03dff9c   ebp: b03dffe4   esp: b03dffe0
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=3Db03de000 task=3Db034db40)
> Stack: 00020800 b03dfff8 b03e0898 000000bd b03e0340 b040cb80 0044f007 b01=
00211=20
> Call Trace:
>  [<b0103c00>] show_stack+0x7a/0x90
>  [<b0103d81>] show_registers+0x152/0x1ca
>  [<b0103f86>] die+0xf4/0x178
>  [<b0114556>] do_page_fault+0x42a/0x645
>  [<b01038a7>] error_code+0x2b/0x30
>  [<b03e0898>] start_kernel+0x13a/0x151
>  [<b0100211>] 0xb0100211
> Code: e0 ff ff 21 e3 eb 24 8b 0d 84 c6 40 b0 b8 26 10 10 b0 8b 15 c0 eb 3=
4 b0 85 c9 0f 44 c8 8b 43 10 c1 e0 07 89 90 84 52 41 b0 ff d1 <8b> 43 08 a8=
 08 74 d5 e8 d8 7f 1f 00 eb f2 55 89 e5 56 53 fb ba=20
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>=20
>=20
> b010108f <cpu_idle>:
> b010108f: 55                    push   %ebp
> b0101090: 89 e5                 mov    %esp,%ebp
> b0101092: 53                    push   %ebx
> b0101093: bb 00 e0 ff ff        mov    $0xffffe000,%ebx
> b0101098: 21 e3                 and    %esp,%ebx
> b010109a: eb 24                 jmp    b01010c0 <cpu_idle+0x31>
> b010109c: 8b 0d 84 c6 40 b0     mov    0xb040c684,%ecx
> b01010a2: b8 26 10 10 b0        mov    $0xb0101026,%eax
> b01010a7: 8b 15 c0 eb 34 b0     mov    0xb034ebc0,%edx
> b01010ad: 85 c9                 test   %ecx,%ecx
> b01010af: 0f 44 c8              cmove  %eax,%ecx
> b01010b2: 8b 43 10              mov    0x10(%ebx),%eax
> b01010b5: c1 e0 07              shl    $0x7,%eax
> b01010b8: 89 90 84 52 41 b0     mov    %edx,0xb0415284(%eax)
> b01010be: ff d1                 call   *%ecx
> b01010c0: 8b 43 08              mov    0x8(%ebx),%eax
> ^^^^^^^^^^^^^^^^^^ OOPS. This is the check to need_resched().
> b01010c3: a8 08                 test   $0x8,%al
> b01010c5: 74 d5                 je     b010109c <cpu_idle+0xd>
> b01010c7: e8 d8 7f 1f 00        call   b02f90a4 <schedule>
> b01010cc: eb f2                 jmp    b01010c0 <cpu_idle+0x31>
>=20
>=20
> Ah, and yes, the kernel is tainted. So Nvidia already received a bugrepor=
t.
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart4012366.mpM5W03BRG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtteiFGK1OIvVOP4RAuO9AJ97Cu86vHzB/A4827GHotIczgdVQQCeJoFc
zO/vm2Ez6sUl39in2K4BvYI=
=RmMF
-----END PGP SIGNATURE-----

--nextPart4012366.mpM5W03BRG--
