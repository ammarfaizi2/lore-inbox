Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVJCMuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVJCMuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 08:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJCMuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 08:50:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19472 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750785AbVJCMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 08:50:00 -0400
Date: Mon, 3 Oct 2005 13:49:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051003124950.GD16717@flint.arm.linux.org.uk>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net> <20051003094803.GC3500@home.fluff.org> <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com> <20051003100431.GA16717@flint.arm.linux.org.uk> <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:43:50PM +0300, Pekka Enberg wrote:
> Usually yes but it makes releasing partial initialization much simpler
> because you can  reuse the normal release counterpart. For example,
> 
> static int driver_init(void)
> {
>      dev->resource1 = request_region(...);
>      if (!dev->resource1)
>              goto failed;
> 
>      dev->resource2 = request_region(...);
>      if (!dev->resource2)
>              goto failed;
> 
>      return 0;
> 
> failed:
>      driver_release(dev);
>      return -1;
> }
> 
> static void driver_release(struct device * dev)
> {
>      release_resource(dev->resource1);
>      release_resource(dev->resource2);
>      kfree(dev);
> }
> 
> Many drivers have the release function copy-pasted to init with lots
> of goto labels exactly because release_region, iounmap, and friends
> aren't NULL safe.

And the above is buggy.  request_region() allocates memory.
release_resource() unregisters the resource but does _not_
free the allocated memory.

On the other hand, release_region() is the counter-part of
request_region() and should be used to release resources
created by request_region().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
