Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285233AbRLFVmX>; Thu, 6 Dec 2001 16:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbRLFVmE>; Thu, 6 Dec 2001 16:42:04 -0500
Received: from holomorphy.com ([216.36.33.161]:32898 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285227AbRLFVlx>;
	Thu, 6 Dec 2001 16:41:53 -0500
Date: Thu, 6 Dec 2001 13:41:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: proc_pid_statm
Message-ID: <20011206134150.A818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear where the number 0x60000000 comes from. I believe it's
attempting to anticipate the layout of the process address space, in
particular the fact that ELF interpreters are mapped starting at
ELF_ET_DYN_BASE when formatted as dynamic shared objects, (and this
used to happen around 0x60000000 if I remember old ldd output), and in
many cases, all dynamic shared objects are mapped at still higher
addresses. Open-coding this number seems non-portable.

Could someone comment on this?


Cheers,
Bill


I think the author may have had this in mind (though this may still
report inaccurately on a few architectures):


--- linux-2.4.17-pre4-virgin/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux-2.4.17-pre4/fs/proc/array.c	Thu Dec  6 13:36:33 2001
@@ -75,6 +75,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/processor.h>
+#include <linux/elf.h>
 
 /* Gcc optimizes away "strlen(x)" for constant x */
 #define ADDBUF(buffer, string) \
@@ -491,14 +492,13 @@
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
+				if(vma->vm_end > ELF_ET_DYN_BASE)
+					lrs += pages;    /* library */
+				else
+					trs += pages;	/* text */
+			} else
+				drs += pages;	/* stack and data */
 			vma = vma->vm_next;
 		}
 		up_read(&mm->mmap_sem);
