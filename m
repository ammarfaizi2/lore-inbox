Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUE0Otf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUE0Otf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUE0Otf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:49:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4745
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264628AbUE0OtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:49:21 -0400
Date: Thu, 27 May 2004 16:49:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       mingo@elte.hu, riel@redhat.com, torvalds@osdl.org, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527144916.GE3889@dualathlon.random>
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it> <1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it> <206b3-5WN-33@gated-at.bofh.it> <20baw-1Lz-15@gated-at.bofh.it> <m38yff7zn3.fsf@averell.firstfloor.org> <20040527112705.GA21190@wohnheim.fh-wedel.de> <20040527134950.GB3889@dualathlon.random> <20040527141547.GC23194@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040527141547.GC23194@wohnheim.fh-wedel.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 04:15:47PM +0200, Jörn Engel wrote:
> On Thu, 27 May 2004 15:49:50 +0200, Andrea Arcangeli wrote:
> > On Thu, May 27, 2004 at 01:27:05PM +0200, Jörn Engel wrote:
> > > Cool!  If that is included, I don't have any objections against 4k
> > > stacks anymore.
> > 
> > note that it will introduce an huge slowdown, there's no way to enable
> > that in production. But for testing it's fine.
> 
> Would it be possible to add something short to the function preamble
> on x86 then?  Similar to this code, maybe:
> 
> if (!(stack_pointer & 0xe00))	/* less than 512 bytes left */
> 	*NULL = 1;
> 
> Not sure how this can be translated into short and fast x86 assembler,
> but if it is possible, I would really like to have it.  Then all we
> have left to do is make sure no function ever uses more than 512
> bytes.  Famous last words, I know.

If it would be _inlined_ it would be *much* faster, but it would likely
be measurable anyways. Less measurable though. There's no way with gcc
to inline the above in the preamble, one could hack gcc for it though
(there's exactly an asm preable thing in gcc that is the one that is
currently implemented as call mcount plus the register saving, chaning
it to the above may be feasible, though it would need a new option in
gcc)

another nice thing to have (this one zerocost at runtime) would be a
way to set a limit on the size of the local variables for each function.
gcc knows that value very well, it's the sub it does on the stack
pointer the first few asm instructions after the call.  That would
reduce the common mistakes.  An equivalent script is the one from Keith
Owens checking the vmlinux binary after compilation but I'm afraid
people runs that one only after the fact.
