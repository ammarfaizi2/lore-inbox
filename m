Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRLQRAB>; Mon, 17 Dec 2001 12:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281512AbRLQQ7w>; Mon, 17 Dec 2001 11:59:52 -0500
Received: from david.siemens.de ([192.35.17.14]:37817 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S281483AbRLQQ7l>;
	Mon, 17 Dec 2001 11:59:41 -0500
Message-ID: <3C1E245C.4D44542F@mchr2.siemens.de>
Date: Mon, 17 Dec 2001 17:59:09 +0100
From: TDSCAF <Albert.Fluegel.gp@mchr2.siemens.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: autofs4 problem
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i have a really severe autofs4 problem. Kernel is 2.4.7,
Redhat-7.0, Hardware is a Fujitsu/Siemens HPC Line dual
Processor, so kernel is built with SMP turned on. automounter
Daemon is 4.0.0pre10 . gcc is 2.96:
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
RAM is 2 GB, CPU: Pentium III (Coppermine), 256 kb Cache,
Boot disk is an IDE disk, a SCSI Symbios 53c1010 hostadapter and
a connected additional disk is installed, but not used, the
SCSI-adapter driver isn't loaded. IDE controller is
ServerWorks OSB4.

I'm desperately trying to find the reason for my quite
reproducible problem (it's not the locking thing in the kernel
that has been fixed since quite a while)

Assume an map like that:

kaefer -rw /tmp2 kaefer:/tmp2
gustav -rw /tmp2 gustav:/tmp2
distel -rw /tmp2 distel:/tmp2
averna -rw /tmp2 averna:/tmp2
solp1 -rw /tmp2 solp1:/tmp2
...
host-1 -rw /tmp2 host-1:/tmp2
host-2 -rw /tmp2 host-2:/tmp2
...

i.e. all of those hosts have a /tmp2 directory, that is exported
properly. Automounter Daemon runs with the following args:

automount -t 1 /mnt/my-subdir yp map-name grpid,hard,nodevs,nosymlink

(or with file instead yp, makes no difference)

Basically we don't want a timeout, which is that short. But it
helps to reproduce the problem within minutes. Otherwise it
shows up after some hours, what is not acceptable for users
with long-running compute jobs. The software accesses the
/tmp2 directories and home-direcotries (also autofs-Mounted)
from time to time and once within a few hours the users see
either a "Permission denied" or "Directory does not exist".
And this happens with that stress test, too. Assume the following
script:

#!/bin/sh

# build a list of files to touch within one command
I=1
while [ $I -le 32 ] ; do
  FILES="$FILES /mnt/my-subdir/host-$I/tmp2/affile"
  I=`expr $I + 1`
done

while true ; do
  echo 'trying to touch and ls'
  touch $FILES
  if [ $? -ne 0 ] ; then
    exit 1
  fi
  ls -ld $FILES

  date

  /bin/rm -f /tmp/bla
  head -4c /dev/random > /tmp/bla
  RANDNUM=`sum /tmp/bla | awk '{print $1}'`
  WAITTIME=`expr '(' $RANDNUM ')' / 2 + 980000`

# random sleep time between 980 ms and ~ 1020 with script
# interpretatin ... delay - neglible

  ls -ld $FILES>/dev/null
  usleep $WAITTIME
done

What i try to achieve with that random delay is, that
during expire of the 32 mounts another access to them
occurs and this in fact happens quite frequently, some-
times leading to the mentioned error message during
touch, followed by the exit 1, sometimes not. I wouldn't
have a problem, if the problem showed up only under this
stress test, but it's happening also under `normal'
circumstances. This test runs between few seconds and
several (say, 20) minutes until failing. It is not
depending on the kind of NFS-Server. This can be either
a Linux or Sun machine. No notable difference. I tcpdumped
the network traffic. No clue. Or better: i can see, that
no new mount request is leaving the machine directed to
the server, that supplies one of the directories. Sometimes
the touch complains about olny one missing directory,
sometimes about 8 or so, in successive order (e.g.:
/mnt/my-subdir/host-7/tmp2 through /mnt/my-subdir/host-12/tmp2 )

I suspect, that the autofs4 returns from the revalidate thinking,
sth has been or is mounted, but has not in reality or has been
expired in the meantime. I experimented a lot. I modified
the daemon to serialize the mounts, not just fork and
report to the kernel, when done. Didn't help. Have a lot
of strace output about that. Looks all ok. So i suspected,
it's the kernel autofs4. Found several things, that looked
weird to me and modified them, but no success. What i tried
(please don't laugh, maybe some of the stuff is ridiculous):

* protected the queues linked list using a spinlock during
  traversal and modification against parallel accesses

* modified the autofs4_wait function in several more ways
  to have the queues list distinguish between the different
  notification requests. (If thought it might be a problem,
  that a mount request is being added, but finding an expire
  request, thinking 'oh, we have that already, can jump on the
  request for mount', though in fact waiting for expire, but i
  was wrong here, one more time)

* added an additional flag, cause i thought, it might happen
  during execution of the first lines of try_to_fill_dentry,
  where the dcache is not yet locked, that the test for
  AUTOFS_INF_EXPIRING fails and one thread/CPU walks on
  through the function while another CPU works in parallel
  on an ioctl-issued autofs4_expire_multi and before setting
  the flag, the other thread has passed the if. I added another
  flag, that is set in try_to_fill_dentry and checked in
  the autofs4_expire_multi to avoid, that the mountpoint in
  question will be expired, when not expected to expire.
  But this wasn't the problem either.

I have tons of syslog and strace -f output of the daemon, but
no more clues here.

This problem is quite a show-stopper here, otherwise we must
set the expire time to infinite, what is not really desirable
or we must use the userspace amd :-(

Any hint how to narrow the problem is appreciated.

Thanks for reading and with kindest regards,

 Albert

-- 
Albert Flügel              Tel.:   +49-89-636-27690
science+computing AG       Fax.:   +49-89-636-21950
bei: Infineon AG           D1:     +49-171-3698673
E-Mail:                    Albert.Fluegel.gp@mchr2.siemens.de
