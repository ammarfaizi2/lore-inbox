Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbUJ1JxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbUJ1JxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1Jv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:51:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:62392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262868AbUJ1Jup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:50:45 -0400
Date: Thu, 28 Oct 2004 02:48:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sorav Bansal <sbansal@stanford.edu>
Cc: tacetan@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: User/Kernel Pointer bug in sys_poll
Message-Id: <20041028024839.6a1e1064.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU>
References: <20041028052218.52478.qmail@web50207.mail.yahoo.com>
	<Pine.GSO.4.44.0410272246240.7124-100000@elaine9.Stanford.EDU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorav Bansal <sbansal@stanford.edu> wrote:
>
> Older x86 architectures (386 and before) allow the kernel to write to any
>  user location regardless of the write-protect bits.
> 
>  Hence, with this bug, a user program could write to the write-protected
>  region of its address space by calling the sys_poll system call and
>  setting the address and data values appropriately.

Nope.  The only significant difference between copy_from_user() and
__put_user() here is that copy_from_user() checks that the address is not
in the 0xc0000000-0xffffffff range.  __put_user() skips that check.

So

	if (copy_from_user(kaddr, addr, n))
		fail();
	__put_user(42, addr);

is safe.  We know that the address is in the 0x00000000-0xbfffffff range by
the time we call __put_user().  And if the page at *addr it not writeable
the kernel will take a fault.

So I see no hole.  But I wouldn't have coded it that way...
