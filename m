Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWDMNim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWDMNim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWDMNim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:38:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50660 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964933AbWDMNil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:38:41 -0400
Date: Thu, 13 Apr 2006 14:38:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413133814.GA29914@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <20060413163727.GA1365@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413163727.GA1365@oleg>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:37:27PM +0400, Oleg Nesterov wrote:
> Simpllify do_each_task_pid/while_each_task_pid macros.
> This also makes the code a bit smaller.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- MM/include/linux/pid.h~	2006-03-23 22:48:10.000000000 +0300
> +++ MM/include/linux/pid.h	2006-04-13 20:28:53.000000000 +0400
> @@ -99,21 +99,16 @@ extern void FASTCALL(free_pid(struct pid
>  			pids[(type)].node)
>  
>  
> -/* We could use hlist_for_each_entry_rcu here but it takes more arguments
> - * than the do_each_task_pid/while_each_task_pid.  So we roll our own
> - * to preserve the existing interface.
> - */
> -#define do_each_task_pid(who, type, task)				\
> -	if ((task = find_task_by_pid_type(type, who))) {		\
> -		prefetch(pid_next(task, type));				\
> -		do {
> -
> -#define while_each_task_pid(who, type, task)				\
> -		} while (pid_next(task, type) &&  ({			\
> -				task = pid_next_task(task, type);	\
> -				rcu_dereference(task);			\
> -				prefetch(pid_next(task, type));		\
> -				1; }) );				\
> -	}
> +#define do_each_task_pid(who, type, task)					\
> +	do {									\
> +		struct hlist_node *pos___;					\
> +		struct pid *pid___ = find_pid(who);				\
> +		if (pid___ != NULL)						\
> +			hlist_for_each_entry_rcu((task), pos___,		\
> +				&pid___->tasks[type], pids[type].node) {
> +
> +#define while_each_task_pid(who, type, task)					\
> +			}							\
> +	} while (0)

This is prtty ugly.  Can't we just have a

#define for_each_task_pid(task, pid, type, pos) \
	hlist_for_each_entry_rcu((task), (pos),  \
		(&(pid))->tasks[type], pids[type].node) {

and move the find_pid to the caller?  That would make the code a whole lot
more readable.
