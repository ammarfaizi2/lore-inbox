Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVJRTJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVJRTJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJRTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:09:25 -0400
Received: from aun.it.uu.se ([130.238.12.36]:1967 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751081AbVJRTJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:09:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.18486.209678.977162@alkaid.it.uu.se>
Date: Tue, 18 Oct 2005 21:08:38 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: usb: Patch for USBDEVFS_IOCTL from 32-bit programs
In-Reply-To: <1129661516.2779.25.camel@laptopd505.fenrus.org>
References: <20051017181554.77d0d45d.zaitcev@redhat.com>
	<20051018171333.GA29504@kroah.com>
	<20051018114933.276781da.zaitcev@redhat.com>
	<1129661516.2779.25.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
 > On Tue, 2005-10-18 at 11:49 -0700, Pete Zaitcev wrote:
 > 
 > > 
 > > The problem here is that compat_ptr does NOT turn user data pointer
 > > into a kernel pointer. It's still a user pointer, only sized
 > > differently. So, when you do set_fs(KERNEL_DS), this pointer
 > > is invalid (miraclously, it does work on AMD64, so Dell's tests
 > > pass on their new Xeons).
 > > 
 > > So, you cannot simply to have a small shim. Instead, you have to allocate
 > > the buffer, do copy_from_user(), and then call the ioctl. But then,
 > > it would be a double-copy, when the ioctl allocates the buffer again.
 > > 
 > > I tweaked this in various ways, and the patch I posted looks like
 > > the cleanest solution. But please tell me if I miss something obvious.
 > 
 > 
 > there is one more option; allocate on the user stack space for a 64 bit
 > struct, then copy_in_user() the fields to that and then pass the new
 > pointer to the 64 bit struct to the ioctl.....

Doesn't work and it would break user-space.
Case 1 is when the user stack pointer is at or very near the limit
of the available address space for the user stack, and the next page
is not available for expanding the stack.
Case 2 is when user-space manages its own threads and stacks, using
sigaltstack() to ensure that signal handlers execute elsewhere. Assume
the user stack pointer is at or near the limit of the currently allocated
stack. Having the kernel write to memory beyond the user's stack pointer
can then easily clobber some unrelated user data structure.

So please don't do this.

/Mikael
