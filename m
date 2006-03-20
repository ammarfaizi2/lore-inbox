Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWCTLpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWCTLpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWCTLpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:45:09 -0500
Received: from mail.axxeo.de ([82.100.226.146]:34688 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1750785AbWCTLpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:45:07 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Date: Mon, 20 Mar 2006 12:44:58 +0100
User-Agent: KMail/1.7.2
Cc: Ingo Oeser <ioe-lkml@rameria.de>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net> <200603132105.32794.ioe-lkml@rameria.de> <20060313173103.7681b49d.akpm@osdl.org>
In-Reply-To: <20060313173103.7681b49d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603201244.58507.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Andrew Morton wrote:
> Ingo Oeser <ioe-lkml@rameria.de> wrote:
> >
> >  -int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> >  -{
> >  -	struct task_struct *p = current;
> >  -	scm->creds = (struct ucred) {
> >  -		.uid = p->uid,
> >  -		.gid = p->gid,
> >  -		.pid = p->tgid
> >  -	};
> >  -	scm->fp = NULL;
> >  -	scm->sid = security_sk_sid(sock->sk, NULL, 0);
> >  -	scm->seq = 0;
> >  -	if (msg->msg_controllen <= 0)
> >  -		return 0;
> >  -	return __scm_send(sock, msg, scm);
> >  -}
> 
> It's worth noting that scm_send() will call security_sk_sid() even if
> (msg->msg_controllen <= 0).

Chris, do you know if this is needed in this case?

> If that test is likely to be true with any frequency then perhaps we can
> optimise things...

That test seems to be the original intention for the splitup. 

The security modules just put their hooks here. Maybe we can
fold these hooks into __scm_send() and have the old
splitup again to get the old code paths back.

It seems that the credential copy in af_unix.c 

memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
if (siocb->scm->fp)
            unix_attach_fds(siocb->scm, skb);

doesn't depend on the "msg_controllen <= 0" test. If we can introduce this 
dependency there, we can put credential setup into __scm_send().

I would suggest we fold these two lines into a function and decide this later.

Chris, would this suffice?

Regards

Ingo Oeser

BTW: ioe-lkml@rameria.de is simply netdev@axxeo.de at work :-)
