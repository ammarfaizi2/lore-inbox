Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWEVLfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWEVLfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWEVLfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:35:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWEVLfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:35:21 -0400
Date: Mon, 22 May 2006 04:35:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3
Message-Id: <20060522043502.5a271f81.akpm@osdl.org>
In-Reply-To: <200605221325.10761.mb@bu3sch.de>
References: <20060522022709.633a7a7f.akpm@osdl.org>
	<200605221115.k4MBFq42013901@turing-police.cc.vt.edu>
	<200605221325.10761.mb@bu3sch.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mb@bu3sch.de> wrote:
>
> On Monday 22 May 2006 13:15, you wrote:
> > On Mon, 22 May 2006 02:27:09 PDT, Andrew Morton said:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/
> > 
> > Mostly works, am chasing down 3 small things (all 3 were new as of -mm2 - I was
> > busy chasing them when -mm3 showed up).
> > 
> > 1) Something has gone astray in the hardware RNG rework.  /sbin/rngd was
> > quite happy dealing with the i810 RNG in my laptop under -rc4-mm1, but under
> > -mm2 and -mm3, I get this (from strace /bin/rngd):
> > 
> > open("/dev/hw_random", O_RDONLY)        = 3
> > read(3, "q\252cg", 4)                   = 4
> > read(3, 0xbfaf56ac, 4)                  = -1 EAGAIN (Resource temporarily unavai lable)
> > 
> > It works for some number of reads, but eventually pulls an EAGAIN.  When
> > stracing on a console that was slow-to-scroll, it did several dozen before
> > failing - so it's apparently a timing thing.  I stuck a debugging printk
> > in just before the test that returns EAGAIN, and got this:
> > 
> > [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> > [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> > [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> > [   68.361000] rng_read data_present=1 i=0 bytes_read=1
> > [   68.361000] rng_read data_present=0 i=20 bytes_read=0
> > 
> > It looks to me line the old code stayed in a while() loop in rng_dev_read
> > until it had fulfilled the read request (including possibly multiple
> > calls to need_resched() and friends).  The new code will bail on an -EAGAIN
> > as soon as the *first* poll fails, rather than waiting until something
> > is available - even if it is NOT flagged O_NONBLOCK.
> 
> Yeah. That is how it works. I am wondering why userspace doesn't
> simply retry, if it receives an EAGAIN.
> Should we return ERESTARTSYS or something like that instead?

Heaven alone knows what that would do.

Let's just retain the present behaviour, please.  Don't break stuff.  Or,
if we really do need to break stuff, we do it with lengthy lead times and
with elaborate process (such as, for example, creating /dev/hw_random-2 and
waiting for userspace to migrate to that, then deprecating /dev/hw_random).

