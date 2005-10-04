Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVJDRzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVJDRzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVJDRzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:55:47 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:6812 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S964868AbVJDRzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:55:46 -0400
Date: Tue, 4 Oct 2005 19:55:43 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
In-Reply-To: <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com>
Message-ID: <Pine.LNX.4.60.0510041945260.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, linux-os (Dick Johnson) wrote:

> 
> On Tue, 4 Oct 2005, Martin Drab wrote:
> 
> > Hi,
> >
> > can anybody tell me why there is no sys_open() exported in kernel/ksyms.c
> > in 2.4 kernels while the sys_close() is there? And what is then the
> > preferred way of opening files from within a 2.4 kernel module?
> >
> > Thank you,
> > Martin
> 
> There is no way to open files within the kernel. Any attempt is
> just a hack. The kernel is designed to perform tasks on behalf
> of the caller. It doesn't have a context. It uses the caller's
> context. A file-descriptor is a number that relates to the
> current context. i.e., STDIN_FILENO is __different__ for you
> and somebody else, even though it has the same numerical value.

I know.

> To open a file in the kernel requires either a task with a
> context (like a kernel thread) or you have to steal the context
> of somebody which can destroy some innocent task's context.

No this should have been a well controlled situation within an ioctl call.
But I guess i should probably transfer this into the user-space, even 
though it means more data transfers to user-space from kernel space. OK, I 
got it.

> You are never supposed to use files inside the kernel; period!

Yes, yes, I got it. :-)

> If you need to obtain file-data for a driver or receive file-
> data from a driver, we have read(), write(), mmap(), and ioctl()

mmap() is actually what i wanted to do automatically without the need to 
transfer all the necessary data from the kernel to the user app, and then 
let the app do it all on its own. But I see now there is probably no other 
way but to let the app do it all. Especially given that I need to do some 
things within the driver before the mmap() - I guess that should be 
possibble to do from within the fops->mmap(), but I also need to do 
something upon munmap()ping. Where should I place that? There doesn't seem 
to be any function that would be called upon user munmap(). :(

> to accomplish these things from user-mode. A user-mode program can
> write data directly to your driver using mmap(), for instance.
> Or it can use a function-code you define to upload/download data
> using ioctl().
> 
> This is a FAQ. Many persons have rejected this advice, only
> to later on modify their drivers to correspond to the correct
> way of writing Unix/Linux device drivers. This, after they've
> trashed many innocent tasks.

OK, sorry for bothering. I'll try rewritin it somehow.

Martin
