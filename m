Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293647AbSCKWrz>; Mon, 11 Mar 2002 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293601AbSCKWrm>; Mon, 11 Mar 2002 17:47:42 -0500
Received: from mail.rpi.edu ([128.113.22.40]:59536 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S293547AbSCKWqy>;
	Mon, 11 Mar 2002 17:46:54 -0500
Date: Mon, 11 Mar 2002 17:47:02 -0500 (EST)
Message-Id: <20020311.174702.74741981.obatan@rpi.edu>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: a faster way to gettimeofday?
From: OBATA Noboru <noboru@ylug.org>
In-Reply-To: <3C859007.50102@candelatech.com>
In-Reply-To: <3C859007.50102@candelatech.com>
X-Mailer: Mew version 3.0.54 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a program that I very often need to calculate the current
> time, with milisecond accuracy.  I've been using gettimeofday(),
> but gprof shows it's taking a significant (10% or so) amount of
> time.  Is there a faster (and perhaps less portable?) way to get
> the time information on x86?  My program runs as root, so should
> have any permissions it needs to use some backdoor hack if that
> helps!

Just from curious, I have implemented the userland gettimeofday
as a shared library.  It runs about ten times faster than the
system call on my PC, Pentium4 1.5GHz, Linux-2.4.18-pre9-ac3.

The benchmark program says:

  system call: 1.226556 usec/call
  userland   : 0.133730 usec/call, (usec = micro second = 0.000001 sec)

It is available from:

  http://www.cs.rpi.edu/~obatan/ugettime/ugettime-0.1.1.tar.gz

You have to run calibration program "calib" first.  Then compile
a shared library ugettime.so, in which these calibrated
parameters are embedded as constants.  (So you need to recompile
it whenever you reboot the system. :-)  Please read README to
see how to use it.

Preloading this library enables the userland gettimeofday.  For
example,

  $ LD_PRELOAD=./ugettime.so emacs

will execute emacs and all gettimeofday system calls that emacs
issues will be handled by ./ugettime.so.

Patient calibration gives you very accurate userland
gettimeofday if your original gettimeofday and TSC on your
system has good enough precision.

I'm running verification program for 18 hours, but the userland
gettimeofday still synchronizes with the actual system call.

  :
  :
  sys: 1015885532.519445              <- system call
  usr: 1015885532.519444 (-0.000001)  <- userland (difference in seconds)
  sys: 1015885533.029344
  usr: 1015885533.029344 (+0.000000)
  sys: 1015885533.539446
  usr: 1015885533.539445 (-0.000001)
  :
  :

Yes, it is just for fun...  Enjoy!

-- 
OBATA Noboru (noboru@ylug.org)
