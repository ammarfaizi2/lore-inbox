Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVIXEIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVIXEIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 00:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVIXEIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 00:08:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:262 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751397AbVIXEIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 00:08:42 -0400
Date: Sat, 24 Sep 2005 06:05:34 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050924040534.GB18716@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Fri, Sep 23, 2005 at 11:13:30AM -0700, Davide Libenzi wrote:
> 
> The sys_epoll_wait() function was not handling correctly negative 
> timeouts (besides -1), and like sys_poll(), was comparing millisec to 
> secs in testing the upper timeout limit.
> 
> 
> Signed-off-by: Davide Libenzi <davidel@xmailserver.org>
> 
> 
> - Davide

> --- a/fs/eventpoll.c	2005-09-23 10:56:57.000000000 -0700
> +++ b/fs/eventpoll.c	2005-09-23 11:00:06.000000000 -0700
> @@ -1507,7 +1507,7 @@
>  	 * and the overflow condition. The passed timeout is in milliseconds,
>  	 * that why (t * HZ) / 1000.
>  	 */
> -	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> +	jtimeout = timeout < 0 || (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ) ?
>  		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;

Here, I'm not certain that gcc will optimize the divide. It would be better
anyway to write this which is equivalent, and a pure integer comparison :

+	jtimeout = timeout < 0 || timeout >= 1000 * MAX_SCHEDULE_TIMEOUT / HZ ?
>  		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;

gcc will also spit a warning if the constant is too big for an int,
depending on MAX_SCHEDULE_TIMEOUT and HZ, while in the previous case,
it would remain silent, and possibly, timeout/1000 would never reach
the limit.

Regards,
Willy

