Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285403AbRLGEVm>; Thu, 6 Dec 2001 23:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285404AbRLGEVd>; Thu, 6 Dec 2001 23:21:33 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:64640 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S285403AbRLGEVZ>; Thu, 6 Dec 2001 23:21:25 -0500
Message-ID: <3C1040C3.20601@wipro.com>
Date: Fri, 07 Dec 2001 09:38:35 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: proc_pid_statm
In-Reply-To: <20011206134150.A818@holomorphy.com>
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-3595df69-eac9-11d5-a216-0000e22173f5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-3595df69-eac9-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I looked at ELF_ET_DYN_BASE and it is defined differently on
different architectures. For example on an i386, it is defined
to be 2GB which is 0x80000000.

On ia64 it is defined as (TASK_UNMAPPED_BASE + 0x1000000).

I would *dare* suggest that since all shared libraries are
mmapped, the correct value to compare against in your patch is
TASK_UNMAPPED_BASE.

On my i386, the ldd output and looking at /proc/<pid>/maps
justifies this.

ldd -d /bin/ls
        libtermcap.so.2 => /lib/libtermcap.so.2 (0x4002d000)
        libc.so.6 => /lib/i686/libc.so.6 (0x40031000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)


ld-linux.so.2 is loaded at TASK_UNMAPPED_BASE. Again, let me
remind you that I am speculating, so please correct me if u think
I am wrong.

Comments,
Balbir


William Lee Irwin III wrote:

>It's unclear where the number 0x60000000 comes from. I believe it's
>attempting to anticipate the layout of the process address space, in
>particular the fact that ELF interpreters are mapped starting at
>ELF_ET_DYN_BASE when formatted as dynamic shared objects, (and this
>used to happen around 0x60000000 if I remember old ldd output), and in
>many cases, all dynamic shared objects are mapped at still higher
>addresses. Open-coding this number seems non-portable.
>
>Could someone comment on this?
>
>
>Cheers,
>Bill
>
>
>I think the author may have had this in mind (though this may still
>report inaccurately on a few architectures):
>
>
>--- linux-2.4.17-pre4-virgin/fs/proc/array.c	Thu Oct 11 09:00:01 2001
>+++ linux-2.4.17-pre4/fs/proc/array.c	Thu Dec  6 13:36:33 2001
>@@ -75,6 +75,7 @@
> #include <asm/pgtable.h>
> #include <asm/io.h>
> #include <asm/processor.h>
>+#include <linux/elf.h>
> 
> /* Gcc optimizes away "strlen(x)" for constant x */
> #define ADDBUF(buffer, string) \
>@@ -491,14 +492,13 @@
> 			share += shared;
> 			dt += dirty;
> 			size += total;
>-			if (vma->vm_flags & VM_EXECUTABLE)
>-				trs += pages;	/* text */
>-			else if (vma->vm_flags & VM_GROWSDOWN)
>-				drs += pages;	/* stack */
>-			else if (vma->vm_end > 0x60000000)
>-				lrs += pages;	/* library */
>-			else
>-				drs += pages;
>+			if (vma->vm_flags & VM_EXECUTABLE) {
>+				if(vma->vm_end > ELF_ET_DYN_BASE)
>+					lrs += pages;    /* library */
>+				else
>+					trs += pages;	/* text */
>+			} else
>+				drs += pages;	/* stack and data */
> 			vma = vma->vm_next;
> 		}
> 		up_read(&mm->mmap_sem);
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



------=_NextPartTM-000-3595df69-eac9-11d5-a216-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-3595df69-eac9-11d5-a216-0000e22173f5--
