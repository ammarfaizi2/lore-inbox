Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbUCNFAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbUCNFAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:00:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:1760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263288AbUCNFAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:00:46 -0500
Date: Sat, 13 Mar 2004 21:00:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Lyashkov <shadow@psoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible kernel bug in signal transit.
Message-Id: <20040313210051.6b4a2846.akpm@osdl.org>
In-Reply-To: <1079239159.8186.24.camel@berloga.shadowland>
References: <1079197336.13835.15.camel@berloga.shadowland>
	<20040313171856.37b32e52.akpm@osdl.org>
	<1079239159.8186.24.camel@berloga.shadowland>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Lyashkov <shadow@psoft.net> wrote:
>
> > Thanks for checking though..
>  No. it can`t return final non-zero-returning group_send_sig_info() if
>  first call group_send_sig_info return 0.

you're right.   How about the nice and simple version?

int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
{
	struct task_struct *p;
	struct list_head *l;
	struct pid *pid;
	int retval;
	int found;

	if (pgrp <= 0)
		return -EINVAL;

	found = 0;
	retval = 0;
	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
		int err;

		found = 1;
		err = group_send_sig_info(sig, info, p);
		if (!retval)
			retval = err;
	}
	return found ? retval : -ESRCH;
}

