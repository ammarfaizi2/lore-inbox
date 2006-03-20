Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWCTVhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWCTVhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWCTVhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:37:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47233 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964971AbWCTVhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:37:07 -0500
Date: Mon, 20 Mar 2006 13:36:36 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Catherine Zhang <cxzhang@watson.ibm.com>
Cc: Ingo Oeser <netdev@axxeo.de>, Chris Wright <chrisw@sous-sol.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-ID: <20060320213636.GT15997@sorel.sous-sol.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net> <200603132105.32794.ioe-lkml@rameria.de> <20060313173103.7681b49d.akpm@osdl.org> <200603201244.58507.netdev@axxeo.de> <20060320201802.GS15997@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320201802.GS15997@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> * Ingo Oeser (netdev@axxeo.de) wrote:
> > Hi Chris,
> > 
> > Andrew Morton wrote:
> > > Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > >
> > > >  -int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> > > >  -{
> > > >  -	struct task_struct *p = current;
> > > >  -	scm->creds = (struct ucred) {
> > > >  -		.uid = p->uid,
> > > >  -		.gid = p->gid,
> > > >  -		.pid = p->tgid
> > > >  -	};
> > > >  -	scm->fp = NULL;
> > > >  -	scm->sid = security_sk_sid(sock->sk, NULL, 0);
> > > >  -	scm->seq = 0;
> > > >  -	if (msg->msg_controllen <= 0)
> > > >  -		return 0;
> > > >  -	return __scm_send(sock, msg, scm);
> > > >  -}
> > > 
> > > It's worth noting that scm_send() will call security_sk_sid() even if
> > > (msg->msg_controllen <= 0).
> > 
> > Chris, do you know if this is needed in this case?
> 
> This whole thing is looking broken.  I'm still trying to find the original
> patch which caused the series of broken patches on top.

OK, it starts here from Catherine's patch:

include/net/scm.h::scm_recv()
+	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
+		err = security_sid_to_context(scm->sid, &scontext, &scontext_len);
+		if (!err)
+ 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, scontext_len, scontext);
+ }

Catherine, the security_sid_to_context() is a raw SELinux function which
crept into core code and should not have been there.  The fallout fixes
included conditionally exporting security_sid_to_context, and finally
scm_send/recv unlining.  The end result in -mm looks broken to me.
Specifically, it now does:

	ucred->uid = tsk->uid;
	ucred->gid = tsk->gid;
	ucred->pid = tsk->tgid;
	scm->fp = NULL;
	scm->seq = 0;
	if (msg->msg_controllen <= 0)
		return 0;

	scm->sid = security_sk_sid(sock->sk, NULL, 0);

The point of Catherine's original patch was to make sure there's always
a security identifier associated with AF_UNIX messages.  So receiver
can always check it (same as having credentials even w/out sender
control message passing them).  Now we will have garbage for sid.

thanks,
-chris
