Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSGWRo2>; Tue, 23 Jul 2002 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWRo1>; Tue, 23 Jul 2002 13:44:27 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:22111 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318158AbSGWRo0>; Tue, 23 Jul 2002 13:44:26 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114A4@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "'Andi Kleen'" <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Problem with msync system call
Date: Tue, 23 Jul 2002 20:45:07 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C23279.111B0410"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C23279.111B0410
Content-Type: text/plain;
	charset="iso-8859-1"

>Do a F_SETFL lock/unlock on the file  That should act as a 
>full NFS write barrier and flush all buffers. Best is if you synchronize 
>between the various writers with the full lock.

Do you mean F_SETLK? If so, this didn't help (the source is attached).
If you meant something else, could you be more specific, please? 

Thanks in advance.
Giga


------_=_NextPart_000_01C23279.111B0410
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
    if (lseek (fd, BUFSIZ - 1, SEEK_SET) =3D=3D -1) {=0A=
	perror ("lseek");=0A=
	return -1;=0A=
    }=0A=
    write (fd, "\0", 1);=0A=
    if (lseek (fd, 0, SEEK_SET) =3D=3D -1) {=0A=
	perror ("lseek");=0A=
	return -1;=0A=
    }=0A=
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
	struct flock lck =3D { =0A=
	    F_WRLCK,  /* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK    */=0A=
	    SEEK_SET, /* Where `l_start' is relative to (like `lseek') */=0A=
	    0,        /* Offset where the lock begins                  */=0A=
	    0,        /* Size of the locked area; zero means until EOF */=0A=
	    getpid () /* Process holding the lock                      */=0A=
	};=0A=
=0A=
	if (fcntl (fd, F_SETLK, &lck)) {=0A=
	    perror ("fcntl");=0A=
	    return -1;=0A=
	}=0A=
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
=0A=
	lck.l_type =3D F_UNLCK;=0A=
	if (fcntl (fd, F_SETLK, &lck)) {=0A=
	    perror ("fcntl");=0A=
	    return -1;=0A=
	}=0A=
    }=0A=
=0A=
    return 0;=0A=
}=0A=

------_=_NextPart_000_01C23279.111B0410--
