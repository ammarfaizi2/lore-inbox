Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265882AbSKBGag>; Sat, 2 Nov 2002 01:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbSKBGaf>; Sat, 2 Nov 2002 01:30:35 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:28646 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S265882AbSKBGae>;
	Sat, 2 Nov 2002 01:30:34 -0500
Date: Sat, 2 Nov 2002 01:37:04 -0500
From: Jim Paris <jim@jtan.com>
To: linux-kernel@vger.kernel.org
Subject: time() glitch on 2.4.18 at 177 days uptime?
Message-ID: <20021102013704.A24684@neurosis.mit.edu>
Reply-To: linux-kernel@vger.kernel.org, jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Linux 2.4.18 on an Athlon (i386).

My uptime is 182 days.  About five days ago, I started noticing
strange date effects.  It may be hardware related, but I'm also
suspecting that it may be due to the long uptime, and so I'm hesitant
to reboot, in case there is a bug here that needs to get fixed.

The problem is with time().  Every second, for approximately 1.1ms,
time() reports a value that is about 2^32 microseconds (4295 seconds,
or about an hour and a quarter) in the future.  The glitches always
occur between a change of seconds.  Look at this:

$ while true; do paste <( cat /proc/uptime ) <( date ) ; done | grep -A 1 -B 1 ' 02:' | head -11
15765463.31 15455589.84	Sat Nov  2 00:59:16 EST 2002
15765463.32 15455589.84	Sat Nov  2 02:10:51 EST 2002
15765463.33 15455589.84	Sat Nov  2 00:59:17 EST 2002
--
15765465.31 15455589.84	Sat Nov  2 00:59:18 EST 2002
15765465.32 15455589.84	Sat Nov  2 02:10:53 EST 2002
15765465.34 15455589.84	Sat Nov  2 00:59:19 EST 2002
--
15765466.30 15455589.84	Sat Nov  2 00:59:19 EST 2002
15765466.32 15455589.84	Sat Nov  2 02:10:54 EST 2002
15765466.33 15455589.84	Sat Nov  2 00:59:20 EST 2002

The first two values on each line are from /proc/uptime, and the rest
is of course from "date".  This bash script runs a bit slow, which is
why it missed the glitch between :17 and :18, but by watching time()s
more frequently, I can definitely see that they're there.  I don't
know for certain whether this happens at all times during the day, but
I believe it does.  I can do some more logging to figure that out if
necessary.

I've been running ntpdate (and therefore calling do_adjtime()) every
half hour since the system booted, in case that might affect
something.

This glitch does _not_ occur on a 2.2.? system on some x86 processor
with about 256 days uptime (I unfortunately don't know any more
details than that; I only have very limited access to that machine).
I also don't have access to any other 2.4 systems with an uptime of
greater than about 80 days.

This is not a glibc bug; the erroneous values are being returned by
the kernel.  Perhaps someone can help me track this down.  I've put my
kernel config and relevant info from /proc at

    http://neurosis.mit.edu/~jim/time-glitch/

(and would appreciate a CC of any replies)

-jim
