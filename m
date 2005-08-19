Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVHSAbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVHSAbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHSAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:31:44 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:43155 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932537AbVHSAbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:31:43 -0400
Date: Thu, 18 Aug 2005 17:31:43 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: dying disk results in unusable system
Message-ID: <Pine.LNX.4.63.0508181535450.20705@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi...

i've run into this a bunch of times, but decided to look at it more 
closely today.  i use IDE disks in md raid1 and/or raid5, and when one 
disk is dying or dead it tends to make the entire system unusable.

i don't really fault md here, because i'm pretty sure there are some 
fundamental problems...

for example, my test setup has a bad disk and a good disk.  the bad disk 
is sufficiently alive that it's detected at boot time, but pretty much 
every write to it results in a disk error.

the good disk houses the entire system, and is mounted noatime,nodiratime 
(i don't want writes until i trigger them).

after boot i do this:

	dd if=/dev/zero of=/dev/baddisk bs=1M &

wait 10 or 20 seconds, monitoring vmstat output until almost all memory is 
taken by buffers.  then i simulate something like queueing a mail message 
(on the good disk):

	perl -e 'open(F,">/var/tmp/foo"); print F "x" x 16384; fsync(F); close(F);'

this will essentially never complete.  it might complete, but it'll take a 
lot longer than my patience -- and regardless it's long enough to be bad 
for any real system.

in order to eliminate one variable i've split the bad disk and good disk 
onto different controllers -- bad on a promise ultra100, and good on a 
3ware 7504.

the current state of the system is like so:

# vmstat 5
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
...
 0  6      0 181900 1714472  50148    0    0     0     0 1001    88  0  0  0 100
...

# ps auxww | grep D
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       144  0.0  0.0      0     0 ?        D    16:50   0:00 [pdflush]
root       145  0.0  0.0      0     0 ?        D    16:50   0:00 [pdflush]
root      3326  0.0  0.0   6768  1044 ?        Ds   16:50   0:00 /sbin/syslogd
ntp       3429  0.0  0.2  15316  5144 ?        DLs  16:50   0:00 /usr/sbin/ntpd -p /var/run/ntpd.pid -u 104:104
root      3613  1.3  0.0   3976   496 pts/0    DN   17:03   0:02 dd if /dev/zero of /dev/hde bs 1M
root      3654  0.0  0.0  12460  1040 ?        D    17:05   0:00 /USR/SBIN/CRON
root      3656  0.0  0.0  10424  1564 pts/1    D+   17:05   0:00 perl -e open(F,">/var/tmp/foo"); print F "x" x 16384; fsync(F); close(F);

my theory is that pretty much all of memory is dirty buffers which can 
never be flushed... and perhaps pdflush is also stuck trying to flush 
those unflushable buffers, because it won't skip ahead in the queue of 
dirty buffers.

generally at this failure point it becomes impossible to even log into the 
system because of the handful of writes required... and clean reboots are 
hopeless because sync will never complete.

the kernel is debian 2.6.12-1-amd64-k8-smp, but it's a problem i've 
experienced many times over the years... if there are other patches or 
kernels i should try, let me know.

i'm hoping this might cause some discussion... i see a few possibilities:

- if there were some way to explicitly drop dirty buffers then md raid[156]
  could drop dirty buffers for the first disk to fail in a raid set -- this
  would dramatically increase survivability for raid[156] setups when a
  disk fails in this manner.  (dropping dirty buffers in multidisk failures
  might not be desirable...)

- something like blockdev(8) could be used to manually drop dirty buffers
  in other write failure situations.  i.e. without md i think it should
  possibly be up to the admin to decide to drop dirty buffers.

- if pdflush really is stuck doing only bad writes then maybe it should
  have some way to deprioritize writes to devices which have had write
  failures recently.

- when a disk has exhibited a write error then be more aggressive about
  blocking processes writing to the disk -- i.e. behave as if
  /proc/sys/vm/dirty_ratio is a lot lower for that device.  i'm skeptical
  this would halt my dd process fast enough though -- because it barely
  takes it any time to chew up all of memory with dirty buffers... i'm
  sure the first error report comes too late.

- send dirty buffers for bad disks to swap??  this is at least a safe thing
  to do even on non-raided systems... and it gets past the memory choke.

thoughts?  i'm going to hang onto this bad disk so i can try out patches...
if folks point me in the right direction(s) i could even work on fixes.

-dean
