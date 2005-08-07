Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVHGKzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVHGKzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 06:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVHGKzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 06:55:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22536 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751479AbVHGKzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 06:55:35 -0400
Message-ID: <42F5E86C.5000105@vmware.com>
Date: Sun, 07 Aug 2005 03:54:36 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH 2/8] Move privileged processor operations to the subarch
 layer
References: <42F46307.606@vmware.com> <20050807010615.GG7762@shell0.pdx.osdl.net>
In-Reply-To: <20050807010615.GG7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Aug 2005 10:54:53.0015 (UTC) FILETIME=[70A64670:01C59B3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>i386 Transparent Paravirtualization Subarch Patch #2
>>
>>This change encapsulates CPUID and debug register accessors and moves
>>them into the sub-architecture layer. 
>>    
>>
>
>This one looks to be a superset of Xen version:
>
>
>@@ -453,6 +441,7 @@ struct thread_struct {
> 	unsigned long		v86flags, v86mask, saved_esp0;
> 	unsigned int		saved_fs, saved_gs;
> /* IO permissions */
>+	unsigned long	io_pl;
>  
>

We also added an iopl field to the thread struct; this was committed to 
-rc4-mm1:

The patch titled

     x86: make IOPL explicit

has been added to the -mm tree.  Its filename is

     x86-make-iopl-explicit.patch


diff -puN include/asm-i386/processor.h~x86-make-iopl-explicit include/asm-i386/processor.h
--- devel/include/asm-i386/processor.h~x86-make-iopl-explicit	2005-08-03 23:11:31.000000000 -0700
+++ devel-akpm/include/asm-i386/processor.h	2005-08-03 23:12:06.000000000 -0700
@@ -420,6 +420,7 @@ struct tss_struct {
 	 * Cache the current maximum and the last task that used the bitmap:
 	 */
 	unsigned long io_bitmap_max;
+ 	unsigned long	iopl;
 	struct thread_struct *io_bitmap_owner;
 	/*



> 	unsigned long	*io_bitmap_ptr;
> /* max allowed port in the bitmap, in bytes: */
> 	unsigned long	io_bitmap_max;
>@@ -487,6 +476,7 @@ static inline void load_esp0(struct tss_
> 		tss->ss1 = thread->sysenter_cs;
> 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
> 	}
>+	mach_load_esp0(tss, thread);
>  
>

I moved the entire load_esp0() function to the subarch layer.  We used 
to have a mach_load_esp0(tss, thread) type function.  Either way is 
acceptable - I sort of prefer your way, but I was concerned that Xen 
would not want to support the stashing of the v8086 sysenter CS value in 
ss1 (because Xen might not want to shadow the TSS, but use the real one, 
which implies ss1 is the real kernel segment).  I am sort of less 
concerned with this now, because I think that shadowing the TSS is a 
really good idea for many reasons, and I believe Xen does this anyway.

In general, a hypervisor must be aware of two things on kernel stack 
updates = kernel ESP is essential, but kernel SS is also needed if the 
kernel uses alternate stacks.  The hypervisor need not know the TSS 
pointer itself, since it is either implicit (through TR), or not 
required at all (pure hypercall to update the shadow stack).

What to you think of :

include/asm-i386/mach-default/mach_processor.h:
#define mach_update_esp(ss, esp)  /* nop */

include/asm-i386/processor.h, in load_esp0():

mach_update_esp0(KERNEL_SS, thread->esp0);

Zach
