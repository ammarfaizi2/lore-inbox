Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVGSAMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGSAMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVGSAMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:12:54 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:51312 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261670AbVGSAMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V0/qDGg4tu0ZV1upUPIv1ui+rgegJckZmcQdoxAP4h4h8o4ofebk4/9/27Nf01KSJB1knKnR7oJfS70d+CVk/U//bbOHizuaMnmEGzx4OMSJonpcKY9RV8Z6csMbbwiSBBns/jQMmOZaeiW7D1NrLDxC9VZbi4wZXH856hSPqe4=
Message-ID: <9a874849050718171262ede630@mail.gmail.com>
Date: Tue, 19 Jul 2005 02:12:09 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] no more need to check for NULL before calls to crypto_free_tfm
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050718153055.GA14719@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507170032.28174.jesper.juhl@gmail.com>
	 <20050718153055.GA14719@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Sun, Jul 17, 2005 at 12:32:27AM +0200, Jesper Juhl wrote:
> >
> > --- linux-2.6.13-rc3-orig/drivers/block/cryptoloop.c  2005-06-17 21:48:29.000000000 +0200
> > +++ linux-2.6.13-rc3/drivers/block/cryptoloop.c       2005-07-16 23:35:55.000000000 +0200
> > @@ -227,14 +227,14 @@ cryptoloop_ioctl(struct loop_device *lo,
> >  static int
> >  cryptoloop_release(struct loop_device *lo)
> >  {
> > -     struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
> > -     if (tfm != NULL) {
> > -             crypto_free_tfm(tfm);
> > -             lo->key_data = NULL;
> > -             return 0;
> > +     struct crypto_tfm *tfm = lo->key_data;
> > +     if (!tfm) {
> > +             printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
> > +             return -EINVAL;
> >       }
> > -     printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
> > -     return -EINVAL;
> > +     crypto_free_tfm(tfm);
> > +     lo->key_data = NULL;
> > +     return 0;
> >  }
> 
> This change looks rather pointless.
> 
Hmm, I guess you're right. Dunno why I reordered that, but you are
right, it's pretty pointless. Except for getting rid of the cast, that
makes sense, it's superfluous so it should go away...

> The rest of the patch looks good.
> 
> Thanks,

You're welcome. Thank you for reviewing it.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
