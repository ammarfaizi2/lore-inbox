Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVHFAi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVHFAi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVHFAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:38:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262172AbVHFAhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:37:51 -0400
Date: Fri, 5 Aug 2005 17:36:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: benoit.boissinot@ens-lyon.fr
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH] s390: fix invalid kmalloc flags
Message-Id: <20050805173629.78f3a0e6.akpm@osdl.org>
In-Reply-To: <20050806002603.GA29515@ens-lyon.fr>
References: <20050806002603.GA29515@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benoit.boissinot@ens-lyon.fr wrote:
>
> The following patch fixes the compilation (defconfig) of s390:
> 
>  arch/s390/mm/built-in.o(.text+0x152c): In function `query_segment_type':
>  extmem.c: undefined reference to `__your_kmalloc_flags_are_not_valid'
>  arch/s390/mm/built-in.o(.text+0x19ec): In function `segment_load':
>  : undefined reference to `__your_kmalloc_flags_are_not_valid'
> 
> 
>  Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> 
>  --- a/arch/s390/mm/extmem.c	2005-08-06 01:32:56.000000000 +0200
>  +++ b/arch/s390/mm/extmem.c	2005-07-31 17:46:36.000000000 +0200
>  @@ -172,8 +172,8 @@ dcss_diag_translate_rc (int vm_rc) {
>   static int
>   query_segment_type (struct dcss_segment *seg)
>   {
>  -	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA);
>  -	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA);
>  +	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA|GFP_KERNEL);
>  +	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA|GFP_KERNEL);

No, GFP_DMA should work OK.  Except GFP_DMA doesn't have __GFP_VALID set. 
It's strange that this didn't get noticed earlier.

Ben, was there a reason for not giving GFP_DMA the treatment?
