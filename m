Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVEQXJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVEQXJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEQXJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:09:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:48073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261938AbVEQXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:09:21 -0400
Date: Tue, 17 May 2005 16:10:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
Message-Id: <20050517161000.5e0fb0a9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
References: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> Avoid taking the tasklist_lock in sys_times if the process is
> single threaded. In a NUMA system taking the tasklist_lock may
> cause a bouncing cacheline if multiple independent processes
> continually call sys_times to measure their performance.
> 
> ...
> +		if (current == next_thread(current)) {
> +			/*
> +			 * Single thread case. We do not need to scan the tasklist
> +			 * and thus can avoid the read_lock(&task_list_lock). We
> +			 * also do not need to take the siglock since we
> +			 * are the only thread in this process
> +			 */
> +			utime = cputime_add(current->signal->utime, current->utime);
> +			stime = cputime_add(current->signal->utime, current->stime);
> +			cutime = current->signal->cutime;
> +			cstime = current->signal->cstime;
> +		} else {

Well, hrm, maybe.  If this task has one sibling thread, and that thread is
in the process of exitting then (current == next_thread(current)) may
become true before that sibling thread has had a chance to dump its process
accounting info into the signal structure.

If that dumping happens prior to the __detach_pid() call then things are
probably OK (modulo memory ordering issues).  Otherwise there's a little
window where the accounting will go wrong.

Have you audited that code to ensure that the desired sequencing occurs in
all cases and that the appropriate barriers are in place?

It all looks a bit fast-and-loose.  If there are significant performance
benefits and these issues are loudly commented (they aren't at present)
then maybe-OK, I guess.
