Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292520AbSCKUBS>; Mon, 11 Mar 2002 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292294AbSCKUA7>; Mon, 11 Mar 2002 15:00:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12807 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292520AbSCKUAt>; Mon, 11 Mar 2002 15:00:49 -0500
Date: Mon, 11 Mar 2002 20:00:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: RFC: /proc/kcore
Message-ID: <20020311200041.B32309@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A short while ago, I cooked up the following for the ARM architecture
to allow /proc/kcore to work.  I suspect it needs to be extended to all
architectures however; comments from all other architecture maintainers
are welcome.

In the ELF headers, we supply the following information for the kernels
memory space:

        phdr->p_type    = PT_LOAD;
        phdr->p_flags   = PF_R|PF_W|PF_X;
        phdr->p_offset  = dataoff;
        phdr->p_vaddr   = PAGE_OFFSET;
        phdr->p_paddr   = __pa(PAGE_OFFSET);
        phdr->p_filesz  = phdr->p_memsz = ((unsigned long)high_memory - PAGE_OFFSET);
        phdr->p_align   = PAGE_SIZE;

So, when we access file offset 'dataoff' we expect the bytes starting
at virtual memory address 'PAGE_OFFSET' (or physical address
__pa(PAGE_OFFSET)).

'dataoff' comes from get_kcore_size, and is the same as the elf_buflen
you see in the patch below, and is the first byte of non-header
information.

With a file offset of 'elf_buflen', the original code does:

	start = __va(0)

and the only way this will return the byte at PAGE_OFFSET is if __va
is defined as (PAGE_OFFSET + (x)).  However, a machine where the RAM
does not start at physical address zero, this will not be the case.

I therefore expect that the code I have below for ARM should be used
for all architectures.

I'd like other people to confirm.  If I don't hear anything, I'll
generate such a patch, and forward it to Linus, Marcelo and LKML for
inclusion in the next kernel releases.

--- orig/fs/proc/kcore.c	Mon Oct  1 23:11:24 2001
+++ linux/fs/proc/kcore.c	Tue Jan 29 20:57:03 2002
@@ -382,7 +382,17 @@
 	}
 #endif
 	/* fill the remainder of the buffer from kernel VM space */
+#ifndef __arm__
 	start = (unsigned long)__va(*fpos - elf_buflen);
+#else
+	/*
+	 * this would appear to be more correct than the above.
+	 * We said in the ELF header that the data which starts
+	 * at 'elf_buflen' is virtual address PAGE_OFFSET.  This
+	 * is not what the above does.
+	 */
+	start = PAGE_OFFSET + (*fpos - elf_buflen);
+#endif
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 		

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

