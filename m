Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267024AbUBRXqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267068AbUBRXqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:46:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58852
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267024AbUBRXqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:46:44 -0500
Date: Thu, 19 Feb 2004 00:46:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Raphael Rigo <raphael.rigo@inp-net.eu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: New do_mremap vulnerabitily.
Message-ID: <20040218234639.GT4478@dualathlon.random>
References: <4033841A.6020802@inp-net.eu.org> <Pine.LNX.4.58.0402180954590.2686@home.osdl.org> <4033E3A4.80509@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4033E3A4.80509@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 05:13:56PM -0500, Chris Friesen wrote:
> Linus Torvalds wrote:
> 
> >Fixed in 2.6.3 and 2.4.25 (and, I think, vendor kernels), please upgrade
> >if you allow local shell access to untrusted users.
> 
> There is still a call to do_munmap() that does not check the return 
> code, called from move_vma(), which in turn is called in do_mremap().
> 
> Can that call ever fail and cause Bad Things to happen?

it shouldn't cause bad things, it may generate a corrupt address space
from userspace point of view (the original vma will be stil there), but
it's like if you did one more mmap, so it's only a problem if you can
drive the app to buffer overflow or something like that because of this
corrupted address space. So it's only an userspace issue with real apps,
and with real apps the only thing that can make munamp fail is an oom
which is near to impossible for you to oom the app exactly in this
do_munmap call, the by far highest probability is that the first oom
will happen in the page faults, not in the syscalls.

> If we know that its never going to fail, it might be useful to have a 
> comment explaining it so we don't open up more exploits in the future.

the whole code needs a revamp for example for when the pagetables cannot
be allocated and the merging isn't retired (similar problem to the
do_munmap you mentioned above and there are other issues like that),
mremap simply isn't retiring correctly in presence of oom errors, that's
only an userspace issue, no way to exploit the kernel with that, we've
to fix it for 2.6 to provide perfect retirement from oom (basically only
a pratical matter with full overcommit but anyways). For 2.4 where the
thing will go in production the next day, going with the bandaid from
Solar was the simplest and in turn safest solution without risk of
regression.
