Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVBCCQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVBCCQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVBCCQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:16:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262597AbVBCCQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:16:30 -0500
Message-Id: <200502030219.j132JsTi013377@pasta.boston.redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix for memory corruption from /proc/kcore access
Date: Wed, 02 Feb 2005 21:19:54 -0500
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo.  A fairly nasty memory corruption potential exists when
/proc/kcore is accessed and there are at least 62 vmalloc'd areas.

The problem is that get_kcore_size() does not properly account for
the elf_prstatus, elf_prpsinfo, and task_struct structure sizes in
the fabricated ELF header, and then elf_kcore_store_hdr() and its
associated calls to storenote() will possibly overrun the "elf_buf"
buffer allocated by read_kcore().  Because the requested buffer size
is rounded up to a page multiple, only certain ranges of counts of
vmalloc'd areas will actually lead to a memory corruption.  When it
does happen, usually the end of the /proc/kcore reader's task_struct
ends up being copied into a slab page (or sometimes into a data page)
causing a kernel crash (or data corruption) at a later point in time.

The 1st hunk of the patch below fixes this problem.  The latter 3
hunks correct the "p_filesz" value for the note section (which is
already initialized to 0 on line 232) as stored in the ELF header,
but these hunks are not necessary to fix the corruption possiblity.

The fix is already in 2.6.

Cheers.  -ernie



--- linux-2.4.29/fs/proc/kcore.c.orig	2004-08-07 19:26:06.000000000 -0400
+++ linux-2.4.29/fs/proc/kcore.c	2005-02-02 19:52:50.000000000 -0500
@@ -136,7 +136,10 @@ static unsigned long get_kcore_size(int 
 	}
 	*elf_buflen =	sizeof(struct elfhdr) + 
 			(*num_vma + 2)*sizeof(struct elf_phdr) + 
-			3 * sizeof(struct memelfnote);
+			3 * (sizeof(struct elf_note) + 4) +
+			sizeof(struct elf_prstatus) +
+			sizeof(struct elf_prpsinfo) +
+			sizeof(struct task_struct);
 	*elf_buflen = PAGE_ALIGN(*elf_buflen);
 	return (size - PAGE_OFFSET + *elf_buflen);
 }
@@ -279,7 +282,7 @@ static void elf_kcore_store_hdr(char *bu
 
 	memset(&prstatus, 0, sizeof(struct elf_prstatus));
 
-	nhdr->p_filesz	= notesize(&notes[0]);
+	nhdr->p_filesz += notesize(&notes[0]);
 	bufp = storenote(&notes[0], bufp);
 
 	/* set up the process info */
@@ -296,7 +299,7 @@ static void elf_kcore_store_hdr(char *bu
 	strcpy(prpsinfo.pr_fname, "vmlinux");
 	strncpy(prpsinfo.pr_psargs, saved_command_line, ELF_PRARGSZ);
 
-	nhdr->p_filesz	= notesize(&notes[1]);
+	nhdr->p_filesz += notesize(&notes[1]);
 	bufp = storenote(&notes[1], bufp);
 
 	/* set up the task structure */
@@ -305,7 +308,7 @@ static void elf_kcore_store_hdr(char *bu
 	notes[2].datasz	= sizeof(struct task_struct);
 	notes[2].data	= current;
 
-	nhdr->p_filesz	= notesize(&notes[2]);
+	nhdr->p_filesz += notesize(&notes[2]);
 	bufp = storenote(&notes[2], bufp);
 
 } /* end elf_kcore_store_hdr() */
