Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267293AbUHPADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbUHPADz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHPADy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:03:54 -0400
Received: from zero.aec.at ([193.170.194.10]:43525 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267293AbUHPADm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:03:42 -0400
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] waitid system call
References: <2tCiy-8pK-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 16 Aug 2004 02:03:37 +0200
In-Reply-To: <2tCiy-8pK-13@gated-at.bofh.it> (Roland McGrath's message of
 "Mon, 16 Aug 2004 01:10:06 +0200")
Message-ID: <m3smaoc5k6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

Are you sure you converted the new _rusage member properly 
in the 64->32bit siginfo converter? struct rusage uses long.

> +asmlinkage long sys32_waitid(int which, compat_pid_t pid,
> +			     siginfo_t32 __user *uinfo, int options)
> +{
> +	siginfo_t info;
> +	long ret;
> +	mm_segment_t old_fs = get_fs();
> +
> +	info.si_signo = 0;
> +	set_fs (KERNEL_DS);
> +	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options);
> +	set_fs (old_fs);

Better use compat_alloc_user_space() for this. Otherwise it won't
work for UML/x86-64. Also that will make it easier to port to other
architectures. 

+	/* 1 if group stopped since last SIGCONT, -1 if SIGCONT since report */
+  	int			stop_state;

Can't this be merged into some other field? No need to waste memory
unnecessarily.

-Andi

