Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbRBVVTH>; Thu, 22 Feb 2001 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRBVVS5>; Thu, 22 Feb 2001 16:18:57 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:35701 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129119AbRBVVSu>;
	Thu, 22 Feb 2001 16:18:50 -0500
Message-ID: <3A9581CF.33C66558@sgi.com>
Date: Thu, 22 Feb 2001 13:17:03 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: interactive disk performance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A problem that I seem to have noticed to some extent or another in the 2.4 series
is that while the elevator algorithm may achieve best disk bandwidth utilization,
it seems to be heavily at the expense of interactive use.

I was running a disk intensive program over nfs, so the nfsd's were quite busy --
usually 3/4 were in 'D' wait.

During this time, I tried to bring up this compose window for the email I am
writing.  It took over 2 minutes to come up.  Now the CPU is 66%idle, 31%in idled --
meaning it's fairly inactive -- everything was waiting on the disk waits.

I'm sure that the file the nfsd's were writing out was one long contiguous stream --
most of which could be coalesced into large multi-block writes.  Somehow it seems
that the multi-block writer was getting 1 block in, then more blocks kept coming
in so fast that the Q would only unplug every once in a while -- and maybe 1
block of an interactive request would go through.

I don't remember the exact timeout or max wait/sector while blocks are being
coalesced, but it seems it heavily favors the heavy disk user.

In Unix design, the CPU algorithm was designed to lower the priority of CPU
intensive tasks such that interactive use got higher priority for short bursts.

Maybe a process should have a disk (and maybe net while we are at it) priority that adjusts
based on usage in the way the CPU algorithm adjusts -- then the block structure could
have an added 'priority' field of what the process's priority was when it wrote the
block.  Thus even if a process goes away -- the blocks still retain priority.

Then the elevator algorithm would sort not just by locality but also weighting it 
with the block's priority.  Perhaps it would be a make-time or run-time configurable
whether or not to optimize for disk-throughput, or interactive usage.  Perhaps even
a 'nice' value that allows the user to subjectively prioritize processes.

Possible?  Usefulness?

-l


-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
