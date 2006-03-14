Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWCNBdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWCNBdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCNBdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:33:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWCNBdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:33:36 -0500
Date: Mon, 13 Mar 2006 17:31:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-Id: <20060313173103.7681b49d.akpm@osdl.org>
In-Reply-To: <200603132105.32794.ioe-lkml@rameria.de>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net>
	<20060312.180802.13404061.davem@davemloft.net>
	<200603132105.32794.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
>  -int scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  -{
>  -	struct task_struct *p = current;
>  -	scm->creds = (struct ucred) {
>  -		.uid = p->uid,
>  -		.gid = p->gid,
>  -		.pid = p->tgid
>  -	};
>  -	scm->fp = NULL;
>  -	scm->sid = security_sk_sid(sock->sk, NULL, 0);
>  -	scm->seq = 0;
>  -	if (msg->msg_controllen <= 0)
>  -		return 0;
>  -	return __scm_send(sock, msg, scm);
>  -}

It's worth noting that scm_send() will call security_sk_sid() even if
(msg->msg_controllen <= 0).

If that test is likely to be true with any frequency then perhaps we can
optimise things...
