Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUF0QM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUF0QM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUF0QM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:12:27 -0400
Received: from smtprelay04.ispgateway.de ([62.67.200.165]:12968 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S263709AbUF0QMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:12:21 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __alloc_bootmem_node should not panic when it fails
Date: Sun, 27 Jun 2004 08:27:26 +0200
User-Agent: KMail/1.6.2
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, rusty@rustcorp.com.au
References: <20040627052747.GG23589@krispykreme>
In-Reply-To: <20040627052747.GG23589@krispykreme>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406270827.28310.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 27 June 2004 07:27, Anton Blanchard wrote:
> The following patch does that. We fall back to the regular
> __alloc_bootmem when __alloc_bootmem_node fails, which means all other
> nodes are checked for available memory.
 
But allocating from other nodes has performance implications, which
might be quite big, depending on the specific architecture. So you
should at least print an KERN_INFO or even KERN_WARNING message, 
if this happens.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> diff -puN mm/bootmem.c~debugit mm/bootmem.c
> --- gr_work/mm/bootmem.c~debugit	2004-06-06 21:49:20.729826223 -0500
> +++ gr_work-anton/mm/bootmem.c	2004-06-06 22:07:16.840243987 -0500
> @@ -371,11 +371,6 @@ void * __init __alloc_bootmem_node (pg_d
>  	if (ptr)
>  		return (ptr);
>  
> -	/*
> -	 * Whoops, we cannot satisfy the allocation request.
> -	 */
> -	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
Maybe changing this message to:
	printk(KERN_WARNING "Failed to alloc %lu bytes from local node.\n"
	" Allocating from distant node instead. Performance may drop!\n", size);

> -	panic("Out of memory");
> -	return NULL;
> +	return __alloc_bootmem(size, align, goal);
>  }

So now the user knows what is going on and that this node might need
more memory ;-)

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3mjOU56oYWuOrkARAuQGAJ9lasSDYLgMDzAGnGYxnH4OpSHXNQCg0uy3
12GFsxYaaptUIZkYHYUw9Is=
=1ydw
-----END PGP SIGNATURE-----
