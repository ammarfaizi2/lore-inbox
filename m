Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCRCVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 21:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUCRCVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 21:21:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32135
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262328AbUCRCVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 21:21:14 -0500
Date: Thu, 18 Mar 2004 03:22:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-aa1
Message-ID: <20040318022201.GE2113@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This implements anon_vma for the anonymous memory unmapping and objrmap
for the file mappings, effectively removing rmap completely and
replacing it with more efficient algorithms (in terms of memory
utilization and cpu cost for the fast paths).

I attached the results for a basic benchmark comparing 2.4, 2.6 and
2.6-aa.

Next thing to fix are the nonlinear mappings (probably I will use the
sysctl for the short term, sysctl may be needed anyways for allowing
mlock to all users), and then the rbtree for the i_mmap{shared} (the
prio_tree isn't stable yet, over time we can replace it with the
prio_tree of course).

I'm running this kernel while writing this and it's under 500M swap load
without problems. Ingo complains some workload with zillon of vmas
in the same file will not work well, but 1) those workloads are supposed
to use remap_file_pages in 32bit archs, and 2) they wants mlock anyways,
and this vm design is optimal on the 64bit without requiring nor
remap_file_pages nor mlock there.

This is better than anonmm because it's finegriend, so applications
using local "malloc" in a process-group will scale better during heavy
swapping (in presence of tons of processes in the same group), and
secondly it gets mremap right (tons of programs uses cows heavily, the
most obvious example is kde, I don't know if they ever run mremap but
this sounds safer overall).  It costs a bit more of memory but I don't
think it matters, an anon_vma is only 12 bytes and it can cover
gigabytes of address space.

I did some robusteness improvement as well in the ->nopage handlings,
and a fix in bttv that didn't set VM_RESERVE, plus some cleanup in the
vma merging.

vma merging for mprotect and mremap is disabled for now, but it can be
enabled again, and after we re-enable it file backed vmas should be
supported too in the merging (so far they aren't).

In terms of performance I hope with this effort we'll get back the two
digit percent loss compared to 2.4 based kernels, if this doesn't bring
all performance back the next suspect is the scheduler lacking HT
awareness or stuff like that (but I doubt, see the bench page and
imagine a much bigger box with quite some more ram than 1G).

With regard to the x86 32bit arch this releases 4byte of page_t, plus it
saves tons of zone-normal to make it possible to use >=4G boxes with the
optimal 3:1 model like we do in 2.4 today (something not doable in 2.6
mainline due the huge rmap overhead, and that in practice limits the 2.6
kernel to non PAE boxes [depending on the workload]).

Credit for the original objrmap idea goes to David Miller, the first
good implementation for 2.6 is from Dave McCracken but only for the file
mappings, and the first effort to cover the anonymous memory too is from
Hugh Dickins and Wli also maintained the anonmm code later. I coalesced
the good stuff together plus I designed and implemented the the anon_vma
solution for anonymous memory.

Alternate solutions to anon_vma have been proposed and they may be
considered in alternative to this. Ideally we should split the anon_vma
patch in two parts, one that could be re-used by the anonmm design,
though I was no time to split it so far. I'm not claiming anon_vma is
definitely superior to anonmm but it's the solution I prefer. It is clearly
more efficient in some very high end workload I've in mind, but in the
small boxes it takes a bit more of memory so for the simpler workloads
anonmm is prefereable, plus anonmm allows full vma merging (though it
requires cow during mremap).

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa1/

Only in 2.6.5-rc1-aa1: 00000_extraversion-1

	Add -aa1.

Only in 2.6.5-rc1-aa1: 00000_twofish-2.6.gz

	Compatibility cryptoloop.

Only in 2.6.5-rc1-aa1: 00100_objrmap-core-1.gz

	Objrmap core from Dave McCracken implementing objrmap
	methods for file mappings reusing the truncate
	infrastructure (as in DaveM's effort). This doesn't
	obsolete rmap yet, anonymous memory is still tracked
	via rmap.

Only in 2.6.5-rc1-aa1: 00101_anon_vma-1.gz

	Implements innovative objrmap methods for anonymous
	memory using the finegriend anon_vma design that handles
	mremap gracefully and avoids to scan all mm in a child-group
	to find the right vmas as it happens with anonmm. This effectively
	obsoletes rmap and infact it releases 4bytes per page_t by dropping the
	pte_chains.

	The combination of anon_vma and objrmap-core avoids huge waste
	of memory and cpu resources and it boosts smp scalability too.
	This makes it possible to use >=4G boxes without the 4:4 slowdown.

	The nonlinear vmas aren't covered yet, so this is an insecure
	kernel at this time (only in terms of local security
	DoS, no root compromise can happen or whatever like that, it's
	like allowing a bad user to use mlock, so he can turn
	down the machine locally). The nonlinear vmas will be covered too with
	further patches, this is already more than good enough for starting
	beating on it with real loads like single user desktop usage.

	The file based methods will have to be optimized further too with
	a rbtree.

	Both the nonlinear vmas and the rbtree for the file methods
	i_mmap{shared} will be covered in the next -aa.

	If you find compile breakages s/->mapping/->as.mapping/ will fix it.

Only in 2.6.5-rc1-aa1: 00200_kgdb-ga-1.gz
Only in 2.6.5-rc1-aa1: 00201_kgdb-ga-recent-gcc-fix-1.gz
Only in 2.6.5-rc1-aa1: 00201_kgdb-THREAD_SIZE-fixes-1.gz
Only in 2.6.5-rc1-aa1: 00201_kgdb-x86_64-support-1.gz

	kgdb from Andrew's -mm tree.

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bench

testprogram:

#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

#define SIZE (512*1024*1024)

int main(int argc, char ** argv)
{
  int fd = -1, level, max_level;
  char * start, * end, * tmp;

  max_level = atoi(argv[1]);

  if ((start = mmap(0, SIZE, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, fd, 0)) == MAP_FAILED)
    perror("mmap"), exit(1);
  end = start + SIZE;
  
  for (tmp = start; tmp < end; tmp += 4096) {
    *tmp = 0;
  }

  for (level = 0; level < max_level; level++) {
    int pid = fork();
    if (pid < 0)
      perror("fork"), exit(1);
    for (tmp = start; tmp < end; tmp += 4096) {
      *(volatile char *)tmp;
    }
  }
  for (;;)
	if (wait(NULL) < 0)
		break;
  return 0;
}

2.4.21 based kernel:

6:

real    0m6.548s
user    0m11.340s
sys     0m10.730s

real    0m6.684s
user    0m11.120s
sys     0m11.090s

7:

real    0m12.145s
user    0m22.180s
sys     0m21.330s

real    0m11.862s
user    0m21.680s
sys     0m21.100s


2.6.5-rc2-aa1 (== 2.6 + objrmap + anon_vma):

6:

real    0m6.520s
user    0m9.926s
sys     0m11.791s

real    0m6.527s
user    0m9.823s
sys     0m11.975s

7:

real    0m12.072s
user    0m21.913s
sys     0m22.034s

real    0m12.062s
user    0m21.331s
sys     0m22.161s

2.6.2 (the last non-objrmap kernel I had installed on the test box)

6:

real    0m8.359s
user    0m10.490s
sys     0m17.840s

real    0m8.185s
user    0m9.684s
sys     0m18.078s

7:

real    0m16.150s
user    0m21.184s
sys     0m38.473s

real    0m16.082s
user    0m21.441s
sys     0m38.025s


from number 8 2.6.2 runs out of memory in fork, 2.6.5-rc1-aa1
reaches 9 without problems filling around 400m with pagetables.
--UPT3ojh+0CqEDtpF--
