Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVJYH4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVJYH4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVJYH4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:56:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40722 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932081AbVJYH4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:56:03 -0400
Date: Tue, 25 Oct 2005 08:55:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Message-ID: <20051025075555.GA25020@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com> <20051022170240.GA10631@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 10:45:04PM -0400, Nicolas Pitre wrote:
> On Sat, 22 Oct 2005, Russell King wrote:
> > Please contact Nicolas Pitre about that - that was my suggestion,
> > but ISTR apparantly the overhead is too high.
> 
> Going through a kernel buffer will simply double the overhead.  Let's 
> suppose it should not be a big enough issue to stop the patch from being 
> merged though (and it looks cleaner that way). However I'd like for the 
> WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user 
> buffers should be 64-bit aligned.

The WARN_ON is pointless because we guarantee that the stack is always
64-bit aligned on signal handler setup and return.

> I don't see how standard COW could not happen.  The only difference with 
> a true write fault as if we used put_user() is that we bypassed the data 
> abort vector and the code to get the FAR value.  Or am I missing 
> something?

pte_write() just says that the page _may_ be writable.  It doesn't say
that the MMU is programmed to allow writes.  If pte_dirty() doesn't
return true, that means that the page is _not_ writable from userspace.
If you write to it from kernel mode (without using put_user) you'll
bypass the MMU read-only protection and may end up writing to a page
owned by two separate processes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
