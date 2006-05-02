Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWEBG4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWEBG4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWEBG4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:56:53 -0400
Received: from h80ad2444.async.vt.edu ([128.173.36.68]:22490 "EHLO
	h80ad2444.async.vt.edu") by vger.kernel.org with ESMTP
	id S932415AbWEBG4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:56:52 -0400
Message-Id: <200605020656.k426uO7H002518@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue 
In-Reply-To: Your message of "Tue, 02 May 2006 01:56:37 +0200."
             <20060501235637.GB12543@MAIL.13thfloor.at> 
From: Valdis.Kletnieks@vt.edu
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu> <20060501143344.3952ff53.akpm@osdl.org>
            <20060501235637.GB12543@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146552983_2571P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 02:56:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146552983_2571P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 May 2006 01:56:37 +0200, Herbert Poetzl said:
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08

> first, what do we expect from --bind mounts regarding
> vfs (mount) level flags like noatime, noexec, nodev?
> 
>  - should they be propagated from the original mfs/mount?

I tripped over this apparent regression when I hit a problem with some code
that expected this behavior.  Given the documented behavior of the mount syscall
(see below), apparently propagating all flags intact and clearing all
flags are the only 2 options that don't break the documented API.

>  - should they only restrict the original set?
>  - should they allow to modify the existing flags?

Well, absent a '-o newflags' to modify it, propagating the originals
probably follows the Principle of Least Surprise.   And whether mountflags
are permissible is an API change issue...

> IMHO, it makes perfect sense to mount something noatime
> and change that rule later for a subtree like this:
> 
>  mkdir /foo
>  mount -t tmpfs -o rw,noatime none /foo
>  mkdir /foo/bar
>  mount --bind -o atime /foo/bar /foo/bar

Here, there's a -o parameter being passed.

> second, has the kernel to decide what flags userspace
> can request and/or change, depending on the original?

Can of worms, too complicated for 3AM. :)

> and finally, how to handle --rbind mounts at a level
> deeper than the top?

More worms. ;)

Note that any provision for changing the mountflags *IS* a break of
the documented API.  'man 2 mount' says specifically:

       MS_BIND
              (Linux 2.4 onwards) Perform a bind mount, making  a  file  or  a
              directory subtree visible at another point within a file system.
              Bind mounts may cross file system boundaries and span  chroot(2)
              jails.   The  filesystemtype, mountflags, and data arguments are
              ignored.

I admit not knowing that whether POSIX or other standards specify that
mountflags be ignored.

--==_Exmh_1146552983_2571P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVwKXcC3lWbTT17ARAtaZAKC9h7a4lD+Bfvz45Inu2E8R4fkPCACcDs6V
463WZUH+m6tNM/r24y+Mf8M=
=kqRN
-----END PGP SIGNATURE-----

--==_Exmh_1146552983_2571P--
