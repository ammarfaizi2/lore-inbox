Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286201AbRLJIdg>; Mon, 10 Dec 2001 03:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286202AbRLJId1>; Mon, 10 Dec 2001 03:33:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59144 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S286201AbRLJIdN>;
	Mon, 10 Dec 2001 03:33:13 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112100833.fBA8X6m209019@saturn.cs.uml.edu>
Subject: Re: [PATCH] proc-based cpu affinity user interface
To: colpatch@us.ibm.com (Matthew Dobson)
Date: Mon, 10 Dec 2001 03:33:05 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C03F647.5F23193@us.ibm.com> from "Matthew Dobson" at Nov 27, 2001 12:23:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been working on a patch that is a roll up of Andrew Morton's patch, and
> also of some work by Nick Pollitt to use a prctl() interface to the
> cpus_allowed bitmask.  It also includes a new bitmask 'launch_policy' which
> allows a process to set a launch policy which is used to determine it's
> childrens' cpus_allowed bitmasks prior to launch.

It looks like you are limiting the number of CPUs to sizeof(long).
Must you? Using "%lx" would be better in any case. Considering that
you may outgrow the format, maybe this info doesn't belong in the
/proc/*/stat files at all. For "ps" usage, a simple flag to indicate
if the process is locked to a CPU would be OK. There are 3 cases
of interest:

1. can run on all CPUs
2. can run on only the currently used CPU
3. can run on some subset of the available CPUs

(defined sanely for 1-CPU and 2-CPU systems of course)


> diff -Nur linux-2.4.10/fs/proc/array.c linux-2.4.10-launch_policy/fs/proc/array.c
> --- linux-2.4.10/fs/proc/array.c	Fri Oct 26 15:07:16 2001
> +++ linux-2.4.10-launch_policy/fs/proc/array.c	Thu Nov 15 13:38:57 2001
> @@ -50,6 +50,10 @@
>   * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
>   *			 :  proc_misc.c. The rest may eventually go into
>   *			 :  base.c too.
> + *
> + * Andrew Morton     : cpus_allowed
> + *
> + * Matthew Dobson    : launch_policy (Thanks to Andrew Morton for inspiraton)
>   */
>  
>  #include <linux/config.h>
> @@ -343,7 +347,7 @@
>  	read_unlock(&tasklist_lock);
>  	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
>  %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
> -%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
> +%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
>  		task->pid,
>  		task->comm,
>  		state,
> @@ -386,7 +390,9 @@
>  		task->nswap,
>  		task->cnswap,
>  		task->exit_signal,
> -		task->processor);
> +		task->processor,
> +		task->cpus_allowed,
> +		task->launch_policy);
