Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFPSLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFPSLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFPSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:11:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:61569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264411AbUFPSHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:07:23 -0400
Date: Wed, 16 Jun 2004 20:07:22 +0200 (MEST)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.58.0406160910020.27252@ppc970.osdl.org>
Subject: Re: [PATCH 2.6.7] kill(2), killpg(2) wrongly fail with EPERM
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <25304.1087409242@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday Linus,

> On Wed, 16 Jun 2004, Michael Kerrisk wrote:
> > 
> > The following patch for 2.6.7 fixes the problem.  Please apply.
> 
> How about this imho nicer version instead? It results in the main loop
> being just:
> 
>         success = 0;
>         retval = -ESRCH;
>         for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
>                 int err = group_send_sig_info(sig, info, p);
>                 success |= !err;
>                 retval = err;  
>         }
>         return success ? 0 : retval;

Yes, it is nicer.

> which seems sensible. If _any_ group-send succeeded, we want to return 
> success (ie this is not a EPERM vs everything else issue).
> 
> Does this work for you?

Well, in terms of SUSv3/POSIX, I don't think there's a problem, 
since the only errors trhat are specified for kill()/killpg() 
are EPERM, ESRCH, and EINVAL (invalid signal number).  Aside 
from the fact that I didn't spot the nice way, I wrote my 
patch as I did since I was worried about the possibility of 
some other Linux-specific errno values creeping around in the 
woodwork.  But a little further investigation seems to show that
there aren't other cases to worry about (EAGAIN in send_sig()
doesn't apply for kill()/killpg().  So, your patch is better, 
since simpler.  I've tested it, and it works as I would expect 
for EPERM.

Thanks,

Michael


> -----
> ===== kernel/signal.c 1.120 vs edited =====
> --- 1.120/kernel/signal.c	Wed Jun  9 01:46:51 2004
> +++ edited/kernel/signal.c	Wed Jun 16 09:09:51 2004
> @@ -1071,23 +1071,19 @@
>  	struct task_struct *p;
>  	struct list_head *l;
>  	struct pid *pid;
> -	int retval;
> -	int found;
> +	int retval, success;
>  
>  	if (pgrp <= 0)
>  		return -EINVAL;
>  
> -	found = 0;
> -	retval = 0;
> +	success = 0;
> +	retval = -ESRCH;
>  	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
> -		int err;
> -
> -		found = 1;
> -		err = group_send_sig_info(sig, info, p);
> -		if (!retval)
> -			retval = err;
> +		int err = group_send_sig_info(sig, info, p);
> +		success |= !err;
> +		retval = err;
>  	}
> -	return found ? retval : -ESRCH;
> +	return success ? 0 : retval;
>  }
>  
>  int
> 

-- 
+++ Jetzt WLAN-Router für alle DSL-Einsteiger und Wechsler +++
GMX DSL-Powertarife zudem 3 Monate gratis* http://www.gmx.net/dsl

