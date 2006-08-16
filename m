Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWHPOx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWHPOx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHPOx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:53:58 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:46729 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751198AbWHPOx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:53:57 -0400
Date: Wed, 16 Aug 2006 23:17:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 2/7] pid: Add do_each_pid_task
Message-ID: <20060816191748.GA579@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <11556661923847-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11556661923847-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Eric W. Biederman wrote:
>  
> +#define do_each_pid_task(pid, type, task)				\
> +	if ((task = pid_task(pid, type))) {				\
> +		prefetch(pid_next(task, type));				\
> +		do {
> +
> +#define while_each_pid_task(pid, type, task)				\
> +		} while (pid_next(task, type) &&  ({			\
> +				task = pid_next_task(task, type);	\
> +				rcu_dereference(task);			\
> +				prefetch(pid_next(task, type));		\
> +				1; }) );				\
> +	}

A small nit. Suppose a non-leader thread blocks a signal, and does
exec. There is a window when we have 2 tasks with the same pid in
PIDTYPE_PID namespace. If send_sigio() send the signal in that
window, it will be delivered twice to process.

Oleg.

