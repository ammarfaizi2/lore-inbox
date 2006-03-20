Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWCTWea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWCTWea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWCTWea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:34:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751304AbWCTWe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:34:28 -0500
Date: Mon, 20 Mar 2006 14:31:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: cxzhang@watson.ibm.com, netdev@axxeo.de, chrisw@sous-sol.org,
       ioe-lkml@rameria.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-Id: <20060320143103.31b7d933.akpm@osdl.org>
In-Reply-To: <20060320213636.GT15997@sorel.sous-sol.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net>
	<200603132105.32794.ioe-lkml@rameria.de>
	<20060313173103.7681b49d.akpm@osdl.org>
	<200603201244.58507.netdev@axxeo.de>
	<20060320201802.GS15997@sorel.sous-sol.org>
	<20060320213636.GT15997@sorel.sous-sol.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> wrote:
>
> * Chris Wright (chrisw@sous-sol.org) wrote:
> > * Ingo Oeser (netdev@axxeo.de) wrote:
> > > Hi Chris,
> > > 
> > > Andrew Morton wrote:
> > > > Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > > >
> > > > >  -int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> > > > >  -{
> > > > >  -	struct task_struct *p = current;
> > > > >  -	scm->creds = (struct ucred) {
> > > > >  -		.uid = p->uid,
> > > > >  -		.gid = p->gid,
> > > > >  -		.pid = p->tgid
> > > > >  -	};
> > > > >  -	scm->fp = NULL;
> > > > >  -	scm->sid = security_sk_sid(sock->sk, NULL, 0);
> > > > >  -	scm->seq = 0;
> > > > >  -	if (msg->msg_controllen <= 0)
> > > > >  -		return 0;
> > > > >  -	return __scm_send(sock, msg, scm);
> > > > >  -}
> > > > 
> > > > It's worth noting that scm_send() will call security_sk_sid() even if
> > > > (msg->msg_controllen <= 0).
> > > 
> > > Chris, do you know if this is needed in this case?
> > 
> > This whole thing is looking broken.  I'm still trying to find the original
> > patch which caused the series of broken patches on top.
> 
> OK, it starts here from Catherine's patch:
> 
> include/net/scm.h::scm_recv()
> +	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> +		err = security_sid_to_context(scm->sid, &scontext, &scontext_len);
> +		if (!err)
> + 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, scontext_len, scontext);
> + }
> 
> Catherine, the security_sid_to_context() is a raw SELinux function which
> crept into core code and should not have been there.  The fallout fixes
> included conditionally exporting security_sid_to_context, and finally
> scm_send/recv unlining.

Yes.  So we're OK up the uninlining, right?

>  The end result in -mm looks broken to me.
> Specifically, it now does:
> 
> 	ucred->uid = tsk->uid;
> 	ucred->gid = tsk->gid;
> 	ucred->pid = tsk->tgid;
> 	scm->fp = NULL;
> 	scm->seq = 0;
> 	if (msg->msg_controllen <= 0)
> 		return 0;
> 
> 	scm->sid = security_sk_sid(sock->sk, NULL, 0);
> 
> The point of Catherine's original patch was to make sure there's always
> a security identifier associated with AF_UNIX messages.  So receiver
> can always check it (same as having credentials even w/out sender
> control message passing them).  Now we will have garbage for sid.

This answers the question I've been asking all and sundry for a week, thanks ;)

So:

- scm-fold-__scm_send-into-scm_send.patch is OK

- scm_send-speedup.patch is wrong

- Catherine's patch introduces a possibly-significant performance
  problem: we're now calling the expensive-on-SELinux security_sk_sid()
  more frequently than we used to.

- That "initialise scm->creds via a temporary struct" trick still
  generates bad code.


I actually have enough to be going on with here - I'll drop it all.
