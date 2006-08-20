Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHTJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHTJQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWHTJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 05:16:17 -0400
Received: from 1wt.eu ([62.212.114.60]:44304 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751715AbWHTJQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 05:16:17 -0400
Date: Sun, 20 Aug 2006 11:15:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Andrew Morton <akpm@osdl.org>, Ernie Petrides <petrides@redhat.com>
Subject: [PATCH] binfmt_elf.c : the BAD_ADDR macro again
Message-ID: <20060820091515.GC602@1wt.eu>
References: <20060820020417.GA17450@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820020417.GA17450@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 06:04:17AM +0400, Solar Designer wrote:
> Willy and all,
> 
> Attached are 7 small changes from 2.4.33-ow1, as separate patches.  I do
> not feel that these warrant separate messages.

OK, I will reply to them one at a time, though, otherwise it will take me
hours to write one single mail !

> linux-2.4.33-ow1-BAD_ADDR.diff
> 
> This one is a one-liner, in binfmt_elf.c:
> 
> -#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
> +#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
> 
> I feel that it is more logical to have BAD_ADDR() defined in this way:
> indeed, the first kernel-space address is unusable for userspace.  I
> don't think this change affects anything, and we had it in -ow for a
> couple of years.

I remember being surprized by this macro when I discovered it about one month 
ago. But I was working on something else and let it go. I should have checked
more carefully, because binfmt_aout already defines it as >=, and 2.6 has it
fixed too (recenty though). However, it's not enough to fix the macro, there
are two tests which need to be fixed too, as explained there :

  http://lkml.org/lkml/2006/6/21/507

The proper fix would then be :

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b0ad905..249b710 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -77,7 +77,7 @@ static struct linux_binfmt elf_format = 
 	NULL, THIS_MODULE, load_elf_binary, load_elf_library, elf_core_dump, ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -345,7 +345,7 @@ static unsigned long load_elf_interp(str
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
+	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
 		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
@@ -772,7 +772,7 @@ #endif
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work.  Avoid overflows.  */


And even then, I'm not happy with this test :

   TASK_SIZE - elf_ppnt->p_memsz < k

because it means that we only raise the error when

   k + elf_ppnt->p_memsz > TASK_SIZE

I really think that we want to check this instead :

   k + elf_ppnt->p_memsz >= TASK_SIZE

Otherwise we leave a window where this is undetected :

   load_addr + eppnt->p_vaddr == TASK_SIZE - eppnt->p_memsz

This will later lead to last_bss getting readjusted to TASK_SIZE, which I
don't think is expected at all :

            k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
            if (k > last_bss)
                last_bss = k;

Then I think we should change this at both places :

- 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
+		    BAD_ADDR(k + elf_ppnt->p_memsz)) {

The same change would also be needed in 2.6 then. I can provide a patch
for both 2.4 and 2.6 if everyone agree.

I cc Chuck Ebbert, Ernie Petrides and Andrew who discussed the subject
in June.

Regards,
Willy

