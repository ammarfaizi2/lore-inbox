Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDTJFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDTJFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDTJF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:05:29 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27410 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750772AbWDTJF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:05:27 -0400
Date: Thu, 20 Apr 2006 11:05:14 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> traced.  It takes a bitmask and a length.  A system call is traced
> if its bit is one.  Otherwise, it executes normally, and is
> invisible to the ptracing parent.
> [...]
> +int set_syscall_mask(struct task_struct *child, char __user *mask,
> +		     unsigned long len)
> +{
> +	int i, n = (NR_syscalls + 7) / 8;
> +	char c;
> +
> +	if(len > n){
> +		for(i = NR_syscalls; i < len * 8; i++){
> +			get_user(c, &mask[i / 8]);
> +			if(!(c & (1 << (i % 8)))){
> +				printk("Out of range syscall at %d\n", i);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		len = n;
> +	}

Since it's quite likely that len > n will be true (e.g. after installing the
latest version of your debug tool) it would be better to silently ignore all
bits not within the range of NR_syscalls.
There is no point in flooding the console. The tracing process won't see any
of the non existant syscalls it requested to see anyway.
