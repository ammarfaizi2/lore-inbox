Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271138AbRIHVDC>; Sat, 8 Sep 2001 17:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271147AbRIHVCx>; Sat, 8 Sep 2001 17:02:53 -0400
Received: from mailb.telia.com ([194.22.194.6]:62214 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S271138AbRIHVCp>;
	Sat, 8 Sep 2001 17:02:45 -0400
Message-Id: <200109082102.f88L2vo18714@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Arjan Filius <iafilius@xs4all.nl>, Robert Love <rml@tech9.net>
Subject: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
Date: Sat, 8 Sep 2001 22:58:18 +0200
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is interesting. [Assumes UP Athlon - correct]
Note that all BUGs out in highmem.h:95 (kmap_atomic)
and that test is only on if you have enabled HIGHMEM_DEBUG
[my analyze is done with a 2.4.10-pre2 kernel, but I checked with
later patches and I do not think they fix it either...]

The preemptive kernel puts more SMP stress on the kernel than
running with multiple CPUs.

So this might be a potential bug in the kernel proper, running with
a SMP computer.

If I understand the bug correctly, a process gets a page fault.
Starts to map in the page. But before the final part it checks -
and the page is already there!!! Correct?

On Saturday den 8 September 2001 19:33, Arjan Filius wrote:
> Hello Robert,
>
>
> I tried 2.4.10-pre4 with patch-rml-2.4.10-pre4-preempt-kernel-1.
> But it seems to hit highmem (see below) (i do have 1.5GB ram)
> 2.4.10-pre4 plain runs just fine.
>
> With the kernel option mem=850M the patched kernel boots an seems to run
> fine. However i didn't do any stress testing yet, but i still notice
> hickups while playing mp3 files at -10 nice level with mpg123 on a 1.1GHz
> Athlon, and removing for example a _large_ file (reiser-on-lvm).
>
> My syslog output with highmem:
>
> Sep  8 18:10:16 sjoerd kernel: kernel BUG at
> /usr/src/linux-2.4.10-pre4/include/asm/highmem.h:95! Sep  8 18:10:16 sjoerd
> kernel: invalid operand: 0000
> Sep  8 18:10:16 sjoerd kernel: CPU:    0
> Sep  8 18:10:16 sjoerd kernel: EIP:    0010:[do_wp_page+636/1088]
> [- - -]
> sjoerd kernel: Call Trace: [handle_mm_fault+141/224]
> [do_page_fault+375/1136] [do_page_fault+0/1136] [__mmdrop+58/64]
> [do_exit+595/640] Sep  8 18:10:16 sjoerd kernel:    [error_code+52/64]

Lets look at this example. You need to add some inline functions...

handle_mm_fault
	takes the mm->page_table_lock [this should prevent reschedules]
	allocs pmd
	allocs pte
	handle_pte_fault(...)
handle_pte_fault [inline, most likely path]
	pte is present
	it is a write access
	but the pte is not writeable  - call do_wp_page
do_wp_page
	plays some games with the lock...
	finally calls copy_cow_page [inline] with the page_table_lock
	UNLOCKED!
copy_cow_page
	calls clear_user_highpage or copy_user_highpage
both clear_user_highpage and copy_user_highpage
	calls kmap_atomic
kmap_atomic
	page is a highmem page
	but during the time this process was unlocked some other
	thread has allocated the page in question... BUG out.

So somewere between the UNLOCK (might be a lot later) and the
BUG test in kmap_atomic the process running in kernel got preempted.
(most likely during the page copy since it will take some time)

Another process (thread) started to run - hit the same page fault
but succeeded in its alloc.

Back to the first process it continues, finally checks - the page
is there... and BUGS.

Note that this can happen in a pure SMP kernel.

But let the processes (threads) run on two CPUs. And let the
first get an interrupt/bh after unlock - the other can pass
and add the page before the first one can continue - same
result!

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
