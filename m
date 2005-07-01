Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263303AbVGAKst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbVGAKst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbVGAKst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:48:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41127 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263303AbVGAKso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:48:44 -0400
Message-ID: <42C5210B.8080806@in.ibm.com>
Date: Fri, 01 Jul 2005 16:25:07 +0530
From: suzuki <suzuki@in.ibm.com>
Organization: IBM Global Services India
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH] madvise() does not always return -EBADF on non-file
 mapped area 
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

madvise() system call returns -EBADF for areas which does not map to 
files, only for *behaviour* request MADV_WILLNEED.

Is it the intended behaviour of madvise() ?

According to man pages, madvise returns :

EBADF - the map exists, but the area maps something that isn’t a file.

I have attached a patch which could resolve the issue.

-- 
regards,

Suzuki K P
Linux Technology Centre,
IBM Software Labs,
India.



Patch to fix madvise() to return -EBADF for non-file mapped area on any 
requested behaviour.

Signed Off by : Suzuki K P <suzuki@in.ibm.com>
================================================

--- mm/madvise.c        2005-07-01 16:08:26.000000000 +0530
+++ mm/madvise.c.new    2005-07-01 16:07:45.000000000 +0530
@@ -62,9 +62,6 @@ static long madvise_willneed(struct vm_a
  {
         struct file *file = vma->vm_file;

-       if (!file)
-               return -EBADF;
-
         start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
         if (end > vma->vm_end)
                 end = vma->vm_end;
@@ -114,8 +111,12 @@ static long madvise_dontneed(struct vm_a
  static long madvise_vma(struct vm_area_struct * vma, unsigned long start,
                         unsigned long end, int behavior)
  {
+       struct file* filp = vma->vm_file;
         long error = -EBADF;

+       if(!filp)
+               goto  out;
+
         switch (behavior) {
         case MADV_NORMAL:
         case MADV_SEQUENTIAL:
@@ -136,6 +137,7 @@ static long madvise_vma(struct vm_area_s
                 break;
         }

+out:
         return error;
  }

