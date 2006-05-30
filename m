Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWE3QrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWE3QrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWE3QrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:47:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64542 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932294AbWE3QrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:47:22 -0400
Date: Tue, 30 May 2006 18:49:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: .17rc5 cfq slab corruption.
Message-ID: <20060530164917.GB4199@suse.de>
References: <20060526213915.GB7585@redhat.com> <20060526170013.67391a2b.akpm@osdl.org> <20060527070724.GB24988@suse.de> <20060527133122.GB3086@redhat.com> <20060530131728.GX4199@suse.de> <20060530161232.GA17218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530161232.GA17218@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Dave Jones wrote:
> On Tue, May 30, 2006 at 03:17:28PM +0200, Jens Axboe wrote:
>  > On Sat, May 27 2006, Dave Jones wrote:
>  > > On Sat, May 27, 2006 at 09:07:24AM +0200, Jens Axboe wrote:
>  > >  > On Fri, May 26 2006, Andrew Morton wrote:
>  > >  > > Dave Jones <davej@redhat.com> wrote:
>  > >  > > >
>  > >  > > > Was playing with googles new picasa toy, which hammered the disks
>  > >  > > > hunting out every image file it could find, when this popped out:
>  > >  > > > 
>  > >  > > > Slab corruption: (Not tainted) start=ffff810012b998c8, len=168
>  > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > >  > > > 090: 10 bd 28 1b 00 81 ff ff 6b 6b 6b 6b 6b 6b 6b 6b
>  > >  > > > Prev obj: start=ffff810012b99808, len=168
>  > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > >  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > >  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > >  > > > Next obj: start=ffff810012b99988, len=168
>  > >  > > > Redzone: 0x5a2cf071/0x5a2cf071.
>  > >  > > > Last user: [<ffffffff8032c319>](cfq_free_io_context+0x2f/0x74)
>  > >  > > > 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > >  > > > 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>  > >  > 
>  > >  > Pretty baffling... cfq has been hammered pretty thoroughly over the
>  > >  > last months and _nothing_ has shown up except some performance anomalies
>  > >  > that are now fixed. Since daves case (at least) seems to be
>  > >  > use-after-free, I'll see if I can reproduce with some contrived case.
>  > >  > I'm asuming that picasa forks and exits a lot with submitted io in
>  > >  > between than may not have finished at exit.
>  > > 
>  > > The second time I hit it, was actually during boot up.
>  > 
>  > Dave, do you have any io scheduler switching going on?
> 
> Here's something interesting (possibly unrelated).
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=193534
> 
> I added this patch to our devel kernel (based on 17rc5-git5 right now)
> 
> It's similar to the list_head debugging patch from -mm
> 
> --- linux-2.6.12/include/linux/list.h~	2005-08-08 15:34:50.000000000 -0400
> +++ linux-2.6.12/include/linux/list.h	2005-08-08 15:35:22.000000000 -0400
> @@ -5,7 +5,9 @@
>  
>  #include <linux/stddef.h>
>  #include <linux/prefetch.h>
> +#include <linux/kernel.h>
>  #include <asm/system.h>
> +#include <asm/bug.h>
>  
>  /*
>   * These are non-NULL pointers that will result in page faults
> @@ -52,6 +52,16 @@ static inline void __list_add(struct lis
>  			      struct list_head *prev,
>  			      struct list_head *next)
>  {
> +	if (next->prev != prev) {
> +		printk("List corruption. next->prev should be %p, but was %p\n",
> +				prev, next->prev);
> +		BUG();
> +	}
> +	if (prev->next != next) {
> +		printk("List corruption. prev->next should be %p, but was %p\n",
> +				next, prev->next);
> +		BUG();
> +	}
>  	next->prev = new;
>  	new->next = next;
>  	new->prev = prev;
> @@ -162,6 +162,16 @@ static inline void __list_del(struct lis
>   */
>  static inline void list_del(struct list_head *entry)
>  {
> +	if (entry->prev->next != entry) {
> +		printk("List corruption. prev->next should be %p, but was %p\n",
> +				entry, entry->prev->next);
> +		BUG();
> +	}
> +	if (entry->next->prev != entry) {
> +		printk("List corruption. next->prev should be %p, but was %p\n",
> +				entry, entry->next->prev);
> +		BUG();
> +	}
>  	__list_del(entry->prev, entry->next);
>  	entry->next = LIST_POISON1;
>  	entry->prev = LIST_POISON2;
> 
> 
> And then it turned up this:
> 
> List corruption. next->prev should be f74a5e2c, but was ea7ed31c
> Pointing at cfq_set_request.

I think I'm missing a piece of this - what list was corrupted, in what
function did it trigger?


-- 
Jens Axboe

