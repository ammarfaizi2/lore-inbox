Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUJWD57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUJWD57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269183AbUJWD5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:57:24 -0400
Received: from kelvin.pobox.com ([207.8.226.2]:59865 "EHLO kelvin.pobox.com")
	by vger.kernel.org with ESMTP id S267810AbUJWDyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:54:44 -0400
Date: Fri, 22 Oct 2004 20:54:42 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       roland@redhat.com, jdewand@redhat.com
Subject: [PATCH][2.4] ELF fixes for executables with huge BSS (2/2)
Message-ID: <20041023035442.GB3445@ip68-4-98-123.oc.oc.cox.net>
References: <20041023034127.GA26813@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023034127.GA26813@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a 2.4.27-2.4.28 port of this patch:

> [PATCH] binfmt_elf.c fix for 32-bit apps with large bss
> 
> From: Julie DeWandel <jdewand@redhat.com>
> 
> A problem exists where a 32-bit application can have a huge bss, one that
> is so large that an overflow of the TASK_SIZE happens.  But in this case,
> the overflow is not detected in load_elf_binary().  Instead, because
> arithmetic is being done using 32-bit containers, a truncation occurs and
> the program gets loaded when it shouldn't have been.  Subsequent execution
> yields unpredictable results.
> 
> The attached patch fixes this problem by checking for the overflow
> condition and sending a SIGKILL to the application if the overflow is
> detected.  This problem can in theory exist when loading the elf
> interpreter as well, so a similar check was added there.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>


diff -ruN linux-2.4.28-pre4-bk2-bkn1/fs/binfmt_elf.c linux-2.4.28-pre4-bk2-bkn2/fs/binfmt_elf.c
--- linux-2.4.28-pre4-bk2-bkn1/fs/binfmt_elf.c	2004-10-16 03:44:41.000000000 -0700
+++ linux-2.4.28-pre4-bk2-bkn2/fs/binfmt_elf.c	2004-10-16 04:16:38.000000000 -0700
@@ -332,6 +332,18 @@
 	    }
 
 	    /*
+	     * Check to see if the section's size will overflow the
+	     * allowed task size. Note that p_filesz must always be
+	     * <= p_memsize so it is only necessary to check p_memsz.
+	     */
+	    k = load_addr + eppnt->p_vaddr;
+	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
+		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
+	        error = -ENOMEM;
+		goto out_close;
+	    }
+
+	    /*
 	     * Find the end of the file mapping for this phdr, and keep
 	     * track of the largest address we see for this.
 	     */
@@ -711,6 +723,19 @@
 		if (k < start_code) start_code = k;
 		if (start_data < k) start_data = k;
 
+		/*
+		 * Check to see if the section's size will overflow the
+		 * allowed task size. Note that p_filesz must always be
+		 * <= p_memsz so it is only necessary to check p_memsz.
+		 */
+		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		    elf_ppnt->p_memsz > TASK_SIZE ||
+		    TASK_SIZE - elf_ppnt->p_memsz < k) {
+			/* set_brk can never work.  Avoid overflows.  */
+			send_sig(SIGKILL, current, 0);
+			goto out_free_dentry;
+		}
+
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
 		if (k > elf_bss)
