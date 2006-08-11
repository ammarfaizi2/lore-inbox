Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWHKVW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWHKVW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHKVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:22:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932419AbWHKVW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:22:57 -0400
Date: Fri, 11 Aug 2006 17:25:22 -0400
From: Don Zickus <dzickus@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060811212522.GF18865@redhat.com>
References: <20060807174439.GJ16231@redhat.com> <m17j1kctb8.fsf@ebiederm.dsl.xmission.com> <20060807235727.GM16231@redhat.com> <m1ejvrakhq.fsf@ebiederm.dsl.xmission.com> <20060809200642.GD7861@redhat.com> <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com> <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irl01hex.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 
> >> I'm a little disappointed but at this point it isn't a great surprise,
> >> the code is early yet and hasn't had much testing or attention.
> >> I wonder if I have missed something else silly.
> >> 
> >> As for testing, can you use plain kexec to load the kernel at a
> >> different address?  I'm curious to know if it is something related
> >> to the kexec on panic path or if it is just running at a different
> >> location that is the problem.
> >

I think I have found the 'something silly'.  Here is a patch that allows
our Dell em64t boxes to boot.  This change matches the original code.  The
main difference that caused the problems was the setting of _PAGE_NX bit.
This caused issues in early_io_remap().  

Thanks to Larry Woodman for debugging this.  

Cheers,
Don


Signed-off-by:  Don Zickus <dzickus@redhat.com>

--- linux-2.6.17.noarch/arch/x86_64/mm/init.c.orig	2006-08-11 12:35:58.000000000 -0400
+++ linux-2.6.17.noarch/arch/x86_64/mm/init.c	2006-08-11 13:14:20.000000000 -0400
@@ -196,7 +196,7 @@
 		vaddr += addr & ~PMD_MASK;
 		addr &= PMD_MASK;
 		for (i = 0; i < pmds; i++, addr += PMD_SIZE)
-			set_pmd(pmd + i,__pmd(addr | __PAGE_KERNEL_LARGE));
+			set_pmd(pmd + i,__pmd(addr | _KERNPG_TABLE | _PAGE_PSE));
 		__flush_tlb();
 		return (void *)vaddr;
 	next:
