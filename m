Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTERUBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTERUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:01:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:49793 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262182AbTERUBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:01:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 13:13:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <200305181949.h4IJn9L05083@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.55.0305181254080.3568@bigblue.dev.mcafeelabs.com>
References: <200305181949.h4IJn9L05083@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Peter T. Breuer wrote:

> This is essentially the same struct as mine. I used the pid of the task,
> where you use the address of the task. You use an atomic count, whereas
> I used an ordinary int, guarded by the embedded spinlock.
>
>
> > #define nestlock_lock(snl) \
> > 	do { \
> > 		if ((snl)->uniq == current) { \
>
> That would be able to read uniq while it is being written by something
> else (which it can, according to the code below). It needs protection.

No it does not, look better.


> > 			atomic_inc(&(snl)->count); \
>
> OK, that's the same.
>
> > 		} else { \
> > 			spin_lock(&(snl)->lock); \
> > 			atomic_inc(&(snl)->count); \
> > 			(snl)->uniq = current; \
>
> Hmm .. else we wait for the lock, and then set count and uniq, while
> somebody else may have entered and be reading it :-). You exit with

Nope, think about a case were it breaks. False negatives are not possible
because it is set by the same task and false positives either.



> Well, it's not assembler either, but at least it's easily comparable
> with the nonrecursive version. It's essentially got an extra if and
> an inc in the lock. That's all.

Well, there's a little difference. In case of contention, you loop with
your custom try lock while I used the optimized asm code inside spin_lock.
But again, I believe we didn't lose anything with the removal of this code
(nested/recursive locks) from the kernel.



- Davide

