Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSLIW7S>; Mon, 9 Dec 2002 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSLIW7S>; Mon, 9 Dec 2002 17:59:18 -0500
Received: from ext-nj2gw-2.online-age.net ([216.35.73.164]:2237 "EHLO
	ext-nj2gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S266320AbSLIW7Q>; Mon, 9 Dec 2002 17:59:16 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA68048955F6@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: [RFC] countdown timer driver
Date: Mon, 9 Dec 2002 18:06:02 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I am implementing a driver for a set of hardware countdown timers and I have
a few questions as to how this device's interface should be approached.

Background on the device:
Actually, there are several implementations of this hardware that I must
support, but here are the basics that they all have in common.

The device contains several countdown timers. A count is loaded into the
device,
the timer is enabled, the timer counts down to 0 at which point it fires an
interrupt, reloads the counter to the original value, and so on....

To be clear, this device differs from the rtc device in the following ways:
1. RTC tracks date/time of day. The countdown timer device is not aware of
   date/time.
2. There are multiple countdown timers.
3. Each countdown timer may/may not have programmable clock rates and the
   rates available vary from device to device. Some have software selectable
   rates and others have rates selectable by jumpers.
4. Countdown timers don't have update or alarm interrupt modes.
5. One may still want to use /dev/rtc alongside the countdown timers.

Questions:
1. Is there already a standard kernel interface to this type of timer?
2. Is there any reason to interface/integrate this type of device with the
   high-res timer stuff currently under development for the 2.5 kernel?

Assuming there is not a standard and this device should be handled separate
from the high-res timer/posix timer stuff I am proposing this interface:

Goals:
1. Hide the complexity of each device (counter sizes, clock rates, etc...)
   so the user has a simple and consistent interface regardless of the
   particular hardware implementation.
2. Programmable to nanosecond resolution (limited by the resolution of the
   individual devices of course).
3. Ability to set a timeout value of reasonable magnitude. I.e. programming
   a device using a 32-bit int value corresponding to number of nanoseconds
   is not a sufficiently large timeout value.


The driver registers /dev/timer0, /dev/timer1, etc... for each timer device.
Obviously a major number would need to be assigned to the /dev/timer device.

The following ioctls would exist:
#define TIMER_LOAD_COUNT           _IOW('t', 1, struct timespec)
#define TIMER_GET_COUNT            _IOR('t', 2, struct timespec)
#define TIMER_START                _IO('t', 3)
#define TIMER_STOP                 _IO('t', 4)

A read blocks until an interrupt occurs unless interrupts are already
pending. The read returns number of interrupts since the last read so
pileups can be
detected. Select would also be implemented.


An alternative approach would be this:
Writing a value in the form of struct timespec loads and starts the counter.
Writing a struct timespec with a value of 0 stops the timer.
A read returns struct timespec with the current timer value.
Interrupts are received using the select function. The driver would respond
to
the select with POLLPRI when the count had expired.


Comments?
