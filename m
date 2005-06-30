Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVF3W3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVF3W3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVF3W3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:29:00 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:20150 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263070AbVF3W2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:28:32 -0400
Date: Fri, 1 Jul 2005 00:28:28 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, arjan@infradead.org,
       miklos@szeredi.hu, linux-kernel@vger.kernel.org,
       Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: FUSE merging?
Message-ID: <20050630222828.GA32357@janus>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630124622.7c041c0b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:46:22PM -0700, Andrew Morton wrote:
> 
> - Frank points out that a user can send a sigstop to his own setuid(0)
>   task and he intimates that this could cause DoS problems with FUSE.  More
>   details needed please?

It's the other way around:
Apparently it is not a security problem to SIGSTOP or even SIGKILL a
setuid program. So why is it a security problem when such a program is
delayed by a supposedly malicious behaving FUSE mount?

I think that setuid programs take too many things for granted, especially
"time". I also think the ptrace equivalence principle (item C2 in the
FUSE doc) is too harsh for FUSE.

Suppose the process changes id to full root and we can no longer send
signals to it. Are there any other ways we could affect its scheduling
without FUSE? I think "yes", clearly not that easy as when it accesses a
FUSE mount but "yes". Think about typing ^S (XOFF), or by letting it read
from a pipe or from a file on a very very slow device. Or by renicing
the parent in advance. Regarding the pipe: yes the setuid program could
check that with fstat() but is such a check fundamentally the right
approach? I have doubt because unified I/O is a good thing and there is
no guarantee whatsoever about completion of any FS operation within a
certain amount of time. Suppose another malicious process does a lookup
in a huge directory without hashed names? What about a process consuming
lots of memory, pushing everything else into swap? What about deleting
a _huge_ file or do other things which might(?) take a considerable
amount of kernel time? [id]notify might even help using this to delay
a root process at a crucial point to exploit a race. So, I think there
are many ways to affect the execution speed of [setuid] programs. I
have never heard of a setuid root program which renices itself, such,
that it successfully avoids a race or DoS exploit.

And then the DoS thing using simulated endless files within FUSE. It is
already possible to create terabyte sized [sparse] files. Can the fstat()
size/blocks info be trusted from FUSE? no more than fstat() outside FUSE
because the file may still be growing!

> - I don't recall seeing an exhaustive investigation of how an
>   unprivileged user could use a FUSE mount to implement DoS attacks against
>   other users or against root.

In general I think it is _hard_ to protect against a local DoS for many
reasons and I don't see any new fundamental problem here with FUSE:
it is just making it more obvious that it's hard to write secure setuid
programs. Those programs should _know_ that input data and anything else
from the user is "tainted" and that they must be _very_ careful with it,
in every detail.

-- 
Frank
