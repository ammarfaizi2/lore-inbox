Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUJEMGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUJEMGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 08:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJEMGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 08:06:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43442 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268989AbUJEMGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 08:06:42 -0400
Date: Tue, 5 Oct 2004 13:06:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Pasi Savolainen <psavo@iki.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm2
In-Reply-To: <1096968325.2628.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0410051251210.6757-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Peter Zijlstra wrote:
> On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
> >   LD      .tmp_vmlinux1
> >   KSYM    .tmp_kallsyms1.S
> > make: *** wait: No child processes.  Stop.
> > - -
> > The 'no child processes' keeps on coming up at 'random' moments under
> > rc3-mm1. First time ever that I've seen it otherwise.
> 
> Just a simple mee too!
> on 2.6.9-rc3-mm2-VP-T0 and on some earlier Sx patches as well.
> Unfortunatly I haven't had time to track back as to when this was
> introduced.

Please, would you try this patch below that I posted yesterday?
At the time I thought the trylock was hardly used so not urgent.

I've just now discovered that the standard SMP PREEMPT read_lock
- as in do_wait's read_lock(&tasklist_lock) for example - uses it
via one of those dreaded expansions that grep misses:
		if (likely(_raw_##op##_trylock(lock)))

I've been suffering the occasional leftover zombie from multiple
kernel builds precisely since the preempt-smp.patch went in; been
hunting it unsuccessfully in spare moments, yesterday noticed that
bug, today realize it's probably what I've been hunting - I'm
about to start my own tests again, can't be sure until tomorrow.

Hugh

The i386 and x86_64 _raw_read_trylocks in preempt-smp.patch
are too successful: atomic_read() returns a signed integer.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc3-mm2/include/asm-i386/spinlock.h	2004-10-04 12:00:14.000000000 +0100
+++ linux/include/asm-i386/spinlock.h	2004-10-04 18:50:32.752864600 +0100
@@ -235,7 +235,7 @@ static inline int _raw_read_trylock(rwlo
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
-	if (atomic_read(count) < RW_LOCK_BIAS)
+	if (atomic_read(count) >= 0)
 		return 1;
 	atomic_inc(count);
 	return 0;
--- 2.6.9-rc3-mm2/include/asm-x86_64/spinlock.h	2004-10-04 12:00:15.000000000 +0100
+++ linux/include/asm-x86_64/spinlock.h	2004-10-04 18:50:32.752864600 +0100
@@ -236,7 +236,7 @@ static inline int _raw_read_trylock(rwlo
 {
 	atomic_t *count = (atomic_t *)lock;
 	atomic_dec(count);
-	if (atomic_read(count) < RW_LOCK_BIAS)
+	if (atomic_read(count) >= 0)
 		return 1;
 	atomic_inc(count);
 	return 0;

