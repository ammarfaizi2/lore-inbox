Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265308AbUFHTgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265308AbUFHTgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 15:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUFHTgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 15:36:32 -0400
Received: from holomorphy.com ([207.189.100.168]:30080 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264279AbUFHTga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 15:36:30 -0400
Date: Tue, 8 Jun 2004 12:36:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: downgrade_write replacement in remap_file_pages
Message-ID: <20040608193621.GA12780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20040608154438.GK18083@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040608154438.GK18083@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 05:44:38PM +0200, Andrea Arcangeli wrote:
> Apparently downgrade_write deadlocks the kernel in the mmap_sem
> under load. I suspect some rwsem bug. Anyways it's matter of time before
> in my tree I replace the rwsem implementation with my spinlock based
> common code implementation again that I can understand trivially (unlike
> the current code). I don't mind a microoptimization when the code is so
> complicated, so I don't mind too much to fix whatever current bug in
> downgrade_write.
> In the meantime to workaround the deadlock (and to verify if this make
> the deadlock go away, which returned a positive result) I implemented
> this patch: this doesn't fix downgrade_wite, but I'm posting it here
> because I believe it's much better code regardless of the
> downgrade_write issue.  With this patch we'll never run down_write again
> in production, the down_write will be taken only once when the db or the
> simulator startup (during the very first page fault) and never again, in
> turn providing (at least in theory) better runtime scalability.

I've been using something similar since about May 20. However, it was
unclear that it was a deadlock as opposed to semaphore contention from
the reports I got.


On Tue, Jun 08, 2004 at 05:44:38PM +0200, Andrea Arcangeli wrote:
> -		if (pgoff != linear_page_index(vma, start) &&
> -		    !(vma->vm_flags & VM_NONLINEAR)) {
> +		if (unlikely(pgoff != linear_pgoff && !(vma->vm_flags & VM_NONLINEAR))) {

There is no linear_pgoff variable...


-- wli
