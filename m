Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVKJXrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVKJXrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVKJXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:47:48 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:7772 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932113AbVKJXrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:47:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] getrusage sucks
Date: Thu, 10 Nov 2005 15:47:40 -0800
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] getrusage sucks
Thread-Index: AcXmRvTaPWIQgoVLSaONfNRRhJXDRgACdrMQ
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "Claudio Scordino" <cloud.of.andor@gmail.com>,
       <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
X-OriginalArrivalTime: 10 Nov 2005 23:47:42.0196 (UTC) FILETIME=[24140B40:01C5E651]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason is what if tsk is no longer available when you call
getrusage? 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Claudio Scordino
> Sent: Thursday, November 10, 2005 2:34 PM
> To: linux-kernel@vger.kernel.org; kernelnewbies@nl.linux.org
> Subject: [PATCH] getrusage sucks
> 
> Does exist any _real_ reason why getrusage can't be invoked 
> by a task to know 
> statistics of another task ?
> 
> The changes would be very trivial, as shown by the following patch.
> 
>               Claudio
> 
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1746,9 +1746,13 @@ int getrusage(struct task_struct *p, int
> 
>  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
>  {
> -  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> -     return -EINVAL;
> -  return getrusage(current, who, ru);
> +  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
> +      struct task_struct* tsk = find_task_by_pid(who);
> +      if (tsk == NULL)
> +        return -EINVAL;
> +     return getrusage(tsk, RUSAGE_SELF, ru);
> +   } else
> +     return getrusage(current, who, ru);
>  }
> 
>  asmlinkage long sys_umask(int mask)
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
