Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUA3Eze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUA3Eze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:55:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:47797 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266544AbUA3Ez1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:55:27 -0500
Date: Thu, 29 Jan 2004 20:56:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Curt Hartung" <curt@northarc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raw devices broken in 2.6.1? AND- 2.6.1 I/O degraded?
Message-Id: <20040129205605.5bd140b2.akpm@osdl.org>
In-Reply-To: <020d01c3e6d0$acd78f60$0700000a@irrosa>
References: <01c501c3e6b9$67225f70$0700000a@irrosa>
	<20040129163852.4028c689.akpm@osdl.org>
	<020d01c3e6d0$acd78f60$0700000a@irrosa>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Curt Hartung" <curt@northarc.com> wrote:
>
> I have a separate, far more serious problem with the 2.6 I/O system but I'm
> still working through FAQ's to see if its my error.
> 
> Long story short- I have a simple test program you can try, to see for
> yourself (compare a 2.4 build with 2.6) :
> http://66.118.69.159/~curt/bigfile_test.C compile with: gcc -o bf -lpthread
> bigfile_test.C
> 
> Test platform is- 512M of RAM, athalon 1.33Ghz and some generic IBM drive,
> ext2 (no journaling) results at the bottom. Its a vanilla installation of
> RedHat 7.2
> 
> Long story slightly longer. I am the lead developer at one of the
> "enterprise software vendors who has been clamboring for the new threading
> model" (highwinds-software, UseNet server software)
> 
> I have been on pins and needles waiting for a stable release so I could
> test/certify our software on it; our customers are screaming for it and I
> want to give it to them, but the performance of our software on this kernel
> was pathetic. Stalls, halts, terrible.
> 
> I finnaly narrowed it down to the disk subsystem, and the test program shows
> the meat of it. When there is massive contention for a file, or just heavy
> (VERY heavy) volume, the 2.6.1 kernel (presumably the filesystem portion)
> falls over dead. The test program doesn't show death, but could by just
> upping the thrasher count a bit.

2.6.1 had a readahead bug which will adversely affect workloads such as
this.  Apart from that, there is still quite a lot of tuning work to be
done in 2.6.  As the tree settles down, and as more testers come on board. 
People are working on the VM and readahead code as we speak.  It's always
best to test the most up-to-date tree.


> Where do I go with this? Anyone have any idea who I can take this test
> program to?

You came to the right place.

> I have been telling our customers for over a year now "Don't
> worry, Linux will be able to rock with the new threading model" and then..
> this.. I want to be constructive here. Any advice would be appreciated, I'm
> new to the Linux community per se, though I've been developing on it for
> years.

You wouldn't expect huge gain from 2.6 in the I/O department.  Your
workload is seek-limited.  I am seeing some small benefits from the
anticipatory I/O scheduler with your test though.


> RESULTS:
> 
> Changing ONLY the kernel and rebooting, I ran the program twice to make sure
> any buffers were flushed. This had a dramatic effect, as the second (and all
> subsequent attempts, these results are representative) were consistenty
> better, although the 2.6.1 implementation was still worse.
> 
> This test program accurately models the largest job our UseNet software
> does, randomly accessing ENORMOUS files. It creates a 2G file and then
> accesses it with and without contention.
> 
> [root|/usr/local/tornado_be/bin]$ uname -a
> Linux professor.highwinds-software.com 2.6.1 #0 SMP Wed Jan 28 01:24:07 EST
> 2004 i686 unknown
> 
> bytes to write[2000027648]
> time [227]
> 1000 random 8192-byte accesses (single threaded)
> time [12]
> 1000 random 2048-byte accesses (single threaded)
> time [11]
> Now spawning 4 threads to kill the same file
> 1000 random 8192-byte accesses (with thrashers)
> time [65]
> 1000 random 2048-byte accesses (with thrashers)
> time [56]
> [curt|/usr/local/test]$ ./bf bigfile
> bytes to write[0]
> time [0]
> 1000 random 8192-byte accesses (single threaded)
> time [10]
> 1000 random 2048-byte accesses (single threaded)
> time [10]
> Now spawning 4 threads to kill the same file
> 1000 random 8192-byte accesses (with thrashers)
> time [57]
> 1000 random 2048-byte accesses (with thrashers)
> time [48]
> 
> 
> [curt|/usr/local/test]$ uname -a
> Linux professor.highwinds-software.com 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT
> 2001 i686 unknown
> 
> bytes to write[2000027648]
> time[139]
> 1000 random 8192-byte accesses (single threaded)
> time[33]
> 1000 random 2048-byte accesses (single threaded)
> time[13]
> Now spawning 4 threads to kill the same file
> 1000 random 8192-byte accesses (with thrashers)
> time[42]
> 1000 random 2048-byte accesses (with thrashers)
> time[50]
> [curt|/usr/local/test]$ ./bf bigfile
> bytes to write[0]
> time[0]
> 1000 random 8192-byte accesses (single threaded)
> time[10]
> 1000 random 2048-byte accesses (single threaded)
> time[9]
> Now spawning 4 threads to kill the same file
> 1000 random 8192-byte accesses (with thrashers)
> time[44]
> 1000 random 2048-byte accesses (with thrashers)
> time[40]

I'm fairly suspicious about the disparity between the time taken for those
initial large writes.  Two possible reasons come to mind:

1) Your disk isn't using DMA.  Use `hdparm' to check it, and check your
   kernel IDE config if it is not using DMA.

2) 2.4 sets the dirty memory writeback thresholds much higher: 40%/60%
   vs 10%/40%.  So on a 512M box it is possible that there is much more
   dirty, unwritten-back memory after the timing period has completed than
   under 2.6.  Although this difference in tuning can affect real-world
   workloads, it is really an error in the testing methodology.  Generally,
   the timing shuld include an fsync() so that all I/O which the program
   issue has completed.

   Or you can put 2.6 on par by setting
   /proc/sys/vm/dirty_background_ratio to 40 and dirty_ratio to 60.

It doesn't happen in my 256MB/2CPU/IDE testing here.  2.4 and 2.6 are
showing the same throughput.  2.6 maybe a shade quicker.

2.6.2-rc2-mm2:

vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[2000027648]
time[51]
1000 random 8192-byte accesses (single threaded)
time[11]
1000 random 2048-byte accesses (single threaded)
time [8]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [32]
1000 random 2048-byte accesses (with thrashers)
time [35]
vmm:/home/akpm> sync
vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[0]
time[0]
1000 random 8192-byte accesses (single threaded)
time[8]
1000 random 2048-byte accesses (single threaded)
time [7]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [32]
1000 random 2048-byte accesses (with thrashers)
time [37]

2.4.20:

vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[2000027648]
time[56]
1000 random 8192-byte accesses (single threaded)
time[11]
1000 random 2048-byte accesses (single threaded)
time [7]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [35]
1000 random 2048-byte accesses (with thrashers)
time [33]
vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[0]
time[0]
1000 random 8192-byte accesses (single threaded)
time[8]
1000 random 2048-byte accesses (single threaded)
time [7]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [38]
1000 random 2048-byte accesses (with thrashers)
time [35]

2.4.25-pre8:

vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[2000027648]
time[50]
1000 random 8192-byte accesses (single threaded)
time[10]
1000 random 2048-byte accesses (single threaded)
time [7]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [39]
1000 random 2048-byte accesses (with thrashers)
time [34]
vmm:/home/akpm> sync                      
vmm:/home/akpm> ./bigfile_test /mnt/hda5/1
bytes to write[0]
time[0]
1000 random 8192-byte accesses (single threaded)
time[7]
1000 random 2048-byte accesses (single threaded)
time [7]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [36]
1000 random 2048-byte accesses (with thrashers)
time [34]

Longer-term, if your customers are using scsi, you should ensure that the
disks do not use a tag queue depth of more than 4 or 8.  More than that and
the anticipatory scheduler becomes ineffective and you won't get that
multithreaded-read goodness.

Please stay in touch, btw.  If we cannot get applications such as yours
working well, we've wasted our time...

