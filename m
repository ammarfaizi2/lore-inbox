Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWGKNCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWGKNCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWGKNCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:02:51 -0400
Received: from gw.exalead.com ([193.47.80.25]:393 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S1750737AbWGKNCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:02:50 -0400
Message-ID: <44B3A178.2060908@exalead.com>
Date: Tue, 11 Jul 2006 15:02:48 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.0.2) Gecko/20060404 SeaMonkey/1.0.1 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Huge performance issue with cciss driver on HP DL385 servers (2.6.13
 -> 2.6.17)
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

We are facing a very serious I/O performance problem with a 2.6.16 Linux
kernel running on HP DL385 servers. From time to time, the disk access
become *really* slow, and the "iostat" tool reports an average I/O
service time greater than 30 ms, with only a single-threaded program
doing sequential read or write operations. We have observed this problem
on various versions of the Linux kernel (downloaded from the kernel.org
ftp site), ranging from 2.6.13 to 2.6.17 . The current configuration of
our production kernel is "Linux ng5 2.6.16-gentoo-r4-Exalead #1 SMP Thu
May 4 16:11:19 CEST 2006 x86_64 AMD Opteron(tm) Processor 246 GNU/Linux"
(see config below). We are running our software on the following hardware:

HP DL 385 with 2 dual core AMD Opteron 265, 16 GB memory
HP Smart Array P600

The problem was also observed on a DL585 with 4 single core AMD Opteron
844 and a HP Smart Array 6402.

After lots of tests and tries, we have been able to isolate two
different problems:

1) From time to time, the server seems to enter into a "slow I/O" mode,
where the entire machine becomes affected by the performance drop. This
mode seems to be sticky, in the sense that the performance remain bad
until a reboot of the server. When in this mode, all I/O operations are
slowed down, and even a single tar or rsync command on a few gigabytes
can take hours, with iostat reporting an average service time greater
than 10 ms (instead of less than 1 ms in "normal" mode). For the moment,
we have not been able to find a deterministic way of triggering this
sticky mode.

2) Some very specific sequences of system calls result in "locally" slow
I/O transfers ("locally" meaning that the performance drop only affects
the process running the system calls, and that the slow down is not
sticky like the problem described in 1) ). We have found a way to
deterministically reproduce this bug, with the attached program
(iotest.c, compile with "gcc -g -m64 -o iotest iotest.c"). This program
basically reproduces a sequence of system calls used in a inter-server
file transfer tool we are using (similar to rsync, using O_DIRECT
transfers): the program is a single thread receiving bytes from a TCP
socket, and writing them into a file opened in O_DIRECT mode. The
following conditions are required to trigger the bug:

   - the test program must be run just after a reboot, on an idle machine
   - the file must be created on an ext3 filesystem
   - the file must be opened in O_DIRECT mode
   - the buffer passed to pwrite() must be larger than 1024 KB
   - the /sys/block/cciss\!c0d2/queue/max_sectors_kb kernel parameter
must be set to 256 (default value)

When this program runs, the iostat command reports a unusally high value
of service time:
[POS
Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
avgrq-sz avgqu-sz   await  svctm  %util
cciss/c0d0   0.00   0.90  0.00 31.80    0.00    0.00     0.00     0.00
    0.00     3.67  115.43  30.26  96.24

Note that the very same program, writing the very same output file does
not always show the problem when run on a machine that has a longer uptime.

We have a strong presumption that the problem is related to the size of
the requests sent to the cciss driver. Attached to this message are the
traces created by the blocktrace tool, for two executions of the test
program with a 1024 KB buffer, on the same file. The first trace
("Slow I/O" below) corresponds to the "slow I/O" problem, run just after
booting the machine. The second trace ("Normal I/O" below) corresponds
to a run of the program that did not show the problem. The most visible
difference between the two traces is that the "slow_io" trace shows
larger write requests than the "normal_io" trace (512 sectors instead of
248).
We have tried to lower the value of the max_sectors_kb parameter, and it
seems to make the problem disappear (we were not able to observe it with
a max_sectors_kb value of 128).
The max_sectors_kb parameter, however, does not seen to affect the
"sticky" slow I/O problem described in 1).



Test program:
-------------

#define _XOPEN_SOURCE 500
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>

/* a running ttytst source IP */
#define CHARGEN_IP "192.168.115.175"

int main(int argc, char **argv) {
  if (argc != 3) {
    fprintf(stderr, "usage: %s FILE BUFSIZE\n", argv[0]);
    return -1;
  }

  char* fname = argv[1];
  size_t bufflen = strtol(argv[2], NULL, 10);
  if (bufflen % 512 != 0 || bufflen == 0) {
    fprintf(stderr, "illegal buffer size: %s\n", argv[2]);
    return -1;
  }

  /* Allocate a 512-bytes aligned buffer for O_DIRECT transfers. */
  void* buffer = malloc(bufflen + 512);
  size_t delta = 512 - ((size_t) buffer) % 512;
  void *abuffer = buffer + delta;

  /* Connect a socket to a chargen server. */
  int sd = socket(PF_INET, SOCK_STREAM, 0);
  struct sockaddr_in daddr;
  if (sd == -1) {
    perror("cannot create socket");
    return -1;
  }
  daddr.sin_family = AF_INET;
  daddr.sin_port = htons(19);
  daddr.sin_addr.s_addr = inet_addr(CHARGEN_IP);
  if (connect(sd, (struct sockaddr *) &daddr,
              sizeof(struct  sockaddr_in)) != 0) {
    perror("cannot connect socket");
    return -1;
  }

  /* Open the output file, using O_DIRECT mode. */
  int fd = open(fname, O_WRONLY|O_CREAT|O_TRUNC|O_DIRECT, 0777);
  if (fd == -1) {
    perror("cannot open file");
    return -1;
  }
  off_t offset = 0;
  while (1) {
    /* Read the stream of bytes into the buffer and write the buffer to
disk.*/
    long remain = bufflen;
    while (remain != 0) {
      ssize_t bfn = recv(sd, abuffer + bufflen -  remain, remain, 0);
      remain -= bfn;
    }

    /* The following pwrite call is pathologically slow when the following
     * conditions are met:
     *
     *  - "fd" is opened with the O_DIRECT flag
     *  - "bufflen" is greater than 1024K
     *  - the file is located on an ext3 filesystem
     *  - the program must be run just after a reboot, with an idle machine
     */
    pwrite(fd, abuffer, bufflen, offset);
  }
  return 0;
}

Normal I/O mode:
----------------

104,0    3    54559    19.281294744  8796  I   W 1659619943 + 248 [iotest]
104,0    3    54560    19.281303970  8796  Q   W 1659620191 + 248 [iotest]
104,0    3    54561    19.281304742  8796  G   W 1659620191 + 248 [iotest]
104,0    3    54562    19.281305050  8796  I   W 1659620191 + 248 [iotest]
104,0    3    54563    19.281305875  8796  D  WB 1659619447 + 248 [iotest]
104,0    3    54564    19.281309344  8796  D  WB 1659619695 + 248 [iotest]
104,0    3    54565    19.281312648  8796  D  WB 1659619943 + 248 [iotest]
104,0    3    54566    19.281315915  8796  D  WB 1659620191 + 248 [iotest]
104,0    3    54567    19.281328651  8796  Q   W 1659620439 + 209 [iotest]
104,0    3    54568    19.281347876  8796  G   W 1659620439 + 209 [iotest]
104,0    3    54569    19.281350396  8796  P   R [iotest]
104,0    3    54570    19.281350605  8796  I   W 1659620439 + 209 [iotest]
104,0    3    54571    19.281351789  8796  U   R [iotest] 9
104,0    3    54572    19.281352410  8796  D  WB 1659620439 + 209 [iotest]
104,0    3    54573    19.281398220     0  C  WB 1659618592 + 96 [1]
104,0    3    54574    19.281836054     0  C  WB 1659618696 + 255 [1]
104,0    3    54575    19.282265369     0  C  WB 1659618951 + 248 [1]
104,0    3    54576    19.282697580     0  C  WB 1659619199 + 248 [1]
104,0    3    54577    19.283129806     0  C  WB 1659619447 + 248 [1]
104,0    3    54578    19.283562172     0  C  WB 1659619695 + 248 [1]
104,0    3    54579    19.283992548     0  C  WB 1659619943 + 248 [1]
104,0    3    54580    19.284425102     0  C  WB 1659620191 + 248 [1]
104,0    3    54581    19.284798866     0  C  WB 1659620439 + 209 [1]
104,0    3    54582    19.298365090  8796  Q   W 1659618592 + 96 [iotest]
104,0    3    54583    19.298368809  8796  G   W 1659618592 + 96 [iotest]
104,0    3    54584    19.298370886  8796  P   R [iotest]
104,0    3    54585    19.298371985  8796  I   W 1659618592 + 96 [iotest]
104,0    3    54586    19.298385539  8796  Q   W 1659618696 + 255 [iotest]
104,0    3    54587    19.298387729  8796  G   W 1659618696 + 255 [iotest]
104,0    3    54588    19.298388201  8796  I   W 1659618696 + 255 [iotest]
104,0    3    54589    19.298418855  8796  Q   W 1659618951 + 248 [iotest]
104,0    3    54590    19.298420219  8796  G   W 1659618951 + 248 [iotest]
104,0    3    54591    19.298420578  8796  I   W 1659618951 + 248 [iotest]
104,0    3    54592    19.298448670  8796  Q   W 1659619199 + 248 [iotest]
104,0    3    54593    19.298449527  8796  G   W 1659619199 + 248 [iotest]
104,0    3    54594    19.298449891  8796  I   W 1659619199 + 248 [iotest]
104,0    3    54595    19.298452564  8796  D  WB 1659618592 + 96 [iotest]
104,0    3    54596    19.298456281  8796  D  WB 1659618696 + 255 [iotest]
104,0    3    54597    19.298459828  8796  D  WB 1659618951 + 248 [iotest]
..
104,0    3    60498    21.388669049     0  C  WB 1659619695 + 248 [1]
104,0    3    60499    21.389098680     0  C  WB 1659619943 + 248 [1]
104,0    3    60500    21.389531417     0  C  WB 1659620191 + 248 [1]
104,0    3    60501    21.389904904     0  C  WB 1659620439 + 209 [1]
CPU0 (fast):
 Reads Queued:           0,        0KiB	 Writes Queued:          13,
   68KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        9,
   52KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,
    0KiB
 Read Merges:            0        	 Write Merges:            4
 Read depth:             0        	 Write depth:            13
 IO unplugs:             1        	 Timer unplugs:           0
CPU1 (fast):
 Reads Queued:           0,        0KiB	 Writes Queued:          30,
2,110KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       26,
2,094KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:       67,
6,193KiB
 Read Merges:            0        	 Write Merges:            4
 Read depth:             0        	 Write depth:            13
 IO unplugs:             7        	 Timer unplugs:           0
CPU2 (fast):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,
    0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,
    0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        2,
  254KiB
 Read Merges:            0        	 Write Merges:            0
 Read depth:             0        	 Write depth:            13
 IO unplugs:             0        	 Timer unplugs:           0
CPU3 (fast):
 Reads Queued:           0,        0KiB	 Writes Queued:      11,118,
1,262MiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:   11,114,
1,262MiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:   11,085,
1,258MiB
 Read Merges:            0        	 Write Merges:            4
 Read depth:             0        	 Write depth:            13
 IO unplugs:         1,242        	 Timer unplugs:           0

Total (fast):
 Reads Queued:           0,        0KiB	 Writes Queued:      11,161,
1,264MiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:   11,149,
1,264MiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:   11,154,
1,265MiB
 Read Merges:            0        	 Write Merges:           12
 IO unplugs:         1,250        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 59,150KiB/s
Events (fast): 60,747 entries
Skips: 0 forward (0 -   0.0%)
Input file fast.blktrace.0 added
Input file fast.blktrace.1 added
Input file fast.blktrace.2 added
Input file fast.blktrace.3 added


"Slow" I/O mode:
----------------

104,0    3        1     0.000000000     0  C  WB 1659618695 + 417 [1]
104,0    3        2     0.011180049  8687  Q   W 1659617056 + 96 [iotest]
104,0    3        3     0.011186104  8687  G   W 1659617056 + 96 [iotest]
104,0    3        4     0.011191270  8687  P   R [iotest]
104,0    3        5     0.011193012  8687  I   W 1659617056 + 96 [iotest]
104,0    3        6     0.011255351  8687  Q   W 1659617160 + 511 [iotest]
104,0    3        7     0.011257598  8687  G   W 1659617160 + 511 [iotest]
104,0    3        8     0.011261388  8687  I   W 1659617160 + 511 [iotest]
104,0    3        9     0.011311837  8687  Q   W 1659617671 + 512 [iotest]
104,0    3       10     0.011313442  8687  G   W 1659617671 + 512 [iotest]
104,0    3       11     0.011317217  8687  I   W 1659617671 + 512 [iotest]
104,0    3       12     0.011352926  8687  Q   W 1659618183 + 512 [iotest]
104,0    3       13     0.011353613  8687  G   W 1659618183 + 512 [iotest]
104,0    3       14     0.011357376  8687  I   W 1659618183 + 512 [iotest]
104,0    3       15     0.011361204  8687  D  WB 1659617056 + 96 [iotest]
104,0    3       16     0.011382358  8687  D  WB 1659617160 + 511 [iotest]
104,0    3       17     0.011387535  8687  D  WB 1659617671 + 512 [iotest]
104,0    3       18     0.011392169  8687  D  WB 1659618183 + 512 [iotest]
104,0    3       19     0.011410449  8687  Q   W 1659618695 + 417 [iotest]
104,0    3       20     0.011411340  8687  G   W 1659618695 + 417 [iotest]
104,0    3       21     0.011414503  8687  P   R [iotest]
104,0    3       22     0.011414677  8687  I   W 1659618695 + 417 [iotest]
104,0    3       23     0.011416007  8687  U   R [iotest] 5
104,0    3       24     0.011416774  8687  D  WB 1659618695 + 417 [iotest]
104,0    3       25     0.011654972     0  C  WB 1659617056 + 96 [1]
104,0    3       26     0.040166680     0  C  WB 1659617160 + 511 [1]
104,0    3       27     0.064106955     0  C  WB 1659617671 + 512 [1]
104,0    3       28     0.070817854     0  C  WB 1659618183 + 512 [1]
104,0    3       29     0.095427985     0  C  WB 1659618695 + 417 [1]
104,0    3       30     0.106417190  8687  Q   W 1659617056 + 96 [iotest]
104,0    3       31     0.106421738  8687  G   W 1659617056 + 96 [iotest]
104,0    3       32     0.106424386  8687  P   R [iotest]
104,0    3       33     0.106425686  8687  I   W 1659617056 + 96 [iotest]
104,0    3       34     0.106496278  8687  Q   W 1659617160 + 511 [iotest]
104,0    3       35     0.106498505  8687  G   W 1659617160 + 511 [iotest]
104,0    3       36     0.106502479  8687  I   W 1659617160 + 511 [iotest]
104,0    3       37     0.106537846  8687  Q   W 1659617671 + 512 [iotest]
104,0    3       38     0.106539195  8687  G   W 1659617671 + 512 [iotest]
104,0    3       39     0.106554708  8687  I   W 1659617671 + 512 [iotest]
..
104,0    3     6038    19.323083579  8687  I   W 1659618695 + 417 [iotest]
104,0    3     6039    19.323084665  8687  U   R [iotest] 5
104,0    3     6040    19.323085298  8687  D  WB 1659618695 + 417 [iotest]
104,0    3     6041    19.323321403     0  C  WB 1659617056 + 96 [1]
CPU0 (slow):
 Reads Queued:           0,        0KiB	 Writes Queued:          33,
  156KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       27,
  132KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,
    0KiB
 Read Merges:            0        	 Write Merges:            6
 Read depth:             0        	 Write depth:            23
 IO unplugs:             2        	 Timer unplugs:           0
CPU1 (slow):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,
    0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,
    0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        2,
   96KiB
 Read Merges:            0        	 Write Merges:            0
 Read depth:             0        	 Write depth:            23
 IO unplugs:             0        	 Timer unplugs:           0
CPU2 (slow):
 Reads Queued:           0,        0KiB	 Writes Queued:          10,
   52KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        7,
   40KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,
    0KiB
 Read Merges:            0        	 Write Merges:            3
 Read depth:             0        	 Write depth:            23
 IO unplugs:             1        	 Timer unplugs:           0
CPU3 (slow):
 Reads Queued:           0,        0KiB	 Writes Queued:       1,079,
214,023KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:    1,059,
213,943KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:    1,088,
213,252KiB
 Read Merges:            0        	 Write Merges:           20
 Read depth:             0        	 Write depth:            23
 IO unplugs:           245        	 Timer unplugs:           0

Total (slow):
 Reads Queued:           0,        0KiB	 Writes Queued:       1,122,
214,231KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:    1,093,
214,115KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:    1,090,
213,348KiB
 Read Merges:            0        	 Write Merges:           29
 IO unplugs:           248        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 11,041KiB/s
Events (slow): 6,210 entries
Skips: 0 forward (0 -   0.0%)
Input file slow.blktrace.0 added
Input file slow.blktrace.1 added
Input file slow.blktrace.2 added
Input file slow.blktrace.3 added


Kernel config:
--------------

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-gentoo-r4-Exalead
# Thu May  4 16:06:05 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_AS is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_SCHED_SMT is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=4
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_MV is not set
CONFIG_SCSI_SATA_NV=y
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_BLK_DEV_DM_BBR is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
# CONFIG_E1000_NAPI is not set
# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=m
CONFIG_BNX2=m

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
CONFIG_SPEAKUP_DEFAULT="none"

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_EXPORT=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_INOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m



