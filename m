Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319339AbSIFS6A>; Fri, 6 Sep 2002 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319338AbSIFS57>; Fri, 6 Sep 2002 14:57:59 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:63728 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S319339AbSIFS55>;
	Fri, 6 Sep 2002 14:57:57 -0400
Date: Fri, 6 Sep 2002 21:02:30 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: ext3 corruption on 2.4.18 (LVM, vt82c586b, no DMA)
Message-ID: <20020906190230.GB7560@gintaras>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20020904102605.GB8576@gintaras> <20020906183415.B7946@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20020906183415.B7946@redhat.com>
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://ice.dammit.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2002 at 06:34:15PM +0100, Stephen C. Tweedie wrote:
> On Wed, Sep 04, 2002 at 12:26:06PM +0200, Marius Gedminas wrote:
> > There's an old Compaq Deskpro 2000 (Pentium MMX 166 MHz, 384M RAM)
> > that's being used as an Internet gateway (NAT) and FTP server for about
> > 200 users.  It was previously running that other operating system, and I
> > helped convert it to Linux (Debian 3.0).
>=20
> > About 20 hours after mke2fs the first erros started cropping up:
> >=20
> >   kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry i=
n directory #8568833: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1104134607,=
 rec_len=3D16847, name_len=3D207
>=20
> Well, there are a couple of ext3 fixes that have just been merged into
> Marcelo's bk tree, so you could try that and see if it helps.
> However, I suspect it won't, because:
>=20
> > Unfortunately I noticed this only two days later.

(Now all partitions are mounted with errors=3Dremount-ro.  I didn't know
that wasn't the default.)

> > e2fsck found *lots*
> > of errors, and it keeps restarting from the beginning for some reason.
> > I'm starting to have doubts if it will ever finish.
>=20
> This suggests that e2fsck is finding new corruption each time it is
> scanning the disk.  That sounds as if a hardware or driver-level
> problem is more likely.  What sorts of errors are you getting from the
> fsck passes?

Mostly "Inode XXX is in use, but has dtime set", some "Inode XXX has
compression flag set on filesystem without compression support", a
couple of "Inode XXX has illegal block(s)", which are followed by "Too
many illegal blocks in inode XXX" (AFAIU that forces the restart of pass
1).

I have a full typescript (1.4M) if you're interested.  The different
iterations of pass 1 are very similair but there are also differenctes.
I got tired after five iterations and just mkfs'ed it again.

This is starting to look more and more like a hardware problem.  The
next day I suddenly noticed that / and /var (both on /dev/hda) were
remounted read-only, probably because of errors.  That 140G LVM
partition was still rw.  An ls or grep would fail in any directory, but
some of the files could be accessed by their full path.  Trying to
access other files (even files in /proc) would result in I/O or Bus
error.  Actually, I'm only 90% sure about /proc -- could be it was
/usr/bin/less that was unreadable.  I was a bit excited at the time.
But I usually cat things in /proc, and I clearly remember that I could
successfully cat some files in /etc.

A reboot helped, but the syslog contained nothing interesting.  I ran
memtest for at least 20 hours -- it found no errors.  I think I already
mentioned that read-only badblock scan also found nothing.

BTW both /, /var and about 20GB part of LVM are on /dev/hda, which is an
40G IBM drive.  It might be pure superstition, but the words "IBM hard
drive" do not inspire much confidence to me.

> > Is this an unfortunate interaction between ext3 and LVM, or should I
> > suspect flaky hardware?  RAM, disks, IDE cable?  There were problems
> > with /dev/hdd earlier that hinted a broken cable (borken model name in
> > hdparm -i), and the cable was replaced with a new one.
>=20
> One thing that would help would be to try a surface scan which writes
> stuff to the disk and verifies it.  The "badblocks" code from e2fsck
> can do that, but the most effective form of "badblocks" for such a
> case is highly destructive to your data, so it's only useful if you
> don't need to preserve the data already on the filesystem.

It might be difficult to arrange at the moment, but I'll keep it in mind.

> > I gather from Configure.help that DMA is broken on Via VP2, but it is
> > turned off here.
>=20
> Unfortunately, if you disable UDMA mode, you also lose the checksums
> between drive and controller which can detect cable data corruption.

Ah, that's good to know.  Is there a kernel tree that supports DMA on
VP2?  I think I heard somewhere that the new IDE code did that, but I
wasn't paying much attention to its fate lately.

Thanks,
Marius Gedminas
--=20
It's not illegal to disagree with my opinions (*).
[...]
(*) Although it obviously _should_ be. Mwhaahahahahaaa... You unbelievers
will all be shot when the revolution comes!
		-- Linus Torvalds

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9ePvGkVdEXeem148RAsqVAJ4qzM3rNNVi5cOwGrKdpLeyh/tTUACfdz+z
7eRXLum2LEqlxEy9ps+eyjY=
=95aa
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
