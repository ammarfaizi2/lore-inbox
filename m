Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCQWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCQWuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCQWuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:50:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:14769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261331AbVCQWtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:49:43 -0500
Date: Thu, 17 Mar 2005 14:49:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: tzachar@cs.bgu.ac.il
Cc: linux-kernel@vger.kernel.org, juhl-lkml@dif.dk
Subject: Re: binfmt_elf padzero problems
Message-Id: <20050317144929.3b468531.akpm@osdl.org>
In-Reply-To: <1111086609.12193.27.camel@nexus.cs.bgu.ac.il>
References: <1111086609.12193.27.camel@nexus.cs.bgu.ac.il>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nir Tzachar <tzachar@cs.bgu.ac.il> wrote:
>
> hello.
> 
> i am seeing a problem(?) with the patch described at:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109865760703851&w=2
> i'm using vanilla 2.6.11 (not .1/.2/.3/.4 ...)
> 
> the short version:
> padzero does not alway do the right thing (more correctly, it's caller,
> load_elf_binary).
>  
> the longer version:
> 
> padzero calls clear_user. clear_user first checks if the address passed
> is writable. if it is not, an error is returned. 
> the problem manifest itself when the area being cleared is not
> writable... this should not normally happen in the context of
> load_elf_binary, however it _can_ happen with the following assembly
> code (intel syntax):
> 
> section .text
> global _start
> _start:
>         mov eax,0x1
>         mov ebx,0x0
>         int 0x80
>         hlt
> 
> assembled with nasm -f elf, produces a binary with a bss segment of zero
> size, aligned to 1, and one program header.
> now, the when calling padzero, elf_bss holds an address which belongs
> to .text (since no (fake)program header for .bss wad created), i.e; not
> writable....
> when padzero is called, it tries to clean the rest of the .text section,
> which clearly results with an error.....
> 
> thus, my (very) small binary always segfaults under 2.6.11+ ....
> 
> on the other hand, i can be dead wrong.. if so, id like to know why...
> 

Tricky.

I guess if the bss has zero length then we can skip the zeroing of the end
of the page at the end of bss, as long as we're dead sure that we didn't
accidentally instantiate a single page on behalf of that zero-length bss.

Something like this, perhaps?


--- 25/fs/binfmt_elf.c~a	Thu Mar 17 14:47:35 2005
+++ 25-akpm/fs/binfmt_elf.c	Thu Mar 17 14:48:44 2005
@@ -907,15 +907,17 @@ static int load_elf_binary(struct linux_
 	 * mapping in the interpreter, to make sure it doesn't wind
 	 * up getting placed where the bss needs to go.
 	 */
-	retval = set_brk(elf_bss, elf_brk);
-	if (retval) {
-		send_sig(SIGKILL, current, 0);
-		goto out_free_dentry;
-	}
-	if (padzero(elf_bss)) {
-		send_sig(SIGSEGV, current, 0);
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
+	if (likely(elf_bss != elf_brk)) {	/* Is there any bss at all? */
+		retval = set_brk(elf_bss, elf_brk);
+		if (retval) {
+			send_sig(SIGKILL, current, 0);
+			goto out_free_dentry;
+		}
+		if (padzero(elf_bss)) {
+			send_sig(SIGSEGV, current, 0);
+			retval = -EFAULT; /* Nobody gets to see this, but.. */
+			goto out_free_dentry;
+		}
 	}
 
 	if (elf_interpreter) {
_


