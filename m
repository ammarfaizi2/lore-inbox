Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSKGTZZ>; Thu, 7 Nov 2002 14:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSKGTZZ>; Thu, 7 Nov 2002 14:25:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261522AbSKGTZY>;
	Thu, 7 Nov 2002 14:25:24 -0500
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <m14ratepbf.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> 
	<m14ratepbf.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Nov 2002 11:32:36 -0800
Message-Id: <1036697556.10457.254.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 00:50, Eric W. Biederman wrote:

> In staging the image we allocate a whole pile of pages, and keep them
> locked in place.  Waiting for years potentially until the machine
> reboots or panics.   This memory is not accounted for anywhere so no
> one can see that we have it allocated, which makes debugging hard.
> Additionally in locking up megabytes for a long period of time we
> create unsolvable fragmentation issues for the mm layer to deal with.

Just an idea:

Could a new, unrunnable process be created to "hold" the image?

<hand-wave>
Use a hypothetical sys_kexec() to:
1. create an empty process.
2. copy the kernel image and parameters into the processes' address
space.
3. put the process to sleep.
</hand-wave>

If it's floating out there for weeks or years, the data could get paged
out and not wired down.  It would show up in ps, so you'd have at least
some visibility into the allocation.

Change your mind?  Kill the process.

It might be complicated (or unworkable) to handle the panic case
properly, but for the case where a fast reboot is requested by calling
sys_reboot(), one should be able to fault-in and read back the image
from the "kexec holder" process' address space, copying it to the final
destination as you go.

You might even be able to go the next step, and if the process were
crafted carefully, waking it and running it would trigger the "copyin,
quiesce, and go" behavior.

Just a thought.

Andy


