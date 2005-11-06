Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKFNDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKFNDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKFNDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:03:49 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:42148 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750763AbVKFNDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:03:48 -0500
Message-ID: <436E1086.EE67F433@tv-sign.ru>
Date: Sun, 06 Nov 2005 17:17:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Additional/catchup RCU signal fixes for -mm
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> > If !thread_group_leader() does exec de_thread() calls release_task(->group_leader)
> > before calling exit_itimers(). This means that send_group_sigqueue() which
> > always has p == ->group_leader parameter can oops here.
> 
> But in that case, __exit_sighand(->group_leader) would have been called,
> so ->sighand would be NULL.

Yes, that is why (I think) oops can happen.

> And none of this can change while we are holding
> tasklist_lock.

Yes, but de_thread()->release_task(->group_leader) can take tasklist_lock
before us.

> If we don't want to be hitting the exec()ed task with a signal, the
> thing to do would be to drop the signal, as in the attached patch.
> I believe that this is an acceptable approach, since had the timer
> fired slightly later, it would have been disabled, right?
> 
> Thoughts?
> 
>                                                 Thanx, Paul
> 
> Signed-off-by: <paulmck@us.ibm.com>
> 
> diff -urpNa -X dontdiff linux-2.6.14-mm0-fix-2/kernel/signal.c linux-2.6.14-mm0-fix-3/kernel/signal.c
> --- linux-2.6.14-mm0-fix-2/kernel/signal.c      2005-11-05 15:05:38.000000000 -0800
> +++ linux-2.6.14-mm0-fix-3/kernel/signal.c      2005-11-05 16:27:52.000000000 -0800
> @@ -1481,6 +1481,10 @@ send_group_sigqueue(int sig, struct sigq
>         read_lock(&tasklist_lock);
>         while (p->group_leader != p)
>                 p = p->group_leader;
> +       if (p->sighand == NULL) {
> +               ret = 1;

Oh, I think there is another problem here. I'll post a separate
message.

Oleg.
