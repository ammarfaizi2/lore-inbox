Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUJGNkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUJGNkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJGNjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:39:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47046 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269508AbUJGNiQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:38:16 -0400
Message-Id: <200410070551.i975pJvx010290@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable 
In-Reply-To: Your message of "Wed, 06 Oct 2004 21:29:44 BST."
             <1097094582.29866.15.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041005212712.I6910@flint.arm.linux.org.uk> <20041005210659.GA5276@kroah.com> <20041005221333.L6910@flint.arm.linux.org.uk> <1097074822.29251.51.camel@localhost.localdomain> <20041006174108.GA26797@kroah.com> <1097090333.29706.4.camel@localhost.localdomain> <20041006205417.GA25437@kroah.com>
            <1097094582.29866.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1503122430P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 01:51:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1503122430P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <24804.1097128278.1@turing-police.cc.vt.edu>

On Wed, 06 Oct 2004 21:29:44 BST, Alan Cox said:
> On Mer, 2004-10-06 at 21:54, Greg KH wrote:
> > Ok, then anyone with some serious bash-foo care to send me a patch for
> > the existing /sbin/hotplug file that causes it to handle this properly?

Greg - Unless you're willing to trust that /dev/ is in something of a sane
state (basically, you're willing to take a leap of faith that /dev/console
and/or /dev/null exist and are references to character devices with the
correct major,minor pair, it's a somewhat doomed quest.

> Something like
> 
> #!/bin/sh
> (
> Everything you had before
> ) <>/dev/console 2>&1

That should be '< /dev/console > /dev/console 2>&1' - what you have will open
fd0 on /dev/console for read/write, then point fd2 at wherever fd1 happened to
be pointing.  And even that version isn't totally correct - the man page for sh
specifically says: "A failure to open or create a file causes the redirection
to fail."  So if /dev/console is borked due to a bad console= kernel
boot parameter, we'll *still* be flying along with a borked stderr.

A *slightly* better version would be:

#!/bin/sh
# First, check if it's even there - we could mknod it but it's
# not safe if /dev is totally scrogged or on a R/O filesystem.
if [ ! -c /dev/console ]; then
  exit 999
  # not-really-safe mknod magic
  if [ -e /dev/console ]; then
    /bin/rm -f /dev/console
  fi
  /sbin/mknod /dev/console c 5 1
  # end not-really-safe code
fi
# Next, try redirecting each of 0,1,2 to /dev/console - if
# we redirect and fail, try to use /dev/null instead.
exec < /dev/console
if [ ! /dev/fd/0 -ef /dev/console ]; then
    exec < /dev/null
    if [ ! /dev/fd/0 -ef /dev/null ]; then
        exit 998;
    fi
fi
exec > /dev/console
if [ ! /dev/fd/1 -ef /dev/console ]; then
    exec > /dev/null
    if [ ! /dev/fd/1 -ef /dev/null ]; then
         exit 998;
    fi
fi
exec 2> /dev/console
if [ ! /dev/fd/2 -ef /dev/console ]; then
    exec 2> /dev/null
    if [ ! /dev/fd/2 -ef /dev/null ]; then
        exit 998
    fi
fi
# Everything you had before

This would be a lot shorter as:

for filedesc in 0 1 2; do
  exec $filedesc<> /dev/console
  if [ ! /dev/fd/$filedesc -ef /dev/console ]; then
    exec $filedesc> /dev/null
    if [ ! /dev/fd/$filedesc -ef /dev/null ]; then
      exit 998
    fi
  fi
done

But that leaves fd 0-2 in read/write rather than unidirectional.

The reason the rm/mknod isn't really safe is because if either of them
generate an error message, they'll go wherever fd2 is pointing (which is
the problem we're trying to solve, and a major bootstrap problem).

Note that this *still* assumes that at least one of /dev/console or /dev/null
is sane enough to use - if /dev/console won't open (due to a borked 'console='
on the boot line, or whatever), and /dev/null is on a R/O filesystem and has
gotten mangled and is now a regular file, you're still screwed....


--==_Exmh_1503122430P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZNlXcC3lWbTT17ARAh11AKDm1SNLLdpA6E0ikBUChu59OoH8TQCfUGHq
p06bfB1WUGtfRQ9x+r03xmc=
=N76E
-----END PGP SIGNATURE-----

--==_Exmh_1503122430P--
