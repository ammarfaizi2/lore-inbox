Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbTCGGn6>; Fri, 7 Mar 2003 01:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTCGGn6>; Fri, 7 Mar 2003 01:43:58 -0500
Received: from mail.eskimo.com ([204.122.16.4]:60687 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261394AbTCGGnz>;
	Fri, 7 Mar 2003 01:43:55 -0500
Date: Thu, 6 Mar 2003 22:54:15 -0800
To: "Guangyu Kang (Shanghai)" <GuangyuKang@viatech.com.cn>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Help please: DVD ROM read difficulty
Message-ID: <20030307065415.GA7379@eskimo.com>
References: <C373923C3B6ED611874200010250D52E155E1A@exchsh01.viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C373923C3B6ED611874200010250D52E155E1A@exchsh01.viatech.com.cn>
User-Agent: Mutt/1.5.3i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 10:14:59AM +0800, Guangyu Kang (Shanghai) wrote:
> Hi:
>         Currently I'm working on a DVD player fo LINUX project.
>         My player use libc read() function on /dev/hdc, i.e. dvd rom in my
> system, to read data.
>         The last issue I encountered is difficulties during reading
> scratched discs.
>         Such disc will cause the dvd rom drive get ECC error (code = 0x40)
> when perorming the read action.
>         And the kernel will keep retrying to get the correct data from the
> disc.

A related problem in this case is that the reader thread will be stuck
in uninterruptible sleep, probably for several minutes.  Meaning, the
process can't even be stopped or killed.

Since the read tends to just return short, without raising an error at
all, the process will often immediately go back into uninterruptible
sleep if it does wake up, too, since it's spinning on the system call.
Signal delivery seems to be pretty flaky in this case too - you'd expect
a signal 9 to be delivered as soon as the process tries to wake up, but
it tends to not.  I've had to try junk like:

	while true ; do kill -9 $stupid_process ; done

.. just to get something to die when it's reading bad media.

A quick way around this tends to be to hit the eject button on the CD
drive itself - it will cause the driver to abort the read quickly when
it sees that the drive is empty.  However, if the tray is locked, this
is impossible (and sometimes, the driver will get into a bad state and
won't let you unlock the tray, either).

All around, error handling on CD's and DVD's is extremely flaky.


At the very least, if the driver is going to be in some sort of long
term wait, it needs to put the process in an interruptible sleep and
have some capability of aborting the request.

Of course, it gets worse in kernels where ide-scsi is in use, since in
that case error messages are often not even delivered.  Do I cdrom read
audio ioctl, watch it go to sleep *forever* after the IDE layer gets
reset underneath it and the request gets lost completely.  I loved
trying to debug that one at the application level. :-)

-J
