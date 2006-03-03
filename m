Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWCCWhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWCCWhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWCCWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:37:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751748AbWCCWg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:36:59 -0500
Date: Fri, 3 Mar 2006 14:36:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin LaHaise <bcrl@linux.intel.com>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, mingo@redhat.com, jblunck@suse.de, matthew@wil.cx,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <Pine.LNX.4.64.0603031415330.22647@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603031429320.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>
 <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com>
 <5041.1141417027@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603031332140.22647@g5.osdl.org>
 <20060303215114.GA13893@linux.intel.com> <Pine.LNX.4.64.0603031415330.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Mar 2006, Linus Torvalds wrote:
>
> I suspect you have some bug in your implementation. I think Dekker's 
> algorithm depends on the reads and writes being ordered, and you don't 
> seem to do that.

IOW, I think you need a full memory barrier after the 
	"lock->turn = cpu ^ 1;"
and you should have a "smp_rmb()" in between your reads of
	"lock->flags[cpu ^ 1]"
and
	"lock->turn"
to give the ordering that Dekker (or Peterson) expects.

IOW, the code should be something like

	lock->flags[other] = 1;
	smp_wmb();
	lock->turn = other
	smp_mb();
	while (lock->turn == cpu) {
		smp_rmb();
		if (!lock->flags[other])
			break;
	}

where the wmb's are no-ops on x86, but the rmb's certainly are not.

I _suspect_ that the fact that it starts working with an 'sfence' in there 
somewhere is just because the sfence ends up being "serializing enough" 
that it just happens to work, but that it has nothing to do with the 
current kernel wmb() being wrong.

		Linus
