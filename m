Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSGTCR2>; Fri, 19 Jul 2002 22:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGTCR2>; Fri, 19 Jul 2002 22:17:28 -0400
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:12166 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S317327AbSGTCR1>; Fri, 19 Jul 2002 22:17:27 -0400
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
References: <fa.m2aun2v.khulp2@ifi.uio.no>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <fa.m2aun2v.khulp2@ifi.uio.no>
Date: 19 Jul 2002 19:20:28 -0700
Message-ID: <87eldzjg2b.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:
>
> I've been sitting on this question for years, hoping I'd come across the 
> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
> got to know this. :)

Boy, how newbie can you get?  Fortunately, you've got lots of people
setting you straight, and they've given you all those different
answers to choose from!  ;)

> Another question I'm unclear about is "does every userspace-visible memory 
> allocation have an inode"?  Loaded programs are basically mmaped files, and 
> shared memory is now its own filesystem out of which you mmap stuff.  But I 
> don't know about a process's stack and heap.

I'd say a mapping "has an inode" if its associated "vm_area_struct"
has a non-NULL "->vm_file" (in which case the inode number is stored
in "->vm_file->f_dentry->d_inode->i_ino").  By this standard, it's
pretty easy to see what parts of a process's address space have an
inode.  Just "cat /proc/nnn/maps".  Each map line will have an inode
number in the fifth column or zero if there's no associated inode.

In general, executable text (including shared libraries) and other
pages mmapped from real files have inodes.  Pages mmapped anonymously
don't---if they're private---or do---if they're shared.  In the latter
case, they have a nameless (i.e., unlinked) inode in the shmfs though
its name shows up as "/dev/zero" in "/proc/nnn/maps".  Both System V
and POSIX shared memory have inodes in shmfs, I believe.  Pages
allocated with brk/sbrk (including heap for C programs) don't have an
inode.

Mmapping "/dev/zero" is a special case.  Private (or read-only) maps
of "/dev/zero" will be associated with "/dev/zero"'s inode.  Make a
shared, writable map of "/dev/zero", and it acts like a shared
anonymous page: it's associated with an unlinked inode in shmfs, but
its name shows up as "/dev/zero" in "/proc/nnn/maps".

Mmapping other devices could do anything...  By default, the maps stay
associated with the device inode but could be changed by the device
code at its whim.

> Then earlier today I wander across kerneltrap's interview with Larry McVoy, 
> who espouses the viewpoint that Linux VM design should store statistics in 
> inodes rather than worrying so much about individual pages, and I get 
> confused again.

Well, if I recall correclty, Larry made it clear in that interview
that he wasn't 100% sure how the Linux MM was doing things right now,
and he certainly wasn't claiming his scheme would plug right in.  If
his scheme were to be adopted, presumably we would want to introduce
inodes associated with private, anonymous pages (including brk/sbrk
pages).

-- 
Kevin Buhr <buhr@telus.net>
