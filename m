Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTEaQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEaQL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:11:27 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:32976 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264437AbTEaQLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:11:23 -0400
Date: Sat, 31 May 2003 10:46:18 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@digeo.com,
       hch@infradead.org
Subject: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030531104617.J672@nightmaster.csn.tu-chemnitz.de>
References: <20030530164150.A26766@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030530164150.A26766@us.ibm.com>; from paulmck@us.ibm.com on Fri, May 30, 2003 at 04:41:50PM -0700
X-Spam-Score: -4.2 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19M99v-0004HC-00*SjyLdKbXgZw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Fri, May 30, 2003 at 04:41:50PM -0700, Paul E. McKenney wrote:
> -struct page *
> -ia32_install_shared_page (struct vm_area_struct *vma, unsigned long address, int no_share)
> +int
> +ia32_install_shared_page (struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access, pmd_t *pmd)
>  {
>  	struct page *pg = ia32_shared_page[(address - vma->vm_start)/PAGE_SIZE];
>  
>  	get_page(pg);
> -	return pg;
> +	return install_new_page(mm, vma, address, write_access, pmd, pg);
>  }

Why do we always pass mm and vma down, even if vma->vm_mm
contains the mm, where the vma belongs to? Is the connection
between a vma and its mm also protected by the mmap_sem?

Is this really necessary or an oversight and we waste a lot of
stack in a lot of places?

If we just need it for accounting: We need current->mm, if we
need it to locate the next vma relatively to this vma, vma->vm_mm
is the one.

Puzzled

Ingo Oeser
