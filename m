Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbSI3IFQ>; Mon, 30 Sep 2002 04:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSI3IFQ>; Mon, 30 Sep 2002 04:05:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29969 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261970AbSI3IFO>; Mon, 30 Sep 2002 04:05:14 -0400
Message-Id: <200209300804.g8U84ip18330@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Date: Mon, 30 Sep 2002 10:58:47 -0200
X-Mailer: KMail [version 1.3.2]
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua> <20020927140302.B13401@flint.arm.linux.org.uk> 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is slightly offtopic, but since this issue cropped up
when I tried to build 2.5 on a box which builds 2.4
just fine I post it here. BTW, if someone knows
GCC mailing list addr to send this, please let me know it.

[a story about 2.5 kernel not finding stdarg.h snipped]

> > > I will try, but it seems to be right behavior - we tell gcc
> > > to NOT use standard include places and it does exactly this.
> > > So it's not a bug.
> >
> > No.  You missed it.
> >
> > gcc -nostdic
> >     ^^^^^^^^ don't use standard includse
> >    -iwithprefix include
> >    ^^^^^^^^^^^^^^^^^^^^ but use the specified include path, built out of
> > the gcc installation prefix, /usr/lib/gcc-lib/<target>/<version>/
>
> aha! my gcc internally adds
> -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
> Dunno where it took this strange idea... I have no such
> dir. Anyway, I'll fix my gcc installation.

On 27 September 2002 12:05, Daniel Jacobowitz wrote:
> > gcc version 3.0.3
> >  /usr/lib/gcc-lib/i686-pc-linux-gnu/3.0.3/cpp0 -lang-c -nostdinc -v
>
> That's not the problem.
>
> > -I/usr/src/linux-2.5.36/include
> > -iprefix /usr/sbin/../../lib/gcc-lib/i686-pc-linux-gnu/3.0.3/
>
> That's the problem.  Where's the -iprefix coming from?   Your configure
> doesn't specify /usr/sbin anywhere.

Heh. I believe that my GCC installation is okay, but slightly unusual:

/usr/bin/gcc is a symlink: -> /usr/app/gcc3.0.3posix/bin/gcc
/usr/app/gcc -> /usr/app/gcc3.0.3posix
/usr/sbin -> /usr/bin
PATH=/home/vda/bin:/sbin:/usr/sbin:/bin:/usr/bin

so when I run gcc it actually runs /usr/sbin/gcc. Am I weird? ;)

GCC developers did not expect it and when GCC tries to internally
add -iprefix to the commandline it looks for $GCC_EXEC_PREFIX
in environment and, failing that, takes gcc startup path
as a base. That's where /usr/sbin came into gcc commandline.

This is IMHO wrong. Most other programs hardcode their installation paths
as directed at configure time (still not good, you cannot move installed 
binaries without breaking things) or have small $PACKAGE-config script
which spits out paths to the stdio (I like this!).
I have 38 *-config* files in my /usr/bin so I think it is an accepted
practice.

When I built GCC (a while ago) I hoped it will take at least route of
hardcoding paths and ./configured it this way:
Configured with: ../gcc-3.0.3/configure
--prefix=/usr/app/gcc-3.0.3posix
--exec-prefix=/usr/app/gcc-3.0.3posix
--bindir=/usr/app/gcc-3.0.3posix/bin
--libdir=/usr/lib
--infodir=/usr/app/gcc-3.0.3posix/info
--mandir=/usr/app/gcc-3.0.3posix/man
--with-slibdir=/usr/lib
--with-local-prefix=/usr/local
--with-gxx-include-dir=/usr/include/g++-v3
--enable-threads=posix
but as it turns out this is not enough.

For time being I run kernel make like this:

GCC_EXEC_PREFIX=/usr/app/gcc/lib/gcc-lib/ make ... ... ...

BTW, here is gcc.c source snippet which sets up -iprefix:
=========================================================
  /* Set up the default search paths.  If there is no GCC_EXEC_PREFIX,
     see if we can create it from the pathname specified in argv[0].  */

#ifndef VMS
  /* FIXME: make_relative_prefix doesn't yet work for VMS.  */
  if (!gcc_exec_prefix)
    {
      gcc_exec_prefix = make_relative_prefix (argv[0], standard_bindir_prefix,
					      standard_exec_prefix);
      //printf("vda: gcc_exec_prefix 2:%s\n",gcc_exec_prefix);
					      
      if (gcc_exec_prefix)
	putenv (concat ("GCC_EXEC_PREFIX=", gcc_exec_prefix, NULL_PTR));
    }
#endif

  if (gcc_exec_prefix)
    {
      int len = strlen (gcc_exec_prefix);

      if (len > (int) sizeof ("/lib/gcc-lib/") - 1
	  && (IS_DIR_SEPARATOR (gcc_exec_prefix[len-1])))
	{
	  temp = gcc_exec_prefix + len - sizeof ("/lib/gcc-lib/") + 1;
	  if (IS_DIR_SEPARATOR (*temp)
	      && strncmp (temp + 1, "lib", 3) == 0
	      && IS_DIR_SEPARATOR (temp[4])
	      && strncmp (temp + 5, "gcc-lib", 7) == 0)
	    len -= sizeof ("/lib/gcc-lib/") - 1;
	}

      set_std_prefix (gcc_exec_prefix, len);
      add_prefix (&exec_prefixes, gcc_exec_prefix, "GCC",
		  PREFIX_PRIORITY_LAST, 0, NULL_PTR);
      add_prefix (&startfile_prefixes, gcc_exec_prefix, "GCC",
		  PREFIX_PRIORITY_LAST, 0, NULL_PTR);
    }
--
vda
