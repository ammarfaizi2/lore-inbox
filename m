Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUBRJCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUBRJCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:02:10 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:52437 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263679AbUBRJB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:01:59 -0500
Date: Wed, 18 Feb 2004 10:00:28 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Len Brown <len.brown@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: 2.6.3-rc3 (and possibly earlier 2.6): weird hang and oopses
Message-ID: <20040218090027.GA9868@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Alessandro Suardi <alessandro.suardi@oracle.com>,
	Len Brown <len.brown@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <A6974D8E5F98D511BB910002A50A6647615F214C@hdsmsx402.hd.intel.com> <1076999173.2508.30.camel@dhcppc4> <4032752E.9070201@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <4032752E.9070201@oracle.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2004 at 09:10:22PM +0100, Alessandro Suardi wrote:
> Will run from now for a couple of weeks with CONFIG_ACPI_PROCESSOR=3Dn;
>  I checked my logs and noticed my first hang happened with 2.6.2,

IIRC 2.6.2 didn't yet contain the processor updates...

> I just now noticed that in /var/log I have the full Oops traces
>  (until I Alt-SysRq'd out of it), so I'm attaching them; would you
>  please take a further look and confirm this is _only_ an ACPI-related
>  issue ?

The first Oops seems to be not related to ACPI:

Feb 16 15:57:48 incident kernel: Oops: 0000 [#1]
Feb 16 15:57:48 incident kernel: CPU:    0
Feb 16 15:57:48 incident kernel: EIP:    0060:[<c0242045>]    Not tainted
Feb 16 15:57:48 incident kernel: EFLAGS: 00010246
Feb 16 15:57:48 incident kernel: EIP is at init_dev+0x2b/0x567
Feb 16 15:57:48 incident kernel: eax: a1192400   ebx: d2e6e000   ecx: c0418=
f38   edx: 00008802
Feb 16 15:57:48 incident kernel: esi: 02000000   edi: f3986480   ebp: a1192=
400   esp: d2e6fe98
Feb 16 15:57:48 incident kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 15:57:48 incident kernel: Process sh (pid: 7260, threadinfo=3Dd2e6e0=
00 task=3Dcd98ecc0)
Feb 16 15:57:48 incident kernel: Stack: a1192400 00000000 f7dabb80 c01655e6=
 f7dabb80 c03e52d0 00000000 f782f080=20
Feb 16 15:57:48 incident kernel:        f30d2580 c015cc36 f7dabb80 d2e6ff04=
 d2e6ff00 f7dabb80 420d2290 f554c300=20
Feb 16 15:57:48 incident kernel:        d2e6e000 02000000 f3986480 00500000=
 c0242eea 02000000 a1192400 d2e6ff00=20
Feb 16 15:57:48 incident kernel: Call Trace:
Feb 16 15:57:48 incident kernel:  [<c01655e6>] dput+0x22/0x21f
Feb 16 15:57:48 incident kernel:  [<c015cc36>] link_path_walk+0x61b/0x957
Feb 16 15:57:48 incident kernel:  [<c0242eea>] tty_open+0x90/0x36d
Feb 16 15:57:48 incident kernel:  [<c0242e5a>] tty_open+0x0/0x36d
Feb 16 15:57:48 incident kernel:  [<c0157c7d>] chrdev_open+0xf3/0x21c
Feb 16 15:57:48 incident kernel:  [<c015d860>] open_namei+0xa6/0x400
Feb 16 15:57:48 incident kernel:  [<c0157b8a>] chrdev_open+0x0/0x21c
Feb 16 15:57:48 incident kernel:  [<c014e264>] dentry_open+0x14d/0x218
Feb 16 15:57:48 incident kernel:  [<c014e115>] filp_open+0x67/0x69
Feb 16 15:57:48 incident kernel:  [<c014e598>] sys_open+0x5b/0x8b
Feb 16 15:57:48 incident kernel:  [<c0108f9d>] sysenter_past_esp+0x52/0x71

=2E.. and neither the second, but then the "bad: scheduling while atomic"
calls start. And this call trace looks quite strange... There is no reason
ps should call "acpi_processor_set_performance".... But well, the kernel is
in an inconsistent state already because of the two previous oopses...

Is the kernel compiled with "frame pointers"? CONFIG_FRAME_POINTER ? If not=
,=20
please change this setting to "y".

What follows then are other oopses and bad: scheduling while atomic notices
where I cannot see any relation to ACPI.

Feb 16 16:07:16 incident kernel: SysRq : Show Regs
Feb 16 16:07:16 incident kernel:=20
Feb 16 16:07:16 incident kernel: Pid: 0, comm:              swapper
Feb 16 16:07:16 incident kernel: EIP: 0060:[<c02380f8>] CPU: 0
Feb 16 16:07:16 incident kernel: EIP is at acpi_processor_idle+0x13c/0x1cb
Feb 16 16:07:16 incident kernel:  EFLAGS: 00000216    Not tainted
Feb 16 16:07:16 incident kernel: EAX: 0050d212 EBX: 00000808 ECX: 0050d079 =
EDX: 00000808
Feb 16 16:07:16 incident kernel: ESI: c1b7d2b0 EDI: c0105000 EBP: c1b7d200 =
DS: 007b ES: 007b
Feb 16 16:07:16 incident kernel: CR0: 8005003b CR2: 421b7000 CR3: 35924000 =
CR4: 000006d0
Feb 16 16:07:16 incident kernel: Call Trace:
Feb 16 16:07:16 incident kernel:  [<c0106cee>] default_idle+0x0/0x27
Feb 16 16:07:16 incident kernel:  [<c0105000>] rest_init+0x0/0x5e
Feb 16 16:07:16 incident kernel:  [<c023007b>] acpi_ut_copy_ipackage_to_ipa=
ckage+0x69/0xdb
Feb 16 16:07:16 incident kernel:  [<c0106cee>] default_idle+0x0/0x27
Feb 16 16:07:16 incident kernel:  [<c0105000>] rest_init+0x0/0x5e
Feb 16 16:07:16 incident kernel:  [<c0106d79>] cpu_idle+0x2e/0x37
Feb 16 16:07:16 incident kernel:  [<c0462686>] start_kernel+0x182/0x1b0
Feb 16 16:07:16 incident kernel:  [<c04623dd>] unknown_bootoption+0x0/0xff

acpi_processor_idle seems to innocent, "ps" is causing an oops again:

Feb 16 16:08:28 incident kernel: Unable to handle kernel paging request at =
virtual address 02000064
Feb 16 16:08:28 incident kernel:  printing eip:
Feb 16 16:08:28 incident kernel: c017b7ce
Feb 16 16:08:28 incident kernel: *pde =3D 00000000
Feb 16 16:08:28 incident kernel: Oops: 0000 [#7]
Feb 16 16:08:28 incident kernel: CPU:    0
Feb 16 16:08:28 incident kernel: EIP:    0060:[<c017b7ce>]    Not tainted
Feb 16 16:08:28 incident kernel: EFLAGS: 00010286
Feb 16 16:08:28 incident kernel: EIP is at proc_pid_stat+0xa8/0x53c
Feb 16 16:08:28 incident kernel: eax: 00000000   ebx: 02000000   ecx: f4971=
000   edx: c03e6330
Feb 16 16:08:28 incident kernel: esi: e9b0d900   edi: c4c7c580   ebp: c3a58=
000   esp: c3a59e3c
Feb 16 16:08:28 incident kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 16:08:28 incident kernel: Process ps (pid: 7430, threadinfo=3Dc3a580=
00 task=3Dd56e52e0)
Feb 16 16:08:28 incident kernel: Stack: c4c7c580 ffffffff 00000008 c4c7c780=
 00000010 f1db65f0 f7f57858 c3a58000=20
Feb 16 16:08:28 incident kernel:        c3a58000 f1db6580 e3935006 c0179382=
 f1db6ef0 f7f570f8 c3a58000 c3a58000=20
Feb 16 16:08:28 incident kernel:        f1db6e80 f254f510 c017939b e9b0d900=
 f1db6e80 c3a59f70 f7ff4700 c3a59f00=20
Feb 16 16:08:28 incident kernel: Call Trace:
Feb 16 16:08:28 incident kernel:  [<c0179382>] pid_revalidate+0x28/0xd2
Feb 16 16:08:28 incident kernel:  [<c017939b>] pid_revalidate+0x41/0xd2
Feb 16 16:08:28 incident kernel:  [<c01655e6>] dput+0x22/0x21f
Feb 16 16:08:28 incident kernel:  [<c015cc36>] link_path_walk+0x61b/0x957
Feb 16 16:08:28 incident kernel:  [<c013741c>] buffered_rmqueue+0xc1/0x15a
Feb 16 16:08:28 incident kernel:  [<c0137559>] __alloc_pages+0xa4/0x342
Feb 16 16:08:28 incident kernel:  [<c01787e2>] proc_info_read+0x74/0x155
Feb 16 16:08:28 incident kernel:  [<c014e115>] filp_open+0x67/0x69
Feb 16 16:08:28 incident kernel:  [<c014ee92>] vfs_read+0xbc/0x127
Feb 16 16:08:28 incident kernel:  [<c014f11d>] sys_read+0x42/0x63
Feb 16 16:08:28 incident kernel:  [<c0108f9d>] sysenter_past_esp+0x52/0x71

	Dominik

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAMymrZ8MDCHJbN8YRAgP5AJ9UlsxQyC5qZKuOYOxL1hFNfd9AVwCeN3tw
BVrK23+whOLI54asP+0O8BM=
=13Ny
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
