Return-Path: <linux-kernel-owner+w=401wt.eu-S1752356AbWLQKTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbWLQKTI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbWLQKTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:19:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60481 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbWLQKTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:19:07 -0500
Date: Sun, 17 Dec 2006 10:18:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kill_something_info: misc cleanups
Message-ID: <20061217101856.GA1285@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <20061216200510.GA5535@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216200510.GA5535@tv-sign.ru>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 11:05:10PM +0300, Oleg Nesterov wrote:
>  static int kill_something_info(int sig, struct siginfo *info, int pid)
>  {
>  	int ret;
> +
> +	rcu_read_lock();
> +	if (pid > 0) {
> +		ret = kill_pid_info(sig, info, find_pid(pid));
> +	} else if (pid == -1) {
> +		struct task_struct *p;
> +		int found = 0;
> +
> +		ret = 0;
> +		read_lock(&tasklist_lock);
> +		for_each_process(p)
> +			if (!is_init(p) && p != current->group_leader) {
> +				int err = group_send_sig_info(sig, info, p);
> +				if (err != -EPERM)
> +					ret = err;
> +				found = 1;
> +			}
> +		read_unlock(&tasklist_lock);
> +		if (!found)
> +			ret = -ESRCH;

This branch should probably be factored out into a helper of it's own:

static int kill_this_group_info(int sig, struct siginfo *info)
{
	struct task_struct *p;
	int ret = 0, found = 0;

	read_lock(&tasklist_lock);
	for_each_process(p) {
		if (!is_init(p) && p != current->group_leader) {
			int err = group_send_sig_info(sig, info, p);
			if (err != -EPERM)
				ret = err;
			found = 1;
		}
	}
	read_unlock(&tasklist_lock);
	if (!found)
		return -ESRCH;
	return found ? ret : -ESRCH;
}

> +	} else {
> +		struct pid *grp = task_pgrp(current);
> +		if (pid != 0)
> +			grp = find_pid(-pid);
> +		ret = kill_pgrp_info(sig, info, grp);
> +	}

This also looks rather unreadable, an

	} else if (pid) {
		ret = kill_pgrp_info(sig, info, find_pid(-pid));
	} else {
		ret = kill_pgrp_info(sig, info, task_pgrp(current));
	}

might be slightly more code, but also a lot more readable.

