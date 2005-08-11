Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVHKVgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVHKVgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVHKVgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:36:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22409 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932211AbVHKVgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:36:32 -0400
Subject: [question] What's the difference between /dev/kmem and /dev/mem
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 17:36:28 -0400
Message-Id: <1123796188.17269.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I thought I use to know this. But what is the difference
between /dev/kmem and /dev/mem.  I thought that with /dev/kmem you could
use the actual kernel addresses to read from. 

For example, if I wanted to read the current variable X in the kernel, I
could look up the address of X in System.map, then mmaping to /dev/kmem
I could get to that variable using the address that I got from
System.map.  But this doesn't seem to work.

I'm getting an IO error on read. And looking at this I see:


static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
{
        unsigned long long val;
	/*
	 * RED-PEN: on some architectures there is more mapped memory
	 * than available in mem_map which pfn_valid checks
	 * for. Perhaps should add a new macro here.
	 *
	 * RED-PEN: vmalloc is not supported right now.
	 */
	if (!pfn_valid(vma->vm_pgoff))
		return -EIO;
	val = (u64)vma->vm_pgoff << PAGE_SHIFT;
	vma->vm_pgoff = __pa(val) >> PAGE_SHIFT;
	return mmap_mem(file, vma);
}

I printed out the value in vma->vm_pgoff, and it still has the
0xc0000000 (but shifted >> 12). Isn't this suppose to also remove the
0xc?  Or am I just totally off here? 

Thanks,

-- Steve



