Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTBCUiO>; Mon, 3 Feb 2003 15:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBCUiO>; Mon, 3 Feb 2003 15:38:14 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23315
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265409AbTBCUiN>; Mon, 3 Feb 2003 15:38:13 -0500
Subject: Re: [patch] HT scheduler, sched-2.5.59-E2
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>, Erich Focht <efocht@ess.nec.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.44.0302031812500.12700-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302031812500.12700-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1044305265.802.60.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Feb 2003 15:47:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 13:23, Ingo Molnar wrote:

> the attached patch (against 2.5.59 or BK-curr) has two HT-scheduler fixes
> over the -D7 patch:

Hi, Ingo.  I am running this now, with good results. Unfortunately I do
not have an HT-capable processor, so I am only testing the interactivity
improvements.  They are looking very good - a step in the right
direction.  Very nice.

A couple bits:

> -		wake_up_interruptible(PIPE_WAIT(*inode));
> +		wake_up_interruptible_sync(PIPE_WAIT(*inode));
> ...
> -		wake_up_interruptible(PIPE_WAIT(*inode));
> +		wake_up_interruptible_sync(PIPE_WAIT(*inode));
>  ...
> -		wake_up_interruptible(PIPE_WAIT(*inode));
> +		wake_up_interruptible_sync(PIPE_WAIT(*inode));

These are not correct, right?  I believe we want normal behavior here,
no?

> --- linux/kernel/sys.c.orig	
> +++ linux/kernel/sys.c	
> @@ -220,7 +220,7 @@
>  
>  	if (error == -ESRCH)
>  		error = 0;
> -	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
> +	if (0 && niceval < task_nice(p) && !capable(CAP_SYS_NICE))

What is the point of this? Left in for debugging?

> -#define MAX_SLEEP_AVG		(2*HZ)
> -#define STARVATION_LIMIT	(2*HZ)
> +#define MAX_SLEEP_AVG		(10*HZ)
> +#define STARVATION_LIMIT	(30*HZ)

Do you really want a 30 second starvation limit?  Ouch.

> +	printk("rq_idx(smp_processor_id()): %ld.\n", rq_idx(smp_processor_id()));

This gives a compiler warning on UP:

        kernel/sched.c: In function `sched_init':
        kernel/sched.c:2722: warning: long int format, int arg (arg 2)

Since rq_idx(), on UP, merely returns its parameter which is an int.

Otherwise, looking nice :)

	Robert Love

