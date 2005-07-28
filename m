Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVG1Gom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVG1Gom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 02:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVG1Gol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 02:44:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:26787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261274AbVG1Gol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:44:41 -0400
Date: Wed, 27 Jul 2005 22:49:14 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728054914.GA13904@kroah.com>
References: <9e473391050725172833617aca@mail.gmail.com> <20050726003018.GA24089@kroah.com> <9e47339105072517561f53b2f9@mail.gmail.com> <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com> <9e47339105072719057c833e62@mail.gmail.com> <20050728034610.GA12123@kroah.com> <9e473391050727205971b0aee@mail.gmail.com> <20050728040544.GA12476@kroah.com> <9e47339105072721495d3788a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072721495d3788a8@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 12:49:21AM -0400, Jon Smirl wrote:
> @@ -207,6 +208,28 @@ flush_write_buffer(struct dentry * dentr
>  	struct attribute * attr = to_attr(dentry);
>  	struct kobject * kobj = to_kobj(dentry->d_parent);
>  	struct sysfs_ops * ops = buffer->ops;
> +	char *x, *y, *z;
> +
> +	/* locate leading white space */
> +	x = buffer->page;
> +	while (isspace(*x) && (x - buffer->page < count))
> +		x++;

Ok, I can follow this.  For example
buffer->page = "  foo  "

then x = "foo  " at the end of that .

> +	/* locate trailng white space */
> +	z = y = x;
> +	while (y - buffer->page < count) {
> +		y++;
> +		z = y;
> +		while (isspace(*y) && (y - buffer->page < count)) {
> +			y++;
> +		}
> +	}
> +	count = z - x;

Hm, I _think_ this works, but I need someone else to verify this...
Anyone else?


> +
> +	/* strip the white space */
> +	if (buffer->page != x)
> +		memmove(buffer->page, x, count);
> +	buffer->page[count] = '\0';

Why move the buffer?  Why not just pass in a pointer to the start of the
"non-whitespace filled" buffer to the store() function?

thanks,

greg k-h
