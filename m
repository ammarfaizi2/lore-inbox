Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTDIFnV (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTDIFnV (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:43:21 -0400
Received: from [12.47.58.221] ([12.47.58.221]:1043 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262784AbTDIFnT (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:43:19 -0400
Date: Tue, 8 Apr 2003 22:55:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Variable PTE_FILE_MAX_BITS
Message-Id: <20030408225514.478469e0.akpm@digeo.com>
In-Reply-To: <20030409011653.A9103@devserv.devel.redhat.com>
References: <20030409011653.A9103@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 05:54:51.0400 (UTC) FILETIME=[89509080:01C2FE5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> Andrew,
> 
> would you be so kind to take this and forward to Linus?
> I think this segment of the code is your brainchild.

y'know, as I was writing that code I thought "no architecture could be dumb
enough to make PTE_FILE_MAX_BITS variable".

> On sparc

Ah.  That architecture.

> 
> --- linux-2.5.66-bk11/mm/fremap.c	2003-04-05 13:26:24.000000000 -0800
> +++ linux-2.5.66-bk11-sparc/mm/fremap.c	2003-04-05 13:28:22.000000000 -0800
> @@ -136,10 +136,10 @@
>  		return err;
>  
>  	/* Can we represent this offset inside this architecture's pte's? */
> -#if PTE_FILE_MAX_BITS < BITS_PER_LONG
> -	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
> -		return err;
> -#endif
> +	/* This needs to be evaluated at runtime on some platforms */
> +	if (PTE_FILE_MAX_BITS < BITS_PER_LONG)
> +		if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
> +			return err;
>  

The reason I didn't do this in the first place is that if PTE_FILE_MAX_BITS
is 32 (as it is for ia32 PAE), the compiler generates a warning about the
(1<<32).  I guess it generates a bug, too.

Ho hum.  I shall make it "1ULL".
