Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWGIWqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWGIWqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWGIWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:46:54 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:49630 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932302AbWGIWqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:46:53 -0400
Date: Mon, 10 Jul 2006 06:46:57 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/8] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #4]
Message-ID: <20060710024657.GA255@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>
> +static int elf_fdpic_core_dump(long signr, struct pt_regs *regs,
> +			       struct file *file)
> +{
>
>  [... snip ...]
>
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g,p)
> +			if (current->mm == p->mm && current != p) {
> +				tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
> +				if (!tmp) {
> +					read_unlock(&tasklist_lock);
> +					goto cleanup;
> +				}
> +				INIT_LIST_HEAD(&tmp->list);
> +				tmp->thread = p;
> +				list_add(&tmp->list, &thread_list);
> +			}
> +		while_each_thread(g,p);
> +		read_unlock(&tasklist_lock);

Do you see any reason for tasklist_lock here (and in elf_core_dump) ?

do_each_thread() is rcu-safe, and all tasks which use this ->mm must
sleep in wait_for_completion(&mm->core_done) at this point.

Oleg.

