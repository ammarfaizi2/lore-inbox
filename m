Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHIThK>; Fri, 9 Aug 2002 15:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSHIThJ>; Fri, 9 Aug 2002 15:37:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48076 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315445AbSHIThF>; Fri, 9 Aug 2002 15:37:05 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 14:34:17 -0500
Message-Id: <1028921658.19434.365.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect that it would actually require more than just this.  I tried
this with the same test I've been using and had several failed attepmts
at low numbers by getting wierd unexpected signals (like 28), and then
one that ran for a much longer time and produced an oops with random
garbage to the console (trying to extract this now).

-Paul Larson

On Thu, 2002-08-08 at 17:02, Linus Torvalds wrote:
> ----
> --- 1.2/include/linux/threads.h	Tue Feb  5 07:23:04 2002
> +++ edited/include/linux/threads.h	Thu Aug  8 14:58:28 2002
> @@ -19,6 +19,7 @@
>  /*
>   * This controls the maximum pid allocated to a process
>   */
> -#define PID_MAX 0x8000
> +#define PID_MASK 0x3fffffff
> +#define PID_MAX (PID_MASK+1)
>  
>  #endif
> ===== kernel/fork.c 1.57 vs edited =====
> --- 1.57/kernel/fork.c	Tue Jul 30 15:49:20 2002
> +++ edited/kernel/fork.c	Thu Aug  8 15:00:16 2002
> @@ -142,7 +142,7 @@
>  		return 0;
>  
>  	spin_lock(&lastpid_lock);
> -	if((++last_pid) & 0xffff8000) {
> +	if((++last_pid) & ~PID_MASK) {
>  		last_pid = 300;		/* Skip daemons etc. */
>  		goto inside;
>  	}
> @@ -157,7 +157,7 @@
>  			   p->tgid == last_pid	||
>  			   p->session == last_pid) {
>  				if(++last_pid >= next_safe) {
> -					if(last_pid & 0xffff8000)
> +					if(last_pid & ~PID_MASK)
>  						last_pid = 300;
>  					next_safe = PID_MAX;
>  				}
> 
> 


