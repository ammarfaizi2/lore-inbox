Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSKDU3z>; Mon, 4 Nov 2002 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSKDU3z>; Mon, 4 Nov 2002 15:29:55 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56974
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262743AbSKDU3x>; Mon, 4 Nov 2002 15:29:53 -0500
Message-ID: <3DC6DA2B.8060903@redhat.com>
Date: Mon, 04 Nov 2002 12:35:55 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021102
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
References: <87y98bxygd.fsf@goat.bogus.local>	<Pine.LNX.4.44.0211021754180.2300-100000@home.transmeta.com>	<20021104024910.GA14849@ravel.coda.cs.cmu.edu> 	<20021104145049.GC9197@think.thunk.org> <1036424005.1113.73.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1036424005.1113.73.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox wrote:

> execve /proc/self/fd/n ???

Inspired by this and because Alan of course cannot be wrong about
something as simple as this I went on and implemented it.  Just to jind
that it's not working properly.  Try this:


$ echo -e "#! /bin/sh\necho u1" > u1
$ chmod +x u1
$ echo -e "#! /bin/sh\necho u2" > u2
$ chmod +x u2
$ cat u.c
int
main()
{
  system ("cp -f u1 uu");
  int fd = open ("./uu", 0);
  char buf[100];
  sprintf (buf, "/proc/self/fd/%d", fd);
  char buf2[100];
  int n = readlink (buf, buf2, sizeof (buf2));
  buf2[n] = '\0';
  system ("cp -f u2 uu");
  execl (buf, buf2, "hallo", 0);
  return 0;
}
$ gcc -c o u u.c
$ ./u


You should see 'u2' as the result.  But this is exactly what the fexecve
call is supposed to prevent.  The file, once opened, should be reused.
The expected result is 'u1'.

The problem is, as you can see from the readlink call in strace's
output, that /proc/self/fd/XXX is used as a symlink in the execve call.
 The symlink of course refers to 'u2'.

And thinking back, I did try to write fexecve like this back when...

Anyway, any solution to this is welcome since the missing fexecve is
regularly asked for.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9xtor2ijCOnn/RHQRAgHQAJ9YsYVnX9rKVYf9Rzy4fgUx5195pgCghnXC
b5ZIJ1+vivZ2pWTmLxdrXtc=
=vJwO
-----END PGP SIGNATURE-----

