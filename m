Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKASjg>; Wed, 1 Nov 2000 13:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbQKASj0>; Wed, 1 Nov 2000 13:39:26 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:17414 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S129171AbQKASjX>; Wed, 1 Nov 2000 13:39:23 -0500
Message-ID: <3A006340.93822A@dm.ultramaster.com>
Date: Wed, 01 Nov 2000 13:38:56 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] /proc/<pid>/stat access stalls badly for swapping process, 
 2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi VM/procfs hackers,

System is UP Athlon 700mhz with 256mb ram running vanilla 2.4.0-test10.
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

I'd like to report what seems like a performance problem in the latest
kernels.  Actually, all recent kernels have exhibited this problem, but
I was waiting for the new VM stuff to stabilize before reporting it. 

My test is: run 7 processes that each allocate and randomly access 32mb
of ram (on a 256mb machine).  Even though 7*32MB = 224MB, this still
sends the machine lightly into swap.  The machine continues to function
fairly smoothly for the most part.  I can do filesystem operations, run
new programs, move desktops in X etc.

Except: programs which access /proc/<pid>/stat stall for an inderminate
amount of time.  For example, 'ps' and 'vmstat' stall BADLY in these
scenarios.  I have had the stalls last over a minute in higher VM
pressure situations. 

Unfortunately, when system is thrashing, it's nice to be able to run
'ps' in order to get the PID to kill, and run a reliable vmstat to
monitor it.

Here's a segment of an strace of 'ps' showing a 12 second stall (this
isn't the worst I've seen by any means, but a 12 second stall trying to
get process info for 1 swapping task can easily snowball into a DOS).

     0.000119 open("/proc/4746/stat", O_RDONLY) = 7
     0.000072 read(7, "4746 (hog) D 4739 4739 827 34817"..., 511) = 181
    12.237161 close(7)                  = 0

The wchan of the stalled 'ps' is in __down_interruptible, which probably
doesn't help much.

This worked absolutely fine in 2.2.  Even under extreme swap pressure,
vmstat continues to function fine, spitting out messages every second as
it should.

David Mansfield
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
