Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932865AbWFXGPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWFXGPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 02:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbWFXGPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 02:15:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932865AbWFXGPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 02:15:42 -0400
Date: Fri, 23 Jun 2006 23:15:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [patch] s390: setup.c cleanup + build fix
Message-Id: <20060623231535.b368fbda.akpm@osdl.org>
In-Reply-To: <20060623133122.GJ9446@osiris.boeblingen.de.ibm.com>
References: <20060623133122.GJ9446@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 15:31:22 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Cleanup & fix 31 bit compilation:
> 
>   CC      arch/s390/kernel/setup.o
> arch/s390/kernel/setup.c:83: error: initializer element is not computable at
>                                     load time
> arch/s390/kernel/setup.c:83: error: (near initialization for
>                                     'code_resource.start')
> Not sure which patch in the -mm tree breaks this, but since this can be
> considered a cleanup it can be merged anyway.
> 

That's strange.

>  /*
> - * Setup options
> - */
> -extern int _text,_etext, _edata, _end;
> -
> -/*
>   * This is set up by the setup-routine at boot-time
>   * for S390 need to find out, what we have to setup
>   * using address 0x10400 ...
> @@ -80,15 +76,11 @@ extern int _text,_etext, _edata, _end;
>  
>  static struct resource code_resource = {
>  	.name  = "Kernel code",
> -	.start = (unsigned long) &_text,
> -	.end = (unsigned long) &_etext - 1,
>  	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
>  };
>  
>  static struct resource data_resource = {
>  	.name = "Kernel data",
> -	.start = (unsigned long) &_etext,
> -	.end = (unsigned long) &_edata - 1,
>  	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
>  };
>  
> @@ -422,6 +414,11 @@ setup_resources(void)
>  	struct resource *res;
>  	int i;
>  
> +	code_resource.start = (unsigned long) &_text;
> +	code_resource.end = (unsigned long) &_etext - 1;
> +	data_resource.start = (unsigned long) &_etext;
> +	data_resource.end = (unsigned long) &_edata - 1;
> +
>  	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
>  		res = alloc_bootmem_low(sizeof(struct resource));
>  		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;

The linker should be able to handle all that.  I wonder why it didn't.

And it works for me.  What is "31 bit compilation"?
