Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTFANln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTFANln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:41:43 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:20031 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S264629AbTFANlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:41:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Linux 2.4.20, 2.4.21-rc6 both stalls - from low free memory
Date: Sun, 1 Jun 2003 09:51:57 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB0187FFE1@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.4.20, 2.4.21-rc6 both stalls - from low free memory
Thread-Index: AcMoRUG+cSHdzFuHQGm981oTrzFsWg==
From: "Lauro, John" <jlauro@umflint.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I posted a message Friday to the usenet group, but it must be a
one-way gateway...  I'll include it at the end as it has more
details...

2.420 and 2.4.21-rc6 both have major freezes during heavy writes.
Watching "vmstat 1" will give a clue as free droping below 4000 will
almost guarantee it.  It takes hours for my system to recover once
hit...

Lots of inactive pages, free buffers and clean cache pages, etc...
The server has 12GB of RAM.

After the last incident while trying to convert a mysql database to an
oracle database, I drove back into work and used <shift><scrollock>
and free was at 815.

Is there a way I can make free pages get released sooner/more
aggressively?  
In the Documentation directory of the 2.4.21-rc6 it talks about
freepages in sysctl/vm.txt and filesystems/proc.txt to tune it, but I
can not find that.

Would  [PATCH] rmap 15j for 2.4.21-rc6 help?  Unfortunately I can't do
much testing as I need to make this a production box...

PS: 2.4.16-rc6 seems to have significantly more overhead compared to
2.4.20.  However that might be due to HZ running at 1000 instead of
100 on my two comparisons, but the performance drop seems larger.  


Below is my first message that went to usenet instead of directly to
the list...:
Hello,

This is my first post on the subject, but I tried to read all articles
related to this prior to posting...

At first I noticed the problem with 2.4.20 on this new box and started
looking for a solution and seen that 2.4.21-RC6 had some patches that
helped
for some on similiar issues....

2.4.21-RC6 did not help me... :(

I seen some posts on this apparent ongoing problem, so hopefully my
observations might help as I think I noticed some things that others
did not
mention...
Server config:  Dual 2.8Ghz Xeon with 12GB of RAM, main data area on
ext3 on
LVM RAID 0 on HW RAID 1.  Swap and some lesser used partitions on ext3
(no
LVM HardWare RAID 1).  Kernel is running with HZ at 1000.

The way I reproduce:  Heavy writes on an already moderately busy but
70%
idle box...

The way I watch for it:
vmstat 1   (from the console, or ssh session, no X on the box so I can
watch
the mouse....)
As that outputs one line a second, I can tell when it freezes, at that
stops....

What generally happens is memory on free (according to vmstat) gets
low,
(somewhere around 4000 appears to be the freeze spot) .  After several
seconds (or minutes :( ) it gets to 9000 or maybe not that much and
responds
a little untill memory drops down again.  Next to no output on the
drives
while it's stalled...

While it's stalled, switching consoles (ALT-F#> can take a second.
and
typing on the console takes 1 or 2 seconds to echo.  No response back
from
telenet/ssh to a box untill the pauses stop....

If I know I am going to be doing heavy writes, but not more then a
several
GB....  I have a work around...  I wore a simple problem the allocates
3GB
of RAM (only takes a a few second to run and doesn't pause the system,
and
then exits).  This gets free from about 6000-10000 it normally likes
to
hover around to over 3,000,000.  Then there is no lockups during the
writes....  as long as free stays above 5000....

I need to get this system stable under heavy writes.  What kernel do
you
recommend?  The lowest (I think) I can go back to is 2.4.16 for driver
reasons. Support for >12GB is critical.  What kernel versions started
having
this problem?

As another data point, here was some top stats from top in the middle
of a
few seconds between lock outs.
177 process, 155 sleeping, 22 running, 0 zombie, 0 stopped
CPU0 status: 1.63 user, 98.2 system, 0.0 nice 0.0: iowait  0.0 idle
CPU1 status 0.34 user  99.30 system  0.0 nice, 0.0 iowait 0.0 idle

Mem: 12,103,348k av, 12097532k used,  5816k free, 0 shard,  75244k
buff
            2,575,7540k active,  9,047,304k inactive
swap: 4192956k av, 20,808k used   4172148k free,   11439524k cache

Load was running something 90 something, and this box should of
normally
have been under 1, or at most 2 with the job that was creating the
20GB of
data....

