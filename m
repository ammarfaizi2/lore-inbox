Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUAXVSD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAXVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:18:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:11972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261931AbUAXVR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:17:57 -0500
Date: Sat, 24 Jan 2004 13:17:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audit 2.6 set_pte users
Message-Id: <20040124131755.5336c8a5.akpm@osdl.org>
In-Reply-To: <20040124042225.GO11236@krispykreme>
References: <20040124042225.GO11236@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> Hi,
> 
> I went through all the users of set_pte to check if they flush the
> current pte if it is present. Below is a summary of the audit,
> everything looks good except for a failure case in
> dup_mmap->copy_page_range.

I was hoping this might fix the "missing TLB flush" which Martin
Schwidefsky believes is there, and which is causing him grief.

> --- 1.154/kernel/fork.c	Tue Jan 20 10:38:15 2004
> +++ edited/kernel/fork.c	Sat Jan 24 14:17:00 2004
> @@ -347,6 +347,7 @@
>  fail_nomem:
>  	retval = -ENOMEM;
>  fail:
> +	flush_tlb_mm(current->mm);
>  	vm_unacct_memory(charge);
>  	goto out;
>  }

But look:

 	retval = 0;
 	build_mmap_rb(mm);
 
 out:
 	flush_tlb_mm(current->mm);
 	up_write(&oldmm->mmap_sem);
 	return retval;
 fail_nomem:
 	retval = -ENOMEM;
 fail:
+	flush_tlb_mm(current->mm);
 	vm_unacct_memory(charge);
 	goto out;
 }


There is no missing flush here.
