Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946133AbWJSRqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946133AbWJSRqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946269AbWJSRqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:46:43 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:24754 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946133AbWJSRqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:46:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NQMxKlrf+k1iS1cl0ztCBHbgmZQEkmdjYGo9ezw9kcUYHa7LV+ozo4p+cU8qSniPURdAl/Ne1avcA45YksD6UnC2mo64yUTozChlfxnOJ4FkAwXJQRx2vOxsvi7YvdajKYXey8dhif9RDrJ2kbK0+6mRYSMPooDR5+1A/dlZLEQ=  ;
Message-ID: <4537B9FB.7050303@yahoo.com.au>
Date: Fri, 20 Oct 2006 03:46:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org>
In-Reply-To: <1161275748231-git-send-email-ralf@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Problem:
> 
> 1. There is a process containing two thread (T1 and T2).  The
>    thread T1 calls fork().  Then dup_mmap() function called on T1 context.
> 
> static inline int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> 	...
> 	flush_cache_mm(current->mm);
> 	...	/* A */
> 	(write-protect all Copy-On-Write pages)
> 	...	/* B */
> 	flush_tlb_mm(current->mm);
> 	...
> 
> 2. When preemption happens between A and B (or on SMP kernel), the
>    thread T2 can run and modify data on COW pages without page fault
>    (modified data will stay in cache).
> 
> 3. Some time after fork() completed, the thread T2 may cause a page
>    fault by write-protect on a COW page.
> 
> 4. Then data of the COW page will be copied to newly allocated
>    physical page (copy_cow_page()).  It reads data via kernel mapping.
>    The kernel mapping can have different 'color' with user space
>    mapping of the thread T2 (dcache aliasing).  Therefore
>    copy_cow_page() will copy stale data.  Then the modified data in
>    cache will be lost.

What about if you just flush the caches after write protecting all
COW pages? Would that work? Simpler? Better performance? (I don't know)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
