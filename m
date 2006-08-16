Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWHPUss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWHPUss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHPUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:48:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7636 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWHPUsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:48:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sPcnnG3znEY64J3QhtA9KlfxaYisMbO8UingDUmA15WPqfLGX7WRZ2lmM6RvsjervfCTSRA73dnSwZ15C0+U23vBn2YdE1GliagWhxJs/h29vczRo8QcBV8GC71nNAbf5MIlbjgu00YYSHfiF2hJG2jq8BmUNbu0w3NbIGtPJzI=
Message-ID: <9a8748490608161348m52ed08c2qb06c8923a93b9cd4@mail.gmail.com>
Date: Wed, 16 Aug 2006 22:48:45 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de, "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
In-Reply-To: <20060816203935.GB1040@pingi.kke.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608122248.22639.jesper.juhl@gmail.com>
	 <20060815.020004.76775981.davem@davemloft.net>
	 <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
	 <20060815.021503.71555009.davem@davemloft.net>
	 <20060815160657.GA14266@pingi.kke.suse.de>
	 <9a8748490608161322q64e7d48fmbdf68288db22b64e@mail.gmail.com>
	 <20060816203935.GB1040@pingi.kke.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/06, Karsten Keil <kkeil@suse.de> wrote:
> On Wed, Aug 16, 2006 at 10:22:46PM +0200, Jesper Juhl wrote:
> > On 15/08/06, Karsten Keil <kkeil@suse.de> wrote:
> > >On Tue, Aug 15, 2006 at 02:15:03AM -0700, David Miller wrote:
> > >> From: "Jesper Juhl" <jesper.juhl@gmail.com>
> > >> Date: Tue, 15 Aug 2006 11:08:35 +0200
> > >>
> > >> > Hmm, perhaps I made a mistake and missed a path. Maybe it would be
> > >> > better to fix if by making isdn_writebuf_skb_stub() always set the skb
> > >> > to NULL when it does free it. That would add a few more assignments
> > >> > but should ensure the right result always.
> > >> > What do you say?
> > >>
> > >> Do we know if the ->writebuf_skb() method ever frees the skb?  If it
> > >> never does, then yes your suggestion would be one way to handle this.
> > >
> > >
> > >It does if it consumes the skb (then it returns skb->len).
> > >But the skb have not to be freed imediately in this case, it maybe
> > >queued or used until all bytes are written to the physical device.
> > >
> > >If it returns any other value the skb is not freed.
> > >
> > >This logic came from using skb for transparent data too.
> > >Here it was possible, that the hw driver only take some bytes from the
> > >skb (so it returns < skb->len), then the isdn layer should requeue
> > >the skb so no transparent data get lost.
> > >
> > >But this mechanism was never used in drivers, only 3 states:
> > >
> > >The driver accept the packet then it is responsible for the skb
> > >and return skb->len or the driver do not accept it (e.g. buffer full,
> > >conntection is going down), then it return 0 and does not free the
> > >skb.
> > >
> > >If some internal error in the HW driver occur, it should return a
> > >negative value and it also do not free the skb.
> > >
> >
> > Ok, if I understand you correctly, then there's no actual problem here.
> > right?
> >
>
> I not aware of any problems in this code (besides it should be cleaned up
> and rewritten).
>
> Was here any trigger for your patch ?
>

Well, the trigger for the initial patch was Coverity bug #1060 .
I looked at it and thought it looked valid, so I tried to cook up a
patch for was I believed looked like an actual problem.


Here's what Coverity had to say :

CID: 1060
Checker: USE_AFTER_FREE (help)
File: base/src/linux-2.6/drivers/isdn/i4l/isdn_net.c

...
1006 	void isdn_net_writebuf_skb(isdn_net_local *lp, struct sk_buff *skb)
1007 	{
1008 		int ret;
1009 		int len = skb->len;     /* save len */
1010 	
1011 		/* before obtaining the lock the caller should have checked that
1012 		   the lp isn't busy */
1013 		if (isdn_net_lp_busy(lp)) {
1014 			printk("isdn BUG at %s:%d!\n", __FILE__, __LINE__);
1015 			goto error;
1016 		}
1017 	
1018 		if (!(lp->flags & ISDN_NET_CONNECTED)) {
1019 			printk("isdn BUG at %s:%d!\n", __FILE__, __LINE__);
1020 			goto error;
1021 		}

Event freed_arg: Pointer "skb" freed by function
"isdn_writebuf_skb_stub" [model]
Also see events: [double_free]

1022 		ret = isdn_writebuf_skb_stub(lp->isdn_device, lp->isdn_channel, 1, skb);

At conditional (1): "ret != len" taking true path

1023 		if (ret != len) {
1024 			/* we should never get here */
1025 			printk(KERN_WARNING "%s: HL driver queue full\n", lp->name);
1026 			goto error;
1027 		}
1028 		
1029 		lp->transcount += len;
1030 		isdn_net_inc_frame_cnt(lp);
1031 		return;
1032 	
1033 	 error:

Event double_free: Double free of pointer "skb" in call to "kfree_skb" [model]
Also see events: [freed_arg]

1034 		dev_kfree_skb(skb);
1035 		lp->stats.tx_errors++;
1036 	
1037 	}
...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
