Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946650AbWKAGtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946650AbWKAGtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946642AbWKAGtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:49:53 -0500
Received: from 1wt.eu ([62.212.114.60]:1541 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1946650AbWKAGtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:49:53 -0500
Date: Wed, 1 Nov 2006 08:49:22 +0100
From: Willy Tarreau <w@1wt.eu>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH 49/61] ISDN: fix drivers, by handling errors thrown by ->readstat()
Message-ID: <20061101074922.GE543@1wt.eu>
References: <20061101053340.305569000@sous-sol.org> <20061101054422.145185000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101054422.145185000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:29PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Jeff Garzik <jeff@garzik.org>
> 
> This is a particularly ugly on-failure bug, possibly security, since the
> lack of error handling here is covering up another class of bug: failure to
> handle copy_to_user() return values.
> 
> The I4L API function ->readstat() returns an integer, and by looking at
> several existing driver implementations, it is clear that a negative return
> value was meant to indicate an error.
> 
> Given that several drivers already return a negative value indicating an
> errno-style error, the current code would blindly accept that [negative]
> value as a valid amount of bytes read.  Obvious damage ensues.
> 
> Correcting ->readstat() handling to properly notice errors fixes the
> existing code to work correctly on error, and enables future patches to
> more easily indicate errors during operation.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> Cc: Karsten Keil <kkeil@suse.de>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  drivers/isdn/i4l/isdn_common.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.18.1.orig/drivers/isdn/i4l/isdn_common.c
> +++ linux-2.6.18.1/drivers/isdn/i4l/isdn_common.c
> @@ -1134,9 +1134,12 @@ isdn_read(struct file *file, char __user
>  		if (dev->drv[drvidx]->interface->readstat) {
>  			if (count > dev->drv[drvidx]->stavail)
>  				count = dev->drv[drvidx]->stavail;
> -			len = dev->drv[drvidx]->interface->
> -				readstat(buf, count, drvidx,
> -					 isdn_minor2chan(minor));
> +			len = dev->drv[drvidx]->interface->readstat(buf, count,
> +						drvidx, isdn_minor2chan(minor));
> +			if (len < 0) {
> +				retval = len;
> +				goto out;
> +			}
>  		} else {
>  			len = 0;
>  		}

Seems appropriate for 2.4 too. Jeff, Karsten, no objection ?

Willy

