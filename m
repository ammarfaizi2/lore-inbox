Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVCKWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVCKWWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVCKWUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:20:25 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:12804 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261779AbVCKWSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:18:52 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Dave Jones <davej@redhat.com>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<20050311021248.GA20697@redhat.com>
	<16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 12 Mar 2005 07:18:19 +0900
In-Reply-To: <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 10 Mar 2005 18:42:10 -0800 (PST)")
Message-ID: <87vf7xg72s.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Hmm.. We seem to not have any tests for the counts becoming negative, and
> this would seem to be an easy mistake to make considering that both I and 
> Dave did it.

I stole this from -mm.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


From: Ingo Molnar <mingo@elte.hu>

The patch below will detect atomic counter underflows.  This has been
test-driven in the -RT patchset for some time.  qdisc_destroy() triggered
it sometimes (in a seemingly nonfatal way, during device shutdown) - with
DaveM suggesting that it is most likely a bug in the networking code.  So
it would be nice to have this in -mm for some time to validate all atomic
counters on a broader base.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-i386/atomic.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN include/asm-i386/atomic.h~detect-atomic-counter-underflows include/asm-i386/atomic.h
--- 25/include/asm-i386/atomic.h~detect-atomic-counter-underflows	Wed Nov  3 15:27:37 2004
+++ 25-akpm/include/asm-i386/atomic.h	Wed Nov  3 15:27:37 2004
@@ -132,6 +132,10 @@ static __inline__ int atomic_dec_and_tes
 {
 	unsigned char c;
 
+	if (!atomic_read(v)) {
+		printk("BUG: atomic counter underflow at:\n");
+		dump_stack();
+	}
 	__asm__ __volatile__(
 		LOCK "decl %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
_
