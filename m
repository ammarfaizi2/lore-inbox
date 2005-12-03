Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVLCDXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVLCDXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 22:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVLCDXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 22:23:50 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:5043 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751173AbVLCDXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 22:23:49 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43910731.4090404@shaw.ca>
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
	 <43910731.4090404@shaw.ca>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 22:23:45 -0500
Message-Id: <1133580225.4894.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't strip CC's

On Fri, 2005-12-02 at 20:47 -0600, Robert Hancock wrote:
> Vinay Venkataraghavan wrote:
> > But this is not always the case right. The point that
> > you mention above is specifically why I posted this
> > question. It could well be the case that the   user
> > space page could be swapped out when the user space
> > process is blocked. So when the ioctl is serviced in
> > kernel space, there is no guarantee that the page is
> > still mapped. This could cause a page fault. 
> > I think this is why we need to do a
> > copy_to_user/copy_from_user.
> 
> I don't think this is actually the case. I'm not entirely sure, but I 
> believe that if memcpy from user space works at all on a platform, then 
> if the page is swapped out it will still get swapped in when needed. In 
> any case, this is not the main reason for using these functions. The 
> main reason is that memory addresses passed from userspace might not be 
> valid at all, and reading these addresses directly would cause a kernel 
> oops in that case. These functions set up an exception handler so that 
> invalid address reads/writes return failure instead of crashing the system.

Nope, the kernel is always locked into memory.  If you take a page fault
from the kernel world, you will crash and burn. The kernel is never
"swapped out".  So if you are in kernel mode, going into do_page_fault
in arch/i386/mm/fault.c there is no path to swap a page in.  Even the
vmalloc_fault only handles a page not in the page global descriptor of
the current task.  But if this page is not mapped somewhere in memory
(not swapped out), you will get a kernel oops.

Kernel memory may never be swapped out. What happens if an interrupt
tries to use such memory. How does it handle sleeping?

Just change copy_to_user into memcopy, and see how long your system
stays up and running.  Do it on a machine that you don't need to worry
about rogue applications.  It won't last very long.

-- Steve


