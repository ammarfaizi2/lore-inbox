Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVDBAUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVDBAUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVDBASf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:18:35 -0500
Received: from ns1.s2io.com ([142.46.200.198]:28107 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262941AbVDBAGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 19:06:17 -0500
Subject: Re: oom-killer disable for iscsi/lvm2/multipath userland critical
	sections
From: Dmitry Yusupov <dima@neterion.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050401221400.GQ29492@g5.random>
References: <20050401221400.GQ29492@g5.random>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Fri, 01 Apr 2005 16:06:13 -0800
Message-Id: <1112400373.9559.100.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.5
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

I just successfully tested the patch on my environment. It actually
resolved OOM-killer problem for my iscsid.

Important note: daemon's parent must be init.

In my test, OOM-killer killed everything around but iscsid, and iscsid
successfully finished registration of new SCSI host in the middle of
crazy OOM-killer :)

Thanks!
Dima

On Sat, 2005-04-02 at 00:14 +0200, Andrea Arcangeli wrote:
> Hello,
> 
> some private discussion (that was continuing some kernel-summit-discuss
> thread) ended in the below patch. I also liked a textual "disable"
> instead of value "-17" (internally to the kernel it could be represented
> the same way, but the /proc parsing would be more complicated). If you
> prefer textual "disable" we can change this of course.
> 
> Comments welcome.
> 
> From: Andrea Arcangeli <andrea@suse.de>
> Subject: oom killer protection
> 
> iscsi/lvm2/multipath needs guaranteed protection from the oom-killer.
> 
> Signed-off-by: Andrea Arcangeli <andrea@suse.de>
> 
> --- 2.6.12-seccomp/fs/proc/base.c.~1~	2005-03-25 05:13:28.000000000 +0100
> +++ 2.6.12-seccomp/fs/proc/base.c	2005-04-01 23:47:22.000000000 +0200
> @@ -751,7 +751,7 @@ static ssize_t oom_adjust_write(struct f
>  	if (copy_from_user(buffer, buf, count))
>  		return -EFAULT;
>  	oom_adjust = simple_strtol(buffer, &end, 0);
> -	if (oom_adjust < -16 || oom_adjust > 15)
> +	if ((oom_adjust < -16 || oom_adjust > 15) && oom_adjust != OOM_DISABLE)
>  		return -EINVAL;
>  	if (*end == '\n')
>  		end++;
> --- 2.6.12-seccomp/include/linux/mm.h.~1~	2005-03-25 05:13:28.000000000 +0100
> +++ 2.6.12-seccomp/include/linux/mm.h	2005-04-01 23:53:11.000000000 +0200
> @@ -856,5 +856,8 @@ int in_gate_area_no_task(unsigned long a
>  #define in_gate_area(task, addr) ({(void)task; in_gate_area_no_task(addr);})
>  #endif	/* __HAVE_ARCH_GATE_AREA */
>  
> +/* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
> +#define OOM_DISABLE -17
> +
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */
> --- 2.6.12-seccomp/mm/oom_kill.c.~1~	2005-03-08 01:02:30.000000000 +0100
> +++ 2.6.12-seccomp/mm/oom_kill.c	2005-04-01 23:46:18.000000000 +0200
> @@ -145,7 +145,7 @@ static struct task_struct * select_bad_p
>  	do_posix_clock_monotonic_gettime(&uptime);
>  	do_each_thread(g, p)
>  		/* skip the init task with pid == 1 */
> -		if (p->pid > 1) {
> +		if (p->pid > 1 && p->oomkilladj != OOM_DISABLE) {
>  			unsigned long points;
>  
>  			/*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

