Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUBUERp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUBUERp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:17:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:60330 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261531AbUBUENL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:13:11 -0500
Date: Fri, 20 Feb 2004 20:13:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][4/4] poll()/select() timeout behavior
Message-Id: <20040220201328.609fe4e2.akpm@osdl.org>
In-Reply-To: <20040220210452.GE1912@ti19.telemetry-investments.com>
References: <20040220210452.GE1912@ti19.telemetry-investments.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com> wrote:
>
> This patch forces select() to wait *at least* the specified timeout if
> no events have occurred, same as poll(). The SUSv3 man page for select(2)
> says:
> 
>    "If the timeout parameter is not a null pointer, it specifies a maximum
>    interval to wait for the selection to complete. If the specified
>    time interval expires without any requested operation becoming ready,
>    the function shall return."
> 
> Additionally:
> 
>    "If the requested timeout interval requires a finer granularity than
>    the implementation supports, the actual timeout interval shall be
>    rounded up to the next supported value."
> 
> Unfortunately, fixing the fencepost error places a hard lower limit of
> 1/HZ on the time slept, and increases the average minimum sleep time
> threefold, from 1/(2*HZ) jiffy to 3/(2*HZ).

I'm inclined to live with the current behaviour rather than
risk breaking existing apps.

> 
> --- linux/fs/select.c	2004-02-20 14:29:11.000000000 -0500
> +++ linux/fs/select.c	2004-02-20 14:30:18.326814232 -0500
> @@ -313,8 +313,8 @@
>  		if (sec < 0 || usec < 0 || usec >= 1000000)
>  			goto out_nofds;
>  
> -		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-1) / HZ - 1) {
> -			timeout = ROUND_UP(usec, 1000000/HZ);
> +		if ((unsigned long) sec < (MAX_SCHEDULE_TIMEOUT-2) / HZ - 1) {
> +			timeout = ROUND_UP(usec, 1000000/HZ) + 1;
>  			timeout += sec * (unsigned long) HZ;
>  		} else {
>  			timeout = MAX_SCHEDULE_TIMEOUT-1;
