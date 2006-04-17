Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDQMG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDQMG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDQMG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:06:58 -0400
Received: from uproxy.gmail.com ([66.249.92.168]:57646 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbWDQMG5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:06:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FuiHt+8HAlPiizA2bw2yv8j1MiKuU1j9KTUY4DfV5WSas6+HVNtLoS2Cmgyup/VYOXP01+TnjiBAZVepNk3safzQ2YGRj1PK/j2WCFZ06286mC3E/CoU1kFGq5/2hRiioS/Lm2bHNMPirxikRW2SMy6HErqbHVMaIGJYGVp4tB0=
Message-ID: <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
Date: Mon, 17 Apr 2006 07:06:54 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> This patch removes the use of repeated calls to kmalloc / kfree when
> writing / reading from a MTD char device. Not the ideal solution
> mentioned in the driver, but nonetheless better.

NAK.  This patch introduces a bug.  See below.

>
> Index: linux-2.6.16.2/drivers/mtd/mtdchar.c
> ===================================================================
> --- linux-2.6.16.2.orig/drivers/mtd/mtdchar.c
> +++ linux-2.6.16.2/drivers/mtd/mtdchar.c
> @@ -170,15 +170,18 @@ static ssize_t mtd_read(struct file *fil
>
>         /* FIXME: Use kiovec in 2.5 to lock down the user's buffers
>            and pass them directly to the MTD functions */
> -       while (count) {
> -               if (count > MAX_KMALLOC_SIZE)
> -                       len = MAX_KMALLOC_SIZE;
> -               else
> -                       len = count;
>
> -               kbuf=kmalloc(len,GFP_KERNEL);
> -               if (!kbuf)
> -                       return -ENOMEM;
> +       if (count > MAX_KMALLOC_SIZE)
> +               len = MAX_KMALLOC_SIZE;
> +       else
> +               len = count;

Now that len is set outside of the loop, it is always the same size. 
If count is large enough to require more than a single read, the the
original size will still be used and it could overflow the user's
buffer.

I agree that doing the kmallocs in a loop looks nasty.  But we need to
make sure moving out of the loop doesn't break things.

josh
