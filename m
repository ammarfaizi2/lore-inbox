Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317717AbSGKCXe>; Wed, 10 Jul 2002 22:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317718AbSGKCXd>; Wed, 10 Jul 2002 22:23:33 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:51844 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S317717AbSGKCXb>; Wed, 10 Jul 2002 22:23:31 -0400
Message-Id: <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 11 Jul 2002 12:25:03 +1000
To: Andrew Morton <akpm@zip.com.au>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: direct-to-BIO for O_DIRECT
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
In-Reply-To: <3D2904C5.53E38ED4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:19 PM 7/07/2002 -0700, Andrew Morton wrote:
>Here's a patch which converts O_DIRECT to go direct-to-BIO, bypassing
>the kiovec layer.  It's followed by a patch which converts the raw
>driver to use the O_DIRECT engine.
>
>CPU utilisation is about the same as the kiovec-based implementation.
>Read and write bandwidth are the same too, for 128k chunks.   But with
>one megabyte chunks, this implementation is 20% faster at writing.
..
>This is with a single (oldish) scsi disk on aic7xxx.  I'd expect the
>margin to widen on higher-end hardware which likes to have more
>requests in flight.

sorry for the delay.
upgrading from 2.4.19 to 2.5.25 took longer than expected, since the QLogic 
FC 2300 HBA
driver isn't part of the standard kernel, and i had to update it to reflect the
io_request_lock -> host->host_lock, kdev_t and kbuild changes.  urgh, pain 
pain pain.
in the process, i discovered some races in their driver, so fixed them also.

the 2.5 block i/o layer is FAR superior to the 2.4 block i/o layer. kudos 
to Jens, Andrew & co for the changeover.

the results:
   2.4.19pre8aa2 (with lockmeter and profile=2)
      normal     167772160 blocks of 512 bytes in 778 seconds (105.27 
mbyte/sec), CPUs 0% idle
      O_DIRECT   20480 blocks of 4194304 bytes in 430 seconds (190.47 
mbyte/sec), CPUs ~55% idle
      /dev/rawN  20480 blocks of 4194304 bytes in 463 seconds (176.86 
mbyte/sec), CPUs ~62% idle

   2.5.25 ('virgin' 2.5.25 with the exception of changing PAGE_OFFSET to 
0x80000000 and
          your O_DIRECT-on-blockdev patch to stop it oopsing -- oops report 
below)
      normal     167772160 blocks of 512 bytes in 607 seconds (134.81 
mbyte/sec), CPUs 0% idle
      O_DIRECT   20480 blocks of 4194304 bytes in 420 seconds (194.61 
mbyte/sec), CPUs ~93% idle
      /dev/rawN  20480 blocks of 4194304 bytes in 422 seconds (193.84 
mbyte/sec), CPUs ~92% idle

   2.5.25 with direct-to-BIO (and PAGE_OFFSET at 0x80000000)
      normal     167772160 blocks of 512 bytes in 615 seconds (133.06 
mbyte/sec), CPUs 0% idle
      O_DIRECT   20480 blocks of 4194304 bytes in 421 seconds (194.37 
mbyte/sec), CPUs ~92% idle
      /dev/rawN  20480 blocks of 4194304 bytes in 421 seconds (194.35 
mbyte/sec), CPUs ~92% idle


its a little hard to tell CPU load difference between direct-to-BIO versus 
non-direct-to-BIO,
but clearly performance was at 100% of 2gbit/s Fibre Channel with 
direct-to-bio; i've never
seen it sustain exactly 100% throughout a test before.

it was interesting to watch the test of 2.4.19pre8aa2 versus both 2.5.25 
tests; whether it is a
change in the linux scheduler or some other artifact, all "worker" threads 
(1 thread per disk)
completed at almost exactly the same time on 2.5.25 kernels.
in contrast, the benchmark on 2.4.19pre8aa2 had some disks complete their 
work up to half
a minute prior to the last thread finishing -- clearly there was some 
degree of "unfairness"
between threads that has since been addressed.

i'll see about getting dual 2gbit/s FC HBAs working now; my FC MultiPathing 
configuration
is having a bad hair day today and i'm not physically near the test host in 
question to
replace a physical fibre cable reporting errors.


details of how the test was conducted --

test host:
  - dual P3 Xeon (733MHz), 2GB PC133 SDRAM (no HIGHMEM defined)
  - single QLogic FC 2300 HBA operating at 2gbit/s in a 64/66 PCI slot

test:
  - benchmark consisted of sequential read requests in parallel across
    8 x 18G 15K RPM FC disks across the first 10GB of each disk
    (why use "sequential reads" you ask?  because its generally consistent --
    i'm not measuring any i/o re-ordering/elevator behaviour, nor am
    i measuring the speed of any disk-shelf controller cache or
    disk-spindle seek speed.  i'm purely measuring how fast data can
    move from the storage subsystem to userspace).
  - benchmark-test considered complete when all disks have gone idle.
  - benchmark program is multithreaded, one thread per device
  - each test run twice with machine rebooted in-between to ensure
    repeatability

block sizes:
  - for normal, test used 20971520 blocks of 512 bytes (10GB) on each disk
  - for O_DIRECT, test used 2560 blocks of 4194304 bytes (10GB) on each disk
  - for /dev/rawN, test used 2560 blocks of 4194304 bytes (10GB) on each disk


oops report #1: (virgin 2.5.25)
         oops occurs on attempting to issue a read() on a O_DIRECT device.
         this was corrected with Andrew's patch of:

         Oops: 0000
         CPU:    0
         EIP:    0010:[<801c4e11>]    Not tainted
         Using defaults from ksymoops -t elf32-i386 -a i386
         EFLAGS: 00010296
         eax: 00000080   ebx: 00000000   ecx: f6e83b20   edx: f3e79c00
         esi: f3e79cc0   edi: 00010000   ebp: f6e83b20   esp: f393bdcc
         ds: 0018   es: 0018   ss: 0018
         Stack: 8013e856 820fcde0 00000010 000000c0 2aca6000 00000000 
f3e79cc0 00070000
                00000070 801c4fac f6e83b20 f6e83b20 8013edbd 00000000 
f6e83b20 00000010
                00000010 00000000 00000000 00000010 00000001 80127acb 
f56e9ae0 f54691e0
         Call Trace: [<8013e856>] [<801c4fac>] [<8013edbd>] [<80127acb>] 
[<8013e118>]
            [<8013e05f>] [<801269de>] [<80126af8>] [<80140113>] 
[<801400a0>] [<8012a9c7>]
            [<8012abad>] [<8011404b>] [<8013a738>] [<8013a8ea>] [<80108a0b>]
         Code: 8b 43 0c c1 ef 09 8b 50 38 8b 40 34 0f ac d0 09 89 c6 85 f6

         >>EIP; 801c4e11 <generic_make_request+11/130>   <=====
         Trace; 8013e856 <bio_alloc+e6/1a0>
         Trace; 801c4fac <submit_bio+5c/70>
         Trace; 8013edbd <ll_rw_kio+1ad/210>
         Trace; 80127acb <handle_mm_fault+6b/e0>
         Trace; 8013e118 <brw_kiovec+a8/100>
         Trace; 8013e05f <generic_direct_IO+ef/100>
         Trace; 801269de <get_user_pages+ee/150>
         Trace; 80126af8 <map_user_kiobuf+b8/100>
         Trace; 80140113 <blkdev_direct_IO+23/30>
         Trace; 801400a0 <blkdev_get_block+0/50>
         Trace; 8012a9c7 <generic_file_direct_IO+167/1e0>
         Trace; 8012abad <generic_file_read+ed/130>
         Trace; 8011404b <schedule+33b/3a0>
         Trace; 8013a738 <vfs_read+98/110>
         Trace; 8013a8ea <sys_read+2a/40>
         Trace; 80108a0b <syscall_call+7/b>
         Code;  801c4e11 <generic_make_request+11/130>
         00000000 <_EIP>:
         Code;  801c4e11 <generic_make_request+11/130>   <=====
            0:   8b 43 0c                  mov    0xc(%ebx),%eax   <=====
         Code;  801c4e14 <generic_make_request+14/130>
            3:   c1 ef 09                  shr    $0x9,%edi
         Code;  801c4e17 <generic_make_request+17/130>
            6:   8b 50 38                  mov    0x38(%eax),%edx
         Code;  801c4e1a <generic_make_request+1a/130>
            9:   8b 40 34                  mov    0x34(%eax),%eax
         Code;  801c4e1d <generic_make_request+1d/130>
            c:   0f ac d0 09               shrd   $0x9,%edx,%eax
         Code;  801c4e21 <generic_make_request+21/130>
           10:   89 c6                     mov    %eax,%esi
         Code;  801c4e23 <generic_make_request+23/130>
           12:   85 f6                     test   %esi,%esi


cheers,

lincoln.

