Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVLOJBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVLOJBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbVLOJBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:01:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161087AbVLOJBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:01:02 -0500
Date: Thu, 15 Dec 2005 01:00:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: miles.lane@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       linux@dominikbrodowski.net, alan@lxorguk.ukuu.org.uk,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible
 [00000001] code: swapper/1
Message-Id: <20051215010038.12ca576f.akpm@osdl.org>
In-Reply-To: <20051215004028.0bf9791f.akpm@osdl.org>
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
	<20051215004028.0bf9791f.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> > Here's the BUG output:
>  > 
>  > [4294671.538000] Freeing unused kernel memory: 220k freed
>  > [4294671.538000] BUG: using smp_processor_id() in preemptible
>  > [00000001] code: swapper/1
>  > [4294671.539000] caller is mod_page_state_offset+0x12/0x28
>  > [4294671.539000]  [<c1003723>] dump_stack+0x16/0x1a
>  > [4294671.539000]  [<c110c1eb>] debug_smp_processor_id+0x77/0x90
>  > [4294671.539000]  [<c10413d3>] mod_page_state_offset+0x12/0x28

This'll plug the above.

Nick, please turn on the nice debugging options in future?


diff -puN mm/page_alloc.c~mm-page_state-opt-fix mm/page_alloc.c
--- devel/mm/page_alloc.c~mm-page_state-opt-fix	2005-12-15 00:50:56.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2005-12-15 00:51:07.000000000 -0800
@@ -1389,8 +1389,8 @@ void mod_page_state_offset(unsigned long
 	unsigned long flags;
 	void *ptr;
 
-	ptr = &__get_cpu_var(page_states);
 	local_irq_save(flags);
+	ptr = &__get_cpu_var(page_states);
 	*(unsigned long *)(ptr + offset) += delta;
 	local_irq_restore(flags);
 }
_

