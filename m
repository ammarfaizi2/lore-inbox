Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVKAEwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVKAEwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKAEwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:52:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964934AbVKAEwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:52:01 -0500
Date: Mon, 31 Oct 2005 20:51:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, oleg@tv-sign.ru,
       dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-Id: <20051031205119.5bd897f3.akpm@osdl.org>
In-Reply-To: <20051031140459.GA5664@elte.hu>
References: <20051031020535.GA46@us.ibm.com>
	<20051031140459.GA5664@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> @@ -1433,7 +1485,16 @@ send_group_sigqueue(int sig, struct sigq
>   	int ret = 0;
>   
>   	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
>  -	read_lock(&tasklist_lock);
>  +
>  +	while(!read_trylock(&tasklist_lock)) {
>  +		if (!p->sighand)
>  +			return -1;
>  +		cpu_relax();
>  +	}

This looks kind of ugly and quite unobvious.

What's going on there?
