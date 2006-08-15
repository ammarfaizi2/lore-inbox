Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965313AbWHOJIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbWHOJIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWHOJIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:08:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:20343 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965313AbWHOJIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:08:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nm4+/EKzycdIf0ygbBlAxKMOAjFJmdBFV7jY5ynWFJmdlJcGwL34qJ9z1X/Ykz3kIClycgGaVCC5W5Gvb8v7JtIPsIW/hOKXV/GqhVyklAVoR6J8VF2A0oKMNU6Ib/eSzD6Paki/RtURZM5USH8QMHASJT0I7HtJc9Dl4c4DKI8=
Message-ID: <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
Date: Tue, 15 Aug 2006 11:08:35 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
Cc: linux-kernel@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de
In-Reply-To: <20060815.020004.76775981.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608122248.22639.jesper.juhl@gmail.com>
	 <20060815.020004.76775981.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/06, David Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Sat, 12 Aug 2006 22:48:22 +0200
>
> > There's double-free bug in
> > drivers/isdn/i4l/isdn_net.c::isdn_net_writebuf_skb().
> >
> > If isdn_writebuf_skb_stub() doesn't handle the entire skb, then it will
> > have freed the skb that was passed to it and when the code then jumps
> > to the error label it'll result in a double free of the skb.
> >
> > The easy way to fix this is to insert an assignment of skb = NULL in the
> > 'if' following the call to isdn_writebuf_skb_stub() so that when the code
> > at the error label calls dev_kfree_skb(skb); the skb will be NULL and
> > nothing will happen since dev_kfree_skb() just does a return if passed a
> > NULL.
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>
> I can't ascertain that this is exactly true.
>
> For example, in isdn_writebuf_skb_stub() we have this:
>
>         if (ret > 0) {
>  ...
>                 if (dev->v110[idx]) {
>  ...
>                         if (ret == skb->len)
>                                 dev_kfree_skb(skb);
>

Hmm, perhaps I made a mistake and missed a path. Maybe it would be
better to fix if by making isdn_writebuf_skb_stub() always set the skb
to NULL when it does free it. That would add a few more assignments
but should ensure the right result always.
What do you say?

> So if ret > 0 and we're doing V.110, we only free the skb
> if isdn_v110_encode put a value at *((int *)nskb->data)
> equal to skb->len.
>
> So in the V.110 case it's not purely the ->writebuf_skb() return
> value that gets returned, rather we return that integer that
> isdn_v110_encode() put there.
>
> Therefore I don't think this SKB leak is %100 correct.  What did
> I miss?
>
> BTW, this ISDN code is rotting a bit and could use some cleanups if
> not a rewrite. :-/
>
A rewrite would be beyond me, but I try to clean up bits and pieces...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
