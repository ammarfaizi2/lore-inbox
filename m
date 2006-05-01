Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWEAOfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWEAOfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWEAOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:35:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:4548 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932120AbWEAOfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:35:43 -0400
Date: Mon, 1 May 2006 10:35:12 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd (i386)
Message-ID: <20060501143512.GA7129@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501095041.16897.49541.sendpatchset@cherry.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 06:49:16PM +0900, Magnus Damm wrote:
> kexec: Avoid overwriting the current pgd (i386)
> 
> This patch upgrades the i386-specific kexec code to avoid overwriting the
> current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> to start a secondary kernel that dumps the memory of the previous kernel.
> 
> The code introduces a new set of page tables called "page_table_a". These
> tables are used to provide an executable identity mapping without overwriting
> the current pgd.

True, current pgd is overwritten but that effects only user space mappings
and currently "crash" supports only backtracing kernel space code. But at
the same time probably it is not a bad idea to maintain a separate page
table and switch to that instead of overwriting the existing pgd. This
shall help if in future user space backtracing is also supported.
  
[..]
>  
> +static int allocate_page_table_a(struct kimage *image)
> +{
> +	struct page *page;
> +	int k = sizeof(image->page_table_a) / sizeof(image->page_table_a[0]);
> +
> +	for (; k > 0; k--) {
> +		page = kimage_alloc_control_pages(image, 0);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		clear_page(page_address(page));
> +		image->page_table_a[k - 1] = page;

I think you also need to write the logic to free those pages if somebody
chooses to unload the pre-loaded kernel.

[..]
> --- 0001/include/linux/kexec.h
> +++ work/include/linux/kexec.h	2006-05-01 11:13:14.000000000 +0900
> @@ -69,6 +69,17 @@ struct kimage {
>  	unsigned long start;
>  	struct page *control_code_page;
>  
> +	/* page_table_a[] holds enough pages to create a new page table
> +	 * that maps the control page twice..
> +	 */
> +
> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
> +	struct page *page_table_a[3]; /* (2 * pte) + pgd */
> +#endif
> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
> +	struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
> +#endif
> +

Would it make a cleaner interface if these array of pointers are maintained
in arch dependent code as global variables instead of putting in arch
independent code. Existing code does something simlar. This becomes further
ugly when another array comes into the picture for x86_64 in next patch.
(page_table_b)

Thanks
Vivek
