Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVCQG3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVCQG3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 01:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVCQG3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 01:29:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40181 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261828AbVCQG3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 01:29:48 -0500
Message-ID: <423923D9.4050801@mvista.com>
Date: Wed, 16 Mar 2005 22:29:45 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Liu, Hong" <hong.liu@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] fix POSIX timers expire before their scheduled time
References: <1111026022.2994.54.camel@devlinux-hong>
In-Reply-To: <1111026022.2994.54.camel@devlinux-hong>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liu, Hong wrote:
> POSIX says: POSIX timers should not expire before their scheduled time.
> 
> Due to the timer started between jiffies, there are cases that the timer
> will expire before its scheduled time.
> This patch ensures timers will not expire early.
> 
> --- a/kernel/posix-timers.c     2005-03-10 15:46:27.329333664 +0800
> +++ b/kernel/posix-timers.c     2005-03-10 15:50:11.884196136 +0800
> @@ -957,7 +957,8 @@
>                             &expire_64, &(timr->wall_to_prev))) {
>                 return -EINVAL;
>         }
> -       timr->it_timer.expires = (unsigned long)expire_64;
> +       timr->it_timer.expires = (unsigned long)expire_64 + 1;
>         tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
>         timr->it_incr = (unsigned long)expire_64;
> 
Has this happened??  The following code (in adjust_abs_time()) is supposed to 
prevent this sort of thing:

	if (oc.tv_sec | oc.tv_nsec) {
		oc.tv_nsec += clock->res;
		timespec_norm(&oc);
	}

Also, we run rather extensive tests for this sort of thing.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

