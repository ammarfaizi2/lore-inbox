Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTB0Jfz>; Thu, 27 Feb 2003 04:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTB0Jfz>; Thu, 27 Feb 2003 04:35:55 -0500
Received: from daimi.au.dk ([130.225.16.1]:32194 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262452AbTB0Jfx>;
	Thu, 27 Feb 2003 04:35:53 -0500
Message-ID: <3E5DDE5A.1BCD0747@daimi.au.dk>
Date: Thu, 27 Feb 2003 10:46:02 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
		<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<3E5DB2CA.32539D41@daimi.au.dk>
		<buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp>
		<3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> 
> Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > Yes.  On some systems, /var and /tmp are the _only_ read-write filesystems.
> >
> > OK, but then on such a system with my approach it would be possible to
> > make /mtab.d a symlink pointing to somewhere under /var.
> 
> ... you could do the same with /etc/mtab.

No.

1) mtab being a symlink is interpreted differently by mount. You
   need to symlink the directory containing mtab, not mtab itself.
2) Some people might want /etc to be mounted from a different
   filesystem.

My first change was to use /etc/mtab.d/mtab, and that works fine
as long as /etc is on the root filesystem.

> 
> In fact since /etc is almost guaranteed to be on the same filesystem as
> /, it seems like "/mtab.d" offers zero advantages over just /etc/mtab --
> the case where /etc/mtab is the most annoying is when /etc is R/O, but
> this almost always means that / will be R/O, making /mtab.d useless too.

If /etc is in fact on the root, then /etc/mtab.d/mtab will work
as well as /mtab.d/mtab. But /etc/mtab does have a disadvantage
because I cannot symlink it to a different location. All I want
is the possibility to place a symlink pointing to the most
desired location for the particular system. So the symlink itself
must be guaranteed to be on the root. Is there any directory
beyond / which we can be sure is on the root filesystem?
Introducing problems just because you don't want to look at the
entry in the root seems like a bad idea to me. I think we need a
location that is guaranteed to be on the root filesystem, which
could be the root itself, if it needs to.

But perhaps we should then say that we require /etc to be on the
root filesystem. Since people are going to need a lot of hacks
anyway if they want their /etc elsewhere. In that case I just
propose we move mtab into a subdirectory, because then that
subdirectory can be replaced by a symlink if anybody desires to.
And the symlink itself can be considered a configuration option
specifying the location of mtab, and as such does belong in /etc.

> 
> > But AFAIK fsck uses mtab.
> 
> It uses /etc/fstab.

[kasperd:pts/0:~] grep /etc/mtab /sbin/fsck*
Binary file /sbin/fsck.ext2 matches
Binary file /sbin/fsck.ext3 matches
Binary file /sbin/fsck.minix matches
[kasperd:pts/0:~] 

> 
> > If mtab does not exist mount will attempt to create a new one with
> > only the root listed.
> 
> Unless you use the `-n' flag, which an init-script should do if it
> knows there's something wierd required to get /var mounted or something.

Of course the -n flag can be used to some extent, but that
doesn't solve all our problems. Current rc.sysinit
implementations does use -n to mount a few filesystems, and
later uses -f to initialize the mtab. But all that happens
before running fsck, so if /var is mounted that early, we
are going to fsck it mounted.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
