Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030573AbWJ3Swg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030573AbWJ3Swg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWJ3Swg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:52:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15750 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030573AbWJ3Swf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:52:35 -0500
Message-ID: <454649CE.80804@engr.sgi.com>
Date: Mon, 30 Oct 2006 10:51:58 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xacct_add_tsk: fix pure theoretical ->mm use-after-free
References: <20061029185826.GA1619@oleg>
In-Reply-To: <20061029185826.GA1619@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> Paranoid fix. The task can free its ->mm after the 'if (p->mm)' check.

Why this change is necessary? This routine is indirectly invoked by
taskstats_exit_send() routine called inside do_exit():

do_exit()
{
        ...
        taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
        taskstats_exit_free(tidstats);
        delayacct_tsk_exit(tsk);

        exit_mm(tsk);
        ...
}

The mm is freed in exit_mm(), right?

- jay


> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- STATS/kernel/tsacct.c~3_mm	2006-10-27 01:03:26.000000000 +0400
> +++ STATS/kernel/tsacct.c	2006-10-29 21:46:12.000000000 +0300
> @@ -80,13 +80,17 @@ void bacct_add_tsk(struct taskstats *sta
>   */
>  void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
>  {
> +	struct mm_struct *mm;
> +
>  	/* convert pages-jiffies to Mbyte-usec */
>  	stats->coremem = jiffies_to_usecs(p->acct_rss_mem1) * PAGE_SIZE / MB;
>  	stats->virtmem = jiffies_to_usecs(p->acct_vm_mem1) * PAGE_SIZE / MB;
> -	if (p->mm) {
> +	mm = get_task_mm(p);
> +	if (mm) {
>  		/* adjust to KB unit */
> -		stats->hiwater_rss   = p->mm->hiwater_rss * PAGE_SIZE / KB;
> -		stats->hiwater_vm    = p->mm->hiwater_vm * PAGE_SIZE / KB;
> +		stats->hiwater_rss   = mm->hiwater_rss * PAGE_SIZE / KB;
> +		stats->hiwater_vm    = mm->hiwater_vm * PAGE_SIZE / KB;
> +		mmput(mm);
>  	}
>  	stats->read_char	= p->rchar;
>  	stats->write_char	= p->wchar;
> 

