Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVBJHdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVBJHdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVBJHdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:33:41 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:56561 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262036AbVBJHdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:33:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NECv9haYolDibjFJRAt+9/9dA/DhknftkWAMvldCBp8IT8wM46HOvOjZPESYern/mweI+j4q2hcCLLQlMyAyXTvMyB7ELdY1zzNBzMtOWktsiVQcr1nFt+ethfWNl8Sadcnh14iOpYesSwNSY3uXBxU9DYS5LRlqcTZJegnzl4U=
Message-ID: <84144f02050209233314373462@mail.gmail.com>
Date: Thu, 10 Feb 2005 09:33:36 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [PATCH] relayfs redux, part 4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com,
       penberg@cs.helsinki.fi
In-Reply-To: <16906.52160.870346.806462@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16906.52160.870346.806462@tut.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 9 Feb 2005 20:49:36 -0600, Tom Zanussi <zanussi@us.ibm.com> wrote:
> +static inline struct page **alloc_page_array(int size, int *page_count)
> +{
> +       int n_pages;
> +       struct page **page_array;
> +
> +       size = PAGE_ALIGN(size);
> +       n_pages = size >> PAGE_SHIFT;
> +
> +       page_array = kcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
> +       if (!page_array)
> +               return NULL;
> +       *page_count = n_pages;
> +
> +       return page_array;
> +}

[snip]

> +static int populate_page_array(struct page **page_array, int page_count)
> +{
> +       int i;
> +
> +       for (i = 0; i < page_count; i++) {
> +               page_array[i] = alloc_page(GFP_KERNEL);
> +               if (unlikely(!page_array[i])) {
> +                       depopulate_page_array(page_array, i);
> +                       return -ENOMEM;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/**
> + *     relay_alloc_rchan_buf - allocate a channel buffer
> + *     @size: total size of the buffer
> + *     @page_array: receives a pointer to the buffer's page array
> + *     @page_count: receives the number of pages allocated
> + *
> + *     Returns a pointer to the resulting buffer, NULL if unsuccessful
> + */
> +void *relay_alloc_rchan_buf(unsigned long size, struct page ***page_array,
> +                           int *page_count)
> +{
> +       void *mem;
> +
> +       *page_array = alloc_page_array(size, page_count);
> +       if (!*page_array)
> +               return NULL;
> +
> +       if (populate_page_array(*page_array, *page_count)) {
> +               kfree(*page_array);
> +               *page_array = NULL;
> +               return NULL;
> +       }

[snip]

Please consider inlining alloc_page_array() and populate_page_array()
into relay_alloc_rchan_buf() as they're only used once. You'd get rid
of passing page_count as a pointer this way. If inlining is
unacceptable, please at least move the n_pages calculation to
relay_alloc_rchan_buf() to make the API more sane.

I think relay_alloc_rchan_buf also would benefit from goto-styled
error handling.

                                  Pekka
