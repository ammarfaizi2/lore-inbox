Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161340AbWKUWx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161340AbWKUWx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031341AbWKUWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:53:54 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:47805 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1031291AbWKUWxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:53:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sXYSAA9tx954JMUAEpNc3luMUAGjmQhr8vLsAxLABgX7PIazTVSzLBnNBJOf9OOLFzYB8ZVHONG6xx1DT6tXfiv6cbMFhs/2n4W9XexZd4jphtD/b6h3oFYUWZy/BNPgVUxW/Reuqq65u+kyK63Jo3NZ+c6jXTU4HGKoxTgyFkY=
Message-ID: <9a8748490611211453m33828363y143cdb8758440f00@mail.gmail.com>
Date: Tue, 21 Nov 2006 23:53:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Rientjes" <rientjes@cs.washington.edu>
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
Cc: linux-kernel@vger.kernel.org,
       "Michael Hipp" <Michael.Hipp@student.uni-tuebingen.de>,
       "Karsten Keil" <kkeil@suse.de>,
       "Kai Germaschewski" <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, starvik@axis.com, dev-etrax@axis.com
In-Reply-To: <Pine.LNX.4.64N.0611211438340.3549@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610302117.24760.jesper.juhl@gmail.com>
	 <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com>
	 <Pine.LNX.4.64N.0611211211280.25455@attu4.cs.washington.edu>
	 <9a8748490611211421p696eb081j5691030f86f6bffe@mail.gmail.com>
	 <Pine.LNX.4.64N.0611211438340.3549@attu4.cs.washington.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/06, David Rientjes <rientjes@cs.washington.edu> wrote:
> On Tue, 21 Nov 2006, Jesper Juhl wrote:
>
> > Ok, I see your point. There may not be an actual bug here, but
> > couldn't it still be considered an improvement, given that with my
> > patch we'll  a) print a warning that we ran into a memory shortage
> > problem, and  b) we save a call to ipc->decompress() and some switch
> > logic in the failing case.   ???
> >
>
> No, because there is duplication of code.  This error condition is already
> addressed:
>
>         skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
>         len = ipc->decompress(stat, skb, skb_out, &rsparm);
>         kfree_skb(skb);
>         if (len <= 0) {
>                 switch (len) {
>                 case DECOMP_ERROR:
>                         ...
>                         break;
>                 case DECOMP_FATALERROR:
>                         ...
>                         break;
>                 }
>                 kfree_skb(skb_out);
>                 return NULL;
>         }
>
> Since neither DECOMP_ERROR or DECOMP_FATALERROR represent a NULL return
> from ipc->decompress(), the switch clause is a no-op and skb_out is freed
> and NULL is returned.
>
> The only thing your patch addresses is moving this before the
> ipc->decompress() call and _duplicating_ both the skb free and the return
> code, as well as adding a warning.  The warning is unnecessary because OOM
> killer will be called soon anyway if this condition is ever reached so the
> fact that it was this allocation that could not be satisfied doesn't
> matter.  Likewise, we need the return code from ipc->decompress() to do
> the other error checking involved.
>

You are right. I concede your point.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
