Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWBIHSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWBIHSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 02:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWBIHSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 02:18:44 -0500
Received: from science.horizon.com ([192.35.100.1]:572 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422822AbWBIHSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 02:18:43 -0500
Date: 9 Feb 2006 02:18:32 -0500
Message-ID: <20060209071832.10500.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bring this up only after a 2-year hiatus, but I'm trying to
port an application from Solaris and Linux 2.4 to 2.6 and finding amazing
performance regression due to this.  (For referemce, as of 2.5.something,
msync(MS_ASYNC) just puts the pages on a dirty list but doesn't actually
start the I/O until some fairly coarse timer in the VM system fires.)

It uses msync(MS_ASYNC) and msync(MS_SYNC) as a poor man's portable
async IO.  It's appending data to an on-disk log.  When a page is full
or a transaction complete, the page will not be modified any further and
it uses MS_ASYNC to start the I/O as early as possible.  (When compiled
with debugging, it also uses remaps the page read-only.)

Then it accomplishes as much as it can without needing the transaction
committed (typically 25-100 ms), and when it's blocked until the
transaction is known to be durable, it calls msync(MS_SYNC).  Which
should, if everything went right, return immediately, because the page
is clean.

Reading the spec, this seems like exactly what msync() is designed for.

But looking at the 2.6 code, I see that it does't actually start the
write promptly, and makes the kooky and unusable suggestions to either
use fdatasync(fd), which will block on all the *following* transactions,
or fadvise(FADV_DONTNEED), which is emphatically lying to the kernel.
The data *is* needed in future (by the database *readers*), so discarding
it from memory is a stupid idea.  The only thing we don't need to do to
the page any more is write to it.


Now, I know I could research when async-IO support became reasonably
stable and have the code do async I/O when on a recent enough kernel,
but I really wonder who the genius was who managed to misunderstand
"initiated or queued for servicing" enough to think it involves sleeping
with an idle disk.

Yes, it's just timing, but I hadn't noticed Linux developers being
ivory-tower academic types who only care about correctness or big-O
performance measures.  In fact, "no, we can't prove it's starvation-free,
but damn it's fast on benchmarks!" is more of the attitude I've come
to expect.


Anyway, for future reference, Linux's current non-implementation of
msync(MS_ASYNC) is an outright BUG.  It "computes the correct result",
but totally buggers performance.


(Deep breath)  Now that I've finished complaining, I need to ask for
help.  I may be inspired to fix the kernel, but first I have to fix my
application, which has to run on existing Linux kernels.

Can anyone advise me on the best way to perform this sort of split-
transaction disk write on extant 2.6 kernels?  Preferably without using
glibc's pthread-based aio emulation?  Will O_DIRECT and !O_SYNC writes
do what I want?  Or will that interact bady with mmap()?

For my application, all transactions are completed in-order, so there is
never any question of which order to wait for completion.  My current
guess is that I'm going to have to call io_submit directly; is there
any documentation with more detail than the man pages but less than the
source code?  The former is silent on how the semantics of the various
IOCB_CMD_* opcodes, while the latter doesn't distinguish clearly between
the promises the interface is intended to keep and the properties of
the current implementation.

Thanks for any suggestions.
