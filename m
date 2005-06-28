Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVF1G1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVF1G1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVF1G0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:26:13 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55251 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261633AbVF1Fw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:52:59 -0400
Message-ID: <42C0E5F9.50609@jp.fujitsu.com>
Date: Tue, 28 Jun 2005 14:54:01 +0900
From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 07/38] CKRM e18: Numtasks Controller
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061755.520778000@w-gerrit.beaverton.ibm.com>
In-Reply-To: <20050623061755.520778000@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:

> Index: linux-2.6.12-ckrm1/kernel/fork.c
> ===================================================================
> --- linux-2.6.12-ckrm1.orig/kernel/fork.c	2005-06-20 13:08:27.000000000 -0700
> +++ linux-2.6.12-ckrm1/kernel/fork.c	2005-06-20 13:08:34.000000000 -0700
> @@ -42,6 +42,8 @@
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
>  #include <linux/ckrm_events.h>
> +#include <linux/ckrm_tsk.h>
> +#include <linux/ckrm_tc.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -1211,6 +1213,9 @@ long do_fork(unsigned long clone_flags,
>  			clone_flags |= CLONE_PTRACE;
>  	}
>  
> +	if (numtasks_get_ref(&current->taskclass->core, 0) == 0) {
> +		return -ENOMEM;
> +	}
>  	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr, pid);
>  	/*
>  	 * Do this prior waking up the new thread - the thread pointer
> @@ -1250,6 +1255,7 @@ long do_fork(unsigned long clone_flags,
>  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>  		}
>  	} else {
> +		numtasks_put_ref(&current->taskclass->core);
>  		free_pidmap(pid);
>  		pid = PTR_ERR(p);
>  	}

Instead of returning -ENOMEM on fork fail due to numtask or forkrate
limit, I'd rather prefer returning -EAGAIN.

Because, according to IEEE Std 1003.1, if fork() fails due to
reaching limit, it shall set the errno to EAGAIN.

Thanks,
MAEDA Naoaki

