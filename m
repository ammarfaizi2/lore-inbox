Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTB1HT2>; Fri, 28 Feb 2003 02:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTB1HT2>; Fri, 28 Feb 2003 02:19:28 -0500
Received: from [213.69.232.58] ([213.69.232.58]:24328 "HELO schottelius.net")
	by vger.kernel.org with SMTP id <S267547AbTB1HTW>;
	Fri, 28 Feb 2003 02:19:22 -0500
Date: Thu, 27 Feb 2003 18:34:19 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Andreas Jaeger <aj@suse.de>
Cc: gcc-bugs@gcc.gnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: configure error in gcc3.1,3.2
Message-ID: <20030227173419.GA4225@schottelius.org>
References: <20030227141034.GA7999@schottelius.org> <hobs0x23uq.fsf@byrd.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <hobs0x23uq.fsf@byrd.suse.de>
User-Agent: Mutt/1.4i
Grom: Nico Schottelius <schottelius@wdt.de>
X-Operating-System: Linux flapp 2.4.21-pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andreas, list,

> > checking for working mmap from /dev/zero...
> > nico@flapp:~/tar.gz/gcc-3.2.2 $=20
> >
> > this stays forever, i got to comment out the check in line 4273 with
> > the source code before. [gcc/configure]
> >
> > #if { (eval echo configure:4296: \"$ac_link\") 1>&5; (eval $ac_link) 2>=
&5; } && test -s conftest${ac_exeext} && (./conftest; exit) 2>/dev/null
> >
> > changed to=20
> >
> > if 0
> >
> > same goes with working mmap, i got to set if 0 there, too.
> > I am using Linux 2.5.[50-63] with devfs. Always the same problem.
>=20
> It looks like a bug in your system.  Please try without devfs - or
> with a 2.4 kernel,

tested it with 2.4.21pre3+devfs and it keeps on hanging again.
I can't test it with a non-devfs system, as I converted all system to devfs=
...

I am forwarding this message to lkml, perhaps Richard Gooch knows about
this problem or howto fix it.

Did no one else have this problem, too ?

Nico


p.s.: attached relevant parts of configure for lkml. [gcc-3.2.2/gcc/configu=
re]

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=configure-from-gcc
Content-Transfer-Encoding: quoted-printable

# The test program for the next two tests is the same except for one
# set of ifdefs.
cat >ct-mmap.inc <<'EOF'
#include <sys/types.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <signal.h>
#include <setjmp.h>
#include <stdio.h>

#if !defined (MAP_ANONYMOUS) && defined (MAP_ANON)
# define MAP_ANONYMOUS MAP_ANON
#endif

/* This mess was copied from the GNU getpagesize.h.  */
#ifndef HAVE_GETPAGESIZE
# ifdef HAVE_UNISTD_H
#  include <unistd.h>
# endif

/* Assume that all systems that can run configure have sys/param.h.  */
# ifndef HAVE_SYS_PARAM_H
#  define HAVE_SYS_PARAM_H 1
# endif

# ifdef _SC_PAGESIZE
#  define getpagesize() sysconf(_SC_PAGESIZE)
# else /* no _SC_PAGESIZE */
#  ifdef HAVE_SYS_PARAM_H
#   include <sys/param.h>
#   ifdef EXEC_PAGESIZE
#    define getpagesize() EXEC_PAGESIZE
#   else /* no EXEC_PAGESIZE */
#    ifdef NBPG
#     define getpagesize() NBPG * CLSIZE
#     ifndef CLSIZE
#      define CLSIZE 1
#     endif /* no CLSIZE */
#    else /* no NBPG */
#     ifdef NBPC
#      define getpagesize() NBPC
#     else /* no NBPC */
#      ifdef PAGESIZE
#       define getpagesize() PAGESIZE
#      endif /* PAGESIZE */
#     endif /* no NBPC */
#    endif /* no NBPG */
#   endif /* no EXEC_PAGESIZE */
#  else /* no HAVE_SYS_PARAM_H */
#   define getpagesize() 8192	/* punt totally */
#  endif /* no HAVE_SYS_PARAM_H */
# endif /* no _SC_PAGESIZE */

#endif /* no HAVE_GETPAGESIZE */

#ifndef MAP_FAILED
# define MAP_FAILED -1
#endif

#undef perror_exit
#define perror_exit(str, val) \
  do { perror(str); exit(val); } while (0)

/* Some versions of cygwin mmap require that munmap is called with the
   same parameters as mmap.  GCC expects that this is not the case.
   Test for various forms of this problem.  Warning - icky signal games.  */

static sigset_t unblock_sigsegv;
static jmp_buf r;
static size_t pg;
static int devzero;

static char *
anonmap (size)
     size_t size;
{
#ifdef USE_MAP_ANON
  return (char *) mmap (0, size, PROT_READ|PROT_WRITE,
			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
#else
  return (char *) mmap (0, size, PROT_READ|PROT_WRITE,
			MAP_PRIVATE, devzero, 0);
#endif
}

static void
sigsegv (unused)
     int unused;
{
  sigprocmask (SIG_UNBLOCK, &unblock_sigsegv, 0);
  longjmp (r, 1);
}

/* Basic functionality test.  */
void
test_0 ()
{
  char *x =3D anonmap (pg);
  if (x =3D=3D (char *) MAP_FAILED)
    perror_exit("test 0 mmap", 2);

  *(int *)x +=3D 1;

  if (munmap(x, pg) < 0)
    perror_exit("test 0 munmap", 3);
}

/* 1. If we map a 2-page region and unmap its second page, the first page
   must remain.  */
static void
test_1 ()
{
  char *x =3D anonmap (pg * 2);
  if (x =3D=3D (char *)MAP_FAILED)
    perror_exit ("test 1 mmap", 4);

  signal (SIGSEGV, sigsegv);
  if (setjmp (r))
    perror_exit ("test 1 fault", 5);

  x[0] =3D 1;
  x[pg] =3D 1;

  if (munmap (x + pg, pg) < 0)
    perror_exit ("test 1 munmap 1", 6);
  x[0] =3D 2;

  if (setjmp (r) =3D=3D 0)
    {
      x[pg] =3D 1;
      perror_exit ("test 1 no fault", 7);
    }
  if (munmap (x, pg) < 0)
    perror_exit ("test 1 munmap 2", 8);
}

/* 2. If we map a 2-page region and unmap its first page, the second
   page must remain.  */
static void
test_2 ()
{
  char *x =3D anonmap (pg * 2);
  if (x =3D=3D (char *)MAP_FAILED)
    perror_exit ("test 2 mmap", 9);

  signal (SIGSEGV, sigsegv);
  if (setjmp (r))
    perror_exit ("test 2 fault", 10);

  x[0] =3D 1;
  x[pg] =3D 1;

  if (munmap (x, pg) < 0)
    perror_exit ("test 2 munmap 1", 11);

  x[pg] =3D 2;

  if (setjmp (r) =3D=3D 0)
    {
      x[0] =3D 1;
      perror_exit ("test 2 no fault", 12);
    }

  if (munmap (x+pg, pg) < 0)
    perror_exit ("test 2 munmap 2", 13);
}

/* 3. If we map two adjacent 1-page regions and unmap them both with
   one munmap, both must go away.

   Getting two adjacent 1-page regions with two mmap calls is slightly
   tricky.  All OS's tested skip over already-allocated blocks; therefore
   we have been careful to unmap all allocated regions in previous tests.
   HP/UX allocates pages backward in memory.  No OS has yet been observed
   to be so perverse as to leave unmapped space between consecutive calls
   to mmap.  */

static void
test_3 ()
{
  char *x, *y, *z;

  x =3D anonmap (pg);
  if (x =3D=3D (char *)MAP_FAILED)
    perror_exit ("test 3 mmap 1", 14);
  y =3D anonmap (pg);
  if (y =3D=3D (char *)MAP_FAILED)
    perror_exit ("test 3 mmap 2", 15);

  if (y !=3D x + pg)
    {
      if (y =3D=3D x - pg)
	z =3D y, y =3D x, x =3D z;
      else
	{
	  fprintf (stderr, "test 3 nonconsecutive pages - %lx, %lx\n",
		   (unsigned long)x, (unsigned long)y);
	  exit (16);
	}
    }

  signal (SIGSEGV, sigsegv);
  if (setjmp (r))
    perror_exit ("test 3 fault", 17);

  x[0] =3D 1;
  y[0] =3D 1;

  if (munmap (x, pg*2) < 0)
    perror_exit ("test 3 munmap", 18);

  if (setjmp (r) =3D=3D 0)
    {
      x[0] =3D 1;
      perror_exit ("test 3 no fault 1", 19);
    }
 =20
  signal (SIGSEGV, sigsegv);
  if (setjmp (r) =3D=3D 0)
    {
      y[0] =3D 1;
      perror_exit ("test 3 no fault 2", 20);
    }
}

int
main ()
{
  sigemptyset (&unblock_sigsegv);
  sigaddset (&unblock_sigsegv, SIGSEGV);
  pg =3D getpagesize ();
#ifndef USE_MAP_ANON
  devzero =3D open ("/dev/zero", O_RDWR);
  if (devzero < 0)
    perror_exit ("open /dev/zero", 1);
#endif

  test_0();
  test_1();
  test_2();
  test_3();

  exit(0);
}
EOF

echo $ac_n "checking for working mmap from /dev/zero""... $ac_c" 1>&6
echo "configure:4276: checking for working mmap from /dev/zero" >&5
if eval "test \"`echo '$''{'ac_cv_func_mmap_dev_zero'+set}'`\" =3D set"; th=
en
  echo $ac_n "(cached) $ac_c" 1>&6
else
  if test "$cross_compiling" =3D yes; then
  # If this is not cygwin, and /dev/zero is a character device, it's probab=
ly
 # safe to assume it works.
 case "$host_os" in
   cygwin* | win32 | pe | mingw* ) ac_cv_func_mmap_dev_zero=3Dbuggy ;;
   * ) if test -c /dev/zero
       then ac_cv_func_mmap_dev_zero=3Dyes
       else ac_cv_func_mmap_dev_zero=3Dno
       fi ;;
  esac
else
  cat > conftest.$ac_ext <<EOF
#line 4292 "configure"
#include "confdefs.h"
#include "ct-mmap.inc"
EOF
if { (eval echo configure:4296: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; }=
 && test -s conftest${ac_exeext} && (./conftest; exit) 2>/dev/null
then
  ac_cv_func_mmap_dev_zero=3Dyes
else
  echo "configure: failed program was:" >&5
  cat conftest.$ac_ext >&5
  rm -fr conftest*
  if test $? -lt 4
 then ac_cv_func_mmap_dev_zero=3Dno
 else ac_cv_func_mmap_dev_zero=3Dbuggy
 fi
fi
rm -fr conftest*
fi


fi

echo "$ac_t""$ac_cv_func_mmap_dev_zero" 1>&6
if test $ac_cv_func_mmap_dev_zero =3D yes; then
  cat >> confdefs.h <<\EOF
#define HAVE_MMAP_DEV_ZERO 1
EOF

fi

echo $ac_n "checking for working mmap with MAP_ANON(YMOUS)""... $ac_c" 1>&6
echo "configure:4323: checking for working mmap with MAP_ANON(YMOUS)" >&5
if eval "test \"`echo '$''{'ac_cv_func_mmap_anon'+set}'`\" =3D set"; then
  echo $ac_n "(cached) $ac_c" 1>&6
else
  if test "$cross_compiling" =3D yes; then
  # Unlike /dev/zero, it is not safe to assume MAP_ANON(YMOUS) works
 # just because it's there. Some SCO Un*xen define it but don't implement i=
t.
 ac_cv_func_mmap_anon=3Dno
else
  cat > conftest.$ac_ext <<EOF
#line 4333 "configure"
#include "confdefs.h"
#define USE_MAP_ANON
#include "ct-mmap.inc"
EOF
if { (eval echo configure:4338: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; }=
 && test -s conftest${ac_exeext} && (./conftest; exit) 2>/dev/null
then
  ac_cv_func_mmap_anon=3Dyes
else
  echo "configure: failed program was:" >&5
  cat conftest.$ac_ext >&5
  rm -fr conftest*
  if test $? -lt 4
 then ac_cv_func_mmap_anon=3Dno
 else ac_cv_func_mmap_anon=3Dbuggy
 fi
fi
rm -fr conftest*
fi


fi

--Qxx1br4bt0+wmkIi--

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+XkwbtnlUggLJsX0RAvP7AJ9NxLaufr/7T8f6TZKESfz6cManMwCgmE2s
hM+BCbDLvWPSjYlSIxSC1ok=
=zmVl
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
