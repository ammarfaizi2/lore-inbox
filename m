Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUCUMOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 07:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUCUMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 07:14:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38882
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263638AbUCUMOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 07:14:36 -0500
Date: Sun, 21 Mar 2004 13:15:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Message-ID: <20040321121526.GD10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <200403211105.05908@WOLK> <20040321114939.GA10787@dualathlon.random> <20040321120005.GC10787@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321120005.GC10787@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 01:00:05PM +0100, Andrea Arcangeli wrote:
> On Sun, Mar 21, 2004 at 12:49:39PM +0100, Andrea Arcangeli wrote:
> > the additional hardness you could remove the BUG_ON on in memory.c at line
> 
> I now discovered that WARN_ON exists too, so probably the best is to
> simply change that to a WARN_ON (or to a printk). If one will ever do a
> pagetable walk again, one has to change that to a BUG_ON by that time.
> Kernel will work stable regardless of that condition triggering.
> 
> --- x/mm/memory.c.~1~	2004-03-20 22:12:43.000000000 +0100
> +++ x/mm/memory.c	2004-03-21 12:59:05.331923016 +0100
> @@ -1429,7 +1429,7 @@ retry:
>  	 * real anonymous pages, they're "device" reserved pages instead.
>  	 */
>  	reserved = !!(vma->vm_flags & VM_RESERVED);
> -	BUG_ON(reserved == pageable);
> +	WARN_ON(reserved == pageable);
>  
>  	/*
>  	 * Should we do an early C-O-W break?

and here the vmware proper fix:

--- vmmon-only/linux/driver.c.~1~	2004-03-21 13:07:02.869326296 +0100
+++ vmmon-only/linux/driver.c	2004-03-21 13:07:28.320457136 +0100
@@ -1083,6 +1083,7 @@ static int LinuxDriverMmap(struct file *
    }
    /* Clear VM_IO, otherwise SuSE's kernels refuse to do get_user_pages */
    vma->vm_flags &= ~VM_IO;
+   vma->vm_flags |= VM_RESERVED;
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 2, 3)
    vma->vm_file = filp;
    filp->f_count++;


You should apply both (though just applying one of the two will fix it).
