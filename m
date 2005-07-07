Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVGGPIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVGGPIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVGGPGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:06:35 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:32141 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261431AbVGGPDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:03:42 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: hdaps-devel@lists.sourceforge.net
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
User-Agent: KMail/1.8.1
Cc: Jens Axboe <axboe@suse.de>, Lenz Grimmer <lenz@grimmer.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>
References: <42C8D06C.2020608@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
In-Reply-To: <20050707080323.GF1823@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 7 Jul 2005 11:03:35 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507071103.36108.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Model: HTS548080M9AT00 (Hitachi)
Laptop: T42.

segfault:/home/spstarr# ./a /dev/hda
head parked

Seems to park, heard it click :)

Shawn.

On July 7, 2005 04:03, Jens Axboe wrote:
> On Mon, Jul 04 2005, Jens Axboe wrote:
> > On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Hi,
> > >
> > > Jens Axboe wrote:
> > > > It isn't too pretty to rely on such unreliable timing anyways. I'm
> > > > not too crazy about spinning the disk down either, it's useless wear
> > > > compared to just parking the head.
> > >
> > > Fully agreed, and that's the approach the IBM Windows driver seems to
> > > take - you just hear the disk park its head when the sensor kicks in
> > > (you can hear it) - the disk does not spin down when this happens.
> > >
> > > Could this be some reserved ATA command that only works with certain#
> > > drives?
> >
> > Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
> > would make sense. As you say, you can hear a drive parking its head.
> > Here's a test case, it doesn't sound like it's parking the hard here.
>
> ATA7 defines a park maneuvre, I don't know how well supported it is yet
> though. You can test with this little app, if it says 'head parked' it
> works. If not, it has just idled the drive.
>
>
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <linux/hdreg.h>
>
> int main(int argc, char *argv[])
> {
> 	unsigned char buf[8];
> 	int fd;
>
> 	if (argc < 2) {
> 		printf("%s <dev>\n", argv[0]);
> 		return 1;
> 	}
>
> 	fd = open(argv[1], O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		return 1;
> 	}
>
> 	memset(buf, 0, sizeof(buf));
> 	buf[0] = 0xe1;
> 	buf[1] = 0x44;
> 	buf[3] = 0x4c;
> 	buf[4] = 0x4e;
> 	buf[5] = 0x55;
>
> 	if (ioctl(fd, HDIO_DRIVE_TASK, buf)) {
> 		perror("ioctl");
> 		return 1;
> 	}
>
> 	if (buf[3] == 0xc4)
> 		printf("head parked\n");
> 	else
> 		printf("head not parked %x\n", buf[3]);
>
> 	close(fd);
> 	return 0;
> }
