Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRITIJh>; Thu, 20 Sep 2001 04:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274365AbRITIJ2>; Thu, 20 Sep 2001 04:09:28 -0400
Received: from [195.223.140.107] ([195.223.140.107]:42990 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274363AbRITIJQ>;
	Thu, 20 Sep 2001 04:09:16 -0400
Date: Thu, 20 Sep 2001 10:09:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920100940.F729@athlon.random>
In-Reply-To: <andrea@suse.de> <8929.1000972873@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8929.1000972873@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Sep 20, 2001 at 09:01:13AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 09:01:13AM +0100, David Howells wrote:
> 
> Andrea Arcangeli <andrea@suse.de> wrote:
> > the process doesn't need to lock multiple mm_structs at the same time.
> 
> fork, ptrace, /proc/pid/mem, /proc/pid/maps
> 
> All have to be able to lock two process's mm_structs simultaneously, even if
> it's indirectly through copy_to_user() or copy_from_user().

ptrace doesn't use down_read_recursive, nor /proc/<>/mem, nor fork.

for /proc/<pid>/maps this check takes care of it of course (or it could
get unfair again: only when we're faulting on our vm we're allowed to go
through):

	if (task == current)
		down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
	else
		down_read(&mm->mmap_sem);

Andrea
