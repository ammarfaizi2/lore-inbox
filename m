Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUGAF4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUGAF4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 01:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUGAF4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 01:56:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:22435 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264045AbUGAF4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 01:56:32 -0400
Date: Wed, 30 Jun 2004 22:56:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: <200407010539.i615dYke017137@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406302250120.11212@ppc970.osdl.org>
References: <200407010539.i615dYke017137@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jun 2004, Roland McGrath wrote:
> 
> No, I am preserving the feature that the child doesn't go away in this case.
> ptraced threads always become zombies and let the ptracer see their exit
> notification and status value.  That is the way we want it to stay.

Umm.. This is not the "ptrace_list". This is the _regular_ child list.

Which means that a bad person can try to:
 - have "normal" children that are self-reaping.
 - _also_ have a self-reaping ptraced child.

Now those _normal_ children may go away, no?

> Linus makes the same point:
> > To let the tracer look at the exit code?
> > 
> > How would you otherwise see what exit code the child exited with?
> 
> In fact, the exit code is usually completely uninteresting for a
> CLONE_THREAD thread (after all, ptrace is the *only* way to see that value,
> so the _exit call didn't expect to pass useful information that way).

Hmm. That would argue for Andrea's patch.

> However, the reliable notification of the fact that the thread died is very
> useful for anything tracing/debugging it.

.. since this information should be available anyway (we'll have woken up 
the tracer, and the tracer will see that the child is gone by simply 
seeing the ESRCH errorcode from ptrace).

Wouldn't that be reliable enough?

So now I'm starting to lean towards Andrea's patch after all..

(Let no-one say that I don't change my mind when presented with good 
arguments. Some people complain that I change my mind _too_ often ;)

		Linus
