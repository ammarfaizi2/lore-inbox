Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUCNFVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 00:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbUCNFVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 00:21:16 -0500
Received: from [213.227.237.65] ([213.227.237.65]:19840 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S263289AbUCNFVO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 00:21:14 -0500
Subject: Re: possible kernel bug in signal transit.
From: Alex Lyashkov <shadow@psoft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040313210051.6b4a2846.akpm@osdl.org>
References: <1079197336.13835.15.camel@berloga.shadowland>
	 <20040313171856.37b32e52.akpm@osdl.org>
	 <1079239159.8186.24.camel@berloga.shadowland>
	 <20040313210051.6b4a2846.akpm@osdl.org>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Organization: PSoft
Message-Id: <1079241668.8186.33.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sun, 14 Mar 2004 07:21:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Вск, 14.03.2004, в 07:00, Andrew Morton пишет:
> Alex Lyashkov <shadow@psoft.net> wrote:
> >
> > > Thanks for checking though..
> >  No. it can`t return final non-zero-returning group_send_sig_info() if
> >  first call group_send_sig_info return 0.
> 
> you're right.   How about the nice and simple version?
> 
> int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
> {
> 	struct task_struct *p;
> 	struct list_head *l;
> 	struct pid *pid;
> 	int retval;
> 	int found;
> 
> 	if (pgrp <= 0)
> 		return -EINVAL;
> 
> 	found = 0;
> 	retval = 0;
> 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
> 		int err;
> 
> 		found = 1;
> 		err = group_send_sig_info(sig, info, p);
> 		if (!retval)
> 			retval = err;
> 	}
> 	return found ? retval : -ESRCH;
> }
not. it error. At this code you save first non zero value err but other
been ignored.


-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
