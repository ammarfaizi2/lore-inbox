Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTDJWHL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTDJWHK (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:07:10 -0400
Received: from [12.47.58.73] ([12.47.58.73]:31040 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264218AbTDJWHJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:07:09 -0400
Date: Thu, 10 Apr 2003 15:18:57 -0700
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
Message-Id: <20030410151857.7ba8f484.akpm@digeo.com>
In-Reply-To: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Apr 2003 22:18:44.0883 (UTC) FILETIME=[266CF630:01C2FFAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> interrupts_open() can easily try to kmalloc() more memory than
> supported by kmalloc.  E.g., with 16KB page size and NR_CPUS==64, it
> would try to allocate 147456 bytes.
> 
> The workaround below is to allocate 4KB per 8 CPUs.  Not really a
> solution, but the fundamental problem is that /proc/interrupts
> shouldn't use a fixed buffer size in the first place.  I suppose
> another solution would be to use vmalloc() instead.  It all feels like
> bandaids though.
> 
> 	--david
> 
> ===== fs/proc/proc_misc.c 1.71 vs edited =====
> --- 1.71/fs/proc/proc_misc.c	Sat Mar 22 22:14:49 2003
> +++ edited/fs/proc/proc_misc.c	Thu Apr 10 14:35:16 2003
> @@ -388,7 +388,7 @@
>  extern int show_interrupts(struct seq_file *p, void *v);
>  static int interrupts_open(struct inode *inode, struct file *file)
>  {
> -	unsigned size = PAGE_SIZE * (1 + NR_CPUS / 8);
> +	unsigned size = 4096 * (1 + NR_CPUS / 8);

urgh, consider me thwapped.

There continue to be a lot of places where we assume that pages are 4k (eg:
sizing of the free page reserves).  But few are as fatal as this one...

Thanks.
