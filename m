Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRJ2FW1>; Mon, 29 Oct 2001 00:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279006AbRJ2FWS>; Mon, 29 Oct 2001 00:22:18 -0500
Received: from tinylinux.tip.CSIRO.AU ([130.155.192.102]:15878 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S279005AbRJ2FWM>; Mon, 29 Oct 2001 00:22:12 -0500
Date: Mon, 29 Oct 2001 16:22:26 +1100
Message-Id: <200110290522.f9T5MQP01460@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: Kari Hurtta <hurtta@leija.mh.fmi.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.13] [devfs 0.119 (20011009)] base.c: devfsd_ioctl
In-Reply-To: <200110281203.f9SC3soW005371@leija.fmi.fi>
In-Reply-To: <200110281203.f9SC3soW005371@leija.fmi.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kari Hurtta writes:
> 
> Can you say where I have wrong?
> 
> Code on devfsd_ioctl() [base.c]:
> 
>         if (fs_info->devfsd_task == NULL)
>         {
>             if ( !spin_trylock (&lock) ) return -EBUSY;
>             fs_info->devfsd_task = current;
>             spin_unlock (&lock);
> 
> To me that spinlock looks like it is useless.
> Either
> 
> 	1) If it is mean that lock protects two CPUs settting
>             fs_info->devfsd_task when another is set it,
> 	    then test about fs_info->devfsd_task == NULL
> 	    should be inside of locked code
> or     2) this is protected with some other lock as comment
>           perhaps indicates:
> 
>         /*  Ensure only one reader has access to the queue. This scheme will
>             work even if the global kernel lock were to be removed, because it
>             doesn't matter who gets in first, as long as only one gets it
>         */
>         if (fs_info->devfsd_task == NULL)
>         {
>             if ( !spin_trylock (&lock) ) return -EBUSY;
> 
> Should this be:
> 
> --- fs/devfs/base.c.old	Thu Oct 11 09:23:24 2001
> +++ fs/devfs/base.c	Sun Oct 28 14:59:03 2001
> @@ -3227,6 +3227,11 @@
>  	if (fs_info->devfsd_task == NULL)
>  	{
>  	    if ( !spin_trylock (&lock) ) return -EBUSY;
> +	    if (fs_info->devfsd_task != NULL) {
> +	         /* We lost race ... */
> +	         spin_unlock (&lock);
> +		 return -EBUSY;
> +	    }
>  	    fs_info->devfsd_task = current;
>  	    spin_unlock (&lock);
>  	    fs_info->devfsd_file = file;

Damn! You're right. I broke that when I simplified the anti-race code
back in June and replaced the #ifdef CONFIG_SMP bits with plain
spinlocks. Unfortunately I didn't put back in a critcal line.
Cut-and-paste error without the paste :-(

OK, I've updated my both my trees. I'll feed this to Linus in my next
release.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
