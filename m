Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSHAFsA>; Thu, 1 Aug 2002 01:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318631AbSHAFsA>; Thu, 1 Aug 2002 01:48:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:28952 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318630AbSHAFr7>; Thu, 1 Aug 2002 01:47:59 -0400
Date: Thu, 1 Aug 2002 07:51:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc4aa1
Message-ID: <20020801055124.GB1132@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be the last update for a week (unless there's a quick bug to
fix before next morning :). I wanted to ship async-io and largepage
support now even if they're not tested well yet, in order to possibly
get feedback while I'll be away.

If you need to use it in production and you need to go completely safe
you should backout (patch -R) these three patches in this below order
(then it'll be for sure as stable as any previous -aa):

	9910_shm-largepage-1.gz
	9900_aio-API-x86-2
	9900_aio-2.gz

But even the above cannot introduce instability unless you actively use
those features (see below how to enable largepage support). (so as worse
it could be a DoS local security problem if something oopses in aio or
similar)

However for any long term permanent installation you should at least
backout the:

	9900_aio-API-x86-1

for API reasons, in case in 2.5 those syscall numbers will be assigned
to different functions. I guess the syscall numbers are basically just
assigned after latest Ben's 2.5 patch but just in case.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc4aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc4aa1/

diff between 2.4.19rc3aa4 and 2.4.19rc4aa1:

Only in 2.4.19rc3aa4: 00_d_unhash-race-1
Only in 2.4.19rc3aa4: 00_mmx_xmm-init-2
Only in 2.4.19rc3aa4: 00_vm86-3
Only in 2.4.19rc3aa4: 00_vm86-drop-v86mode-dead-thread-var-1
Only in 2.4.19rc3aa4: 00_vm86-pagetablelock-1

	Merged in mainline.

Only in 2.4.19rc4aa1: 00_disable-reada-1

	Fix failure of bread against reada by disabling reada
	(from Andrew Morton).

Only in 2.4.19rc3aa4: 00_extraversion-3
Only in 2.4.19rc4aa1: 00_extraversion-4

Only in 2.4.19rc3aa4: 9900_aio-1.gz
Only in 2.4.19rc4aa1: 9900_aio-2.gz

	Merge new cancellation API from Ben, drop the POLL and READX
	functionalities (apparently they were experimental). pipe callbacks
	doesn't implement yet the new cancellation API, they don't overwrite
	the io_event structure yet, so temporarly disabled the copy_to_user of
	such structure in sys_io_cancel (so not fully compliant yet), that
	would otherwise expose uninitialized kernel stack to userspace (will be
	fixed ASAP).

	Didn't merged the sys_getevents_abs modification, it still takes
	the timeout as argument, I still prefer it for the lower overhead in
	the timeout case, despite it has a larger window for going out of sync
	with the timeoftheday (a window with userspace in between where context
	switches cannot disabled). Waiting a final judjment for 2.5 before
	making any change here.

Only in 2.4.19rc3aa4: 9900_aio-API-x86-1
Only in 2.4.19rc4aa1: 9900_aio-API-x86-2

	Go in sync with latest syscall numbering in Ben's proposed patch and
	dropped sys_io_wait enterely.

Only in 2.4.19rc4aa1: 9910_shm-largepage-1.gz

	Merge largpage support for shared memory from Ingo Molnar.
	Dropped from it all the ABI kernel changes like the unregistered
	MAP_BIGPAGE 0x40 as parameter to teh mmap syscall, 0x40 can do
	a completely different thing in 2.5, the original version of the patch
	wasn't backwards compatible. This one is fully backwards (or better
	"forward") binary compatible because it's API-less  (well.. almost, you
	will get -EINVAL if you attempt a MAP_PRIVATE in /dev/shm then and
	stuff like that, _but_ only after enabling the support via sysctl).
	Completely untested though but no need to worry until/unless you run
	"echo 1 >/proc/sys/kernel/shm-use-bigpages", you also need to specify
	at boot how much memory you reserve for largepages, with bigpages=1g or
	similar (same memparse sintax of mem=).

	After the largepage shm support is enabled all shm segments will
	be attempted to be backed from largepages. largepages don't apply
	to file backed mappings or anonymoys mappings, just shared memory
	either from mmap("/dev/zero", MAP_SHARED), /dev/shm or shmget/shmat.
	In particular the shmget API will preallocate all pages (minor note: not the
	pagetables, page faults will still happen!) before returning from the
	syscall (could be changed very easily with a one liner, but I guess
	those db prefer the pages to be preallocated). All shm segments backed
	by largepages are VM_LOCKED (unpageable to swap).

Andrea
