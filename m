Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271801AbRICUN7>; Mon, 3 Sep 2001 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRICUNl>; Mon, 3 Sep 2001 16:13:41 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:2944 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271798AbRICUNZ>; Mon, 3 Sep 2001 16:13:25 -0400
Date: Mon, 3 Sep 2001 15:13:42 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: using O_DIRECT
Message-ID: <20010903151342.A2247@draal.physics.wisc.edu>
In-Reply-To: <20010903104544.X23180@draal.physics.wisc.edu> <20010903175333.P699@athlon.random> <20010903105714.Y23180@draal.physics.wisc.edu> <20010903180524.Q699@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010903180524.Q699@athlon.random>; from andrea@suse.de on Mon, Sep 03, 2001 at 06:05:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have written a small program to use O_DIRECT (attached), after
applying your patch o_direct-14 to kernel 2.4.9.  Opening the file with
O_DIRECT is successful, but attempts to write to the fd return EINVAL.

Am I doing something wrong?  Should I have to recompile glibc too?

(0)<root@draal:/usr/src/mjpeg_play> gcc -o testopen testopen.c
(0)<root@draal:/usr/src/mjpeg_play> strace ./testopen > /dev/null
execve("./testopen", ["./testopen"], [/* 54 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"draal.physics.wisc.edu", ...}) =3D 0
brk(0)                                  =3D 0x120010d90
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D62527, ...}) =3D 0
mmap(NULL, 62527, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x20000030000
close(3)                                =3D 0
open("/lib/libc.so.6.1", O_RDONLY)      =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&\220\1\0\0\0`\201\3"..., 1024)=
 =3D 1024
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D9653762, ...}) =3D 0
mmap(NULL, 1558648, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x200000400=
00
mprotect(0x2000019a000, 141432, PROT_NONE) =3D 0
mmap(0x200001a0000, 98304, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_=
FIXED, 3, 0x150000) =3D 0x200001a0000
mmap(0x200001b8000, 18552, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_=
FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x200001b8000
close(3)                                =3D 0
munmap(0x20000030000, 62527)            =3D 0
getxpid()                               =3D 2387
open("testopen.txt", O_RDWR|O_CREAT|O_SYNC|0x100000, 0644) =3D 3
fstat(1, {st_mode=3DS_IFCHR|0666, st_rdev=3Dmakedev(1, 3), ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x2000001e000
ioctl(1, TCGETS, 0x11fffea50)           =3D -1 ENOTTY (Inappropriate ioctl =
for device)
write(3, "Welcome to the winter of my disc"..., 40) =3D -1 EINVAL (Invalid =
argument)
close(3)                                =3D 0
write(1, "Got fd 3.\nUnable to write to fil"..., 77) =3D 77
munmap(0x2000001e000, 8192)             =3D 0
exit(0)                                 =3D ?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="testopen.c"

/* Test opening of a file with O_DIRECT */

#include <asm/types.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/types.h>
#include <asm/fcntl.h>  /* Note: <fcntl.h> DOES NOT HAVE O_DIRECT! */
                        /* <fcntl.h> is a glibc header... */
#include <errno.h>
#include <stdio.h>

int main(void) {
    char message[] = "Welcome to the winter of my discontent.\n";
    int fd = open("testopen.txt", O_RDWR|O_CREAT|O_SYNC|O_DIRECT, S_IRUSR|S_IRGRP|S_IROTH|S_IWUSR);
    int len;
    if(fd < 0) {
        printf("Unable to open file, errno is %d.\n", errno);
    } else {
        printf("Got fd %d.\n", fd);
        if((len = write(fd, message, strlen(message))) < 0) {
            printf("Unable to write to file, len is %d, errno is %d.\n", len, errno);
        } else {
            printf("%d bytes written to file.\n", len);
        }
    }
    close(fd);
    printf("End of program...\n");
    return 0;
}

--fUYQa+Pmc3FrFX/N--

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuT5HYACgkQjwioWRGe9K0+1QCfeqkbQF81BuYa1rOXqNTSEn9M
DrQAoITqfurRlOlAb/WnVc/eP4sMKSi3
=H5ar
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
