Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSIYXN7>; Wed, 25 Sep 2002 19:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSIYXN7>; Wed, 25 Sep 2002 19:13:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:8148 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261395AbSIYXN6>;
	Wed, 25 Sep 2002 19:13:58 -0400
Message-ID: <3D92446C.1F55CC55@digeo.com>
Date: Wed, 25 Sep 2002 16:19:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] make mprotect() work again
References: <200209252300.g8PN0FGO019455@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2002 23:19:08.0833 (UTC) FILETIME=[F3171910:01C264E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> This patch:
> 
>  ChangeSet@1.536.31.4, 2002-09-17 20:35:47-07:00, akpm@digeo.com
>   [PATCH] consolidate the VMA splitting code
> 
> broke mprotect().  The patch below makes it work again.
> 

Thanks.  Yet another victim of the return-from-the-middle-of-a-function
disease.

I'll send this:


--- 2.5.38/mm/mprotect.c~mprotect-fix	Wed Sep 25 16:16:14 2002
+++ 2.5.38-akpm/mm/mprotect.c	Wed Sep 25 16:16:35 2002
@@ -187,7 +187,7 @@ mprotect_fixup(struct vm_area_struct *vm
 		 * Try to merge with the previous vma.
 		 */
 		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
-			return 0;
+			goto success;
 	} else {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
@@ -209,7 +209,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	vma->vm_flags = newflags;
 	vma->vm_page_prot = newprot;
 	spin_unlock(&mm->page_table_lock);
-
+success:
 	change_protection(vma, start, end, newprot);
 	return 0;
 

.
