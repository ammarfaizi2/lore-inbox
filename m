Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWB1DeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWB1DeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWB1DeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:34:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932286AbWB1DeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:34:24 -0500
Date: Mon, 27 Feb 2006 19:33:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace "vmalloc_node" with "vmalloc" for no-mmu
 architectures in oprofile driver
Message-Id: <20060227193322.7a78c585.akpm@osdl.org>
In-Reply-To: <489ecd0c0602271920u7c0fc0b6p8a8cef0f408c6f3b@mail.gmail.com>
References: <489ecd0c0602271920u7c0fc0b6p8a8cef0f408c6f3b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
>   This is a fix to the oprofile driver. It calls "vmalloc_node()" but
>  no-mmu CPUs do not have that function. "vmalloc()" is OK for no-mmu
>  CPUs.
> 
>  Signed-off-by: Luke Yang <luke.adi@gmail.com>
> 
>  Index: linux-2.6/drivers/oprofile/cpu_buffer.c
>  ===================================================================
>  --- linux-2.6/drivers/oprofile/cpu_buffer.c     2006-02-16
>  16:16:35.000000000 +0800
>  +++ linux-2.6/drivers/oprofile/cpu_buffer.c     2006-02-16
>  16:20:58.000000000 +0800
>  @@ -51,9 +51,13 @@
> 
>          for_each_online_cpu(i) {
>                  struct oprofile_cpu_buffer * b = &cpu_buffer[i];
>  -
>  +
>  +#ifdef MMU
>                  b->buffer = vmalloc_node(sizeof(struct op_sample) * buffer_size,
>                          cpu_to_node(i));
>  +#else
>  +               b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
>  +#endif
>                  if (!b->buffer)
>                          goto fail;

You wanted CONFIG_MMU there.

A better fix is to provide vmalloc_node() on nommu architectures.  COuld you
compile-test this please?

--- devel/mm/nommu.c~nommu-implement-vmalloc_node	2006-02-27 19:30:47.000000000 -0800
+++ devel-akpm/mm/nommu.c	2006-02-27 19:31:53.000000000 -0800
@@ -53,7 +53,6 @@ DECLARE_RWSEM(nommu_vma_sem);
 struct vm_operations_struct generic_file_vm_ops = {
 };
 
-EXPORT_SYMBOL(vmalloc);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(vmalloc_32);
@@ -205,6 +204,13 @@ void *vmalloc(unsigned long size)
 {
        return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
 }
+EXPORT_SYMBOL(vmalloc);
+
+void *vmalloc_node(unsigned long size, int node)
+{
+	return vmalloc(size);
+}
+EXPORT_SYMBOL(vmalloc_node);
 
 /*
  *	vmalloc_32  -  allocate virtually continguos memory (32bit addressable)
_

