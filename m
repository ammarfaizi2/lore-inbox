Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKBSvU>; Thu, 2 Nov 2000 13:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129142AbQKBSvK>; Thu, 2 Nov 2000 13:51:10 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:30483 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S129145AbQKBSu6>; Thu, 2 Nov 2000 13:50:58 -0500
Message-ID: <3A01B79B.71A2D3C7@dm.ultramaster.com>
Date: Thu, 02 Nov 2000 13:51:07 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: mmap_sem (and generic) semaphore fairness question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted yesterday about a problem in 2.4.0-test10 regarding *LONG*
stalls in 'ps' and 'vmstat'.  After a conversation with Rik van Riel, it
seems that this may be caused by contention over the mmap_sem semaphore.

I have a question about the fairness of the semaphore implementation
that may be an explanation for the 'bug' that stops top and vmstat from
updating.

Assume some process, A, is constantly requiring some resource that's
protected by a semaphore, S.  Assume also that the resource is not
available, and that A sleeps inside the kernel, waiting for the
resource, while holding S.

Assume also that some other process, B, is sleeping on aquiring S.

Is it possible for the following to happen repeatedly, keeping B from
ever aquiring S.

1) Resource becomes available.
2) A is 'runnable' and is given an entire timeslice.
3) schedule() to A
4) A releases S
5) A returns to userspace
6) A uses much less than entire timeslice doing calculation
7) A needs some resource again
7) A enters kernel and aquires S
8) A sleeps on resource, rest of timeslice not used, A's 'goodness'
isn't messed up.
9) goto 1.

In this scenario, as long as A never uses it's full timeslice, B will
never get to aquire S.

Specifically, A is some memory hogging program, B is 'ps'.  S is the
mmap_sem and the 'resource' that A is constantly getting in trouble
about is memory (it enters the kernel via a page fault).

Can anyone explain why this wouldn't happen, and wouldn't cause infinite
starvation of B?

David Mansfield
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
