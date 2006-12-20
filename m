Return-Path: <linux-kernel-owner+w=401wt.eu-S965000AbWLTLeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWLTLeY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLTLeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:34:24 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:38887 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964991AbWLTLeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:34:23 -0500
Date: Wed, 20 Dec 2006 13:34:15 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix boot time hang in detect_calgary()
Message-ID: <20061220113415.GB30145@rhun.ibm.com>
References: <20061220105332.GA20922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220105332.GA20922@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:53:32AM +0100, Ingo Molnar wrote:

> Index: linux/arch/x86_64/kernel/pci-calgary.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/pci-calgary.c
> +++ linux/arch/x86_64/kernel/pci-calgary.c
> @@ -1052,7 +1052,7 @@ void __init detect_calgary(void)
>  	void *tbl;
>  	int calgary_found = 0;
>  	unsigned long ptr;
> -	int offset;
> +	unsigned int offset, prev_offset;
>  	int ret;
>  
>  	/*
> @@ -1071,15 +1071,20 @@ void __init detect_calgary(void)
>  	ptr = (unsigned long)phys_to_virt(get_bios_ebda());
>  
>  	rio_table_hdr = NULL;
> +	prev_offset = 0;
>  	offset = 0x180;
> -	while (offset) {
> +	/*
> +	 * The next offset is stored in the 1st word.
> +	 * Only parse up until the offset increases:
> +	 */
> +	while (offset > prev_offset) {
>  		/* The block id is stored in the 2nd word */
>  		if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
>  			/* set the pointer past the offset & block id */
>  			rio_table_hdr = (struct rio_table_hdr *)(ptr + offset + 4);
>  			break;
>  		}
> -		/* The next offset is stored in the 1st word. 0 means no more */
> +		prev_offset = offset;
>  		offset = *((unsigned short *)(ptr + offset));
>  	}
>  	if (!rio_table_hdr) {
> -

Patch looks good to me, thanks. I'll give it a spin to verify.

Please CC me on Calgary patches.

Cheers,
Muli
