Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWGZWtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWGZWtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWGZWtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:49:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47784
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751811AbWGZWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:49:11 -0400
Date: Wed, 26 Jul 2006 15:49:17 -0700 (PDT)
Message-Id: <20060726.154917.124068980.davem@davemloft.net>
To: sds@tycho.nsa.gov
Cc: cxzhang@watson.ibm.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jmorris@namei.org, catalin.marinas@gmail.com,
       michal.k.k.piotrowski@gmail.com, czhang.us@gmail.com
Subject: Re: RFC: kernel memory leak fix for af_unix datagram getpeersec
From: David Miller <davem@davemloft.net>
In-Reply-To: <1153947040.11769.208.camel@moss-spartans.epoch.ncsc.mil>
References: <20060726201916.GA32505@jiayuguan.watson.ibm.com>
	<1153947040.11769.208.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 26 Jul 2006 16:50:40 -0400

> > diff -puN net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix net/unix/af_unix.c
> > --- linux-2.6.18-rc2/net/unix/af_unix.c~af_unix-datagram-getpeersec-ml-fix	2006-07-22 23:01:26.000000000 -0400
> > +++ linux-2.6.18-rc2-cxzhang/net/unix/af_unix.c	2006-07-22 23:14:15.000000000 -0400
> > @@ -1323,8 +1299,9 @@ static int unix_dgram_sendmsg(struct kio
> >  	memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
> >  	if (siocb->scm->fp)
> >  		unix_attach_fds(siocb->scm, skb);
> > -
> > -	unix_get_peersec_dgram(skb);
> > +#ifdef CONFIG_SECURITY_NETWORK
> > +	memcpy(UNIXSID(skb), &siocb->scm->sid, sizeof(u32));
> > +#endif /* CONFIG_SECURITY_NETWORK */
> 
> You want to retain the static inlines, and just update their contents,
> not replace them with embedded #ifdefs.  And this could be a direct
> assignment, right?

This is my feeling too.
