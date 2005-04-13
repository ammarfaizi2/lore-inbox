Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDMLds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDMLds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDMLds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:33:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:56494 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261318AbVDMLdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:33:45 -0400
Subject: Re: Why system call need to copy the date from the userspace
	before using it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tomko <tomko@haha.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <425C9E55.6010607@haha.com>
References: <425C9E55.6010607@haha.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 21:33:27 +1000
Message-Id: <1113392007.5516.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 12:21 +0800, Tomko wrote:
> Hi all,
> 
> I am new to linux , hope someone can help me.
> While i am reading the source code of the linux system call , i find 
> that the system call need to call copy_from_user() to copy the data from 
> user space to kernel space before using it . Why not use it directly as 
> the system call has got the address ?  Furthermore , how to distinguish 
> between user space and kernel space ?

Well, there are more than one reason. But, in general, you always need
to access user memory using specific accessors, like copy_to/from_user,
get/put_user, etc... Some of these reasons are:

 - Userland can give you a bogus pointer. Doing a normal access from the
kernel via a bogus pointer can lead to all sort of funny things, which
you really do not want to happen. What if userland is giving a
destination pointer to the kernel that points to ... the kernel itself
or some of it's data structures ? that would be way to easy for userland
to cause the kernel to crash if the kernel "trusted" pointers from
userland. So one thing those functions do is to check the pointer to see
if it's within valid userland memory bounds

 - Even if within valid memory bounds, it may still be bogus, that is
point to a page that is not mapped, or a destination pointer pointing to
a read-only page, or all sort of other fault caused by accessing it.
Those special access functions are designed to "recover" from there
errors. Instead of the kernel crashing/Oops'ing because of the bad
access, the kernel page fault handler will "notice" that the access
comes from one of these special function and will do some black magic so
that instead of crashing, the access function will just return with an
error that can then be passed back to userspace (usually EFAULT).

 - Some architectures don't have user and kernel memory mapped at the
same time (think about x86 in 4G/4G mode for example). In that case,
accessing user memory requires some specific memory management tricks
that are architecture specific. Those functions take care of that.

There may even be more I don't have in mind at the moment, but the above
is already enough to justify having specific accessor functions for
kernel code to access userland originated pointers.

Ben.


