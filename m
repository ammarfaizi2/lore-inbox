Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUFHQcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUFHQcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFHQcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:32:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:42932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265248AbUFHQcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:32:02 -0400
Date: Tue, 8 Jun 2004 09:31:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: downgrade_write replacement in remap_file_pages
Message-Id: <20040608093111.01a910e9.akpm@osdl.org>
In-Reply-To: <20040608154438.GK18083@dualathlon.random>
References: <20040608154438.GK18083@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Apparently downgrade_write deadlocks the kernel in the mmap_sem
> under load. I suspect some rwsem bug. Anyways it's matter of time before
> in my tree I replace the rwsem implementation with my spinlock based
> common code implementation again that I can understand trivially (unlike
> the current code). I don't mind a microoptimization when the code is so
> complicated, so I don't mind too much to fix whatever current bug in
> downgrade_write.

I must say I agree with the sentiments - the current implementation doesn't
have a very attractive complexity/benefit ratio.  But I wrote a
spinlock-based version three years ago too, so I'm biased ;) Certainly it
is bog-simple and fixes up the overflow-at-32768-waiters bug.

I think a spinlock-based implementation would be OK if it was x86-specific,
because x86 spin_unlock is cheap.  But some architectures do atomic ops in
spin_unlock and won't like it.  Plus those architectures which can
implement atomic_add_return() can implement nice versions of rwsems such as
the ppc64 code.  Although ppc64 still seems to have an overflow bug.

So ho-hum.  As a first step, David, could you please take a look into
what's up with downgrade_write()?

(Then again, we need to have a serious think about the overflow bug.  It's
fatal.  Should we fix it?  If so, the current rwsem implementation is
probably unsalvageable).
