Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbSJNEMH>; Mon, 14 Oct 2002 00:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261814AbSJNEMG>; Mon, 14 Oct 2002 00:12:06 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:18670 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S261812AbSJNEMG>; Mon, 14 Oct 2002 00:12:06 -0400
Date: Sun, 13 Oct 2002 21:17:56 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] 2.5.42 partial fix for older pl2303
Message-ID: <20021014041756.GD17162@ip68-4-86-174.oc.oc.cox.net>
References: <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com> <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net> <20021012205604.GB17162@ip68-4-86-174.oc.oc.cox.net> <20021013004249.GC17162@ip68-4-86-174.oc.oc.cox.net> <20021013011644.GA12720@kroah.com> <20021013043008.GD10921@ip68-4-86-174.oc.oc.cox.net> <20021013202504.GA23533@kroah.com> <20021014024930.GE10921@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014024930.GE10921@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 07:49:30PM -0700, Barry K. Nathan wrote:
> On the contrary, the percentage of non-working PL-2303 opens has now
> gone from 50% to somewhere in the 5-15% range (rough guess). IOW, it's
> working better than my previous patch.
> 
> FWIW, I'm seeing some "sleeping function called from illegal context"
> oopses, but I didn't see if those were happening with my old patch. I'll
> test with your latest batch of USB changes later (after they get merged
> by Linus, most likely).

After applying the cset-1.782-to-1.850.txt.gz from
kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/ I'm still having the
intermittent problems with the PL-2303 playing dead, and I got this
message once after boot (I think I had two times after boot that the
device seemed dead, FWIW):
drivers/usb/host/ohci-q.c: 00:01.2 bad entry  fb041c0

followed by tons of these oopses (I think it's one per LCP echo
request/reply pair on my PPP connection but I'm not sure):

Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c02095f7>] serial_write+0x77/0x170
 [<c01da4e8>] ppp_async_push+0x138/0x1c0
 [<c01da3a5>] ppp_async_send+0x45/0x50
 [<c01d674e>] ppp_channel_push+0x7e/0x1a0
 [<c01d548d>] ppp_write+0xfd/0x130
 [<c013d67d>] vfs_write+0xcd/0x140
 [<c013d78c>] sys_write+0x3c/0x60
 [<c01075cb>] syscall_call+0x7/0xb

Also, I just tried unplugging and replugging my PL-2303. It gets changed
to ttyUSB1, ttyUSB2, etc. each time. (The removal of the PL-2303 seems
to be detected each time, judging by what I could figure out from the
logs, though.) Attempts to use it at the new device node work.

Attempts to use it at the old device node result in the user program
hanging or waiting for a response (I didn't look at things too closely
so I'm not exactly sure what's going on), and another ...ohci-q.c...bad
entry message (but no oops) is emitted when the program in question is
killed.

Under 2.4.20-pre10 + my 2.4 fix, the device always gets ttyUSB0, and
always works there.

All of this was with USB serial verbose debug disabled. I can try again
with it enabled, or try again with any other patches/suggestions, if it
would help figure out what's going on.

-Barry K. Nathan <barryn@pobox.com>
