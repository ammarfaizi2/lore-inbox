Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288435AbSAHWDQ>; Tue, 8 Jan 2002 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSAHWBY>; Tue, 8 Jan 2002 17:01:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:52742 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288466AbSAHWBI>; Tue, 8 Jan 2002 17:01:08 -0500
Message-ID: <3C3B6ADF.4AAABE58@zip.com.au>
Date: Tue, 08 Jan 2002 13:55:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Anderson <anderson@mclinux.com>
CC: linux-kernel@vger.kernel.org, blinn@mclinux.com
Subject: Re: [BUG][PATCH] 2.4.* mlockall(MCL_FUTURE) is broken -- child inherits 
 VM_LOCKED
In-Reply-To: <3C3B5D1B.45CBF593@mclinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Anderson wrote:
> 
> In 2.4.*, mlockall(MCL_FUTURE) is erroneously inherited by child processes
> across fork() and exec():

The Linux manpage says that it is not inherited across either.

However SUS says that it is not inherited across exec, and
doesn't mention fork() at all.
http://www.opengroup.org/onlinepubs/007908799/xsh/mlockall.html

So...  Shouldn't we be clearing it in the exec() path?

> ...
> # diff -u linux/kernel/fork.c linux-2.4.17/kernel/fork.c
> --- linux/kernel/fork.c Tue Jan  8 15:11:13 2002
> +++ linux-2.4.17/kernel/fork.c  Tue Jan  8 15:12:26 2002
> @@ -219,6 +219,7 @@
>         init_rwsem(&mm->mmap_sem);
>         mm->page_table_lock = SPIN_LOCK_UNLOCKED;
>         mm->pgd = pgd_alloc(mm);
> +       mm->def_flags = 0;
>         if (mm->pgd)
>                 return mm;
>         free_mm(mm);
> 
> Note that it worked OK in 2.2 because mm->def_flags was explicitly cleared in
> mm_alloc(), which was called by both copy_mm() and exec_mmap().  But things
> were shuffled around a bit in 2.4, and it must have gotten lost in the
> translation...

um.  Is this correct?  It seems that we'll be clearing things
like VM_IO on device mappings across fork.  Bad.  Would an explicit
clear of VM_LOCKED be better here?  (Assuming we want to ignore SUS).

-
