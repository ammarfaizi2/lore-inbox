Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRD2Eua>; Sun, 29 Apr 2001 00:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbRD2EuU>; Sun, 29 Apr 2001 00:50:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63880 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132655AbRD2EuK>;
	Sun, 29 Apr 2001 00:50:10 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.40318.158099.137018@pizda.ninka.net>
Date: Sat, 28 Apr 2001 21:50:06 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk>
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > Can someone please explain to me the rationale behind the zerocopy
 > implementation that has appeared in 2.4.4 please?

You've had at least 2 months to ask this question.  Like I have asked
several others I am going to ask you, why you are complaining now?

I see you merged your ARM updates to the AC tree, which is the same
place where the zerocopy stuff went in 2 months for _testing_, why
didn't you notice it?  I was posting zerocopy patches on almost a
daily basis at one point, and I mentioned in each of those patch
releases here on linux-kernel that the intent was to merge this to
Linus.  Why didn't you give it a go to make sure it worked on ARM?

PPC people, along with several other ports, did this and contacted me
to tell me things were OK.

 > Just think - if you did checksumming on aligned word boundaries you
 > could be far faster!

If the ARM checksum routines do not take care of unaligned source
and/or dest buffers, it is completely broken.  Every other port
handles this, ARM has byte/halfword/word loads and stores so it can
handle this just fine.  There is no excuse for this.

And your performance logic is broken too, the thing that is requiring
byte aligned source/dest buffers is eliminating an entire copy across
loopback, and in the sendfile case is copying the data directly from
the page cache into the receiver's userspace buffer.

So you're saying that 2 aligned copies are faster than 1 that starts
on a byte boundary?

ARM's checksum routines are what is broken, not the zerocopy patches.
Note this is a totally different case than the unaligned loads/stores
done to protocol headers that ARM had such trouble with in the past.

These unaligned case happen today, the user can give the kernel on
a send() any alignment it so chooses.  And the checksum routine is
going to operate on that user source buffer, whether it is byte
or word aligned.  So don't make it seem like this is some new
situation, becuase it simply isn't.

The zerocopy stuff has actually improved latency and bandwidth, BTW.
Linus required that it not deteriorate performance for existing
cases, and we verified that it did not on at least 3 platforms (x86,
Alpha, and sparc64).

In short, fix the ARM checksum code.  The kernel is just fine.

Later,
David S. Miller
davem@redhat.com
