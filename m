Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTERTTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTERTTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:19:04 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:26241 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262166AbTERTTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:19:01 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 12:31:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <200305181909.h4IJ9sK02186@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.55.0305181228390.3568@bigblue.dev.mcafeelabs.com>
References: <200305181909.h4IJ9sK02186@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Peter T. Breuer wrote:

> In article <20030518182010$0541@gated-at.bofh.it> you wrote:
> > On Sun, 18 May 2003, Peter T. Breuer wrote:
> >> Here's a before-breakfast implementation of a recursive spinlock. That
>
> > A looong time ago I gave to someone a recursive spinlock implementation
> > that they integrated in the USB code. I don't see it in the latest
> > kernels, so I have to guess that they found a better solution to do their
> > things. I'm biased to say that it must not be necessary to have the thing
> > if you structure your code correctly.
>
> Well, you can get rid of anything that way. The question is if the
> interface is an appropriate one to use or not - i.e. if it makes for
> better code in general, or if it make errors of programming less
> likely.
>
> I would argue that the latter is undoubtedly true - merely that
> userspace flock/fcntl works that way would argue for it, but there
> are a couple of other reasons too.
>
> Going against is the point that it may be slower.  Can you dig out your
> implementation and show me it?  I wasn't going for assembler in my hasty
> example.  I just wanted to establish that it's easy, so that it becomes
> known that its easy, and folks therefore aren't afraid of it.  That both
> you and I have had to write it implies that it's not obvious code to
> everyone.

It was something like this. The real code should be in 2.2.x I believe.
The problem at the time was nested ( recursive ) spinlocks.



typedef struct s_nestlock {
	spinlock_t lock;
	void *uniq;
	atomic_t count;
} nestlock_t;

#define nestlock_init(snl) \
	do { \
		spin_lock_init(&(snl)->lock); \
		(snl)->uniq = NULL; \
		atomic_set(&(snl)->count, 0); \
	} while (0)

#define nestlock_irqlock(snl, flags) \
	do { \
		if ((snl)->uniq == current) { \
			atomic_inc(&(snl)->count); \
			flags = 0; /* No warnings */ \
		} else { \
			spin_lock_irqsave(&(snl)->lock, flags); \
			atomic_inc(&(snl)->count); \
			(snl)->uniq = current; \
		} \
	} while (0)

#define nestlock_irqunlock(snl, flags) \
	do { \
		if (atomic_dec_and_test(&(snl)->count)) { \
			(snl)->uniq = NULL; \
			spin_unlock_irqrestore(&(snl)->lock, flags); \
		} \
	} while (0)

#define nestlock_lock(snl) \
	do { \
		if ((snl)->uniq == current) { \
			atomic_inc(&(snl)->count); \
		} else { \
			spin_lock(&(snl)->lock); \
			atomic_inc(&(snl)->count); \
			(snl)->uniq = current; \
		} \
	} while (0)

#define nestlock_unlock(snl) \
	do { \
		if (atomic_dec_and_test(&(snl)->count)) { \
			(snl)->uniq = NULL; \
			spin_unlock(&(snl)->lock); \
		} \
	} while (0)






- Davide

