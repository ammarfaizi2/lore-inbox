Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271240AbTG2LBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTG2LBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:01:19 -0400
Received: from mailc.telia.com ([194.22.190.4]:52681 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S271240AbTG2LBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:01:12 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       GPM Mailing List <gpm@arcana.linux.it>
Subject: Re: psmouse: synaptics (2.6.0-test1|2)
References: <20030728081832.GA453@schottelius.org> <m265lmihw2.fsf@telia.com>
	<20030728222217.GD10741@schottelius.org>
From: Peter Osterlund <petero2@telia.com>
Date: 29 Jul 2003 12:59:16 +0200
In-Reply-To: <20030728222217.GD10741@schottelius.org>
Message-ID: <m2he55d2ez.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Nico Schottelius <nico-kernel@schottelius.org> writes:

> Peter Osterlund [Mon, Jul 28, 2003 at 09:13:49PM +0200]:
> > Nico Schottelius <nico-kernel@schottelius.org> writes:
> > > My questions:
> > >    3) how can I read /dev/misc/psaux in Linux 2.6 ?
> > 
> > AFAIK, you can't.
> 
> that could be a problem..
> 
> > >    1) why are you implementing drivers in the kernel?
> > 
> > Because the raw psaux device is no longer exposed to user space.
> 
> means we _are_ obsoleted from now on...
> if that's true I'll try to help you to use code from gpm where possible.
> and I hope we can work together so we can use gpm once again.
> (and possibly develop a buffer, which is available within
> gpm and X...I am rethinking this currently)

No, gpm is not obsoleted. The kernel driver is supposed to export
enough data in the /dev/input/eventX interface. It's then up to user
space programs such as gpm or the XFree driver to do something useful
with this data.

One bonus is that the eventX device can be opened by multiple readers,
so conflicts between gpm and the X driver should not happen any more.
No nead to create any additional shared buffers.

Note that I didn't design this event infrastructure. I just started to
work on the synaptics kernel driver when I realized the XFree driver
didn't work with the 2.5.x kernel.

> > >    2) what source of information do you use to program them?
> > 
> > The synaptics touchpad interfacing guide. I think this link is still valid:
> > 
> >         http://www.synaptics.com/decaf/utilities/ACF126.pdf
> 
> think so, too. but in fact as my dmesg shows, the touchpad doesn't
> like you..and I would like to use it :)

What does dmesg say?

> So, is /dev/input/mice now the general device to use?
> If yes, is it imps2 or what should we talk to it?

You should now use /dev/input/eventX, for some X. The XFree driver has
code to autodetect the correct X which you can probably reuse for gpm.

        http://w1.894.telia.com/~u89404340/touchpad/index.html

>From the event device, you read data looking like this:

        struct input_event {
        	struct timeval time;
        	__u16 type;
        	__u16 code;
        	__s32 value;
        };

The synaptics kernel driver currently reports the following events:

        ABS_X
        ABS_Y
                X, Y coordinates for the finger.

        ABS_PRESSURE
                Z value

        MSC_GESTURE
                W value (emulated if the touchpad doesn't support w)

        BTN_LEFT
        BTN_RIGHT
                Left/right buttons

        BTN_FORWARD
        BTN_BACK
                Up/down buttons, if present.

        BTN_0, ..., BTN_7
                Multi buttons, if present.

Note that the kernel driver only reports changes, so you can no longer
rely on the fact that the touchpad keeps sending data 1s after you
stop using it.

Pass through port devices (pointing sticks for example) get their own
eventX device (at least with the extra kernel patches from the web
page above), but they also report to the /dev/input/mice device, so I
think they will just work without extra gpm support. (I don't have the
hardware to test this though.)

If this data is insufficient for the gpm driver, now would be a good
time to extend/change it, before the stuff gets too widely used. Some
points that have been raised before:

* The W value ought to be split in "number of fingers" and "finger
  width". That would make the protocol general enough to be used for
  other touchpad models too, such as ALPS.

* The Y value is reported in raw form. Should probably be mirrored
  depending on how the touchpad is oriented.

I have also attached a simple test program I created to read from the
event device. Maybe you find it useful for some initial tests.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340


--=-=-=
Content-Disposition: attachment; filename=evdev.C
Content-Description: evdev.C

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

#define EVDEV "/dev/input/event0"

// From linux/include/linux/input.h
struct input_event {
	struct timeval time;
	unsigned short type;
	unsigned short code;
	unsigned int value;
};

static inline double doubleTime(const timeval& tv)
{
    return tv.tv_sec + tv.tv_usec / 1000000.0;
}

static const char* typeStr(int evType)
{
    static char buf[16];

    switch (evType) {
    case 0x00: return "RST";
    case 0x01: return "KEY";
    case 0x02: return "REL";
    case 0x03: return "ABS";
    case 0x04: return "MSC";
    case 0x11: return "LED";
    case 0x12: return "SND";
    case 0x14: return "REP";
    case 0x15: return "FF ";
    default:
	sprintf(buf, "%02x ", evType);
	return buf;
    }
}

static const char* keyStr(int key)
{
    static char buf[16];
    switch (key) {
    case 0x110: return "BTN_LEFT   ";
    case 0x111: return "BTN_RIGHT  ";
    case 0x112: return "BTN_MIDDLE ";
    case 0x113: return "BTN_SIDE   ";
    case 0x114: return "BTN_EXTRA  ";
    case 0x115: return "BTN_FORWARD";
    case 0x116: return "BTN_BACK   ";
    default:
	sprintf(buf, "%4x", key);
	return buf;
    }
}

static const char* relStr(int code)
{
    static char buf[16];
    switch (code) {
    case 0x00: return "X     ";
    case 0x01: return "Y     ";
    case 0x02: return "Z     ";
    case 0x06: return "HWHEEL";
    case 0x07: return "DIAL  ";
    case 0x08: return "WHEEL ";
    case 0x09: return "MISC  ";
    default:
	sprintf(buf, "%4x", code);
	return buf;
    }
}

static const char* absStr(int code)
{
    static char buf[16];
    switch (code) {
    case 0x00: return "ABS_X       ";
    case 0x01: return "ABS_Y       ";
    case 0x18: return "ABS_PRESSURE";
    case 0x28: return "ABS_MISC    ";
    default:
	sprintf(buf, "%4x", code);
	return buf;
    }
}

static const char* codeStr(int evType, int code)
{
    static char buf[16];
    switch (evType) {
    case 0x01:				    // KEY
	return keyStr(code);
    case 0x02:				    // REL
	return relStr(code);
    case 0x03:
	return absStr(code);		    // ABS
    default:
	sprintf(buf, "%4x", code);
	return buf;
    }
}

int main(int argc, char* argv[])
{
    const char* devName = EVDEV;
    if (argc > 1)
	devName = argv[1];

    FILE* f = fopen(devName, "r");
    if (!f) {
	fprintf(stderr, "Can't open file %s, errno:%d (%s)\n",
		devName, errno, strerror(errno));
	exit(1);
    }

    input_event ev;

    double t0 = 0;
    while (fread(&ev, sizeof(input_event), 1, f) == 1) {
	if (t0 == 0)
	    t0 = doubleTime(ev.time);
	double t = doubleTime(ev.time) - t0;
	printf("%10f %s %s %4d\n", t, typeStr(ev.type), codeStr(ev.type, ev.code),
	       ev.value);
    }

    fclose(f);
    return 0;
}

--=-=-=--
