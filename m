Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAVILN>; Mon, 22 Jan 2001 03:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAVILE>; Mon, 22 Jan 2001 03:11:04 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:4106 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129846AbRAVIKr>; Mon, 22 Jan 2001 03:10:47 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2001 09:10:29 +0100
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-27721
Subject: patch: 2.4.0/2.5.0: nanoseconds time resolution
Message-ID: <3A6BF8F9.26580.FB55D37@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Message-Boundary-27721
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body

Hello,

I have spend some time making a patch against the Linux kernel to 
switch to nanoseconds time resolution together with several time-
related updates. I really need support for architectures other than 
i386, specifically a routine that has a very fine and accurate time 
resolution (just using ns == 1000*us isn't the best choice).

For the 2.4.0 patch the ia64, sh, mips64, and parisc architectures are 
completely not done, and the other architectures are either untested or 
done sub-optiomal.

Therefore I put together a simple "hacking document" (see attachment) 
to guide you when trying to port the code.  More text can be found in 
Documentation/kernel-time.txt after the patch, or in the distribution 
for Linux 2.2 (PPSkit-1.0.2.tar*) So please spend an hour or two to 
help me out there. I hope I'm not forced to drop the project.

Unless you can convince me not to have a /proc/sys/kernel/time 
directory, I'd also suggest to accept the patch for 
/usr/src/linux/include/sysctl.h for the standard kernel. Currently I 
have allocated "50" for the "time" entry. I'd like to have a stable 
number for the future.

Regards,
Ulrich Windl



--Message-Boundary-27721
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'hacking'

=====================================================================
A sketch on what to consider when implementing the new time framework
on new architectures (like ia64, mips64, parisc, sh).
=====================================================================
(See
http://ftp.kernel.org/pub/linux/daemons/ntp/PPS/PPS-2.4.0-pre3.tar.bz2
for an implementation for i386)

* Add new config variables to `config.in' and `defconfig' (CONFIG_NTP,
  CONFIG_NTP_PPS, CONFIG_NTP_PPS_SERIAL)

* use `<time.h>' instead of `<timex.h>' or `<sched.h>' to access
  kernel time.

* The kernel knows how to convert kernel time to CMOS time, don't mess
  with time zones yourself

* time is kept in nanoseconds. `do_fast_gettimeoffset()' is replaced
  with `do_exact_nanotime()' that returns nanoseconds passed since
  occurrence of the last timer interrupt. `do_slow_gettimeoffset()' is
  replaced with `do_poor_nanotime()' accordingly.

* `do_gettimeofday()' and `do_settimeofday()' are implemented in the
  architecture-independent module, messing with all the status
  updates.  The common code uses the `do_nanotime()' callback to call
  the architectures' code (allowing code selection during runtime or
  boot-up).

* `set_rtc_mmss()' is called `update_rtc()' now, and it sets the
  complete date and time (not just minutes). A new `ktime_to_rtc()'
  converts kernel time to broken down time components suitable to
  write to CMOS RTC.  `mktime()' is also architecture-independent
  now. The new `rtc_to_ktime()' is used after reading the RTC to get
  kernel time.

* a new `timevar_init()' initializes all the time variables.

* `struct timex' has been changed significantly while trying to
  preserve binary compatibility as far as possible.

* time routines are in `kernel/time.c' now, and `xtime', the kernel's
  representation of time, is protected by `rwlock_t xtime_lock'.  A
  new `rtc_runs_localtime' determines if time-zone corrections have to
  be made for RTC time updates. A new data type `l_fp', a 64bit
  quantity, is used for some internal time variables (needed by the
  NTP clock model).

* a new sysctl interface allows controlling of some time variables,
  most notably the time zone and `rtc_runs_localtime'.  While
  adjusting `time_tick' (the former `tick') is deprecated for NTP
  applications, it allows fine compensation of systematic clock
  errors.

* When the kernel time is set, the RTC update procedure is triggered.

* Old routines are implemented using POSIX-alike `do_clock_gettime()'
  and `do_clock_settime()'. There's also a `do_clock_getres()' that
  gives quite realistic (not optimistic) estimates.

* `adjtimex()' has been significantly reworked, just as most of the
  other time-keeping routines.

* Updating the RTC is controlled by new variables: `rtc_update_slave',
  when non-zero, controls after how many seconds the RTC has to be
  updated. Internally `last_rtc_update' keeps the time of the last
  update.  Upon update the `rtc_update_slave' is cleared on success.

--Message-Boundary-27721--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
