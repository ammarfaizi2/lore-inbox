Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSGWQAD>; Tue, 23 Jul 2002 12:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318129AbSGWP7A>; Tue, 23 Jul 2002 11:59:00 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:6476 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318119AbSGWP5w>; Tue, 23 Jul 2002 11:57:52 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E1149F@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Problem with msync system call
Date: Tue, 23 Jul 2002 18:58:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2326A.2CD20A00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2326A.2CD20A00
Content-Type: text/plain;
	charset="iso-8859-1"

Hello,

RH 7.2 (kernel 2.4.7-10) and RH 7.3 (kernel 2.4.18-3) (I haven't checked the
others).

I attempt to read/write memory mapped file from two Linux machines, which
resides on NFS mounted drive. The file gets corrupted since the changes made
on one machine aren't immediately available on the other. The sample program
is attached to this e-mail. The problematic API set includes (mmap, munmap
and msync system calls). It seems that MS_INVALIDATE has no effect....

The original code uses NFS locking to assure file consistency, but the
example misses this part to simplicity (locking is simulated by the user).
The same code works on a variety of other operating systems, but fails to
work between two Linux or Linux/Other OS machines.

I decided to give up on the performance issue and even tried to remap the
whole file before every attempt to read/write the mapped file. Surprisingly,
even this extreme measure didn't help (the code is commented out using
preprocessor directives in the sample program).
I couldn't find any patch, which specifically fixes this problem, though I
have seen some patches related to msync, which I don't think to be relevant
(Am I wrong?).

I'm sure that someone has come across this problem and I sure hope there is
some workaround/patch available. 
Any help will be greatly appreciated.

Thanks in advance.
Giga

 <<mmap.cc>> 

------_=_NextPart_000_01C2326A.2CD20A00
Content-Type: application/octet-stream;
	name="mmap.cc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mmap.cc"

#include <stdio.h>=0A=
#include <unistd.h>=0A=
#include <sys/mman.h>=0A=
#include <string.h>=0A=
#include <sys/types.h>=0A=
#include <sys/stat.h>=0A=
#include <fcntl.h>=0A=
=0A=
int main (int argc, char* argv []) =0A=
{=0A=
    char buffer [BUFSIZ];=0A=
    char* pMap;=0A=
=0A=
    int fd =3D open ("MAPPED.FILE", O_CREAT | O_RDWR | O_SYNC, =
0666);=0A=
    if (fd =3D=3D -1) {=0A=
	perror ("open");=0A=
	return -1;=0A=
    }=0A=
=0A=
    write (fd, "\0", 1);=0A=
    if (lseek (fd, BUFSIZ - 1, SEEK_SET) !=3D BUFSIZ - 1) {=0A=
	perror ("lseek");=0A=
	return -1;=0A=
    }=0A=
    write (fd, "\0", 1);=0A=
=0A=
    pMap =3D (char*) mmap (NULL, BUFSIZ, PROT_READ | PROT_WRITE, =0A=
			 MAP_SHARED, fd, 0);=0A=
    if ((size_t) pMap =3D=3D -1) {=0A=
	perror ("mmap");=0A=
	return -1;=0A=
    }=0A=
    =0A=
    while (1) {=0A=
	fprintf (stderr, "<Press ENTER to read> OR <Enter string to write> $ =
");=0A=
	fgets (buffer, sizeof (buffer) - 1, stdin);=0A=
=0A=
#if 0=0A=
	if (munmap (pMap, BUFSIZ)) {=0A=
	    perror ("munmap");=0A=
	    return -1;=0A=
	}=0A=
	pMap =3D (char*) mmap (NULL, BUFSIZ, PROT_READ | PROT_WRITE, =0A=
				   MAP_SHARED, fd, 0);=0A=
	if ((size_t) pMap =3D=3D -1) {=0A=
	    perror ("mmap");=0A=
	    return -1;=0A=
	}=0A=
#endif=0A=
=0A=
	if (buffer [0] =3D=3D '\n') {=0A=
	    fprintf (stderr, "Mapped file contents: %s\n", pMap);=0A=
	} else {=0A=
	    strncpy (pMap, buffer, strlen (buffer) - 1);=0A=
	    fprintf (stderr, "Written to mapped file: %s\n", pMap);=0A=
	}=0A=
=0A=
	if (msync (pMap, BUFSIZ, MS_SYNC | MS_INVALIDATE)) {=0A=
	    perror ("msync");=0A=
	    return -1;=0A=
	}=0A=
    }=0A=
=0A=
    return 0;=0A=
}=0A=

------_=_NextPart_000_01C2326A.2CD20A00--
