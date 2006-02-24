Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWBXJHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWBXJHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWBXJHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:07:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1165 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750803AbWBXJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:06:58 -0500
Subject: Re: + add-cpia2-camera-support.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, alan@redhat.com, mchehab@infradead.org,
       akpm@osdl.org
In-Reply-To: <200602240049.k1O0nuQn023548@shell0.pdx.osdl.net>
References: <200602240049.k1O0nuQn023548@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 10:06:55 +0100
Message-Id: <1140772015.2874.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +/* Here we want the physical address of the memory.
> + * This is used when initializing the contents of the
> + * area and marking the pages as reserved.
> + */
> +static inline unsigned long kvirt_to_pa(unsigned long adr)
> +{
> +	unsigned long kva, ret;
> +
> +        kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
> +        kva |= adr & (PAGE_SIZE-1); /* restore the offset */
> +	ret = __pa(kva);
> +	return ret;
> +}
> +
> +static void *rvmalloc(unsigned long size)
> +{
> +	void *mem;
> +	unsigned long adr;
> +
> +	/* Round it off to PAGE_SIZE */
> +	size = PAGE_ALIGN(size);
> +
> +	mem = vmalloc_32(size);
> +	if (!mem)
> +		return NULL;
> +
> +	memset(mem, 0, size);	/* Clear the ram out, no junk to the user */
> +	adr = (unsigned long) mem;
> +
> +	while ((long)size > 0) {
> +		SetPageReserved(vmalloc_to_page((void *)adr));
> +		adr += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
> +	return mem;
> +}

you are adding rvmalloc copy number 14; seems you own the task to make
it generic now ;)
Also I thought SetPageReserved and friends are deprecated :)





> +struct camera_data {
> +	/* locks */
> +	struct semaphore busy_lock;	/* guard against SMP multithreading */
> +	struct v4l2_prio_state prio;
> +

please make this use mutexes; adding new semaphores for no reason is not
a good idea...


