Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbTC2N1i>; Sat, 29 Mar 2003 08:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263415AbTC2N1i>; Sat, 29 Mar 2003 08:27:38 -0500
Received: from CPE-203-51-31-188.nsw.bigpond.net.au ([203.51.31.188]:31741
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S263414AbTC2N1h>; Sat, 29 Mar 2003 08:27:37 -0500
Message-ID: <3E85A1EA.33BD604C@eyal.emu.id.au>
Date: Sun, 30 Mar 2003 00:38:50 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: problem with "ps -olstart"
References: <3E85003A.3DE4DDE7@eyal.emu.id.au> <20030329120928.GB12005@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> 
> On Sat, Mar 29, 2003 at 01:08:58PM +1100, Eyal Lebedinsky wrote:
> 
> > I see a different start time returned on different calls. An example
> > is attached below. This is a show stopper for me. Is this a known
> > problem? Does it have a solution?
> >
> > This is vanilla (my build) 2.4.20 on i386.
> >
> > $ while true ; do ps --pid "3026" -olstart,cmd --no-headers ; done
> > Thu Mar 27 22:03:11 2003 sh
> > Thu Mar 27 22:03:11 2003 sh
> > Thu Mar 27 22:03:12 2003 sh
> > Thu Mar 27 22:03:11 2003 sh
> 
> Look at your ps source. There are many incarnations of ps,
> but perhaps you'll find something like
> 
>         seconds_since_boot = uptime(0,0);
>         seconds_since_1970 = time(NULL);
>         time_of_boot = seconds_since_1970 - seconds_since_boot;
>         start = time_of_boot + pp->start_time/Hertz;
> 
> The interplay of rounding and truncating you see here
> results in what you see. Instead of using ps you might try
> a tiny utility that reads the start time directly.

OK, I can see how ps may be doing a bad job there. It can do
better, e.g. from I can identify a process using something like:
	grep btime /proc/stat
		time machine booted (secs since 1970 probably)
	cut -d' ' -f22 </proc/$pid/stat
		process start time (jiffies since boot)
and if I really want I can convert start_time to seconds and have
a value (the sum of the two) that does not change.

>From a user program, and not depending on /proc, I do not see
how I can access the kernel 'xtime' and 'task->start_time'.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
