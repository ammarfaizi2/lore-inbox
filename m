Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133067AbRDLIif>; Thu, 12 Apr 2001 04:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133068AbRDLIiZ>; Thu, 12 Apr 2001 04:38:25 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:24586 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133067AbRDLIiM>;
	Thu, 12 Apr 2001 04:38:12 -0400
Date: Thu, 12 Apr 2001 10:38:03 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bernd Schmidt <bernds@redhat.com>, Andreas Franck <afranck@gmx.de>,
        David Howells <dhowells@cambridge.redhat.com>, andrewm@uow.edu.au,
        bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix
Message-ID: <20010412103803.B25536@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.30.0104111606010.1106-100000@host140.cambridge.redhat.com> <Pine.LNX.4.31.0104111118000.17733-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104111118000.17733-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Apr 11, 2001 at 11:27:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> On Wed, 11 Apr 2001, Bernd Schmidt wrote:
> See? Do you see why a "memory" clobber is _not_ comparable to a "ax"
> clobber? And why that non-comparability makes a memory clobber equivalent
> to a read-modify-write cycle?

I had to think about this, so I'll explain it a different way in case it
is helpful.

An "ax" clobber says "the whole of eax is undefined after this".  In
contrast, a "memory" clobber says "we are writing unspecified values to
unspecified addresses, but the values are actually valid if you read
memory later".

All earlier writes to any part of _addressed_ memory (or the named
register) must be either discarded, or placed earlier in the instruction
stream.  For "memory" this is a "compiler write barrier".  Addressed
memory means everything except local variables whose addresses are not
taken.

Later reads from memory could be reading from a region that was written
by the "memory" clobbering instruction.  The compiler doesn't know, so
it must assume so.  Therefore later reads must be placed later in the
instruction stream.  This means that "memory" acts as a "compiler read
barrier".

> In short: I disagree 100%. A "memory" clobber -does- effectively tell the
> compiler that memory is read. If the compiler doesn't realize that, then
> it's a compiler bug waiting to happen. No ifs, buts of maybes.

Indeed.

-- Jamie
