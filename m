Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVEQRYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVEQRYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVEQRYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:24:17 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:35597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261920AbVEQRXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:23:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MLwgXLBF4kLpVbYOXovFhSHO+O3/cPgB/MYbv1Q2S5JHTBAuUcScjUASfWndVwga+5Huf7uB1bKsPBQPaDS7tQU7hwzNnJExFl3BSgP26n6O7fyC42A7+I1emSbmrleoYk+L46d8QEUREyPCZ9Z3W8JMZGchI8ek/1wH3dPyygM=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 4/7] BSD Secure Levels: memory alloc failure check
Date: Tue, 17 May 2005 21:27:43 +0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050517152750.GC2944@halcrow.us>
In-Reply-To: <20050517152750.GC2944@halcrow.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505172127.44147.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 19:27, Michael Halcrow wrote:
> It adds a check for a memory allocation failure
> condition.

And leaks tfm if such failure occurs.

> --- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c
> +++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c

>  static int
>  plaintext_to_sha1(unsigned char *hash, const char *plaintext, int len)
>  {

	tfm = crypto_alloc_tfm("sha1", 0);
	if (tfm == NULL) {
		seclvl_printk(0, KERN_ERR, "Failed to load transform for SHA1\n");
		return -ENOSYS;
>  	}
>  	// Just get a new page; don't play around with page boundaries
>  	// and scatterlists.
> -	pgVirtAddr = (char *)__get_free_page(GFP_KERNEL);
> -	sg[0].page = virt_to_page(pgVirtAddr);
> +	pg_virt_addr = (char *)__get_free_page(GFP_KERNEL);
> +	if (!pg_virt_addr) {
> +		seclvl_printk(0, KERN_ERR "%s: Out of memory\n", __FUNCTION__);
> +		return -ENOMEM;
> +	}
