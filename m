Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWIZWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWIZWaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWIZWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:30:00 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:26077 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932449AbWIZW37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:29:59 -0400
Date: Tue, 26 Sep 2006 16:29:58 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Hirokazu Takata <takata.hirokazu@renesas.com>,
       Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-ID: <20060926222958.GN5017@parisc-linux.org>
References: <swfzmcse7mm.wl%takata@linux-m32r.org> <20060924062036.GB30273@parisc-linux.org> <swf8xk8l75h.wl%takata.hirokazu@renesas.com> <20060926143344.f036aa76.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926143344.f036aa76.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 02:33:44PM -0700, Andrew Morton wrote:
> We don't have a changelog for this patch.  My usual technique when this
> happens is to mutter something unprintable then go on a hunt through the
> mailing list archives.
> 
> But all I have is "Matthew Wilcox pointed out that
> generic__raw_read_trylock() is unfit for use.".
> 
> What's wrong with it?

I pointed it out on linux-arch a couple of weeks ago.  Ever look at the
generic__raw_read_trylock implementation?

$ git-diff linus spinlock.c 
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index fb524b0..6fc4c92 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -16,17 +16,6 @@ #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
-/*
- * Generic declaration of the raw read_trylock() function,
- * architectures are supposed to optimize this:
- */
-int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
-{
-       __raw_read_lock(lock);
-       return 1;
-}
-EXPORT_SYMBOL(generic__raw_read_trylock);
-

If the cpu has the lock held for write, is interrupted, and the interrupt
handler calls read_trylock(), it's an instant deadlock.

Now, Dave Miller has subsequently pointed out that we don't have any
situations where this can occur.  Nevertheless, we should delete
generic__raw_read_lock (and its associated EXPORT to make Arjan happy)
so that nobody thinks they can use it.
