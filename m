Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVKPPfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVKPPfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVKPPfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:35:09 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:48805 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030371AbVKPPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:35:07 -0500
Subject: Re: [patch -rt] make gendev_rel_sem a compat_semaphore
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1132155092.6266.6.camel@localhost.localdomain>
References: <1132155092.6266.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 10:34:59 -0500
Message-Id: <1132155299.6266.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crap! I sent this with my kihontech email.  Please respond to this
instead.  I'm still in the process of moving to my new machine, and the
email was messed up.

Thanks,

-- Steve


On Wed, 2005-11-16 at 10:31 -0500, Steven Rostedt wrote:
> Hi Ingo,
> 
> I was getting the following:
> 
> BUG: nonzero lock count 10 at exit time?
>         modprobe: 2972 [ffff81007e1aaf70, 116]
> 
> Call Trace:<ffffffff8014e2db>{printk_task+43} <ffffffff8015040f>{check_no_held_locks+111}
>        <ffffffff80136d3c>{do_exit+3036} <ffffffff80136f5c>{do_group_exit+268}
>        <ffffffff80136f72>{sys_exit_group+18} <ffffffff8011e471>{ia32_sysret+0}
> 
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
> hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> 
> BUG: modprobe/2972, lock held at task exit time!
>  [ffffffff8809fd00] {(struct semaphore *)(&hwif->gendev_rel_sem)}
> .. held by:          modprobe: 2972 [ffff81007e1aaf70, 116]
> ... acquired at:               init_hwif_data+0xaf/0x1a0 [ide_core]
> 
> [snipped to not be so annoying]
> 
> Looking into this I see that gendev_rel_sem, which is only used when the
> device is unregistered, is defined as a semaphore.  This patch changes
> this to be a compat_semaphore.
> 
> -- Steve
> 
> Index: linux-2.6.14-rt13/include/linux/ide.h
> ===================================================================
> --- linux-2.6.14-rt13.orig/include/linux/ide.h	2005-11-15 11:12:37.000000000 -0500
> +++ linux-2.6.14-rt13/include/linux/ide.h	2005-11-16 10:09:10.000000000 -0500
> @@ -910,7 +910,7 @@
>  	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
>  
>  	struct device	gendev;
> -	struct semaphore gendev_rel_sem; /* To deal with device release() */
> +	struct compat_semaphore gendev_rel_sem; /* To deal with device release() */
>  
>  	void		*hwif_data;	/* extra hwif data */
>  
> 

