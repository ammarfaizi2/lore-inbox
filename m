Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756462AbWKUWVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbWKUWVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756706AbWKUWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:21:34 -0500
Received: from nz-out-0102.google.com ([64.233.162.195]:48321 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756462AbWKUWVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:21:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bmK0fEwmcUF4f8iKZBSFOj0IMtnlwdCO52ZLb8Zlo+ZccT1XvfHJzocM57m1b/jmEFVIOzvRY0VnX099uUcFwNMQdrsBfv9vzQQdvaDKmAPPWigs7QaozFMAaFM6g/tNo8wG2LQf+nr/oSdXodYsWnom6eQBFkw1t9IOr5jpMiI=
Message-ID: <9a8748490611211421p696eb081j5691030f86f6bffe@mail.gmail.com>
Date: Tue, 21 Nov 2006 23:21:32 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Rientjes" <rientjes@cs.washington.edu>
Subject: Re: [PATCH] ISDN: Avoid a potential NULL ptr deref in ippp
Cc: linux-kernel@vger.kernel.org,
       "Michael Hipp" <Michael.Hipp@student.uni-tuebingen.de>,
       "Karsten Keil" <kkeil@suse.de>,
       "Kai Germaschewski" <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, starvik@axis.com, dev-etrax@axis.com
In-Reply-To: <Pine.LNX.4.64N.0611211211280.25455@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610302117.24760.jesper.juhl@gmail.com>
	 <9a8748490611210537q1f493d11w700099da3243ef39@mail.gmail.com>
	 <Pine.LNX.4.64N.0611211211280.25455@attu4.cs.washington.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/06, David Rientjes <rientjes@cs.washington.edu> wrote:
> On Tue, 21 Nov 2006, Jesper Juhl wrote:
>
> > Any reason why we can't apply the patch below?
> >
> > On 30/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > >
> > > There's a potential problem in isdn_ppp.c::isdn_ppp_decompress().
> > > dev_alloc_skb() may fail and return NULL. If it does we will be passing a
> > > NULL skb_out to ipc->decompress() and may also end up
> > > dereferencing a NULL pointer at
> > >     *proto = isdn_ppp_strip_proto(skb_out);
> > > Correct this by testing 'skb_out' against NULL early and bail out.
> > >
> > >
> > > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > > ---
> > >
> > >  drivers/isdn/i4l/isdn_ppp.c |    5 +++++
> > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
> > > index 119412d..5a97ce6 100644
> > > --- a/drivers/isdn/i4l/isdn_ppp.c
> > > +++ b/drivers/isdn/i4l/isdn_ppp.c
> > > @@ -2536,6 +2536,11 @@ static struct sk_buff *isdn_ppp_decompre
> > >                 rsparm.maxdlen = IPPP_RESET_MAXDATABYTES;
> > >
> > >                 skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
> > > +               if (!skb_out) {
> > > +                       kfree_skb(skb);
> > > +                       printk(KERN_ERR "ippp: decomp memory allocation
> > > failure\n");
> > > +                       return NULL;
> > > +               }
> > >                 len = ipc->decompress(stat, skb, skb_out, &rsparm);
> > >                 kfree_skb(skb);
> > >                 if (len <= 0) {
> > >
> >
>
> I'm not sure that there's a problem with the original code.  If skb_out
> cannot be allocated, the ipc->decompress function should return NULL
> because struct ippp_struct *master would have been passed as NULL.  So len
> would be 0 upon return, skb would be freed, and the following switch
> statement would catch the error.  Notice it's not a bug to pass NULL to
> kfree_skb() later.
>
Ok, I see your point. There may not be an actual bug here, but
couldn't it still be considered an improvement, given that with my
patch we'll  a) print a warning that we ran into a memory shortage
problem, and  b) we save a call to ipc->decompress() and some switch
logic in the failing case.   ???

I still think the patch makes sense. Perhaps not for the reasons
initially stated, but it adds an error message for a condition that
people may want to see and it errors out a bit earlier in the error
case.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
