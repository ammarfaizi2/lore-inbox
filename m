Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422862AbWJPTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbWJPTeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJPTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:34:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56785 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422856AbWJPTeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:34:21 -0400
Date: Mon, 16 Oct 2006 20:34:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: mfbaustx <mfbaustx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy_from_user / copy_to_user with no swap space
Message-ID: <20061016193419.GE29920@ftp.linux.org.uk>
References: <op.thi3x1mvnwjy9v@titan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.thi3x1mvnwjy9v@titan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 02:19:03PM -0500, mfbaustx wrote:
> stacks start high and grow down.  Somewhere in there you get your heap and  
> shared memory regions.  Since noting about a logical address can identify  
> a specific process, then copy_to/from_user can do nothing to guaruntee  
> that the CORRECT process is paged in.  True?  So you're absolutely  
> obligated to DO the copy at the time the kernel is executing on behalf of  
> that process.  Once your process/thread is context swapped, you've lost  
> the [correct] information on the address mapping.
> 
> So, IF you MUST copy_from/to_user when in the context of the process, AND  
> IF you have no virtual memory/swapping, THEN must it not be true that you  
> can ALWAYS dereferences your user space pointers?

First of all, kernel and userland don't have to be in the same address
space at all; not even on x86 in some configuration.  So dereferencing
user pointer as if it had been a normal pointer simply won't work - what
you'll get might have nothing to do with any user memory.

But even aside of that, even on architectures where kernel and userland
_do_ share address space, there's nothing to guarantee that any given
piece of user address space is currently present or has ever been paged
in to start with.

Dereference that and you'll get an exception.  If you take a look at
the guts of e.g. arch/i386/lib/usercopy.c, you'll see stuff going to
.fixup section; when you call e.g. get_user() on address in a page that
is currently not paged in, exception *is* generated and handled; then
control is returned back to where we'd taken it.

IOW, even low-level code on such targets has to be careful; blind dereferencing
would simply get you an oops.  On something like ppc it's simply out of
question - there you would be able to trigger reads from memory-mapped
registers of hell knows what hardware.  From userland.  Confusing the
living fsck out of hardware and drivers...  _And_ you'd get access to
genuine kernel data.
