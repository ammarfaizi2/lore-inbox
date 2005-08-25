Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVHYO3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVHYO3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVHYO3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:29:03 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:7529 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965021AbVHYO3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=hs6geq6i9QIOAEKwxlzTt7mD4pn9aS3oEm3bPlbhli/HhAGhvG5OGeeO0qJF/+pVTAEvXDm6PEtQjqL5OD4ECwv4A5wpIJlJktUnBAWLd00nNfW+b1c7n9DAtRYvNtqOTK8xs8MGK9RFiHZASBbkr3Bp8tvYbsstWIqrNuwm7Yg=  ;
Message-ID: <430DD5A8.7060705@yahoo.com.au>
Date: Fri, 26 Aug 2005 00:28:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ray Fucillo <fucillo@intersystems.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <430DC285.7070104@intersystems.com>
In-Reply-To: <430DC285.7070104@intersystems.com>
Content-Type: multipart/mixed;
 boundary="------------020704080605000807080204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020704080605000807080204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Ray Fucillo wrote:
> Nick Piggin wrote:
> 
>> fork() can be changed so as not to set up page tables for
>> MAP_SHARED mappings. I think that has other tradeoffs like
>> initially causing several unavoidable faults reading
>> libraries and program text.
>>
>> What kind of application are you using?
> 
> 
> The application is a database system called Caché.  We allocate a large 
> shared memory segment for database cache, which in a large production 
> environment may realistically be 1+GB on 32-bit platforms and much 
> larger on 64-bit.  At these sizes fork() is taking hundreds of 
> miliseconds, which can become a noticeable bottleneck for us.  This 
> performance characteristic seems to be unique to Linux vs other Unix 
> implementations.
> 
> 

As Andi said, hugepages might be a very nice feature for you guys
to look into and might potentially give a performance increase with
reduced TLB pressure, not only your immediate fork problem.

Anyway, the attached patch is something you could try testing. If
you do so, then I would be very interested to see performance results.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------020704080605000807080204
Content-Type: text/plain;
 name="vm-dontcopy-shared.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-dontcopy-shared.patch"

Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c	2005-08-04 15:24:36.000000000 +1000
+++ linux-2.6/kernel/fork.c	2005-08-26 00:20:50.000000000 +1000
@@ -256,7 +256,6 @@ static inline int dup_mmap(struct mm_str
 		 * Note that, exceptionally, here the vma is inserted
 		 * without holding mm->mmap_sem.
 		 */
-		spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
 
@@ -265,8 +264,11 @@ static inline int dup_mmap(struct mm_str
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
-		spin_unlock(&mm->page_table_lock);
+		if (!(file && (tmp->vm_flags & VM_SHARED))) {
+			spin_lock(&mm->page_table_lock);
+			retval = copy_page_range(mm, current->mm, tmp);
+			spin_unlock(&mm->page_table_lock);
+		}
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);

--------------020704080605000807080204--
Send instant messages to your online friends http://au.messenger.yahoo.com 
