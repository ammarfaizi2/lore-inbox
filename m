Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWEAFp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWEAFp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWEAFp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:45:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbWEAFp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:45:58 -0400
Date: Sun, 30 Apr 2006 22:44:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking
 metadata clean, and make it configurable.
Message-Id: <20060430224404.1060d29a.akpm@osdl.org>
In-Reply-To: <1060501053019.22949@suse.de>
References: <20060501152229.18367.patches@notabene>
	<1060501053019.22949@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> 
> When a md array has been idle (no writes) for 20msecs it is marked as
> 'clean'.  This delay turns out to be too short for some real
> workloads.  So increase it to 200msec (the time to update the metadata
> should be a tiny fraction of that) and make it sysfs-configurable.
> 
> 
> ...
> 
> +   safe_mode_delay
> +     When an md array has seen no write requests for a certain period
> +     of time, it will be marked as 'clean'.  When another write
> +     request arrive, the array is marked as 'dirty' before the write
> +     commenses.  This is known as 'safe_mode'.
> +     The 'certain period' is controlled by this file which stores the
> +     period as a number of seconds.  The default is 200msec (0.200).
> +     Writing a value of 0 disables safemode.
> +

Why not make the units milliseconds?  Rename this to safe_mode_delay_msecs
to remove any doubt.

> +static ssize_t
> +safe_delay_store(mddev_t *mddev, const char *cbuf, size_t len)
> +{
> +	int scale=1;
> +	int dot=0;
> +	int i;
> +	unsigned long msec;
> +	char buf[30];
> +	char *e;
> +	/* remove a period, and count digits after it */
> +	if (len >= sizeof(buf))
> +		return -EINVAL;
> +	strlcpy(buf, cbuf, len);
> +	buf[len] = 0;
> +	for (i=0; i<len; i++) {
> +		if (dot) {
> +			if (isdigit(buf[i])) {
> +				buf[i-1] = buf[i];
> +				scale *= 10;
> +			}
> +			buf[i] = 0;
> +		} else if (buf[i] == '.') {
> +			dot=1;
> +			buf[i] = 0;
> +		}
> +	}
> +	msec = simple_strtoul(buf, &e, 10);
> +	if (e == buf || (*e && *e != '\n'))
> +		return -EINVAL;
> +	msec = (msec * 1000) / scale;
> +	if (msec == 0)
> +		mddev->safemode_delay = 0;
> +	else {
> +		mddev->safemode_delay = (msec*HZ)/1000;
> +		if (mddev->safemode_delay == 0)
> +			mddev->safemode_delay = 1;
> +	}
> +	return len;

And most of that goes away.


