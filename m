Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUB1Gn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 01:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUB1Gn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 01:43:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26284
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261826AbUB1Gnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 01:43:52 -0500
Date: Sat, 28 Feb 2004 07:43:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228064352.GP8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <469160000.1077948622@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469160000.1077948622@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:10:22PM -0800, Martin J. Bligh wrote:
> OK, I understand you can window it, but I still don't get where your
> figures of 2.7GB/task vs 1.7GB per task come from?

2.7G is what you can map right now in 2.6 with 3:1.

dropping 1G from the userspace means reducing the shm mappings to 1.7G
of address space.

sorry if I made some confusion.

> 48GB is sailing damned close to the wind. The problem I've had before is

;)

> distros saying "we support X GB of RAM", but it only works for some
> workloads, and falls over on others. Oddly enough, that tends to upset
> the customers quite a bit ;-) I'd agree with what you say - for a generic
> misc load, it might work ... but I'd hate a customer to hear that and
> misinterpret it.

I see...

> > What changes between 3:1 and 2:2 is the "view" on the 20G shm file, not
> > the size of the shm. you can do less simultaneous mmap with a 1.7G view
> > instead of a 2.7G view. the nonlinear vma will be 1.7G in size with 2:2,
> > instead of 2.7G in size with 3:1 or 4:4 (300M are as usual left for some
> > hole, the binary itself and the stack)
> 
> Why is it 2.7GB with both 3:1 and 4:4 ... surely it can get bigger on 
> 4:4 ???

yes it can be bigger there. I wrote it to simplify, I mean it doesn't
need to be bigger, but it can.

> > the only chance it's faster is if you never use syscalls and you drive
> > all interrupts to other cpus and you have an advantage by mapping >2G in
> > the same address space. 
> 
> I think that's the key - when you need to map a LOT of data into the
> address space. Unfortunately, I think that's the kind of app that the
> large machines run.

agreed.

> > I've some doubt 4:4 runs faster anywhere. I could be wrong though.
> 
> There's only one real way to tell ;-)

indeed ;)

> >> If you send me a *simple* simulation test, I'll gladly run it for you ;-)
> >> But I'm not going to go fiddle with Oracle, and thousands of disks ;-)
> > 
> > :)
> > 
> > thanks for the offer! ;) I would prefer a real life db bench since
> > syscalls and irqs are an important part of the load that hurts 4:4 most,
> > it doesn't need to be necessairly oracle though. And if it's a cpu with
> > big tlb cache like p4 it would be prefereable. maybe we should talk
> > about this offline.
> 
> I've been talking with others here about running a database workload
> test, but it'll probably be on a machine with only 8GB or so. I still
> think that's enough to show us something interesting.

yes, it should be enough to show something interesting. However the best
would be to really run it on a 32G box, 32G should be really show the
divergence. getting results w/ and w/o hugetlbfs may be interesting too
(it's not clear if 4:4 will benefit more or less from hutetlbfs, it will
walk only twice to reach the physical page, but OTOH flushing the tlb so
frequently will partly invalidate the huge tlb behaviour).

> > agreed. It's just lower prio at the moment since anon memory doesn't
> > tend to be that much shared, so the overhead is minimal.
> 
> Yup, that's what my analysis found, most of it falls under the pte_direct
> optimisation. The only problem seems to be that at fork/exec time we
> set up the chain, then tear it down again, which is ugly. That's the bit
> where I like Hugh's stuff.

Me too. I've a testcase here that works 50% slower in 2.6 than 2.4, due
the slowdown in fork/pagefaults etc.. (real apps of course doesn't show
it, this is a "malicious" testcase ;).

#include <sys/mman.h>
#include <stdio.h>
#include <fcntl.h>

#define SIZE (1024*1024*1024)

int main(int argc, char ** argv)
{
  int fd, level, max_level;
  char * start, * end, * tmp;

  max_level = atoi(argv[1]);

  fd = open("/tmp/x", O_CREAT|O_RDWR);
  if (fd < 0)
    perror("open"), exit(1);
  if (ftruncate(fd, SIZE) < 0)
    perror("truncate"), exit(1);
  if ((start = mmap(0, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0)) == MAP_FAILED)
    perror("mmap"), exit(1);
  end = start + SIZE;
  
  for (tmp = start; tmp < end; tmp += 4096) {
    *tmp = 0;
  }

  for (level = 0; level < max_level; level++) {
    if (fork() < 0)
      perror("fork"), exit(1);
    if (munmap(start, SIZE) < 0)
      perror("munmap"), exit(1);
    if ((start = mmap(0, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0)) == MAP_FAILED)
      perror("mmap"), exit(1);
    end = start + SIZE;
  
    for (tmp = start; tmp < end; tmp += 4096) {
      *(volatile char *)tmp;
    }
  }
  return 0;
}

(it's insecure since "/tmp/x" is fixed, change that file if you need
local security).

> >> I don't have time at the moment to go write it at the moment, but I
> >> can certainly run it on large end hardware if that helps.
> > 
> > thanks, we should write it someday. that testcase isn't the one suitable
> > for the 4:4 vs 2:2 thing though, for that a real life thing is needed
> > since irqs, syscalls (and possibly page faults but not that many with a
> > db) are fundamental parts of the load.  we could write a smarter
> > testcase as well, but I guess using a db is simpler, evaluating 2:2 vs
> > 4:4 is more a do-once thing, results won't change over time.
> 
> OK, I'll see what people here can do about that ;-)

cool ;)

as I wrote to Wim to make it more acceptable we'll have to modify your
3.5:0.5 PAE patch to do 2.5:1.5 too, to give userspace another 512m that
the kernel actually doesn't need. And still I'm not sure if Wim can live
with 1.7G ipcshm and 512m of shmfs window, if that's not enough user
address space then it's unlikely this thread will go anywhere since 512m
are needed to handle an additional 32G with a reasonable margin (even
after shrinking the page_t to the 2.4 levels).

The last issue that we may run into are apps assuming the stack is at 3G
fixed, some jvm assumed that, but they should be fixed by now (at the
very least it's not hard at all to fix those).

It also depends on the performance difference if this is worthwhile, if
the difference isn't very significant 4:4 will be certainly prefereable
so you can also allocate 4G in the same task for apps not using syscalls
or page faults or flood of network irqs.
