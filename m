Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVLCC1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVLCC1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVLCC1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:27:49 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:6876 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751166AbVLCC1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:27:48 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20051203021154.30862.qmail@web32113.mail.mud.yahoo.com>
References: <20051203021154.30862.qmail@web32113.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 21:27:39 -0500
Message-Id: <1133576859.4894.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 18:11 -0800, Vinay Venkataraghavan wrote:

> > 
> > Hmm, I've only worked with a few platforms (i386,
> > x86_64, ppc, mips, and
> > a little arm but I don't remember that much).  I
> > believe that a memcpy
> > could work on all these platforms (error prone of
> > course, but if the
> > memory is mapped its OK).  
> 
> When entering a system
> > call, the kernel still
> > has access to the memory locations assigned to the
> > user.
> > 
> 
> But this is not always the case right. 

Right.

> The point that
> you mention above is specifically why I posted this
> question. It could well be the case that the   user
> space page could be swapped out when the user space
> process is blocked. So when the ioctl is serviced in
> kernel space, there is no guarantee that the page is
> still mapped. This could cause a page fault. 
> I think this is why we need to do a
> copy_to_user/copy_from_user.

Yes that is a reason to use copy_to/from_user, and it also checks to see
if the memory being used is allowed by the user.

> 
> The piece of code that I am talking about is part of a
> driver code. Unfortunately I am not at liberty to
> divulge the name of the company. So in the driver then
> are not using copy_to_user and copy_from_user. That is
> what puzzles me. Moreover, where they are using these
> functions they use memcpy which is a big security
> risk.

Sounds like the authors of this driver don't know Linux kernel
programming very well.  If you want to test it, I would write a userland
program that uses this ioctl and pass in a bad pointer (NULL or better
yet, the location of schedule found in System.map).  If the machine
crashes, you got your answer ;)  Passing in an address of code might not
crash right away.  You may need to wait till the data cache writes it
out to memory, and the instruction cache reads it.  These two caches are
not always in sync on all platforms.

-- Steve


