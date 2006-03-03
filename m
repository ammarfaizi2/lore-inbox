Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWCCQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWCCQES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWCCQES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:04:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030224AbWCCQEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:04:15 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, jblunck@suse.de,
       bcrl@linux.intel.com, matthew@wil.cx
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Memory barriers and spin_unlock safety
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 03 Mar 2006 16:03:00 +0000
Message-ID: <32518.1141401780@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We've just had an interesting discussion on IRC and this has come up with two
unanswered questions:

(1) Is spin_unlock() is entirely safe on Pentium3+ and x86_64 where ?FENCE
    instructions are available?

    Consider the following case, where you want to do two reads effectively
    atomically, and so wrap them in a spinlock:

	spin_lock(&mtx);
	a = *A;
	b = *B;
	spin_unlock(&mtx);

    On x86 Pentium3+ and x86_64, what's to stop you from getting the reads
    done after the unlock since there's no LFENCE instruction there to stop
    you?

    What you'd expect is:

	LOCK WRITE mtx
	--> implies MFENCE
	READ *A		} which may be reordered
	READ *B		}
	WRITE mtx

    But what you might get instead is this:

	LOCK WRITE mtx
	--> implies MFENCE
	WRITE mtx
	--> implies SFENCE
	READ *A		} which may be reordered
	READ *B		}

    There doesn't seem to be anything that says that the reads can't leak
    outside of the locked section; at least, there doesn't in the AMD's system
    programming manual for Amd64 (book 2, section 7.1).

    Writes on the other hand may not happen out of order, so changing things
    inside a critical section would seem to be okay.

    On PowerPC, on the other hand, the barriers have to be made explicit
    because they're not implied by LWARX/STWCX or by ordinary stores:

	LWARX mtx
	STWCX mtx
	ISYNC
	READ *A		} which may be reordered
	READ *B		}
	LWSYNC
	WRITE mtx

	So, should the spin_unlock() on i386 and x86_64 be doing an LFENCE
	instruction before unlocking?


(2) What is the minimum functionality that can be expected of a memory
    barriers? I was of the opinion that all we could expect is for the CPU
    executing one them to force the instructions it is executing to be
    complete up to a point - depending on the type of barrier - before
    continuing past it.

    On pentiums, x86_64, and frv this seems to be exactly what you get for a
    barrier; there doesn't seem to be any external evidence of it that appears
    on the bus, other than the CPU does a load of memory transactions.

    However, on ppc/ppc64, it seems to be more thorough than that, and there
    seems to be some special interaction between the CPU processing the
    instruction and the other CPUs in the system. It's not entirely obvious
    from the manual just what this does.

    As I understand it, Andrew Morton is of the opinion that issuing a read
    barrier on one CPU will cause the other CPUs in the system to sync up, but
    that doesn't look likely on all archs.

David
