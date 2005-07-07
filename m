Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVGGAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVGGAXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVGGAUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 20:20:39 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:42470 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262421AbVGGASD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 20:18:03 -0400
Date: Wed, 6 Jul 2005 17:17:56 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH] Fix posix_bump_timer args
Message-Id: <20050706171756.258d4f33.rdunlap@xenotime.net>
In-Reply-To: <42CC2257.4030400@am.sony.com>
References: <42CC2257.4030400@am.sony.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 11:26:31 -0700 Geoff Levand wrote:

| This patch makes posix_bump_timer() consistent with common convention 
| by expecting a pointer to the structure be passed.
| 
| Please apply.

Does it matter other than for consistency?

E.g., in a large system with thousands of timers, it seems that it
could (at least theoretically) have a negative impact by using a
pointer dereference instead of a known fixed address.
or am I just imagining that?

Thanks,
~Randy

| Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
| 
| --
| --- linux-2.6.12.1.orig/include/linux/posix-timers.h	2005-06-17 12:48:29.000000000 -0700
| +++ linux-2.6.12.1/include/linux/posix-timers.h.bump	2005-07-06 10:58:52.000000000 -0700
| @@ -108,7 +108,7 @@
|  #define posix_bump_timer(timr, now)					\
|           do {								\
|                long delta, orun;						\
| -	      delta = now.jiffies - (timr)->it.real.timer.expires;	\
| +	      delta = (now)->jiffies - (timr)->it.real.timer.expires;	\
|                if (delta >= 0) {						\
|  	           orun = 1 + (delta / (timr)->it.real.incr);		\
|  	          (timr)->it.real.timer.expires +=			\
| 
| --- linux-2.6.12.1.orig/kernel/posix-timers.c	2005-06-17 12:48:29.000000000 -0700
| +++ linux-2.6.12.1/kernel/posix-timers.c.bump	2005-07-06 10:54:48.000000000 -0700
| @@ -384,11 +384,11 @@
|  		spin_lock(&abs_list.lock);
|  		add_clockset_delta(timr, &new_wall_to);
|  
| -		posix_bump_timer(timr, now);
| +		posix_bump_timer(timr, &now);
|  
|  		spin_unlock(&abs_list.lock);
|  	} else {
| -		posix_bump_timer(timr, now);
| +		posix_bump_timer(timr, &now);
|  	}
|  	timr->it_overrun_last = timr->it_overrun;
|  	timr->it_overrun = -1;
| @@ -810,7 +810,7 @@
|  	if (expires) {
|  		if (timr->it_requeue_pending & REQUEUE_PENDING ||
|  		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
| -			posix_bump_timer(timr, now);
| +			posix_bump_timer(timr, &now);
|  			expires = timr->it.real.timer.expires;
|  		}
|  		else
