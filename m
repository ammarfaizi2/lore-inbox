Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266057AbTIKEmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbTIKEmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:42:40 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:7358 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266057AbTIKEmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:42:35 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Frank Cusack <fcusack@fcusack.com>
Date: Thu, 11 Sep 2003 14:42:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16223.64813.248941.885060@notabene.cse.unsw.edu.au>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: /proc/beep
In-Reply-To: message from Frank Cusack on Wednesday September 10
References: <20030910211413.A17000@google.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 10, fcusack@fcusack.com wrote:
> /proc/beep is a kernel tweak that sends beep "signals" to a userspace
> process reading the /proc/beep file.  There are one or two of these
> modules you can find on the Internet.  In order to support them the
> kernel needs to export kd_mksound.
> 
> Would a /proc/beep module be accepted into the main tree?  From the
> ones I've found, I can understand why they might not be accepted.  But
> I'm willing to do the [small amount of] work required to get one looking
> like other kernel modules.
> 
> If not, could at least kd_mksound be exported by default anyway?  This 
> would allow homegrown /proc/beep's to not require any kernel mods.

The equivalent can be done with the "input layer" in 2.6.
Open /dev/input/uinput and register yourself as a beep handler, and
you get the beeps instead of the speaker.

The following code does this (but doesn't claim to be well written,
portable, reliable, secure, or anything else).

It requires you do be runnig 'esd' and to have loaded some sample into
esd.  The sample is played instead of any beep.

NeilBrown


/*
 * A user event handler that notices bells and
 * echos something
 */

#include <linux/input.h>
#include <linux/uinput.h>
#include <fcntl.h>
#include <stdio.h>


main(int argc, char *argv[])
{
	char *dev = "/dev/input/user";
	int fd;
	int esd,id;
	struct input_event ev;
	struct uinput_user_dev dv;
	if (argc >= 2)
		dev = argv[1];

	
	fd = open(dev, O_RDWR, 0);
	if (!fd) {
		perror(dev);
		exit(1);
	}
	memset(&dv, 0, sizeof(dv));
	strcpy(dv.name, "Quiet Bell");
	dv.id.bustype = 0;
	dv.id.vendor = 0;
	dv.id.product = 0;
	dv.id.version = 1;

	if (write(fd, &dv, sizeof(dv)) != sizeof(dv)) {
		perror("Write device name");
		exit(1);
	}
	if (ioctl(fd, UI_SET_EVBIT, EV_SND)) {
		perror("Cannot request snd event");
		exit(1);
	}
	if (ioctl(fd, UI_SET_SNDBIT, 0)) {
		perror("Cannot request Click");
		exit(1);
	}
	if (ioctl(fd, UI_SET_SNDBIT, 1)) {
		perror("Cannot request Bell");
		exit(1);
	}
	if (ioctl(fd, UI_SET_SNDBIT, 2)) {
		perror("Cannot request Tone");
		exit(1);
	}

	if (ioctl(fd, UI_DEV_CREATE, NULL)) {
		perror("Create uinput dev");
		exit(1);
	}

	if (argc > 2) {
		esd = esd_open_sound(NULL);
		id = esd_sample_getid(esd, argv[2]);
	}

	while (read(fd, &ev, sizeof(ev)) == sizeof(ev)) {
		if (argc <= 2)
			printf("%d %d %d\n", ev.type, ev.code, ev.value);
		else if (ev.type == 18 && ev.code == 2 && ev.value > 0)
			esd_sample_play(esd, id);
	}
	exit(0);
}
