Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269169AbRHBVCp>; Thu, 2 Aug 2001 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbRHBVC0>; Thu, 2 Aug 2001 17:02:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22400 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269152AbRHBVCW>; Thu, 2 Aug 2001 17:02:22 -0400
Date: Thu, 2 Aug 2001 17:01:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021301260.21298-100000@heat.gghcwest.com>
Message-ID: <Pine.LNX.3.95.1010802165949.7742A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:

> 
> 
> On Thu, 2 Aug 2001, Richard B. Johnson wrote:
> 
> > Seriously, it doesn't do any good to state that something sucks. You
> > need to point out the specific problem that you are experiencing.
> > "going to la la land.." is not quite technical enough. In fact, you
> > imply that the machine is still alive because of "disk thrashing".
> > If, in fact, you are a member of the Association for Computing Machinery
> > (so am I), you should know all this. Playing Troll doesn't help.
> >
> > If you suspend (^Z) one of the huge tasks, does the thrashing stop?
> > When suspended, do you still have swap-file space?
> > Are you sure you have managed the user quotas so that the sum of
> > the user's demands for resources can't bring down the machine?
> 
> Anyone having observed this mailing list over the last year knows the
> problem I'm a talking about.  kswapd can get itself into a state where it
> consumes 100% CPU time for hours at a stretch.  During this time, the
> machine is unusable.  There is no way to kill or suspend a task because
> the shells aren't getting scheduled and they can't accept input.  During
> this time, the disks aren't running of course.  Leading up to this, the
> disks do run.  Then when kswapd steps in, they stop, or the throughput
> falls to a trickle.
> 
> Here's a nice trick to pull on any Linux 2.4 box.  Allocate all of the RAM
> in the machine and keep it.  Now, thrash the VM by e.g. find / -exec cat
> {} \;  Watch what happens.  The kernel will try to grow and grow the disk
> cache by swapping your process out to disk.  But, there may not be enough
> room for your process and all the cache that the kernel wants, so the
> machine goes into this sort of soft-deadlock state where kswapd goes away
> for a lunch break.

Well I don't have any such problems here. I wrote this script
from your instructions. I don't know if you REALLY wanted all
the file content to go out to the screen, but I wrote it explicitly.


#!/bin/bash
#
#
SIZ=`head --lines 2 /proc/meminfo | grep Mem | cut -d' ' -f3`
cat >/tmp/try.c <<EOF
#include <stdio.h>
#include <unistd.h>
#include <malloc.h>
int main(void);
int main()
{
    char *cp;

    cp = malloc($SIZ);
    memset(cp, 0x55, $SIZ);
    pause();
    return 0;
}
EOF
gcc -Wall -O2 -o /tmp/try /tmp/try.c
/tmp/try &
find / -exec cat {} \;
# end

Script started on Thu Aug  2 16:50:47 2001
# ps -laxw | grep pause
   140     0    16     1  -1 -20    712    40 pause       S < ?   0:00 (bdflush) te 
     0     0  7433     1   9   0 321056 137808 pause       S    1  0:02 /tmp/try 
     0     0  7631  7626  19   0    844   240             R   p0  0:00 grep pause 
# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  328048640 326234112  1814528        0  4255744 173219840
Swap: 1069268992 189992960 879276032
MemTotal:       320360 kB
MemFree:          1772 kB
MemShared:           0 kB
Buffers:          4156 kB
Cached:         169160 kB
Active:           9616 kB
Inact_dirty:     36012 kB
Inact_clean:    127688 kB
Inact_target:      780 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320360 kB
LowFree:          1772 kB
SwapTotal:     1044208 kB
SwapFree:       858668 kB
# exit
exit

Script done on Thu Aug  2 16:51:26 2001


As you can see, it was quite sucessful in writing to real-RAM-size
of virtual RAM, then swapping it out so other stuff could run.

You can also do:
    for(;;)
       memset(cp, 0x55, $SIZ);
... and have a very slow, but usable, system. This was from the
root account with no quotas.

Perhaps there are problems with buffers that I don't have because
I use SCSI disks for everything.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


