Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUJZQ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUJZQ0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUJZQ0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:26:09 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:60879 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261314AbUJZQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:25:51 -0400
Message-ID: <417E7A8F.7000501@biomail.ucsd.edu>
Date: Tue, 26 Oct 2004 09:25:51 -0700
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: svgalib_helper from svgalib-1.9.19  and RTL 2.6.9-mm1-V0.2 lockup
Content-Type: multipart/mixed;
 boundary="------------000402050505010704040006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000402050505010704040006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
I've built and loaded the 1.9.19 svgalib_helper driver, on 
2.6.9-mm1-V0.2 and when I run a svgalib program the entire system locks 
up hard.
The screen blanks, no keyboard, network, serial, all completely dead.
It seems to work mostly fine on 2.6.9-mm1-U10.3 (it's starting to not 
play as nice with XWindows).
It would be great to see svgalib's interrupt code used in the DRI 
interface. Spin waits spend valuable CPU resources and are not reliable 
(see attached code).

On a completely other note, what replaces __bad_sema_init_use? The 
proprietary ATI drivers use it, and it seems to have been recently retired.
Belayed thanks to Panagiotis for the remap_page_range info.

John Gilbert
jgilbert@biomail.ucsd.edu



--------------000402050505010704040006
Content-Type: text/plain;
 name="vsync.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vsync.c"

/* A work in progress, hope to have a smoothly rotating curser and count as first test of vsync */
/* Done. works pretty good now, and simplified a few things as well */
/* curser rotates 60 times a second along with vsync */

#include <fcntl.h> /* where does O_RDWR come from? */
#include <stdio.h> /* where does stderr come from? */
#include <stdlib.h> /* where does stderr come from? */
#include <signal.h> /* where SIGINT lives */
#include <unistd.h> /* where close lives */
#include <errno.h> /* where errno lives */
#include <sys/ioctl.h> /* where _IOWR lives */
#include <asm-i386/msr.h> /* where rdtscll lives */
#include "/usr/src/linux/drivers/char/drm/drm.h" /* all the drm ioctls and structures */
#include "vsync.h" /* where vsync stuff lives */



int dri_fd = -1;

#ifdef RUNVSYNC

int
main()
{
	unsigned long long int lasttick, thistick, ticks, maxval = 0, minval = ~0, total = 0, meanval;
	int count = 1;

	if (dri_init() == -1) {
		printf("can't open dri device\n");
		exit(1);
	}
	signal(SIGINT, (__sighandler_t) dri_close);
		
	dri_vblank();
	rdtscll(lasttick);

	for (;;) {
	/* note: need to use fprintf, as printf will cache and only really print every once in a while */
		dri_vblank();
		rdtscll(thistick);
		ticks = thistick - lasttick;
		lasttick = thistick;
		maxval = (maxval > ticks) ? maxval : ticks;
		minval = (minval < ticks) ? minval : ticks;
		total += ticks;
		meanval = total / count;
		fprintf(stderr, "\\:%i\t:%llu\t:%llu\t:%llu\t:%llu   \r", count++, ticks, maxval, minval, meanval);
		
		dri_vblank();
		rdtscll(thistick);
		ticks = thistick - lasttick;
		lasttick = thistick;
		maxval = (maxval > ticks) ? maxval : ticks;
		minval = (minval < ticks) ? minval : ticks;
		total += ticks;
		meanval = total / count;
		fprintf(stderr, "|:%i\t:%llu\t:%llu\t:%llu\t:%llu   \r", count++, ticks, maxval, minval, meanval);

		dri_vblank();
		rdtscll(thistick);
		ticks = thistick - lasttick;
		lasttick = thistick;
		maxval = (maxval > ticks) ? maxval : ticks;
		minval = (minval < ticks) ? minval : ticks;
		total += ticks;
		meanval = total / count;
		fprintf(stderr, "/:%i\t:%llu\t:%llu\t:%llu\t:%llu  \r", count++, ticks, maxval, minval, meanval);

		dri_vblank();
		rdtscll(thistick);
		ticks = thistick - lasttick;
		lasttick = thistick;
		maxval = (maxval > ticks) ? maxval : ticks;
		minval = (minval < ticks) ? minval : ticks;
		total += ticks;
		meanval = total / count;
		fprintf(stderr, "-:%i\t:%llu\t:%llu\t:%llu\t:%llu   \r", count++, ticks, maxval, minval, meanval);
	}
}

#endif /* RUNVSYNC */

int dri_init(void)
{
	dri_fd = open ("/dev/dri/card0", O_RDWR);
	return (dri_fd);
}

void dri_close(void)
{
	fprintf(stderr, "\nShutting down!\n");
	if (dri_fd != -1)
		close(dri_fd);
	exit(0);
}

void dri_vblank(void)
{
	int ret;
	drm_wait_vblank_t vbl;

	vbl.request.type = _DRM_VBLANK_RELATIVE;
	vbl.request.sequence = 1;

	do {
		ret = ioctl( dri_fd, DRM_IOCTL_WAIT_VBLANK, &vbl );
		vbl.request.type &= ~_DRM_VBLANK_RELATIVE;
	} while (ret && errno == EINTR);
	return;
}



--------------000402050505010704040006--
