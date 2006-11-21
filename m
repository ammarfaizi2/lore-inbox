Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030964AbWKUNhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030964AbWKUNhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030969AbWKUNhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 08:37:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:52385 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030964AbWKUNhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 08:37:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o+JIICNl+sdjmphzoGdg1qc/+P1yn6v5np38wo+E4ATzEpq8JW0CGayMESw5B8xU59vwssyJeTtJ64OJ29JXBcSPtbsj6+fi5nwF0qczs3CNStChoigKrFQjbVcS0sPpfNS70WjGAsTqZRUbM5etxe1xiZKV/N2xafsYoYIpoUw=
Message-ID: <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com>
Date: Tue, 21 Nov 2006 14:37:34 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
Cc: "Michael Hipp" <Michael.Hipp@student.uni-tuebingen.de>,
       "Karsten Keil" <kkeil@suse.de>,
       "Kai Germaschewski" <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de,
       "Jesper Juhl" <jesper.juhl@gmail.com>, starvik@axis.com,
       dev-etrax@axis.com, "David Rientjes" <rientjes@cs.washington.edu>
In-Reply-To: <200610302117.24760.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610302117.24760.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason why we can't apply the patch below?

On 30/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> There's a potential problem in isdn_ppp.c::isdn_ppp_decompress().
> dev_alloc_skb() may fail and return NULL. If it does we will be passing a
> NULL skb_out to ipc->decompress() and may also end up
> dereferencing a NULL pointer at
>     *proto = isdn_ppp_strip_proto(skb_out);
> Correct this by testing 'skb_out' against NULL early and bail out.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  drivers/isdn/i4l/isdn_ppp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
> index 119412d..5a97ce6 100644
> --- a/drivers/isdn/i4l/isdn_ppp.c
> +++ b/drivers/isdn/i4l/isdn_ppp.c
> @@ -2536,6 +2536,11 @@ static struct sk_buff *isdn_ppp_decompre
>                 rsparm.maxdlen = IPPP_RESET_MAXDATABYTES;
>
>                 skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
> +               if (!skb_out) {
> +                       kfree_skb(skb);
> +                       printk(KERN_ERR "ippp: decomp memory allocation failure\n");
> +                       return NULL;
> +               }
>                 len = ipc->decompress(stat, skb, skb_out, &rsparm);
>                 kfree_skb(skb);
>                 if (len <= 0) {
>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
