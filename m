Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVBXA50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVBXA50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVBXAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:54:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:36746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261778AbVBXAtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:49:08 -0500
Date: Wed, 23 Feb 2005 16:54:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ignored return value of __clear_user in fs/binfmt_elf.c?
Message-Id: <20050223165409.324cc64f.akpm@osdl.org>
In-Reply-To: <200502231727.j1NHRPGH028335@laptop11.inf.utfsm.cl>
References: <200502231727.j1NHRPGH028335@laptop11.inf.utfsm.cl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> Machine is sparc64, bk of today, gcc-3.4.2-6.fc3 (Aurora Corona). First 2.6
> I try to build here, so it might be something known.
> 
> Build fails due to -Werror with:
> 
> include/asm/uaccess.h: In function `load_elf_binary':
> arch/sparc64/kernel/../../../fs/binfmt_elf.c:811: warning: ignoring return value of `__clear_user', declared with attribute warn_unused_result

Oh bugger.

> Around line 811 of fs/binfmt_elf.c I see:
> 
>                              /*
>                               * This bss-zeroing can fail if the ELF file
>                               * specifies odd protections.  So we don't check                                * the return value
>                               */
>                               (void)clear_user((void __user *)elf_bss +
>                                                       load_bias, nbyte);
> 
> so presumably this discarding is OK here...
> 
> I wonder why an explicit (void) cast is not considered "use" by the
> compiler. But then again, explicitly throwing away isn't really "use"...

I'd assumed that it would work.  How about this?

--- 25/fs/binfmt_elf.c~binfmt_elf-build-fix	Wed Feb 23 16:52:48 2005
+++ 25-akpm/fs/binfmt_elf.c	Wed Feb 23 16:53:40 2005
@@ -821,13 +821,14 @@ static int load_elf_binary(struct linux_
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				/*
-				 * This bss-zeroing can fail if the ELF file
-				 * specifies odd protections.  So we don't check
-				 * the return value
-				 */
-				(void)clear_user((void __user *)elf_bss +
-							load_bias, nbyte);
+				if (clear_user((void __user *)elf_bss +
+							load_bias, nbyte)) {
+					/*
+					 * This bss-zeroing can fail if the ELF
+					 * file specifies odd protections.  So
+					 * we don't check the return value
+					 */
+				}
 			}
 		}
 
_

