Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUBVPk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUBVPk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:40:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52615 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261557AbUBVPkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:40:55 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: BOOT_CS
References: <c16rdh$gtk$1@terminus.zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2004 08:13:04 -0700
In-Reply-To: <c16rdh$gtk$1@terminus.zytor.com>
Message-ID: <m1znbbjgfz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin) writes:

> Anyone happen to know of any legitimate reason not to reload %cs in
> head.S?  

Other than the fact it is strongly rude and error prone to depend on
the contents of a global descriptor table you did not setup?

If we did the lgdt boot_gdt before hand I don't see any problems
though.  

But at the point we could as easily do lgdt cpu_gdt_descr, and use
__KERNEL_CS which is better anyway.

> I think the following would be a lot cleaner, as well as a
> lot safer (the jump and indirect branch aren't guaranteed to have the
> proper effects, although technically neither should be required due to
> the %cr0 write):
> 
> @@ -117,10 +147,7 @@
>         movl %cr0,%eax
>         orl $0x80000000,%eax
>         movl %eax,%cr0          /* ..and set paging (PG) bit */
> -       jmp 1f                  /* flush the prefetch-queue */
> -1:
> -       movl $1f,%eax
> -       jmp *%eax               /* make sure eip is relocated */
> +       ljmp $__BOOT_CS,$1f     /* Clear prefetch and normalize %eip
> */
>  1:
>         /* Set up the stack pointer */
>         lss stack_start,%esp
> 
> 
> I've been doing some cleanups in head.S after making the early page
> tables dynamic.

That is almost nice.  Care to export where the bottom of the page
tables or even better where the bottom of the kernel is for those
folks who want to place their ramdisk as low in memory as possible?

Eric
