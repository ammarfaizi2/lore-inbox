Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJGBhS>; Sun, 6 Oct 2002 21:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262304AbSJGBhS>; Sun, 6 Oct 2002 21:37:18 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:23983 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262302AbSJGBhQ>; Sun, 6 Oct 2002 21:37:16 -0400
Date: Sun, 6 Oct 2002 20:42:26 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       gareth@nvidia.com
Subject: Re: nvidia 2.5.40+ patch?
Message-ID: <20021007014225.GC894@draal.physics.wisc.edu>
References: <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006203142.GD10884@draal.physics.wisc.edu> <3DA0A1C1.1080700@drugphish.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <3DA0A1C1.1080700@drugphish.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Roberto Nibali [ratz@drugphish.ch] wrote:
> >Someone posted it to lkml, but here is mine:
>=20
> Hmm, oversaw it, sometimes I read lkml with the delete button ...
>=20
> Looks more like one of the recent spinlock fixes in the ALSA tree fixes=
=20
> this.
>=20
> Could you try following things for me:
> o apply=20
> http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/cset-1.663.1.1=
-to-1.752.txt.gz
> o test it and see if it still oops
> o test it and see if it oops without the NVdriver loaded
> o disable preemtible kernels
> o compile the kernel with stack frame pointer support

I applied these patches (I did not disable preempt, and how do you
enable stack frame pointer support?), and there are 2 oopses in bootup:

ct  6 20:06:07 localhost kernel: 8139too Fast Ethernet driver 0.9.26
Oct  6 20:06:07 localhost kernel: Call Trace: [<c01387ca>]  [<c0213e05>]  [=
<c0213e97>]  [<c0225fd9>]  [<c022d9d0>]  [<c022620e>]  [<c022dd80>]  [<c022=
6678>]  [<c0225ec4>]  [<c0235530>]  [<c02251f6>]  [<c010507a>]  [<c0105040>=
]  [<c0105625>]=20
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01387ca <slabinfo_write+32a/6c0>
Trace; c0213e05 <blk_cleanup_queue+105/180>
Trace; c0213e97 <blk_init_queue+17/2c0>
Trace; c0225fd9 <save_match+c9/130>
Trace; c022d9d0 <do_ide_request+0/30>
Trace; c022620e <init_irq+1ce/560>
Trace; c022dd80 <ide_intr+0/180>
Trace; c0226678 <hwif_init+d8/260>
Trace; c0225ec4 <probe_hwif_init+24/70>
Trace; c0235530 <ide_setup_pci_device+50/80>
Trace; c02251f6 <generic_mii_ioctl+1286/1c70>
Trace; c010507a <stext+7a/1e0>
Trace; c0105040 <stext+40/1e0>
Trace; c0105625 <show_regs+165/170>

Oct  6 20:06:07 localhost kernel: Call Trace: [<c0252cb2>]  [<c0115ac2>]  [=
<c011c8b4>]  [<c0253035>]  [<c0115c66>]  [<c0115c80>]  [<c0253000>]  [<c010=
5625>]=20
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0252cb2 <usb_hub_port_disable+482/8c0>
Trace; c0115ac2 <schedule+192/300>
Trace; c011c8b4 <reparent_to_init+e4/180>
Trace; c0253035 <usb_hub_port_disable+805/8c0>
Trace; c0115c66 <preempt_schedule+36/50>
Trace; c0115c80 <default_wake_function+0/a0>
Trace; c0253000 <usb_hub_port_disable+7d0/8c0>
Trace; c0105625 <show_regs+165/170>

Sound plays fine with no oopses.  Looks like the ALSA oopses were fixed.
(Coincidentally, there's a lot more stuff in alsamixer for my i810_audio)

However I cannot get the nvidia driver to compile with Chris' patch:
(0)<mcelrath@navi:/usr/src/NVIDIA_kernel-1.0-3123.cw> sudo insmod ./NVdrive=
r=20
=2E/NVdriver: unresolved symbol create_workqueue
=2E/NVdriver: unresolved symbol destroy_workqueue
=2E/NVdriver: unresolved symbol flush_workqueue
=2E/NVdriver: unresolved symbol queue_work
=2E/NVdriver:=20

Now, I've had this problem off and on.  I have symbol versioning disabled
because of it.  If I look in my System.map the symbols are clearly there:
(1)<mcelrath@navi:/usr/src/NVIDIA_kernel-1.0-3123.cw> grep create_workqueue=
 /usr/src/linux/System.map=20
c01293d0 T create_workqueue
c035c844 R __kstrtab_create_workqueue
c0367148 R __ksymtab_create_workqueue

What could cause this?  I have modutils 2.4.18, gcc 3.2 (redhat 8.0
3.2-7), and binutils 2.13.90.0.2 (redhat 8.0).  But I have seen this
happen with many different kinds of modules, many kernel versions, and
any compilers (gcc 2.96 -> 3.2).  What is going on?

> >It doesn't look like these messages have anything to do with the nvidia
> >driver, but does "scheduling while atomic" imply that the nvidia driver
> >might be leaving the kernel in a bad state, such that the next time
> >schedule() is called it complains?  (and thus, no nvidia code is in the
> >call chain...)
>=20
> I don't know yet. One thing I suspect since a long time is the AGP=20
> memory mapping and this remap_page_range usage.
>=20
> >Well, maybe they will see this:
> >    http://www.nvnews.net/vbulletin/showthread.php?s=3D&postid=3D25239#p=
ost25239
>=20
> Oh, didn't know there was a community out there :)

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2g5oEACgkQjwioWRGe9K1J1wCg69v4Xa23R9FWXeQfj2kxBTZM
lnAAn1kdvoF5HXL7FZWA7xmu6NYCSJWA
=grwj
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
