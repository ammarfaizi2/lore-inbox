Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTFRMNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTFRMNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:13:13 -0400
Received: from dp.samba.org ([66.70.73.150]:53215 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265179AbTFRMNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:13:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.23143.230698.175126@nanango.paulus.ozlabs.org>
Date: Wed, 18 Jun 2003 22:26:15 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: copy_from_user
In-Reply-To: <20030618003110.6a9751a5.akpm@digeo.com>
References: <16112.2991.972670.344808@cargo.ozlabs.ibm.com>
	<20030618003110.6a9751a5.akpm@digeo.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> This was not deliberate - the memset simply got lost.
> 
> It is simple enough to fix.  Do we remember the details of the
> security hole?

My memory is a little hazy since it is several years ago, but as I
remember it, when you did a write on a pipe, the code would do
copy_from_user and not check the return value.  So, if you did a write
from an unmapped address, and then a read from the pipe, you would get
whatever was in the page that the kernel had allocated as the pipe
buffer.  Tridge had a program that would read out the contents of most
of kernel memory by doing this (I think he had a loop that created a
pipe, did a 4k write from a bad address and then a 4k read, then close
the pipe).  IIRC it relied on the kernel usually using a different
page for each pipe.

The primary fix was of course to make the pipe code check the return
value from copy_from_user and return an EFAULT error.  But the
question was then, how many other places were there that did the same
thing?  So the zeroing of the destination was added as a backup to
make sure that we wouldn't leak the contents of kernel memory as a
result of not checking the result from copy_from_user.  It's a
belt-and-braces kind of thing really.

> > or if the size is 1, 2 or 4.
> 
> This one is OK - __get_user_asm() does the zeroing in the fixup code.

Ah, good.  Maybe ppc should do that too. :)

Paul.
