Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWHPN4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWHPN4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWHPN4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:56:05 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:41190 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750904AbWHPN4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:56:04 -0400
Date: Wed, 16 Aug 2006 22:19:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
Message-ID: <20060816181950.GA472@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <1155666193751-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155666193751-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Eric W. Biederman wrote:
>
> +static inline pid_t pid_nr(struct pid *pid)
> +{
> +	pid_t nr = 0;
> +	if (pid)
> +		nr = pid->nr;
> +	return nr;
> +}

I think this is not safe, you need rcu locks here or the caller should
do some locking.

Let's look at f_getown() (PATCH 7/7). What if original task which was
pointed by ->f_owner.pid has gone, another thread does fcntl(F_SETOWN),
and pid_nr() takes a preemtion after 'if (pid)'? In this case 'pid->nr'
may follow a freed memory.

Oleg.

