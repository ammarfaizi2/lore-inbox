Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTJLBwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 21:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJLBwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 21:52:54 -0400
Received: from [38.119.218.103] ([38.119.218.103]:49537 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S263365AbTJLBwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 21:52:50 -0400
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.10244 secs)
Date: Sat, 11 Oct 2003 20:52:48 -0500
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with de4x5 on Alpha?
Message-ID: <20031012015248.GA6472@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031011162651.GA25489@wang-fu.org> <wrppth3snpz.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <wrppth3snpz.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Marc Zyngier:
> Could you please try 2.6.0-test5 ? Or even better, 2.6.0-test7 with
> the 2.6.0-test5 driver (revert de4x5.[ch] and the Space.c changes) ?
>=20
> The usual debug informations would be helpful too...

I reverted de4x5.[ch] and Space.c to their -test5 versions, and I get
the same effect.  If I disable the starting of networking, and boot, I
can then see this when I attempt to start it:

root@buddha:~# /etc/init.d/networking start
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... done.
root@buddha:~# eth1: media is 100Mb/s.

After that, it's locked up.  Sometimes it prints the media notice before
it hangs, and sometimes it doesn't.  I don't believe I've ever seen it
print that when I booted with nosmp (always hangs before it gets that
far.)  Also, when SMP is enabled, sometimes when I do the SysRq-t I see
this right before the trace starts:

smp_call_function_on_cpu: initial timeout -- trying long wait

And then down mixed in with the trace, I get a notice from a BUG_ON() at
line 878 of arch/alpha/kernel/smp.c  Decoded, it looks like this:

Kernel bug at arch/alpha/kernel/smp.c:878
CPU 1 ifup(102): Kernel Bug 1
pc =3D [<fffffc000031e6a4>]  ra =3D [<fffffc000031e624>]  ps =3D 0000    No=
t tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 =3D 0000000000000041  t0 =3D 0000000000000001  t1 =3D 0000000000000001
t2 =3D 0000000100036c4d  t3 =3D 0000000000000000  t4 =3D ffffffff00000000
t5 =3D 0000000000000001  t6 =3D 61635f706d733e33  t7 =3D fffffc001f41c000
a0 =3D fffffc00005e8b70  a1 =3D 0000000000002600  a2 =3D ffffffffffffffff
a3 =3D 000000000000000a  a4 =3D fffffc0000000008  a5 =3D fffffc001f41fa00
t8 =3D 0000000000000004  t9 =3D 000000000000000d  t10=3D 0000000000000000
t11=3D 000186f800000004  pv =3D fffffc00003f9590  at =3D fffffc000063f0e8
gp =3D fffffc0000631200  sp =3D fffffc001f41f968
Trace:fffffc000031e96c fffffc000031e8a0 fffffc0000367320
fffffc000032c470 fffffc00003859f4 fffffc00003860f0 fffffc00003acae0
fffffc00003ad430 fffffc00003ad454 fffffc00003869ac fffffc0000386e28
fffffc0000315930 fffffc0000313144 fffffc00003130a0
Code: 2ffe0000  47e10400  a59e0020  23de0060  6bfa8001  00000081
<0000036e> 00520922


>>RA;  fffffc000031e624 <smp_call_function_on_cpu+d4/200>

>>PC;  fffffc000031e6a4 <smp_call_function_on_cpu+154/200>   <=3D=3D=3D=3D=
=3D

Trace; fffffc000031e96c <flush_tlb_mm+3c/100>
Trace; fffffc000031e8a0 <ipi_flush_tlb_mm+0/90>
Trace; fffffc0000367320 <exit_mmap+230/290>
Trace; fffffc000032c470 <mmput+c0/140>
Trace; fffffc00003859f4 <exec_mmap+114/180>
Trace; fffffc00003860f0 <flush_old_exec+690/a80>
Trace; fffffc00003acae0 <load_elf_binary+370/d30>
Trace; fffffc00003ad430 <load_elf_binary+cc0/d30>
Trace; fffffc00003ad454 <load_elf_binary+ce4/d30>
Trace; fffffc00003869ac <search_binary_handler+1bc/430>
Trace; fffffc0000386e28 <do_execve+208/290>
Trace; fffffc0000315930 <sys_execve+60/b0>
Trace; fffffc0000313144 <entSys+a4/c0>
Trace; fffffc00003130a0 <entSys+0/c0>

Code;  fffffc000031e68c <smp_call_function_on_cpu+13c/200>
0000000000000000 <_PC>:
Code;  fffffc000031e68c <smp_call_function_on_cpu+13c/200>
   0:   00 00 fe 2f       unop=20
Code;  fffffc000031e690 <smp_call_function_on_cpu+140/200>
   4:   00 04 e1 47       mov  t0,v0
Code;  fffffc000031e694 <smp_call_function_on_cpu+144/200>
   8:   20 00 9e a5       ldq  s3,32(sp)
Code;  fffffc000031e698 <smp_call_function_on_cpu+148/200>
   c:   60 00 de 23       lda  sp,96(sp)
Code;  fffffc000031e69c <smp_call_function_on_cpu+14c/200>
  10:   01 80 fa 6b       ret
Code;  fffffc000031e6a0 <smp_call_function_on_cpu+150/200>
  14:   81 00 00 00       bugchk
Code;  fffffc000031e6a4 <smp_call_function_on_cpu+154/200>   <=3D=3D=3D=3D=
=3D
  18:   6e 03 00 00       call_pal     0x36e   <=3D=3D=3D=3D=3D
Code;  fffffc000031e6a8 <smp_call_function_on_cpu+158/200>
  1c:   22 09 52 00       call_pal     0x520922


This is what lspci shows.  The 21040 is built into the I/O board, but is
only 10mbit so I don't use it.  The 4 21142/43 entries are the ports on
a 4-port DE500-BA card.  I'm using the first port on that card for my
connection.  I've tried swapping around and using the 21040, or a
different port on the other card, but it doesn't seem to change
anything.

00:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [T=
ulip] (rev 23)
00:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 02)
00:02.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 04)
00:06.0 RAID bus controller: Mylex Corporation DAC960P (rev 02)
00:07.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02)
00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 0=
2)
02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43=
 (rev 41)
02:01.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43=
 (rev 41)
02:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43=
 (rev 41)
02:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43=
 (rev 41)

If there's any specific information that I'm not presenting that would
be useful, please just let me know what things to gather up.


--=20
Nathan Poznick <kraken@drunkmonkey.org>

"Ouch!! I landed on my eight-sided dice!" -Joel (as a human sacrifice).
#301


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/iLPwYOn9JTETs+URAnNKAJ46C+Vz2T/YJ+/sDfxSrZgkzCdOBACdHmSV
hfwQ6PQLHXifHx3OajgIeoc=
=vM2k
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
