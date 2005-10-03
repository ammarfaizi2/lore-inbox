Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVJCNmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVJCNmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJCNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:42:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3758 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932212AbVJCNms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:42:48 -0400
Date: Mon, 3 Oct 2005 14:42:41 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051003134241.GV7992@ftp.linux.org.uk>
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net> <20051003094803.GC3500@home.fluff.org> <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com> <20051003100431.GA16717@flint.arm.linux.org.uk> <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:43:50PM +0300, Pekka Enberg wrote:
> On 10/3/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > It makes sense for kfree() to ignore NULL pointers, but does it really
> > make sense for *_unregister() to do so too?  Surely you want to only
> > unregister things which you know have previously been registered?
> 
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

Bullshit.  I have waded through many, *many* initialization sequences
like that.  "Lots of goto labels" is _less_ prone to breakage when
properly done; your variant begs for trouble upon the driver changes.

Note that "lots of goto" is actually a cleaner control structure than
what you propose - the amount of instances of offending statement is
far from being the only metrics.  The only things to verify with it are
	* releasing is done in the opposite order to claiming
	* you always exit to the releasing the last thing you've claimed.
Both are easy to maintain when you change the code _and_ do not break
when you need to introduce something like "keep the number of objects";
I've seen too many cases when release had done the things that can _not_
be made idempotent and still had been used in that manner.  With obvious
breakage resulting from it.

And such breakage is easily introduced when changing the code - it's more
common than forgetting to propagate change between release and failure
exits in initialization.
