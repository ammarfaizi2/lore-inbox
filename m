Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbRBAHDk>; Thu, 1 Feb 2001 02:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbRBAHDa>; Thu, 1 Feb 2001 02:03:30 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:23665 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129073AbRBAHDP>; Thu, 1 Feb 2001 02:03:15 -0500
Message-ID: <3A790A16.C964877@linux.com>
Date: Wed, 31 Jan 2001 23:02:46 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Chris Mason <mason@suse.com>,
        reiserfs-list@namesys.com
Subject: VM brokenness, possibly related to reiserfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Chris, changing JOURNAL_MAX_BATCH from 900 to 100 didn't affect
anything).

Ok, having approached this slightly more intelligently here are [better]
results.

The dumps are large so they are located at http://stuph.org/VM/.  Here's
the story.  I boot and startx, I load xmms and netscape to eat away
memory.  When free buffers/cache falls below 7M the system stalls and
the only recovery is sysrq-E or reboot.  At the moment of stall the disk
will grind continuously for about 25 to 30 minutes then go silent.  At
this point in time the only recovery is reboot, sysrq-E won't work.

If I move the mouse or type a key within 30 seconds of this incident,
that user input will take about 5 minutes to register.  After that
initial minute, nothing more will happen.

Kernel 2.4.1, with reiserfs, devfs, no patches applied.

"klog-X" are basically the same thing but I'm running top, syslogd, and
klogd with -20 priority.  I didn't note anything out of the ordinary in
top.  These are snapshots where I've managed to murder processes and
restart the problem without rebooting.

In the second instance, I had my finger on the kill button and managed
to kill netscape and recover partially.  However the system was heavily
loaded even after the kill.

I have xmms in STOPped state so it's just waiting.

kswapd is taking 12.2% of the CPU according to ps, and kapm-idled is
taking 26.9%.  bdflush is taking 2.7%, X 3.5%, all others are nominal.
The system load was hovering at 1.00 for a few minutes then dropped to
zero.  However scrolling text in an rxvt is slow enough to watch blocks
move.  Running "ps aux" takes nearly one third of a second for total
time.  Total number of processes is ~40.

Jan 31 22:31:51 nifty kernel: kapm-idled  S CBF77F94  4124     3
1        (L-TLB)       4     2
Jan 31 22:31:51 nifty kernel: Call Trace: [schedule_timeout+115/148]
[process_timeout+0/72] [apm_mainloop+221/256] [apm+668/692]
[kernel_thread+31/56] [kernel_thread+40/56]

Jan 31 22:31:51 nifty kernel: kswapd    S CBF75FAC  5704     4
1        (L-TLB)       5     3
Jan 31 22:31:51 nifty kernel: Call Trace: [schedule_timeout+115/148]
[process_timeout+0/72] [interruptible_sleep_on_timeout+66/92]
[kswapd+213/244] [kernel_thread+40/56]

Jan 31 22:31:52 nifty kernel: bdflush   S CBF70000  5912     6
1        (L-TLB)       7     5
Jan 31 22:31:52 nifty kernel: Call Trace: [bdflush+206/216]
[kernel_thread+40/56]


In the fourth snapshot, I have put xmms in STOP state again inside the
memory shortage, memory is at 4800 free buffers/cache and 1592 free mem.

As I entered this shortage period I started a 'ps -eo ... > file' to try
and record data there.  This is the only disk activity happening.  Load
is ~4.00.  I have now killed the ps.

Load has dropped significantly and I have tolerable but quite laggy user
input responsiveness now.

Memory is currently 4900/1588 like above.  Load is about 2.00 and will
continue dropping if I don't do anything.  Any processes I exec which
need to be loaded from disk take several seconds.  I.e. 'uptime' takes
about 4 seconds to execute.

Snapshot #5 will be the last one and I will reboot.  Once memory is
freed from xmms (back to 150megs free), everything is peachy.


-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
