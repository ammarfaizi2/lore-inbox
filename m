Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVHLIkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVHLIkq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVHLIkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:40:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:45250 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750792AbVHLIkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:40:45 -0400
Message-ID: <42FC6305.E7A00C0A@tv-sign.ru>
Date: Fri, 12 Aug 2005 12:51:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> --- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
> +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-11 12:26:45.000000000 -0700
> [ ... snip ... ]
> @@ -785,11 +787,13 @@ no_thread_group:
>  		recalc_sigpending();
> 
> +		oldsighand->deleted = 1;
> +		oldsighand->successor = newsighand;

I don't think this is correct.

This ->oldsighand can be shared with another CLONE_SIGHAND
process and will not be deleted, just unshared.

When the signal is sent to that process we must use ->oldsighand
for locking, not the oldsighand->successor == newsighand.

Oleg.
