Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423529AbWJ0EiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423529AbWJ0EiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 00:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423485AbWJ0EiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 00:38:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423542AbWJ0EiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 00:38:08 -0400
Date: Thu, 26 Oct 2006 21:37:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/5] binfmt: fix uaccess handling
Message-Id: <20061026213741.06f7ecb4.akpm@osdl.org>
In-Reply-To: <20061026130146.GB7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
	<20061026130146.GB7127@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006 15:01:46 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> @@ -254,7 +255,8 @@
>  	p = current->mm->arg_end = current->mm->arg_start;
>  	while (argc-- > 0) {
>  		size_t len;
> -		__put_user((elf_addr_t)p, argv++);
> +		if (__put_user((elf_addr_t)p, argv++))
> +			return -EFAULT;
>  		len = strnlen_user((void __user *)p, PAGE_SIZE*MAX_ARG_PAGES);
>  		if (!len || len > PAGE_SIZE*MAX_ARG_PAGES)
>  			return 0;

We return EFAULT, but if strnlen_user() gets a fault, we return zero.  But
then, the return value of create_elf_tables() gets cheerfully ignored
anyway.  So I assume we start up some new program with a
partially-constructed environment and it then mysteriously malfunctions.

Nice, eh?
