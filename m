Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311258AbSCQCEX>; Sat, 16 Mar 2002 21:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311257AbSCQCEE>; Sat, 16 Mar 2002 21:04:04 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:47885 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311255AbSCQCDx>;
	Sat, 16 Mar 2002 21:03:53 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.63649.587641.538009@argo.ozlabs.ibm.com>
Date: Sun, 17 Mar 2002 13:00:01 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161020230.31850-100000@penguin.transmeta.com>
In-Reply-To: <15507.9919.92453.811733@argo.ozlabs.ibm.com>
	<Pine.LNX.4.33.0203161020230.31850-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Remember: think about the hashes as just TLB's, and the VSID's are just 
> address space identifiers (yeah, yeah, you can have several VSID's per 
> process at least in 32-bit mode, I don't remember the 64-bit thing). So 
> what you do is the same thing alpha does with it's 6-bit ASN thing: when 
> you wrap around, you blast the whole TLB to kingdom come.

I have performance measurements that show that having stale hash-table
entries cluttering up the hash table hurts performance more than
taking the time to get rid of them does.  This is on ppc32 using
kernel compiles and lmbench as the performance measures.

> You _can_ switch the hash table base around on ppc64, can't you?

Not when running under a hypervisor (i.e. on a logically-partitioned
system), unfortunately.  It _may_ be possible to choose the VSIDs so
that we only use half (or less) of the hash table at any time.

> Maybe somebody is seeing the light.

Maybe.  Whenever I have been asked what hardware features should be
added to PPC chips to make Linux run better, I usually put having an
option for software loading of the TLB pretty high on the list.

However, one good argument against software TLB loading that I have
heard (and which you mentioned in another message) is that loading a
TLB entry in software requires taking an exception, which requires
synchronizing the pipeline, which is expensive.  With hardware TLB
reload you can just freeze the pipeline while the hardware does a
couple of fetches from memory.  And PPC64 remains the only
architecture I know of that supports a full 64-bit virtual address
space _and_ can do hardware TLB reload.

I would be interested to see measurements of how many cache misses on
average each hardware TLB reload takes; for a hash table I expect it
would be about 1, for a 3-level tree I expect it would be very
dependent on access pattern but I wouldn't be surprised if it averaged
about 1 also on real workloads.

But this is all a bit academic, the real question is how do we deal
most efficiently with the real hardware that is out there.  And if you
want a 7.5 second kernel compile the only option currently available
is a machine whose MMU uses a hash table. :)

Paul.
