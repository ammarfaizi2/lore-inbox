Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCNXNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCNXNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVCNXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:13:37 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:34485
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262022AbVCNXNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:13:06 -0500
Date: Mon, 14 Mar 2005 15:11:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hugh@veritas.com
Subject: Re: bad pgd/pmd in latest BK on ia64
Message-Id: <20050314151142.716903cb.davem@davemloft.net>
In-Reply-To: <20050314143442.2ab086c9.davem@davemloft.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
	<20050314143442.2ab086c9.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 14:34:42 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> On Mon, 14 Mar 2005 14:06:09 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > Trying to boot a build of the latest BK on ia64 I see
> > a series of messages like this:
> > 
> > mm/memory.c:99: bad pgd e0000001feba4000.
> > mm/memory.c:99: bad pgd e0000001febac000.
> > mm/memory.c:99: bad pgd e0000001febc0d10.
> 
> Things are similarly busted on sparc64 for me as well.
> Things instantly reboot right after the kernel tries
> to open an initial console.

As a followup, when I get an instant reboot like this
it usually means that some loop walking over memory
doesn't terminate properly.  Once the first access to
bogus I/O addresses (past the end of physical RAM)
happens, the machine soft reboots.

I therefore suspect the pgwalk patches.

One thing to note on sparc64 (I'm not sure on ia64) is
that the address passed into handle_mm_fault() can have
non-PAGE_MASK bits set in it (these are state bits from
the MMU miss handlers).

Does ia64 cause something similar to happen?

This never caused problems before, but it may be causing
troubles with the new pgwalk macros.  For example, the
new do { } while() loops test for exactness in the loop
termination test.  If there are low bits set in "addr",
we'll walk right past "end" in the loops and go on like
that forever.

I cannot, however, yet see a path where the handle_mm_fault()
address gets passed into the new pgwalk macro loops.  That
is what I'm searching for now :-)
