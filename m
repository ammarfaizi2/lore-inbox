Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRK1Ssh>; Wed, 28 Nov 2001 13:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRK1Ss1>; Wed, 28 Nov 2001 13:48:27 -0500
Received: from c1238376-a.parker1.co.home.com ([65.6.124.144]:40967 "HELO
	mail.ecnerwal.com") by vger.kernel.org with SMTP id <S279317AbRK1SsV>;
	Wed, 28 Nov 2001 13:48:21 -0500
Date: Wed, 28 Nov 2001 11:44:00 -0700 (MST)
From: Ron Lawrence <rlawrence@netraverse.com>
X-X-Sender: <rjlawre@monster.jayfay.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: CDROM ioctl bug (fwd)
Message-ID: <Pine.LNX.4.33.0111281009140.1724-100000@monster.jayfay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

Jens told me to go ahead and post to this list, since he has been very
busy. Here are the symptoms of my problem : doing reads from a CDROM
device intermingled with CDROM_MEDIA_CHANGED ioctls causes long pauses
during the ioctl. This behavior started in 2.4.10. The ioctl can take a
very long time to return, especially if reading large chunks.

FYI, I tried adjusting the max/min-readahead that appeared in 2.4.16, but
these seemed to have no effect on the problem. If anyone has time to look
into this, or can point me at a likely place to start looking, I would
appreciate it.

Ron Lawrence
rlawrence@netraverse.com

Here is a program that will recreate the problem consistently (larger
numbers produce it more consistently):

- -------- %< ------------
#include <stdio.h>
#include <fcntl.h>
#include <linux/cdrom.h>
/* usage cdr [cd-device [bytes to read] ] */
int
main(int argc, char *argv[]) {
	int cdfd, i, j, k;
	char *infile;
	char c;
	int read_bytes = argc > 2 ? atoi(argv[2]) : 65535;
	char buf[500000];
	char *openit = argc > 1 ? argv[1] : "/dev/cdrom";

	printf("opening %s, reading %d at a time\n", openit, read_bytes);
	if ((cdfd = open(openit, O_RDONLY) ) == -1) {
		exit(2);
	}

	for (i=0; i<50 ;i++) {
		j=time();
		printf("%2.2d Reading %d bytes\n", i, read_bytes);
		read(cdfd, buf, read_bytes);
		printf("%2.2d Calling media change ioctl:\n",i);
		ioctl(cdfd, CDROM_MEDIA_CHANGED, CDSL_CURRENT);
		k=time();
		printf("%2.2d done (%d)\n", i, (k-j));
	}
	return 0;
}
- -------- %< ------------

- ---------- Forwarded message ----------
 Date: Wed, 28 Nov 2001 08:01:20 +0100
 From: Jens Axboe <axboe@suse.de>
 To: Ron Lawrence <rlawrence@netraverse.com>
 Subject: Re: CDROM ioctl bug

  On Tue, Nov 27 2001, Ron Lawrence wrote:
  > -----BEGIN PGP SIGNED MESSAGE-----
  > Hash: SHA1
  >
  > Hi Jens,
  >
  > I'm just writing to ask whether you have had any luck finding the
  > CDROM
  > MEDIA_CHANGE ioctl bug yet. If not, would you mind my posting of the
  > sample program to the kernel list to see if anyone else has time to
  > debug it?

  No time yet, but please go ahead and post the sample program so someone
  else can debug it for now.

  --
  Jens Axboe
- --------------------------------------------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BTBzU0yq8UBYK2oRAmQfAJ4/YaXWrDcWfLcVRREHetBGwAolfwCfeJIt
Z3/z1rseKLU1N1p/gspjieU=
=+NEN
-----END PGP SIGNATURE-----


