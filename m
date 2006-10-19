Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946108AbWJSPUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946108AbWJSPUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946111AbWJSPUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:20:48 -0400
Received: from xenotime.net ([66.160.160.81]:46992 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1946108AbWJSPUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:20:47 -0400
Date: Thu, 19 Oct 2006 08:22:18 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Message-Id: <20061019082218.86aa5405.rdunlap@xenotime.net>
In-Reply-To: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 16:32:07 +0400 Vasily Tarasov wrote:

> --- linux-2.6.18/arch/ia64/ia32/sys_ia32.c.quot32	2006-09-20 07:42:06.000000000 +0400
> +++ linux-2.6.18/arch/ia64/ia32/sys_ia32.c	2006-10-19 11:17:50.000000000 +0400
> @@ -2545,6 +2545,54 @@ long sys32_fadvise64_64(int fd, __u32 of
>  			       advice); 
>  } 
>  
> +asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
> +						qid_t id, void __user *addr)
> +{
> +
> +	switch (cmds) {
> +		case Q_GETQUOTA:
> +			old_fs = get_fs();
> +			set_fs(KERNEL_DS);
> +			ret = sys_quotactl(cmd, special, id, &dqblk);
> +			set_fs(old_fs);
> +			memcpy(&dqblk32, &dqblk, sizeof(dqblk32));
> +			dqblk32.dqb_valid = dqblk.dqb_valid;
> +			if (copy_to_user(addr, &dqblk32, sizeof(dqblk32)))
> +				return -EFAULT;
> +			break;
> +		case Q_SETQUOTA:
> +			if (copy_from_user(&dqblk32, addr, sizeof(dqblk32)))
> +				return -EFAULT;
> +			memcpy(&dqblk, &dqblk32, sizeof(dqblk32));
> +			dqblk.dqb_valid = dqblk32.dqb_valid;
> +			old_fs = get_fs();
> +			set_fs(KERNEL_DS);
> +			ret = sys_quotactl(cmd, special, id, &dqblk);
> +			set_fs(old_fs);
> +			break;
> +		default:
> +			return sys_quotactl(cmd, special, id, addr);
> +	}
> +	return ret;
> +}

Please align the switch and case/default source lines.
We prefer not to "double-indent" each case block inside a switch.

I suppose I should try to add this to CodingStyle since it's
not there.

> --- linux-2.6.18/arch/x86_64/ia32/sys_ia32.c.quot32	2006-09-20 07:42:06.000000000 +0400
> +++ linux-2.6.18/arch/x86_64/ia32/sys_ia32.c	2006-10-19 11:00:18.000000000 +0400
> @@ -915,3 +915,50 @@ long sys32_lookup_dcookie(u32 addr_low, 
>  	return sys_lookup_dcookie(((u64)addr_high << 32) | addr_low, buf, len);
>  }
>  
> +asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
> +						qid_t id, void __user *addr)
> +{
> +
> +	switch (cmds) {
> +		case Q_GETQUOTA:
> +			old_fs = get_fs();
> +			set_fs(KERNEL_DS);
> +			ret = sys_quotactl(cmd, special, id, &dqblk);
> +			set_fs(old_fs);
> +			memcpy(&dqblk32, &dqblk, sizeof(dqblk32));
> +			dqblk32.dqb_valid = dqblk.dqb_valid;
> +			if (copy_to_user(addr, &dqblk32, sizeof(dqblk32)))
> +				return -EFAULT;
> +			break;
> +		case Q_SETQUOTA:
> +			if (copy_from_user(&dqblk32, addr, sizeof(dqblk32)))
> +				return -EFAULT;
> +			memcpy(&dqblk, &dqblk32, sizeof(dqblk32));
> +			dqblk.dqb_valid = dqblk32.dqb_valid;
> +			old_fs = get_fs();
> +			set_fs(KERNEL_DS);
> +			ret = sys_quotactl(cmd, special, id, &dqblk);
> +			set_fs(old_fs);
> +			break;
> +		default:
> +			return sys_quotactl(cmd, special, id, addr);
> +	}


---
~Randy
