Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKKXuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKKXuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKKXuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:50:08 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:35485 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750721AbVKKXuF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:50:05 -0500
X-IronPort-AV: i="3.99,120,1131350400"; 
   d="scan'208"; a="364088557:sNHT27371192"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 15:49:50 -0800
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82BCF33B9@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] getrusage sucks
Thread-Index: AcXnGdDXK8yrYIAtRBqYeUrjqaOpLQAALLOQ
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "Claudio Scordino" <cloud.of.andor@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Chris Wright" <chrisw@osdl.org>, "Magnus Naeslund\(f\)" <mag@fbab.net>,
       <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>,
       "David Wagner" <daw@cs.berkeley.edu>
X-OriginalArrivalTime: 11 Nov 2005 23:49:51.0921 (UTC) FILETIME=[9BD04210:01C5E71A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's better to use "goto" for error exit. Too many read_unlock
here.. 

> -----Original Message-----
> From: Claudio Scordino [mailto:cloud.of.andor@gmail.com] 
> Sent: Friday, November 11, 2005 3:44 PM
> To: Alan Cox
> Cc: Chris Wright; Magnus Naeslund(f); Hua Zhong (hzhong); 
> linux-kernel@vger.kernel.org; kernelnewbies@nl.linux.org; David Wagner
> Subject: Re: [PATCH] getrusage sucks
> 
> >
> > In which case the only comment I have is the one about 
> accuracy - and
> > that is true for procfs too so will only come up if someone gets the
> > urge to use perfctr timers for precision resource management
> 
> According to your comments, this the final patch. 
> 
> Should it be committed ?
> 
>          Claudio
> 
> 
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1746,9 +1746,26 @@ int getrusage(struct task_struct *p, int
> 
>  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
>  {
> -       if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> -               return -EINVAL;
> -       return getrusage(current, who, ru);
> +        if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
> +                struct task_struct* tsk;
> +                struct rusage r;
> +                read_lock(&tasklist_lock);
> +                tsk = find_task_by_pid(who);
> +                if (tsk == NULL) {
> +                        read_unlock(&tasklist_lock);
> +                        return -EINVAL;
> +                }
> +                if ((current->euid != tsk->euid) &&
> +                (current->euid != tsk->uid) &&
> +                (!capable(CAP_SYS_ADMIN))){
> +                        read_unlock(&tasklist_lock);
> +                        return -EPERM;
> +                }
> +                k_getrusage(tsk, RUSAGE_SELF, &r);
> +                read_unlock(&tasklist_lock);
> +                return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> +        } else
> +                return getrusage(current, who, ru);
>  }
> 
>  asmlinkage long sys_umask(int mask)
> 
