Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbUBAWZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUBAWZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:25:22 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:52097 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S265466AbUBAWZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:25:19 -0500
Date: Sun, 1 Feb 2004 14:25:14 -0800
Message-Id: <200402012225.i11MPEN1009925@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: Linus Torvalds's message of  Sunday, 1 February 2004 13:41:48 -0800 <Pine.LNX.4.58.0402011333020.2229@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Lightweight deception
   (2) Impractical interruption socks
   (3) Impertinent piteous expectorants
   (4) Momentous penny cancer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and the thing is, it looks like the signal handling changes have totally
> made the child ignore the "exit_code" thing, unless I'm seriously
> misreading something.

The only time that exit_code has ever been consulted is in
get_signal_to_deliver after the thread has stopped to notify its ptracer
and then been resumed.  That is still the case.  So it's only being ignored
if the child is stopped in some other place and not there.  I don't see the
scenario where that could be happening without the explicit involvement of
user-level stop signals (i.e. not the implicit stops done by ptrace).

Your changes would be equivalent to an atomic combination of
"kill(child_pid, SIGKILL); PTRACE_DETACH(pid);".  That is different from
what PTRACE_KILL normally does, which leaves the dying child attached so
that it reports its death to the ptracer before the original parent.

I haven't really looked into the problem with Dan's test case yet (didn't
seem to reproduce, but I haven't tried a current and cruft-free kernel yet).  
But I don't see any problem with the implementation of PTRACE_KILL.


Thanks,
Roland
