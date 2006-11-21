Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031386AbWKUUU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031386AbWKUUU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031385AbWKUUU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:20:56 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:53463 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1031386AbWKUUUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:20:55 -0500
Date: Tue, 21 Nov 2006 12:20:30 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org,
       Michael Hipp <Michael.Hipp@student.uni-tuebingen.de>,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, starvik@axis.com, dev-etrax@axis.com
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
In-Reply-To: <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0611211211280.25455@attu4.cs.washington.edu>
References: <200610302117.24760.jesper.juhl@gmail.com>
 <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Jesper Juhl wrote:

> Any reason why we can't apply the patch below?
> 
> On 30/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > There's a potential problem in isdn_ppp.c::isdn_ppp_decompress().
> > dev_alloc_skb() may fail and return NULL. If it does we will be passing a
> > NULL skb_out to ipc->decompress() and may also end up
> > dereferencing a NULL pointer at
> >     *proto = isdn_ppp_strip_proto(skb_out);
> > Correct this by testing 'skb_out' against NULL early and bail out.
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> >  drivers/isdn/i4l/isdn_ppp.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
> > index 119412d..5a97ce6 100644
> > --- a/drivers/isdn/i4l/isdn_ppp.c
> > +++ b/drivers/isdn/i4l/isdn_ppp.c
> > @@ -2536,6 +2536,11 @@ static struct sk_buff *isdn_ppp_decompre
> >                 rsparm.maxdlen = IPPP_RESET_MAXDATABYTES;
> >
> >                 skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
> > +               if (!skb_out) {
> > +                       kfree_skb(skb);
> > +                       printk(KERN_ERR "ippp: decomp memory allocation
> > failure\n");
> > +                       return NULL;
> > +               }
> >                 len = ipc->decompress(stat, skb, skb_out, &rsparm);
> >                 kfree_skb(skb);
> >                 if (len <= 0) {
> >
> 

I'm not sure that there's a problem with the original code.  If skb_out 
cannot be allocated, the ipc->decompress function should return NULL 
because struct ippp_struct *master would have been passed as NULL.  So len 
would be 0 upon return, skb would be freed, and the following switch 
statement would catch the error.  Notice it's not a bug to pass NULL to 
kfree_skb() later.

		David
