Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJCXGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTJCXGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:06:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:38299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261344AbTJCXGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:06:42 -0400
Date: Fri, 3 Oct 2003 16:06:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20031003160642.6173f13a.akpm@osdl.org>
In-Reply-To: <20031003225509.GA26590@rudolph.ccur.com>
References: <20031003214411.GA25802@rudolph.ccur.com>
	<20031003152349.7194b73d.akpm@osdl.org>
	<20031003225509.GA26590@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> > Something like this?
> 
> 
> Sigh.  No go; it *looks* good but my app still locks up....

Oh crap, you're mapping /dev/mem rather than going through a device driver.
/dev/mem isn't setting VM_IO.

Does this little experiment make it go?


diff -puN drivers/char/mem.c~a drivers/char/mem.c
--- 25/drivers/char/mem.c~a	Fri Oct  3 16:04:04 2003
+++ 25-akpm/drivers/char/mem.c	Fri Oct  3 16:04:15 2003
@@ -176,7 +176,7 @@ static int mmap_mem(struct file * file, 
 	/*
 	 * Don't dump addresses that are not real memory to a core file.
 	 */
-	if (uncached)
+//	if (uncached)
 		vma->vm_flags |= VM_IO;
 
 	if (remap_page_range(vma, vma->vm_start, offset, vma->vm_end-vma->vm_start,

_

Course I could test it myself...


I wonder what to do.  Perhaps /dev/mam should set VM_IO if any of the
mapped pages are not valid mem_map-style pageframes.  Or maybe it should
just set VM_IO all the time.
