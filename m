Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVAZAUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVAZAUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAZAUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:20:39 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:36001 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262259AbVAZARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:17:21 -0500
Message-ID: <41F6E187.40305@yahoo.com.au>
Date: Wed, 26 Jan 2005 11:17:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hi, please cc Andi on 4 level page tables stuff too]

Anton Blanchard wrote:
> Hi,
> 
> The 4 level pagetable code changed the exit_mmap code to rely on
> TASK_SIZE. On some architectures (eg ppc64 and ia64), this is a per task
> property and bad things can happen in certain circumstances when using
> it.
> 
> It is possible for one task to end up "owning" an mm from another - we
> have seen this with the procfs code when process 1 accesses
> /proc/pid/cmdline of process 2 while it is exiting.  Process 2 exits
> but does not tear its mm down. Later on process 1 finishes with the proc
> file and the mm gets torn down at this point.
> 
> Now if process 1 was 32bit and process 2 was 64bit then we end up using
> a bad value for TASK_SIZE in exit_mmap. We only tear down part of the
> address space and leave half initialised pagetables and entries in the
> MMU etc.
> 
> MM_VM_SIZE() was created for this purpose (and is used in the next line
> for tlb_finish_mmu), so use it. I moved the PGD round up of TASK_SIZE
> into the default MM_VM_SIZE.
> 

Yep, looks like the right thing to do. I don't know about moving the
rounding into MM_VM_SIZE though - it is basically just a requirement of
clear_page_range. Might be better to leave it there?

> As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:
> 
> include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1
> 
> It would be nice to get rid of one more magic constant and just clear
> from 0 ... MM_VM_SIZE(). That would make it consistent with the
> tlb_flush_mmu call below it too.
> 

Considering the comments by Ian and Russell, can we remove the special
casing by going in the other direction; feed FIRST_USER_PGD_NR * PGDIR_SIZE
to tlb_finish_mmu? Ian, Russell, this would only be a change to your
architectures... so long as your tlb_finish_mmu isn't doing something
special when it sees a zero argument AFAIKS that would be OK?

