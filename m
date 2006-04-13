Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWDMQYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDMQYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDMQYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:24:04 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:13701 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932095AbWDMQYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:24:01 -0400
Date: Fri, 14 Apr 2006 00:21:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413202104.GA125@oleg>
References: <20060413163727.GA1365@oleg> <20060413133814.GA29914@infradead.org> <20060413175431.GA108@oleg> <20060413150722.GA5217@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413150722.GA5217@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Christoph Hellwig wrote:
>
> On Thu, Apr 13, 2006 at 09:54:31PM +0400, Oleg Nesterov wrote:
> > > 
> > > #define for_each_task_pid(task, pid, type, pos) \
> > > 	hlist_for_each_entry_rcu((task), (pos),  \
> > > 		(&(pid))->tasks[type], pids[type].node) {
> > > 
> > > and move the find_pid to the caller?  That would make the code a whole lot
> > > more readable.
> > 
> > Then the caller should check find_pid() doesn't return NULL. But yes,
> > we can hide this check inside for_each_task_pid().
> > 
> > But what about current users of do_each_task_pid ? We can't just remove
> > these macros.
> 
> They'd have to switch over to the new variant.  There's just 18 callers
> ayway, currently, and with a patch like the one below that number firther
> decreases :)

Ok, In such a case we should first

#define NEW_IMPROVED_HLIST_FOR_EACH_ENTRY_RCU_WHICH_DOESNT_NEED_EXTRA_PARM(pos, head, member)	\
	for (pos = hlist_entry((head)->first, typeof(*(pos)), member);			\
		rcu_dereference(pos) != hlist_entry(NULL, typeof(*(pos)), member)	\
			&& ({ prefetch((pos)->member.next); 1; });			\
		(pos) = hlist_entry((pos)->member.next, typeof(*(pos)), member))

What do you think? What should be the name for it?

Oleg.

