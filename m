Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbUAJVdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265441AbUAJVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:33:41 -0500
Received: from smtp7.hy.skanova.net ([195.67.199.140]:18128 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265437AbUAJVdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:33:37 -0500
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz>
	<20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz>
	<6u1xq77e29.fsf@zork.zork.net> <20040110202348.GA23318@ucw.cz>
	<6uwu7z5y1y.fsf@zork.zork.net>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Jan 2004 22:33:32 +0100
In-Reply-To: <6uwu7z5y1y.fsf@zork.zork.net>
Message-ID: <m2u133qyj7.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Sat, Jan 10, 2004 at 08:18:22PM +0000, Sean Neakums wrote:
> >
> >> Will this also result in the passthough port not being enabled?
> >> (I'd like to disable it.)
> >
> > It depends on the touchpad firmware. Most leave it enabled.
> > In this mode we don't have any control over the passthrough port.
> 
> I notice that the passthrough appears as an extra device (mouse1 on my
> system).  Is there a way to disable devices from userspace?

You can write a program that grabs the event device for exclusive
access and then just ignores all events, like this:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

/* From linux/include/linux/input.h */
struct input_event {
    struct timeval time;
    unsigned short type;
    unsigned short code;
    unsigned int value;
};

#define EVDEV "/dev/input/event0"

#define EVIOCGRAB _IOW('E', 0x90, int)	    /* Grab/Release device */

int main(int argc, char* argv[])
{
    const char* devName = EVDEV;
    int fd;
    int ret;

    if (argc > 1)
	devName = argv[1];

    fd = open(devName, O_RDONLY);
    if (fd < 0) {
	fprintf(stderr, "Can't open file %s, errno:%d (%s)\n",
		devName, errno, strerror(errno));
	exit(1);
    }

    ret = ioctl(fd, EVIOCGRAB, 1);
    if (ret < 0) {
	printf("Can't grab event device, errno:%d (%s)\n",
	       errno, strerror(errno));
	exit(1);
    }

    for (;;) {
	struct input_event ev;
	read(fd, &ev, sizeof(ev));
    }

    close(fd);
    return 0;
}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
