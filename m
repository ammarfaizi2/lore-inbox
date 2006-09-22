Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWIVInM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWIVInM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWIVInM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:43:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:16902 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751066AbWIVInL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:43:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CQw5oRzamIo2/aglW5IopqLKfOgSmhb3HhdQlL4gIJ/pGcQ0fJRuYnPwLuvtVYi3pSFk9qsZ4HywbAAtgxxFhzghS8zQTD7rHlQQPyRkZzyML03Fw/bcg8AdLK30kfXi5h6k0oT9BbBeop5TvQrrK2fBSp5M+S+V2dletI9vwXI=
Message-ID: <4513A21C.40704@gmail.com>
Date: Fri, 22 Sep 2006 10:43:08 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Om Narasimhan <om.turyx@gmail.com>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>	 <20060921072017.GA27798@us.ibm.com>	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com> <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>
In-Reply-To: <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Om Narasimhan wrote:
> Comments incorporated
> Changes kmalloc() calls succeeded by memset(,0,) to kzalloc()
> 
> Signed off by : Om Narasimhan <om.turyx@gmail.com>
> drivers/block/cciss.c    |    4 +---
> drivers/block/cpqarray.c |    7 ++-----
> drivers/block/loop.c     |    3 +--
> 3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> index 2cd3391..a800a69 100644
> --- a/drivers/block/cciss.c
> +++ b/drivers/block/cciss.c
> @@ -900,7 +900,7 @@ #if 0                /* 'buf_size' member is 16-bits
>                 return -EINVAL;
> #endif
>             if (iocommand.buf_size > 0) {
> -                buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
> +                buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
>                 if (buff == NULL)
>                     return -EFAULT;
>             }
> @@ -911,8 +911,6 @@ #endif
>                     kfree(buff);
>                     return -EFAULT;
>                 }
> -            } else {
> -                memset(buff, 0, iocommand.buf_size);

No.

>             }
>             if ((c = cmd_alloc(host, 0)) == NULL) {
>                 kfree(buff);
> diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
> index 78082ed..34f8e96 100644
> --- a/drivers/block/cpqarray.c
> +++ b/drivers/block/cpqarray.c
> @@ -424,7 +424,7 @@ static int __init cpqarray_register_ctlr
>     hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
>         hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
>         &(hba[i]->cmd_pool_dhandle));
> -    hba[i]->cmd_pool_bits = kmalloc(
> +    hba[i]->cmd_pool_bits = kzalloc(
>         ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
>         GFP_KERNEL);

kcalloc?

> @@ -432,7 +432,6 @@ static int __init cpqarray_register_ctlr
>             goto Enomem1;
> 
>     memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
> -    memset(hba[i]->cmd_pool_bits, 0,
> ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));

What's this? Wrapped? kcalloc?

>     printk(KERN_INFO "cpqarray: Finding drives on %s",
>         hba[i]->devname);
> 
> @@ -523,7 +522,6 @@ static int __init cpqarray_init_one( str
>     i = alloc_cpqarray_hba();
>     if( i < 0 )
>         return (-1);
> -    memset(hba[i], 0, sizeof(ctlr_info_t));
>     sprintf(hba[i]->devname, "ida%d", i);
>     hba[i]->ctlr = i;
>     /* Initialize the pdev driver private data */
> @@ -580,7 +578,7 @@ static int alloc_cpqarray_hba(void)
> 
>     for(i=0; i< MAX_CTLR; i++) {
>         if (hba[i] == NULL) {
> -            hba[i] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
> +            hba[i] = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
>             if(hba[i]==NULL) {
>                 printk(KERN_ERR "cpqarray: out of memory.\n");
>                 return (-1);
> @@ -765,7 +763,6 @@ static int __init cpqarray_eisa_detect(v
>             continue;
>         }
> 
> -        memset(hba[ctlr], 0, sizeof(ctlr_info_t));
>         hba[ctlr]->io_mem_addr = eisa[i];
>         hba[ctlr]->io_mem_length = 0x7FF;
>         if(!request_region(hba[ctlr]->io_mem_addr,
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 7b3b94d..91b48ef 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1260,10 +1260,9 @@ static int __init loop_init(void)
>     if (register_blkdev(LOOP_MAJOR, "loop"))
>         return -EIO;
> 
> -    loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
> +    loop_dev = kzalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);

kcalloc?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
