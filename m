Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTEMUdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTEMUde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:33:34 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19163 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263459AbTEMUc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:32:27 -0400
Date: Tue, 13 May 2003 13:46:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: jdike@karaya.com, roland@redhat.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: build problems on architectures where FIXADDR_* stuff is not
 constant
Message-Id: <20030513134620.3dafeaf3.akpm@digeo.com>
In-Reply-To: <20030513122329.GA31609@namesys.com>
References: <20030513122329.GA31609@namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 20:45:06.0753 (UTC) FILETIME=[89641B10:01C31990]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
>    Since there are architectures where FIXADDR_* stuff is not constant (e.g. UML),
> ...
> +			fixmap_vma.vm_start = FIXADDR_START;
> +			fixmap_vma.vm_end = FIXADDR_TOP;
> +			fixmap_vma.vm_page_prot = PAGE_READONLY;
>  			pgd = pgd_offset_k(pg);
>  			if (!pgd)
>  				return i ? : -EFAULT;

That's modifying static storage which other, unrelated processes or CPUs
may be playing with.

The new code in get_user_pages() is rather rude - it's returning a
statically allocated VMA which isn't in the VMA tree - the caller (who
holds mmap_sem()) could reasonably expect that the VMA can be located via
find_vma(), or removed from the tree or whatever.  But it cannot.

I think it needs to be redone.  Either by stuffing a VMA into every
process's mm which describes the fixmap area, or by failing
get_user_pages() if the caller has passed in a non-NULL `vmas' and is
requesting access to the fixmap area.

Probably the latter.  That'll require that access_process_vm() be changed
to not require a vma.  It's only using the vma for cache flushing, but the
flishing in there is borked anyway.  


