Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUBTVza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUBTVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:55:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261421AbUBTVz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:55:26 -0500
Date: Fri, 20 Feb 2004 16:55:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/4] poll()/select() timeout behavior
In-Reply-To: <20040220210324.GD1912@ti19.telemetry-investments.com>
Message-ID: <Pine.LNX.4.53.0402201648470.713@chaos>
References: <20040220210324.GD1912@ti19.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Bill Rugolsky Jr. wrote:

> This patch changes select() and poll() to not wait forever when a valid,
> but large timeout value is supplied.  The SUSv3 manual page for select(2)
> states:
>
>   "If the timeout argument specifies a timeout interval greater than the
>   implementation-defined maximum value, the maximum value shall be used as
>   the actual timeout value."
>
> Both select() and poll() have a well-defined mechanism to wait forever,
> so there is no need for the existing behavior.
>
> Please apply.
>
>     Bill Rugolsky

The "well-defined mechanism" to wait forever for poll() is to
use ANY negative value as the timeout value. If you chose -1,
that, currently is MAX_SCHEDULE_TIMEOUT on Linux 2.4.24.
Don't your changes muck this up or is "<0" checked somewhere
else?

>
> --- linux/fs/select.c	2004-02-20 14:27:24.784616879 -0500
> +++ linux/fs/select.c	2004-02-20 14:27:28.264660774 -0500
> @@ -316,6 +316,8 @@
>  		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-1) / HZ - 1) {
>  			timeout = ROUND_UP(usec, 1000000/HZ);
>  			timeout += sec * (unsigned long) HZ;
> +		} else {
> +			timeout = MAX_SCHEDULE_TIMEOUT-1;
>  		}
>  	}
>
> @@ -476,7 +478,7 @@
>  			if (seconds <= (MAX_SCHEDULE_TIMEOUT-2) / HZ - 1)
>  				timeout += seconds*HZ;
>  			else
> -				timeout = MAX_SCHEDULE_TIMEOUT;
> +				timeout = MAX_SCHEDULE_TIMEOUT-1;
>  		}
>  	}
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


