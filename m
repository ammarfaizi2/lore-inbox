Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTDVTGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTDVTGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:06:31 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:56215 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263366AbTDVTG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:06:29 -0400
Date: Tue, 22 Apr 2003 23:17:40 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       akpm@digeo.co
Subject: [2.4] binfmt_elf memleak (fix)
Message-ID: <20030422191740.GA7172@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Some time ago I have found a memleak in binfmt_elf.c in 2.5, that was quickly
   fixed by Andrew Morton. The same problem is present in current 2.4 tree.
   Andrew's fix applies to 2.4 with a little fuzz and the result looks correct
   to me. Consider applying following patch (against latest 2.4 bk tree).

Bye,
    Oleg

===== fs/binfmt_elf.c 1.21 vs edited =====
--- 1.21/fs/binfmt_elf.c	Sat May  4 21:05:24 2002
+++ edited/fs/binfmt_elf.c	Tue Apr 22 23:09:38 2003
@@ -375,7 +375,6 @@
 	unsigned long text_data, elf_entry = ~0UL;
 	char * addr;
 	loff_t offset;
-	int retval;
 
 	current->mm->end_code = interp_ex->a_text;
 	text_data = interp_ex->a_text + interp_ex->a_data;
@@ -397,11 +396,9 @@
 	}
 
 	do_brk(0, text_data);
-	retval = -ENOEXEC;
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
-	retval = interpreter->f_op->read(interpreter, addr, text_data, &offset);
-	if (retval < 0)
+	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
 		goto out;
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
@@ -607,7 +604,7 @@
 	retval = setup_arg_pages(bprm);
 	if (retval < 0) {
 		send_sig(SIGKILL, current, 0);
-		return retval;
+		goto out_free_dentry;
 	}
 	
 	current->mm->start_stack = bprm->p;
@@ -711,7 +708,8 @@
 			printk(KERN_ERR "Unable to load interpreter\n");
 			kfree(elf_phdata);
 			send_sig(SIGSEGV, current, 0);
-			return 0;
+			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
+			goto out;
 		}
 	}
 
