Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUFMX4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUFMX4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 19:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUFMX4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 19:56:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:54750 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261405AbUFMX4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 19:56:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Valdis.Kletnieks@vt.edu
Date: Mon, 14 Jun 2004 09:55:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16588.59790.738289.512560@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style questions for patches..
In-Reply-To: message from Valdis.Kletnieks@vt.edu on Saturday June 12
References: <200406121959.i5CJxLAm008168@turing-police.cc.vt.edu>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday June 12, Valdis.Kletnieks@vt.edu wrote:
> 
> Straw-man sample code for illustration:
> 
> --- include/linux/pid.h.vt	2003-09-27 20:50:13.000000000 -0400
> +++ include/linux/pid.h	2004-06-12 15:29:02.507247676 -0400
> @@ -61,4 +61,22 @@ extern void switch_exec_pids(struct task
>  			elem = elem->next, prefetch(elem->next), 	\
>  			task = pid_task(elem, type))
>  
> +#ifdef CONFIG_SECURITY_RANDPID
> +#include <linux/random.h>
> +extern int security_enable_randpid;
> +
> +static inline int alloc_next_pid(int last_pid) {
> +	int next;
> +	if (security_enable_randpid && (last_pid >= RESERVED_PIDS)) {
> +		pid = (get_random_long() % (pid_max - RESERVED_PIDS)) + RESERVED_PIDS + 1;
> +	}
> +	else next = last_pid + 1;
> +	return next;
> +}
> +#else
> +static inline int alloc_next_pid(int last_pid) {
> +	return last_pid + 1;
> +}
> +#endif
> +

This would look better as:

#ifdef CONFIG_SECURITY_RANDPID
#include <linux/random>
extern int security_enable_randpid;
#else
#define security_enable_randpid (0)
#endif

static inline int alloc_next_pid(int last_pid) {
	int next;
	if (security_enable_randpid && (last_pid >= RESERVED_PIDS)) {
		pid = (get_random_long() % (pid_max - RESERVED_PIDS)) + RESERVED_PIDS + 1;
	}
	else next = last_pid + 1;
	return next;
}

and should compile to exactly the same code.
(I know that leaves a lot of your questions unanswered, but I'll leave
that to someone else).

NeilBrown
