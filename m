Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTKOFBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 00:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTKOFBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 00:01:36 -0500
Received: from ozlabs.org ([203.10.76.45]:21150 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261464AbTKOFBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 00:01:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.46013.862161.879144@cargo.ozlabs.ibm.com>
Date: Sat, 15 Nov 2003 16:03:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311141906160.9014-100000@home.osdl.org>
References: <16309.38562.950351.137425@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0311141906160.9014-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Why? Check out get_signal_to_deliver(). And grok the absolute horridness.

Yes, that is pretty special, isn't it. :)

> The rule is: the restart_block is _only_ meaningful if you return 
> -ERESTART_BLOCK. So at any other time it contains stale data.
> 
> > Am I missing something?  Perhaps we should reset restart_block.fn in
> > sys_{,rt_}sigreturn, or possibly in sys_restart_syscall.
> 
> You're missing that the only thing that ever looks at restart_block is the 
> code that is inside the signal handling of ERESTART_BLOCK.

... and sys_restart_syscall().  If your statement was true, why was it
so important to reset restart_block.fn when we deliver a signal?

Seems to me that we can get into a situation where we are in a signal
handler, and the interrupted state has (1) eip/nip pointing at a
system call instruction and (2) the syscall number register (eax/r0)
containing __NR_restart_syscall.  Now, if we get into this state we
will initially have restart_block.fn == do_no_restart_syscall.  But
that can get changed by the signal handler.

Now, when we resume that context we will call sys_restart_syscall
which will call restart_block.fn.  Which won't necessarily still point
to do_no_restart_syscall.  So I still think we have a problem.

Paul.
