Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136251AbREIK77>; Wed, 9 May 2001 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136249AbREIK7u>; Wed, 9 May 2001 06:59:50 -0400
Received: from ns.suse.de ([213.95.15.193]:19471 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136210AbREIK7q>;
	Wed, 9 May 2001 06:59:46 -0400
Date: Wed, 9 May 2001 12:55:51 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrea Arcangeli <andrea@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010509125551.C420@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrea, Trond,

the demo for the NFS SHARED_MAP corruption:

garloff@daubechies:~/C $ uname -sr
Linux 2.4.4
garloff@daubechies:~/C $ ./test_nfs_shared_map ; head -1 ./testfile; sleep =
10; head -1 ./testfile
Linux NFS rocks.
Linux NFS sucks.

Sources attached. I still have to test your fix, Trond.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_nfs_shared_map.c"

/** test_nfs_shared_map.c
 *
 * Creates a file, expands it by ftruncate, mmaps it, writes
 * to the mapped memory, unmaps it and closes the file again.
 * 
 * This triggers a bug in 2.4.4 NFS client code: The file won't
 * contain the data written to the mapped memory.
 * 
 * (c) Kurt Garloff <garloff@suse.de>, 2001-05-09, GNU GPL
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <errno.h>


const char * const bad  = "Linux NFS sucks.\n";
const char * const good = "Linux NFS rocks.\n";
const char * const name = "testfile";

#define LEN 4096

int die (const char* const txt)
{
	perror (txt);
	exit (errno);
}

int main ()
{
	char* adr; int err;
	int fd = open (name, O_RDWR | O_CREAT | O_TRUNC, 0644);
	if (fd <= 0) die ("create testfile");
	err = write (fd, bad, strlen (bad));
	close (fd); 
	truncate (name, LEN);
	sync ();
	fd = open (name, O_RDWR);
	if (fd <= 0) die ("open testfile");
	adr = (char*) mmap (0, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (!adr) die ("mmap failed");
	strcpy (adr, good);
	strcpy (adr+32, good);
#ifdef NEED_MSYNC
	msync (adr, LEN, MS_SYNC);
#endif
	munmap (adr, LEN);
	close (fd);
}

--u5E4XgoOPWr4PD9E--

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6+SI2xmLh6hyYd04RArPWAJ9V5EzcEOxwNJAz5b9V9+N4uGwIqgCfeM3V
NbV+D0V6XzrpUF014hTL9k8=
=Cruf
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
