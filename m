Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274960AbTHLBSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274963AbTHLBSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:18:20 -0400
Received: from birdwell-public.alexa.com ([67.107.182.10]:22033 "EHLO
	moneyb.presidio.alexa.com") by vger.kernel.org with ESMTP
	id S274960AbTHLBSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:18:13 -0400
Message-ID: <0D122719B1756A43AD405320EE3D8EFA01278D79@moneyb.alexa.com>
From: Guolin Cheng <guolin@alexa.com>
To: linux-kernel@vger.kernel.org
Cc: "'engineering@alexa.com'" <engineering@alexa.com>, Ops <ops@alexa.com>
Subject: Help! How to increase linux per-machine, per-user and per-process
	 resource limits??
Date: Mon, 11 Aug 2003 18:18:11 -0700
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

  I encounter problems of how to increase Linux sytem-wide(per-machine),
per-user and per-process resource limits, I mean, the open file limit, inode
limit,  and concurrent process limit.

  I'm running Redhat Linux 8.0 and a generic 2.4.20 kernel downloaded
directly from www.kernel.org. 

  After searched internet for related information/solution, I still can not
get a clear idea about how to do the above work correctly, or accurately.
The following are my questions, please help me to clarify/fix the problems.


1,  system-wide open file limit:  this limit seems controlled by the line
"#define NR_OPEN (1024*1024)     /* Absolute upper limit on fd num */" in
header  file /usr/src/linux/include/linux/fs.h. But after the kernel
recompiled|installed|rebooted, we see a smaller number in
/proc/sys/fs/file-max:

		[root@ops-test1 root]# cat /proc/sys/fs/file-max
		65535
		[root@ops-test1 root]# 

   The following is from the file
/usr/src/linux/Documentation/filesystems/proc.txt:

		file-nr and file-max
		--------------------

		The kernel  allocates file handles dynamically, but doesn't
free them again at
		this time.

		The value  in  file-max  denotes  the  maximum number of
file handles that the
		Linux kernel will allocate. When you get a lot of error
messages about running
		out of  file handles, you might want to raise this limit.
The default value is
		4096. To change it, just write the new number into the file:

		  # cat /proc/sys/fs/file-max
		  4096
		  # echo 8192 > /proc/sys/fs/file-max
		  # cat /proc/sys/fs/file-max
		  8192

   The following is from the proc(5) manual page,

              The  file  file-max is a system-wide limit on the number of
open
              files for all processes.  (See also setrlimit(2), which  can
be
              used  by  a process to set the per-process limit,
RLIMIT_NOFILE,
              on the number of files it may open.)  If you get lots  of
error
              messages  about running out of file handles, try increasing
this
              value:

              echo 100000 > /proc/sys/fs/file-max

              The kernel constant NR_OPEN imposes an upper limit on the
value
              that may be placed in file-max.

              If  you  increase file-max, be sure to increase inode-max to
3-4
              times the new value of file-max, or you will run out of
inodes.

  So, since I NR_OPEN is (1024*1024) in kernel source code, I should get a a
failure return when trying to input a >1048576 (=1024*1024) number into the
/proc/sys/fs/file-max,   right? But actually, it works there.

		[root@ops-test1 root]# uname -a
		Linux ops-test1.alexa.com 2.4.20-v5 #3 SMP Thu May 1
17:37:52 PDT 2003 i686 i686 i386 GNU/Linux
		[root@ops-test1 root]# cat /proc/sys/fs/file-max
		65536
		[root@ops-test1 root]# echo 104857700 >
/proc/sys/fs/file-max
		[root@ops-test1 root]# cat  /proc/sys/fs/file-max
		104857700
		[root@ops-test1 root]# 

2, for system-wide inode limit, I don't know where it is defined. It is said
that the parameter is dynamically adjustable through file
/proc/sys/fs/inode-max, But actually, the file /proc/sys/fs/inode-max
doesn't exist at all!

	The following is from proc(5) manual page as well.

              The  file  inode-max  contains  the  maximum number of
in-memory
              inodes.  On some (2.4) systems, it  may  not  be  present.
This
              value  should  be  3-4  times larger than the value in
file-max,
              since stdin, stdout and network sockets also need  an  inode
to
              handle  them.  When you regularly run out of inodes, you need
to
              increase this value.

		[root@ops-test1 fs]# ls /proc/sys/fs/inode*
		/proc/sys/fs/inode-nr  /proc/sys/fs/inode-state
		[root@ops-test1 fs]# cat /proc/sys/fs/inode-nr
		129329  61
		[root@ops-test1 fs]# cat /proc/sys/fs/inode-state
		129329  61 0 0  0       0      0
		[root@ops-test1 fs]# 

 3, for system-wide process limit, I mean, the total number of maximum
concurrently running processes, is not defined anywhere in kernel source
tree?? or not dynamically adjustable? I can not find any helpful information
on this.


 4, for per-user limits, It's said that we can add related entries in
/etc/security/limits.conf for control purposes. But in this file, we can
only increase limit on open file limit and maximum processes limit. and even
worse, one question and two problem described below comes with it.Please
advice me on how to do it in a accurate way. 

		bash-2.05b# ulimit -a
		core file size        (blocks, -c) unlimited
		data seg size         (kbytes, -d) unlimited
		file size             (blocks, -f) unlimited
		max locked memory     (kbytes, -l) unlimited
		max memory size       (kbytes, -m) unlimited
		open files                    (-n) 1024
		pipe size          (512 bytes, -p) 8
		stack size            (kbytes, -s) 8192
		cpu time             (seconds, -t) unlimited
		max user processes            (-u) 6143
		virtual memory        (kbytes, -v) unlimited
		bash-2.05b#  

  4a,  The default per-user maxproc limit is related to physical memory
installed, the algorithm seems coded in /usr/src/linux/kernel/fork.c, which
is attached below:

		void __init fork_init(unsigned long mempages)
		{
		        /*
		         * The default maximum number of threads is set to a
safe
		         * value: the thread structures can take up at most
half
		         * of memory.
		         */
		        max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) /
8;

		        init_task.rlim[RLIMIT_NPROC].rlim_cur =
max_threads/2;
		        init_task.rlim[RLIMIT_NPROC].rlim_max =
max_threads/2;
		}
  as a consequence of the above, maxproc per user is set to 512 for machines
with 64M memory, or 2048  for 256M, 4096 for 512M, and then at last 7168 for
>=896M, where comes the number 896M?

 4b, I changed  the file /etc/security/limits.conf , added the following two
lines into it, setting both hard/soft limits:
	*       -  nofile              1048576  
	*       -  nproc              1048576

But I have to reboot machine to let the newly increased limits to kick in.
Even worse is,  these new limts only take effect in local sessions only! if
you login through ssh remote session, you still get the original smaller
limits!

 4c, to let remote session through ssh use the newly increased limits, I
have to maunally edit file /etc/rc.d/rc script, and add the following lines
to the end:
	ulimit -n 1048576
	ulimit -u 1048576
    Since all the booting scripts at all runlevels under /etc/rc.d/rc*.d are
started by script /etc/rc.d/rc, this fix the problem on 4b problem above,
But we need another reboot again. and I don't know whether this is a good
way to do it. Please advice.


5, For per-process open-file limit, inode limit and proc limit, I can ONLY
find some info about open-file limit, which seems controlled by a parameter
NR_FILE the same file /usr/src/linux/include/linux/fs.h, the following is
from the file /usr/src/linux/include/linux/fs.h ( the limit is increases to
8 times of original value)

		.....
		/*
		 * It's silly to have NR_OPEN bigger than NR_FILE, but you
can change
		 * the file limit at runtime and only root can increase the
per-process
		 * nr_file rlimit, so it's safe to set up a ridiculously
high absolute
		 * upper limit on files-per-process.
		 *
		 * Some programs (notably those using select()) may have to
be
		 * recompiled to take full advantage of the new limits..
		 */

		......
		#define NR_FILE  65536  /* this can well be larger on a
larger system */
		#define NR_RESERVED_FILES 100 /* reserved for root */
		#define NR_SUPER 4096
		.....


 I don't know how to adjust the value on-line through /proc interface, or
even worse, I don't know where I can see the current value at all. It's
quite easy to confusion the per-process limits with per-user limits, Any
suggestions? or the per-user limits and per-process limits are the same?
while the latter seems untrue..

 Thanks.
 --Guolin Cheng


 

