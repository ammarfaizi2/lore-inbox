Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJDLOD>; Fri, 4 Oct 2002 07:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJDLOD>; Fri, 4 Oct 2002 07:14:03 -0400
Received: from gw.openss7.com ([142.179.199.224]:6926 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261555AbSJDLOA>;
	Fri, 4 Oct 2002 07:14:00 -0400
Date: Fri, 4 Oct 2002 05:19:32 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004051932.A13743@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjanv@fenrus.demon.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk> <20021003170608.A30759@openss7.org> <1033722612.1853.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033722612.1853.1.camel@localhost.localdomain>; from arjanv@fenrus.demon.nl on Fri, Oct 04, 2002 at 11:10:12AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arjan,

On Fri, 04 Oct 2002, Arjan van de Ven wrote:

> On Fri, 2002-10-04 at 01:06, Brian F. G. Bidulock wrote:
> > Alan,
> >=20
> > Would it be possible to put a secondary call table behind
> > the call gate wrappered in sys_ni_syscall that a module
> > could register against.=20
> Why ?
> Adding "unknown" syscalls is I doubt EVER a good idea.
> LiS has *known* and *official* syscalls, they can easily live with a
> stub like nfsd uses.... few lines of code and it's safe.

Well, nfsd does something like this:

	struct nfsd_linkage *nfsd_linkage =3D NULL;

	long
	asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
	{
		int ret =3D -ENOSYS;
	=09
		lock_kernel();

		if (nfsd_linkage ||
		    (request_module ("nfsd") =3D=3D 0 && nfsd_linkage))
			ret =3D nfsd_linkage->do_nfsservctl(cmd, argp, resp);

		unlock_kernel();
		return ret;
	}
	EXPORT_SYMBOL(nfsd_linkage);

I take it that this system call is not in nsfd's main data flow
(probably write() and read are()).  Taking the big kernel lock is
excessive across every putpmsg() and getpmsg() operation and would
seriously impact LiS performance on multiple processors.  In effect,
only one processor would run for LiS.  A reader/write lock would be
better.

Also, LiS does not require module loading on system call, but
(questionably) needs unloading protection -- LiS does not really
need to unload once loaded.  This turns into something more like:

	static int (*do_putpmsg) (int, void *, void *, int, int) =3D NULL;
	static int (*do_getpmsg) (int, void *, void *, int, int) =3D NULL;
	static int (*do_spipe) (int *) =3D NULL;
	static int (*do_fattach) (int, const char *) =3D NULL;
	static int (*do_fdetach) (const char *) =3D NULL;

	static rwlock_t streams_call_lock =3D RW_LOCK_UNLOCKED;

	static long asmlinkage sys_putpmsg(int fd, void *ctlptr,
					   void *dataptr, int band, int flags)
	{
		int ret =3D -ENOSYS;
		read_lock(&streams_call_lock);
		if (do_putpmsg)
			ret =3D do_putpmsg(fd, ctrptr, dataptr, band, flags);
		read_unlock(&streams_call_lock);
		return ret;
	}

	static long asmlinkage sys_getpmsg(int fd, void *ctlptr,
					   void *dataptr, int band, int flags)
	{
		int ret =3D -ENOSYS;
		read_lock(&streams_call_lock);
		if (do_getpmsg)
			ret =3D do_getpmsg(fd, ctrptr, dataptr, band, flags);
		read_unlock(&streams_call_lock);
		return ret;
	}

	static long asmlinkage sys_spipe(int *fd)
	{
		int ret =3D -ENOSYS;
		read_lock(&streams_call_lock);
		if (do_spipe)
			ret =3D do_spipe(fd);
		read_unlock(&streams_call_lock);
		return ret;
	}

	static long asmlinkage sys_fattach(int fd, const char *path)
	{
		int ret =3D -ENOSYS;
		read_lock(&streams_call_lock);
		if (do_fattach)
			ret =3D do_fattach(fd, path);
		read_unlock(&streams_call_lock);
		return ret;
	}

	static long asmlinkage sys_fdetach(const char *path)
	{
		int ret =3D -ENOSYS;
		read_lock(&streams_call_lock);
		if (do_fdetach)
			ret =3D do_fdetach(path);
		read_unlock(&streams_call_lock);
		return ret;
	}

	void register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
				    int (*getpmsg) (int, void *, void *, int, int),
				    int (*spipe) (int *),
				    int (*fattach) (int, const char *),
				    int (*fdetach) (const char *))
	{
		write_lock(&streams_call_lock);
		do_putpmsg =3D putpmsg;
		do_getpmsg =3D getpmsg;
		do_spipe =3D spipe;
		do_fattach =3D fattach;
		do_fdetach =3D fdetach;
		write_unlock(&streams_call_lock);
	}
	void unregister_streams_calls(void)
	{
		register_streams_calls(NULL, NULL, NULL, NULL, NULL);
	}

	EXPORT_SYMBOL(register_streams_calls);
	EXPORT_SYMBOL(unregister_streams_calls);

The module (LiS or iBCS) calls register_streams_calls after it loads and ca=
lls
unregister_streams_calls before it unloads.

But this is repetative and doesn't solve replacement of existing
system calls for profilers and such.  Having a single secondary
call table approch such as:

	struct sys_secondary_call {
		rwlock_t lock;
		long asmlinkage(*call) (void);
	} sys_secondary_call_table[256];

	void *replace_syscall(__u8 nr, void *newcall)
	{
		void *oldcall;
		write_lock(&sys_secondary_call_table[nr].lock);
		oldcall =3D xchg(&sys_secondary_call_table[nr].call, newcall);
		write_unlock(&sys_secondary_call_table[nr].lock);
		return (oldcall);
	}
	EXPORT_SYMBOL(replace_syscall);

	#define SYSCALL_STUB(num) \
	long asmlinkage sys_call_ # num (void) { \
		int ret =3D -ENOSYS; \
		read_lock(&sys_secondary_call_table[num].lock); \
		if (sys_secondary_call_table[num].call) { \
			ret =3D (*sys_secondary_call_table.call) (); \
		read_unlock(&sys_secondary_call_table[num].lock); \
		return (ret); \
	}

	SYSCALL_STUB(__NR_setup);
	SYSCALL_STUB(__NR_exit);
	SYSCALL_STUB(__NR_fork);
		.
		.
		.
	       etc.

With entry.S looking like:

	.data
	ENTRY(sys_call_table)
		.long SYMBOL_NAME(sys_call_0)
		.long SYMBOL_NAME(sys_call_1)
				.
				.
				.
		.long SYMBOL_NAME(sys_call_255)

Then any module could both replace or implement otherwise non-implemented
system calls.  It just seems that the general purpose approach could work
better for most things (even nfsd).

--brian

--=20
Brian F. G. Bidulock    =A6 The reasonable man adapts himself to the =A6
bidulock@openss7.org    =A6 world; the unreasonable one persists in  =A6
http://www.openss7.org/ =A6 trying  to adapt the  world  to himself. =A6
                        =A6 Therefore  all  progress  depends on the =A6
                        =A6 unreasonable man. -- George Bernard Shaw =A6

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9nXlBMYOP2up1d2URAsQhAJwI2SiKTRm3IZWh1a7YKkASSd5PFwCeI/vA
mRRbj/pXsoDPrnn4Lou1sX0=
=nkwD
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
