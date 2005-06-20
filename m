Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFTQlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFTQlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFTQlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:41:19 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50441 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261313AbVFTQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:40:00 -0400
Message-Id: <200506201639.j5KGdoNO016276@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Paradise <paradyse@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Debian Users List <debian-user@lists.debian.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 cannot build nvidia driver? 
In-Reply-To: Your message of "Mon, 20 Jun 2005 20:20:06 +0800."
             <f2176eb805062005201c96510a@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <f2176eb805062004557fc7b9ac@mail.gmail.com>
            <f2176eb805062005201c96510a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119285589_14097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Jun 2005 12:39:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119285589_14097P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <16261.1119285587.1@turing-police.cc.vt.edu>

On Mon, 20 Jun 2005 20:20:06 +0800, Paradise said:
> seems un/register_ioctl32_conversion is removed from 2.6.12-mm1..
> any patch for nvidia kernel driver?

No patch, but some hints - I suspect the problem is a local build config error...

1) The exact patch causing your problem in -mm1 is:
remove-register_ioctl32_conversion-and-unregister_ioctl32_conversion.patch

Building with this one patch -R'ed out should help, but it's the wrong thing
to do, as it only papers over the real problem, which is:

2) Your failing code is in os-interface.c:

void NV_API_CALL os_unregister_ioctl32_conversion(U032 cmd, U032 size)
{
#if defined(NVCPU_X86_64) && defined(CONFIG_IA32_EMULATION) && !defined(HAVE_COMPAT_IOCTL)
    unsigned int request = _IOWR(NV_IOCTL_MAGIC, cmd, char[size]);
    unregister_ioctl32_conversion(request);
#endif
}

Might want to figure out why HAVE_COMPAT_IOCTL isn't defined - there's at least
3 other places where it matters (in nv.c).  It's #defined in the include/linux/fs.h
header in 2.6.12-rc6-mm1, so you probably want to figure out why your build isn't
picking up on it.  Are your #include directories screwed up?

Sorry I can't provide more help, this looks like an X86-64 only issue.  If this
isnt enough, take it up on the NVidia forums:

http://www.nvnews.net/vbulletin/forumdisplay.php?s=&forumid=14



--==_Exmh_1119285589_14097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCtvFVcC3lWbTT17ARArdDAKCEvVcz3Rh2p1zQ6KWXZRUBvkakpgCfeMqA
zN7tmhteSkkvdqRqZ024H20=
=GNQG
-----END PGP SIGNATURE-----

--==_Exmh_1119285589_14097P--
