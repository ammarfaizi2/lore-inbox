Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265407AbUFDBbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265407AbUFDBbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUFDBbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:31:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:44417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265407AbUFDBbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:31:32 -0400
Date: Thu, 3 Jun 2004 18:30:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Fix signal race during process exit
Message-Id: <20040603183044.40e4a95c.akpm@osdl.org>
In-Reply-To: <200406040121.i541LGAI012332@magilla.sf.frob.com>
References: <200406040121.i541LGAI012332@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> Is there a reproducer case around so we can test fixes for this problem?

Jeremy would have the details.

> It seems to me that signals sent to an already dying task might as well
> just be discarded anyway.  All they ever do now (except for trip bugs) is
> change what pending signals you see in the /proc/pid/status entry for a
> zombie.  What's wrong with this:
> 
> Index: linux-2.6/kernel/signal.c
> ===================================================================
> RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/signal.c,v
> retrieving revision 1.120
> diff -u -b -p -r1.120 signal.c
> --- linux-2.6/kernel/signal.c 10 May 2004 20:28:20 -0000 1.120
> +++ linux-2.6/kernel/signal.c 4 Jun 2004 01:16:31 -0000
> @@ -161,6 +161,9 @@ static int sig_ignored(struct task_struc
>  {
>  	void * handler;
>  
> +	if (t->flags & PF_DEAD)
> +		return 1;
> +

I'm not sure about the locking here.  What happens if the task starts
exitting immediately after the above test?

Plus the above adds code to the delivery fastpath, rather than exit().

If we're going to do the above for other reasons (what are they?) then it
would be neater to add a new PF_NO_SIGNALS rather than overloading PF_DEAD.
