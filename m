Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbUKQGlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbUKQGlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUKQGlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:41:52 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:35052
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262183AbUKQGlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:41:09 -0500
Date: Tue, 16 Nov 2004 22:26:11 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, andrea@novell.com
Subject: Re: loops in get_user_pages() for VM_IO
Message-Id: <20041116222611.1f59854a.davem@davemloft.net>
In-Reply-To: <20041116223338.08bb6701.akpm@osdl.org>
References: <20041116175328.5e425e01.davem@davemloft.net>
	<20041116180718.2fa35fbb.davem@davemloft.net>
	<20041116223338.08bb6701.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 22:33:38 -0800
Andrew Morton <akpm@osdl.org> wrote:

> --- sles/mm/memory.c.~1~	2004-11-12 12:30:25.000000000 +0100
> +++ sles/mm/memory.c	2004-11-16 17:58:02.752131952 +0100
> @@ -753,7 +753,7 @@ int get_user_pages(struct task_struct *t
>  			continue;
>  		}
>  
> -		if (!vma || (pages && (vma->vm_flags & VM_IO))
> +		if (!vma || (vma->vm_flags & VM_IO)
>  				|| !(flags & vma->vm_flags))
>  			return i ? : -EFAULT;
> 
> which should fix up the sbuslib.c problem.

It would only becuase do_mmap_pgoff() doesn't check
the return value of make_pages_present().

> Or, better, simply advance over the VM_IO vma and onto the next one?

That would work too.

Although currently in my sparc64 tree I'm setting VM_RESERVED instead
of VM_LOCKED for I/O mappings and that solves the issue as well.  It
would not, of course, solve the mlock() case you mentioned.

I think we need to set these bits consistently across the tree.
And remap_pfn_range() is a good model, so that's what I've used.
Parts of the x86 tree trigger this case too btw, for example
the pci mmap support code.  In fact, all the pci mmap support
routines set VM_LOCKED, probably because they were copied over
from the first two implementations (sparc64 and i386) :-)
