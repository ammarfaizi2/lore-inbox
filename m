Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVFGOuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVFGOuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVFGOuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:50:01 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:22146 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261889AbVFGOta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:49:30 -0400
X-Rentec: external
Message-ID: <42A5B3E0.1090802@rentec.com>
Date: Tue, 07 Jun 2005 10:49:04 -0400
From: Wolfgang Wander <wwc@rentec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org> <42A5AE2D.6020100@rentec.com>
In-Reply-To: <42A5AE2D.6020100@rentec.com>
Content-Type: multipart/mixed;
 boundary="------------050607020907000903030602"
X-Logged: Logged by unicorn.rentec.com as j57En5c5025868 at Tue Jun  7 10:49:06 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050607020907000903030602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Wander wrote:
> Andrew Morton wrote:
> 
>> +avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes.patch 
>>
> 
> 
> As a heads-up.
> 
> This one breaks the fragmentation reduction patch in 32 bit emulation mode.
> Our test case shows the standard 17 fragmented regions in 
> /proc/self/maps (as in
> the 2.6 standard kernel) vs the 2 regions in 2.6.12-rc5-mm2 (and before).
> 
> Somehow the new way of detecting 32 bit remulation mode seems to fail here.
> 
> I'll try to figure out a fix.
> 

Here is one possibility:

Since rc6 the difference between TASK_UNMAPPED_64 and TASK_UNMAPPED_32 is gone
and both are now merged into TASK_UNMAPPED_BASE.  Therefore we can no longer
check our local base against TASK_UNMAPPED_BASE to see if we are running in 32bit
emulation mode.  The appended patch uses other (hopefully the right) means.

Tested on x86_64 in 32 and 64 mode (64 bit fragments as desired, 32 bit
collapses as desired).

Signed-off-by: Wolfgang Wander <wwc@rentec.com>


--------------050607020907000903030602
Content-Type: text/x-patch;
 name="avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="avoiding-mmap-fragmentation-revert-unneeded-64-bit-changes-vs-x86_64-task_size-fixes-for-compatibility-mode-processes-fix.patch"

--- arch/x86_64/kernel/sys_x86_64.c~	2005-06-07 09:12:31.000000000 -0400
+++ arch/x86_64/kernel/sys_x86_64.c	2005-06-07 10:32:07.000000000 -0400
@@ -105,7 +105,8 @@ arch_get_unmapped_area(struct file *filp
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	if (begin != TASK_UNMAPPED_BASE && len <= mm->cached_hole_size) {
+	if (((flags & MAP_32BIT) || test_thread_flag(TIF_IA32))
+	    && len <= mm->cached_hole_size) {
 	        mm->cached_hole_size = 0;
 		mm->free_area_cache = begin;
 	}

--------------050607020907000903030602--
