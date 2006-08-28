Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWH1Em1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWH1Em1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 00:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWH1Em0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 00:42:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751288AbWH1Em0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 00:42:26 -0400
Date: Sun, 27 Aug 2006 21:41:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Solar Designer <solar@openwall.com>
Cc: Julio Auto <mindvortex@gmail.com>, Willy Tarreau <w@1wt.eu>,
       linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Message-Id: <20060827214141.db40620d.akpm@osdl.org>
In-Reply-To: <20060828035556.GA27902@openwall.com>
References: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com>
	<20060828035556.GA27902@openwall.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 07:55:56 +0400
Solar Designer <solar@openwall.com> wrote:

> On Thu, Aug 24, 2006 at 03:41:00AM -0300, Julio Auto wrote:
> > this is my porting (to 2.6.x) of the loop.c issue reported and patched
> > by Solar Designer, to whom all credits of the original idea to the
> > patch go (more info in the original "[PATCH] loop.c: kernel_thread()
> > retval check" e-mail thread).
> 
> The patch looks good to me, although I did not test it.
> 
> > Honestly, I couldn't test it on other computers, but mine. But the
> > tests were made against a stock (unmodified) 2.6.17.9 kernel and the
> > patch works like it should. Nevertheless, a second thought/review is
> > always appreciated.
> 
> I think that testing this on a single machine is fine, but it is
> preferable that you also check for any resource leaks.  That is, replace
> the kernel_thread() call with -EAGAIN, then run losetup in a loop and
> see whether the system possibly leaks a resource.  I did apply this sort
> of testing to my original 2.4 patch.
> 
> > Signed-off-by: Julio Auto <mindvortex@gmail.com>
> 
> Acked-by: Solar Designer <solar@openwall.com>
> 
> > --- drivers/block/loop.c.orig	2006-08-23 11:44:51.000000000 -0700
> > +++ drivers/block/loop.c	2006-08-24 00:33:54.000000000 -0700
> > @@ -841,10 +841,20 @@ static int loop_set_fd(struct loop_devic
> > 
> > 	error = kernel_thread(loop_thread, lo, CLONE_KERNEL);
> > 	if (error < 0)
> > -		goto out_putf;
> > +		goto out_clr;
> > 	wait_for_completion(&lo->lo_done);
> > 	return 0;
> > 
> > + out_clr:
> > +	lo->lo_device = NULL;
> > +	lo->lo_flags = 0;
> > +	lo->lo_backing_file = NULL;
> > +	set_capacity(disks[lo->lo_number], 0);
> > +	invalidate_bdev(bdev, 0);
> > +	bd_set_size(bdev, 0);
> > +	mapping_set_gfp_mask(mapping, lo->old_gfp_mask);
> > +	lo->lo_state = Lo_unbound;
> > +
> >  out_putf:
> > 	fput(file);
> >  out:
> 

The plan is to stop using the deprecated kernel_thread() in loop altogether.

Please review

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/kthread-convert-loopc-to-kthread.patch

