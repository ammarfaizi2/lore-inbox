Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVCLKtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVCLKtS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCLKtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:49:17 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:23448 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261408AbVCLKtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:49:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=heIMWnd8jpkeCVvBA9ZMRl7FMEbPS645iaAD8sdgFHv1P5fXy04gTnOSrki3CIldHz8czMYLVGyojOF7PHGSj1jdkIBHAlt9nTMkRHMgnsGR3fZV2hApU+35or3J/DP7IL425TB2mRa9O8Upbid2RUCI9rR12h4mUV5SC7m6YUA=
Message-ID: <c0a09e5c0503120249598c57a0@mail.gmail.com>
Date: Sat, 12 Mar 2005 02:49:10 -0800
From: Andrew Grover <andy.grover@gmail.com>
Reply-To: Andrew Grover <andy.grover@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 14:37:17 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:

> +       npages = get_user_pages(current,
> +                               current->mm,
> +                               (unsigned long)m.virtaddr,
> +                               maxpages,
> +                               write,
> +                               0,
> +                               imp->pages,
> +                               NULL);

Can't comment on usermode drivers overall, so just some code comments.

do you need a down_read(current->mm->mmap_sem) here? I'm not sure but
that seems to be what most other users of this function are doing.

> +       /*
> +        * Build scatterlist, one entry per page.
> +        * Allow for partial pages at start and end.
> +        */
> +       i = 1;
> +       imp->sg[0].page = imp->pages[0];
> +       imp->sg[0].offset = ((unsigned long)m.virtaddr) & (PAGE_SIZE - 1);
> +       imp->sg[0].length = PAGE_SIZE - imp->sg[0].offset;
> +       if (imp->sg[0].length >= m.size) {
> +               imp->sg[0].length = m.size;
> +       } else {
> +               unsigned long len = m.size - imp->sg[0].length;
> +               for (;len >= PAGE_SIZE && i < npages ; i++) {
> +                       imp->sg[i].page = imp->pages[i];
> +                       imp->sg[i].offset = 0;
> +                       imp->sg[i].length = PAGE_SIZE;
> +                       len -= PAGE_SIZE;
> +               }
> +               if (len) {
> +                       BUG_ON(i >= npages);
> +                       BUG_ON(len >= PAGE_SIZE);
> +                       imp->sg[i].page = imp->pages[i];
> +                       imp->sg[i].offset = 0;
> +                       imp->sg[i].length = len;
> +                       i++;
> +               }
> +       }

size_t len = m.size;
int offset = (unsigned long) m.virtaddr & ~PAGE_MASK;
for (i = 0; i < npages; i++)
{
  imp->sg[i].page = imp->pages[i];
  imp->sg[i].offset = offset;
  imp->sg[i].length = min(len, PAGE_SIZE - offset);

  offset = 0;
  len -= imp->sg[i].length;
}

instead possibly?

Regards -- Andy
