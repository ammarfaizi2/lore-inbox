Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUCXAi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUCXAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:38:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:50148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262951AbUCXAiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:38:55 -0500
Date: Tue, 23 Mar 2004 16:41:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-Id: <20040323164104.11d79f32.akpm@osdl.org>
In-Reply-To: <20040324002149.GT4677@tpkurt.garloff.de>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> > Which architectures are currently making their pre-page execute permissions
> > depend upon VM_EXEC?  Would additional arch patches be needed for this?
> 
> It works on AMD64 (not ia32e), both for 64bit and 32bit binaries.
> I have not yet tested other archs.
> 
> If the values in the protection_map are different depending on bit 2,
> the patch will be effecitve. (OK, the CPU/MMU needs to honour the
> setting of course.) Most likely, the values for 
> protection_map[7] is PAGE_COPY_EXEC and of protection_map[3] is
> PAGE_COPY.

OK.

> > This may not get past Linus of course.  It doesn't even get past me with
> > that magical undocumented -1/0/+1 value of the executable_stack argument. 
> > Please replace that with a proper, commented, #defined-or-enumerated value,
> 
> As you wish, master.
> Slightly edited and untested patch attached.

It gets rejects in arch/x86_64/ia32/ia32_binfmt.c and
arch/ia64/ia32/binfmt_elf32.c - someone has been dinking with your
put_dirty_page() prototype.  I dropped those bits.

And I added the missing bit:

--- 25/include/linux/binfmts.h~noexec-stack-comments	Tue Mar 23 16:35:50 2004
+++ 25-akpm/include/linux/binfmts.h	Tue Mar 23 16:37:11 2004
@@ -62,9 +62,12 @@ extern int prepare_binprm(struct linux_b
 extern void remove_arg_zero(struct linux_binprm *);
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
-#define EXSTACK_DEFAULT   0
-#define EXSTACK_DISABLE_X 1
-#define EXSTACK_ENABLE_X  2
+
+/* Stack area protections */
+#define EXSTACK_DEFAULT   0	/* Whatever the arch defaults to */
+#define EXSTACK_DISABLE_X 1	/* Disable executable stacks */
+#define EXSTACK_ENABLE_X  2	/* Enable executable stacks */
+
 extern int setup_arg_pages(struct linux_binprm * bprm, int executable_stack);
 extern int copy_strings(int argc,char __user * __user * argv,struct linux_binprm *bprm); 
 extern int copy_strings_kernel(int argc,char ** argv,struct linux_binprm *bprm);



Now, what should the kernel do if the executable requests EXSTACK_DISABLE_X
but the kernel cannot do that?  Is it not a bit misleading/dangerous to
permit the executable to run anyway?

