Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVGGICP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVGGICP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVGGICO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:02:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13477 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261213AbVGGICM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:02:12 -0400
Date: Thu, 7 Jul 2005 10:03:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Lenz Grimmer <lenz@grimmer.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707080323.GF1823@suse.de>
References: <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704110604.GL1444@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Jens Axboe wrote:
> On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Hi,
> > 
> > Jens Axboe wrote:
> > 
> > > It isn't too pretty to rely on such unreliable timing anyways. I'm 
> > > not too crazy about spinning the disk down either, it's useless wear 
> > > compared to just parking the head.
> > 
> > Fully agreed, and that's the approach the IBM Windows driver seems to
> > take - you just hear the disk park its head when the sensor kicks in
> > (you can hear it) - the disk does not spin down when this happens.
> > 
> > Could this be some reserved ATA command that only works with certain#
> > drives?
> 
> Perhaps the IDLE or IDLEIMMEDIATE commands imply a head parking, that
> would make sense. As you say, you can hear a drive parking its head.
> Here's a test case, it doesn't sound like it's parking the hard here.

ATA7 defines a park maneuvre, I don't know how well supported it is yet
though. You can test with this little app, if it says 'head parked' it
works. If not, it has just idled the drive.


#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/hdreg.h>

int main(int argc, char *argv[])
{
	unsigned char buf[8];
	int fd;

	if (argc < 2) {
		printf("%s <dev>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd == -1) {
		perror("open");
		return 1;
	}

	memset(buf, 0, sizeof(buf));
	buf[0] = 0xe1;
	buf[1] = 0x44;
	buf[3] = 0x4c;
	buf[4] = 0x4e;
	buf[5] = 0x55;

	if (ioctl(fd, HDIO_DRIVE_TASK, buf)) {
		perror("ioctl");
		return 1;
	}

	if (buf[3] == 0xc4)
		printf("head parked\n");
	else
		printf("head not parked %x\n", buf[3]);

	close(fd);
	return 0;
}

-- 
Jens Axboe

