Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVCKJgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVCKJgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVCKJgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:36:23 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62937 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262647AbVCKJgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:36:15 -0500
Date: Fri, 11 Mar 2005 10:36:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@gw.timesys.com>
Cc: linux-kernel@vger.kernel.org, manas.saksena@timesys.com
Subject: Re: [PATCH] realtime-preempt: update inherited priorities on setscheduler
Message-ID: <20050311093607.GB19954@elte.hu>
References: <20050310212116.GA2420@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310212116.GA2420@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@gw.timesys.com> wrote:

> -	p->prio = effective_prio(p);
> +	/* Don't overwrite an inherited RT priority with the static
> +	   RT priority. */
> +
> +	if (!rt_task(p))
> +		p->prio = effective_prio(p);

are you sure this is needed? The -RT code currently does this:

 static int effective_prio(task_t *p)
 {
         if (rt_task(p))
                 return p->prio;
         return __effective_prio(p);
 }

i.e. if it's an RT task then 'effective priority' is whatever it has
right now. I.e. 'p->prio = effective_prio(p)' will have no effect for RT
tasks. PI would not be working at all if we were overwriting the
inherited priority.

	Ingo
