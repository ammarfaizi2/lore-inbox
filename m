Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCQW7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCQW7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVCQW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:59:41 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:45090 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261336AbVCQW7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:59:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZvbYF50MO4nYX3EN7L8FyEP5I/OwUP8zPdF9vQbj2FFx9u6dX6tuwuixr7VExItYe8f6urogNhyeBpLOtb7l8WoGsM8kA7nPqhdlG7N8hsZPPB8wtzUhx6HQCUSQnsu7Qcy1t4UrkKAxzjZ4VL9iXcY1OHvo5IiLurGIshU+GaU=
Message-ID: <29495f1d05031714596de3b335@mail.gmail.com>
Date: Thu, 17 Mar 2005 14:59:31 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Prezeroing V8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005 13:43:47 -0800 (PST), Christoph Lameter
<clameter@sgi.com> wrote:
> Changelog:
> - Drop clear_pages and the approach to zero pages of higher order
>   first
> - Zero a percentage of pages from all orders to avoid fragmentation
> 
> Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
> /proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
> scrubd.txt
> 
> In an SMP environment the scrub daemon is typically running on the most
> idle cpu. Thus a single threaded application running
> on one cpu may have the other cpu zeroing pages for it etc. The scrub
> daemon is hardly noticable and usually finishes zeroing quickly since
> most processors are optimized for linear memory filling.
> 
> Patch against 2.6.11.3-bk3
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 

<snip>

> Index: linux-2.6.11/mm/scrubd.c
> ===================================================================
> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.11/mm/scrubd.c    2005-03-17 13:12:23.000000000 -0800

<snip>

> +/*
> + * scrub_pgdat() will work across all this node's zones.
> + */
> +static void scrub_pgdat(pg_data_t *pgdat)
> +{
> +       int i;
> +
> +       if (system_state != SYSTEM_RUNNING)
> +               return;
> +
> +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT))
> +               schedule_timeout(30*HZ);

This is a busy-loop, unless you set the state before you call
schedule_timeout(). Additionally, you really want to sleep 30 seconds
at a time? Please use msleep() or msleep_interruptible(), unless you
expect wait-queue events.

Thanks,
Nish
