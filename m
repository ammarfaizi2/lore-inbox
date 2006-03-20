Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWCTXPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWCTXPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWCTXPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:15:45 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42627 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932201AbWCTXPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:15:44 -0500
Date: Mon, 20 Mar 2006 15:15:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, cxzhang@watson.ibm.com,
       netdev@axxeo.de, ioe-lkml@rameria.de, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-ID: <20060320231508.GV15997@sorel.sous-sol.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net> <200603132105.32794.ioe-lkml@rameria.de> <20060313173103.7681b49d.akpm@osdl.org> <200603201244.58507.netdev@axxeo.de> <20060320201802.GS15997@sorel.sous-sol.org> <20060320213636.GT15997@sorel.sous-sol.org> <20060320143103.31b7d933.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320143103.31b7d933.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@sous-sol.org> wrote:
> > Catherine, the security_sid_to_context() is a raw SELinux function which
> > crept into core code and should not have been there.  The fallout fixes
> > included conditionally exporting security_sid_to_context, and finally
> > scm_send/recv unlining.
> 
> Yes.  So we're OK up the uninlining, right?

Yes, although sid_to_context is meant to be analog to the other
get_peersec calls, and should really be made a proper part of the
interface (can be done later, correctness is the issue at hand).

> >  The end result in -mm looks broken to me.
> > Specifically, it now does:
> > 
> > 	ucred->uid = tsk->uid;
> > 	ucred->gid = tsk->gid;
> > 	ucred->pid = tsk->tgid;
> > 	scm->fp = NULL;
> > 	scm->seq = 0;
> > 	if (msg->msg_controllen <= 0)
> > 		return 0;
> > 
> > 	scm->sid = security_sk_sid(sock->sk, NULL, 0);
> > 
> > The point of Catherine's original patch was to make sure there's always
> > a security identifier associated with AF_UNIX messages.  So receiver
> > can always check it (same as having credentials even w/out sender
> > control message passing them).  Now we will have garbage for sid.
> 
> This answers the question I've been asking all and sundry for a week, thanks ;)
> So:
> 
> - scm-fold-__scm_send-into-scm_send.patch is OK

Yes.

> - scm_send-speedup.patch is wrong

Yes.

> - Catherine's patch introduces a possibly-significant performance
>   problem: we're now calling the expensive-on-SELinux security_sk_sid()
>   more frequently than we used to.

I don't expect security_sk_sid() to be terribly expensive.  It's not
an AVC check, it's just propagating a label.  But I've not done any
benchmarking on that.

thanks,
-chris
