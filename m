Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRJZSAu>; Fri, 26 Oct 2001 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRJZSAb>; Fri, 26 Oct 2001 14:00:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7144 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278815AbRJZSAP>; Fri, 26 Oct 2001 14:00:15 -0400
Date: Fri, 26 Oct 2001 19:00:48 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Dave Garry <daveg@firsdown.demon.co.uk>
Cc: junio@siamese.dhis.twinsun.com, bill davidsen <davidsen@tmr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011026190048.D7544@redhat.com>
In-Reply-To: <20011024230917.H7544@redhat.com> <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com> <20011025165226.T7544@redhat.com> <7vofmuu9d7.fsf@siamese.dhis.twinsun.com> <20011026104125.Z7544@redhat.com> <3BD9647A.B6244D05@firsdown.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yprSwhkmOQmTTEHC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD9647A.B6244D05@firsdown.demon.co.uk>; from daveg@firsdown.demon.co.uk on Fri, Oct 26, 2001 at 02:26:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yprSwhkmOQmTTEHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2001 at 02:26:18PM +0100, Dave Garry wrote:

> I'm now running 2.4.14-pre2, still had difficulty applying
> the patch, and ended up patching parport_pc.c by hand. (?)

I made the patch against 2.4.14-pre2.  Works for me:

[tim@cyberelk linux]$ patch -p1 < /tmp/linux-irq.patch
patching file drivers/parport/ChangeLog
patching file drivers/parport/parport_pc.c
[tim@cyberelk linux]$ grep SUBLEVEL Makefile | head -1
SUBLEVEL =3D 14

> However, loading the parport_pc module, with NO arguments,
> like I was doing up till 2.4.10, and it still does not
> recognise the port as being in ECP mode:

As I think I've explained: without an IRQ to use, the current
implementation can't use the FIFO, and so won't use hardware
assistance for ECP mode.

By default, parport_pc doesn't use _any_ interrupts, due to the likely
conflicts it would cause (ISA soundcards, etc.).

> [root@p450 /root]# modprobe parport_pc
> [root@p450 /root]# dmesg -c
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected

So IRQ 7 is detected after you've applied the patch, whereas before it
wasn't at all.  The patch works.  'ECP' is not listed in brackets
because hardware assistance won't be used.

> If I load the module WITH arguments, something I've never
> had to do in the past, it works:
>=20
> [root@p450 /root]# modprobe parport_pc io=3D0x378 irq=3D7

Just use 'irq=3Dauto'.  Now that the IRQ probing is fixed again, this
will work.

> I'm still unsure why I NEED to supply arguments to this module.

The short answer is that you shouldn't have to.  If I remember
correctly, you just want VMware to work.  VMware doesn't go through
the kernel to access the port, it just writes the registers directly.
But it asks the kernel what modes it is prepared to use.  This is
something that needs to be fixed in VMware really: if it isn't going
to use the kernel for port access, it shouldn't care what modes the
kernel would use if it did.

If VMware is going to write to the ports directly, it should do its
own probing of the port hardware.

This policy isn't one of just being obstinate: the old behaviour was a
bug, and differed from what parport.txt had to say about the matter.
Not only that, but in order for ECP-mode printing to work properly the
fixed behaviour is a necessity. (Otherwise we'd use ECP mode on
ECP-able printers even when it was slower to do so!)

Thanks for testing the patch.  Hopefully when the PnPBIOS support is
fully tested we'll be able to use whatever interrupts we find, rather
than playing as safe as we do currently.

Tim.
*/

--yprSwhkmOQmTTEHC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72aTQyaXy9qA00+cRAhTMAJ9cEWW3Fiyck56DmF6XFiK6ieTvRACeL5F5
M0EPsn99lDdVMUJzlj/qwYA=
=0sYk
-----END PGP SIGNATURE-----

--yprSwhkmOQmTTEHC--
