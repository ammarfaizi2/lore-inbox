Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285414AbRLGFAc>; Fri, 7 Dec 2001 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285377AbRLGFAW>; Fri, 7 Dec 2001 00:00:22 -0500
Received: from holomorphy.com ([216.36.33.161]:2436 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285370AbRLGFAI>;
	Fri, 7 Dec 2001 00:00:08 -0500
Date: Thu, 6 Dec 2001 21:00:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: proc_pid_statm
Message-ID: <20011206210006.D818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206134150.A818@holomorphy.com> <3C1040C3.20601@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C1040C3.20601@wipro.com>; from balbir.singh@wipro.com on Fri, Dec 07, 2001 at 09:38:35AM +0530
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 09:38:35AM +0530, BALBIR SINGH wrote:
> I looked at ELF_ET_DYN_BASE and it is defined differently on
> different architectures. For example on an i386, it is defined
> to be 2GB which is 0x80000000.

The corrected patch follows:


--- linux-2.4.17-pre4-virgin/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-2.4.17-pre4/fs/proc/array.c	Thu Dec  6 20:58:36 2001
@@ -491,14 +491,13 @@
 			share += shared;
 			dt += dirty;
 			size += total;
-			if (vma->vm_flags & VM_EXECUTABLE)
-				trs += pages;	/* text */
-			else if (vma->vm_flags & VM_GROWSDOWN)
-				drs += pages;	/* stack */
-			else if (vma->vm_end > 0x60000000)
-				lrs += pages;	/* library */
-			else
-				drs += pages;
+			if (vma->vm_flags & VM_EXECUTABLE) {
+				if(vma->vm_end > TASK_UNMAPPED_BASE)
+					lrs += pages;    /* library */
+				else
+					trs += pages;	/* text */
+			} else
+				drs += pages;	/* stack and data */
 			vma = vma->vm_next;
 		}
 		up_read(&mm->mmap_sem);
