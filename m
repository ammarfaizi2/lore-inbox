Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTDSQJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTDSQJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:09:51 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:63504 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263408AbTDSQJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:09:49 -0400
Date: Sat, 19 Apr 2003 18:21:47 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Private namespaces
Message-ID: <20030419162147.GB19740@win.tue.nl>
References: <1052141040.355.12.camel@labunix> <20030416132324.GA18700@win.tue.nl> <20030419145239.GL29143@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419145239.GL29143@iucha.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 09:52:39AM -0500, Florin Iucha wrote:

> I have compiled the sample program on 2.5.67-pre6 and it fails with
>    clone: Cannot allocate memory
> when run as a regular user. Is there a workaround?

Well, the comment says

"Exercise Play with this in several situations. You may have to be root."

and the source says

        if (! (flags & CLONE_NEWNS))
                return 0;

        if (!capable(CAP_SYS_ADMIN)) {
                put_namespace(namespace);
                return -EPERM;
        }

so there is not much hope for a regular user.

Now you ask: but why ENOMEM?
That is a tiny flaw in the kernel source.
I suppose

--- fork.c~     Tue Mar 25 04:54:46 2003
+++ fork.c      Sat Apr 19 18:21:44 2003
@@ -873,7 +873,8 @@
                goto bad_fork_cleanup_sighand;
        if (copy_mm(clone_flags, p))
                goto bad_fork_cleanup_signal;
-       if (copy_namespace(clone_flags, p))
+       retval = copy_namespace(clone_flags, p);
+       if (retval)
                goto bad_fork_cleanup_mm;
        retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
        if (retval)

would fix that.

Andries

