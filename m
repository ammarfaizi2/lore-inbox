Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUILSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUILSuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268788AbUILSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:50:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53418 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268786AbUILSuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:50:10 -0400
Date: Sun, 12 Sep 2004 11:49:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Alex Zarochentsev <zam@namesys.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       wli@holomorphy.com
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
 atomic_sub_and_test
Message-Id: <20040912114948.49095cd2.pj@sgi.com>
In-Reply-To: <20040912163352.GA27411@backtop.namesys.com>
References: <20040912031235.48c738ae.pj@sgi.com>
	<20040912163352.GA27411@backtop.namesys.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex writes:
> please try this patch:
> ...
> +++ reiser4-linux-2.6/fs/reiser4/flush_queue.c
> ...
> +#include <asm/atomic.h>

This patch doesn't help.

Both with and without this patch, I observe the following:

 1) include/asm/atomic.h is listed in fs/reiser4/.flush_queue.o.cmd
    (apparently it is included indirectly, even if not explicitly so)
 2) The command:
	make fs/reiser4/flush_queue.o
    produces the output:
	fs/reiser4/flush_queue.c: In function `end_io_handler':
	fs/reiser4/flush_queue.c:451: warning: implicit declaration of function `atomic_sub_and_test'
 3) include/asm/atomic.h (which is include/asm-sparc/atomic.h via the asm symlink)
    does _not_ mention atomic_sub_and_test
 4) include/asm-sparc64/atomic.h _does_ mention atomic_sub_and_test (and build ok)
 5) the final kernel link fails with:
	fs/built-in.o(.text+0x58618): In function `end_io_handler':
	: undefined reference to `atomic_sub_and_test'
	make[1]: *** [arch/sparc/boot/image] Error 1

I also saw an email from Bill Irwin go by, explaining that he did not
choose to add atomic_sub_and_test to include/asm-sparc/atomic.h, which
email is consistent with my observation that sparc atomic.h does not
define atomic_sub_and_test.

It would seem that your asm-sparc/atomic.h is not the same as mine.

I believe that mine is the one in 2.6.9-rc1-mm4, which is the same as
the latest one in Linus' bk tree, since its most recent change of:

  1.10 04/05/14 19:00:05 akpm@osdl.org[torvalds] +10 -0
  Implement atomic_inc_and_test() on various architectures

and continuing through now.  This atomic.h is 4550 bytes long, with an
md5sum of:

	90eb38997e21e579fc1cd1617180d630  include/asm-sparc/atomic.h

And, to repeat myself, it has no mention of atomic_sub_and_test.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
