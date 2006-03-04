Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWCDK6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWCDK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWCDK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:58:16 -0500
Received: from ozlabs.org ([203.10.76.45]:64441 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750886AbWCDK6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:58:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
Date: Sat, 4 Mar 2006 21:58:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> PPC has an absolutely _horrible_ memory ordering implementation, as far as 
> I can tell. The thing is broken. I think it's just implementation 
> breakage, not anything really fundamental, but the fact that their write 
> barriers are expensive is a big sign that they are doing something bad. 

An smp_wmb() is just an eieio on PPC, which is pretty cheap.  I made
wmb() be a sync though, because it seemed that there were drivers that
expected wmb() to provide an ordering between a write to memory and a
write to an MMIO register.  If that is a bogus assumption then we
could make wmb() lighter-weight (after auditing all the drivers we're
interested in, of course, ...).

And in a subsequent message:

> If so, a simple write barrier should be sufficient. That's exactly what 
> the x86 write barriers do too, ie stores to magic IO space are _not_ 
> ordered wrt a normal [smp_]wmb() (or, as per how this thread started, a 
> spin_unlock()) at all.

By magic IO space, do you mean just any old memory-mapped device
register in a PCI device, or do you mean something else?

Paul.
