Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUHMMl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUHMMl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUHMMl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:41:28 -0400
Received: from mout0.freenet.de ([194.97.50.131]:42465 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S265091AbUHMMlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:41:05 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC, PATCH] sys_revoke(), just a try. (was: Re: dynamic /dev security hole?)
Date: Fri, 13 Aug 2004 14:39:11 +0200
User-Agent: KMail/1.6.2
References: <20040808162115.GA7597@kroah.com> <200408121849.20227.mbuesch@freenet.de> <1092340279.22362.6.camel@localhost.localdomain>
In-Reply-To: <1092340279.22362.6.camel@localhost.localdomain>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Eric Lammerts <eric@lammerts.org>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408131439.19704.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Iau, 2004-08-12 at 17:49, Michael Buesch wrote:
> > +static ssize_t revoke_read(struct file *filp,
> > +			   char *buf,
> > +			   size_t count,
> > +			   loff_t *ppos)
> > +{
> > +	return 0;
> > +}
> 
> -EIO I think but I'm not sure I remember the BSD behaviour in full

[SNIP]
REVOKE(2)                 OpenBSD Programmer's Manual                REVOKE(2)

NAME
     revoke - revoke file access

SYNOPSIS
     #include <unistd.h>

     int
     revoke(const char *path);

DESCRIPTION
     The revoke function invalidates all current open file descriptors in the
     system for the file named by path. Subsequent operations on any such de-
     scriptors fail, with the exceptions that a read() from a character device
     file which has been revoked returns a count of zero (end of file), and a
     close() call will succeed.  If the file is a special file for a device
     which is open, the device close function is called as if all open refer-
     ences to the file had been close
[SNAP]

Means, that it returns different values for normal files and device
files? Do I understand that correctly?
- -EIO for files
0 for device nodes

> > +static int filp_revoke(struct file *filp, struct inode *inode)
> > +{
> 
> First problem here is that the handle might still be in use
> for mmap, so you'd need to undo mmaps on it. A second is that 

So I guess if we simply munmap them, programs will fail (will
segfault?). Or is it safe to munmap a mapping, while some
program is using it?

> while you can ->flush() here you can't really close it until the
> file usage count hits zero. 

Is it really required to close it in revoke? I mean, if we flush it,
no data remains unwritten to disk. The user program will call
close, later by itself.

> You are btw tackling a really really hard problem and its more likely

Yes, yes. I know. ;)

> the way to do this is to add revoke() methods to drivers and do it at
> the driver level - as the tty layer does with vhangup.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHLZ1FGK1OIvVOP4RAsXCAKCacyQvhemTY3CU47IwRBRxkBJYOwCguHq6
uKebhV87/GyDIJT5hk+0tbk=
=sIL3
-----END PGP SIGNATURE-----
