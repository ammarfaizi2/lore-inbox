Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJWzN>; Wed, 10 Jan 2001 17:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAJWzD>; Wed, 10 Jan 2001 17:55:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129406AbRAJWyu>;
	Wed, 10 Jan 2001 17:54:50 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101102209.f0AM9N803486@flint.arm.linux.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 10 Jan 2001 22:09:22 +0000 (GMT)
Cc: mantel@suse.de (Hubert Mantel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010110163158.F19503@athlon.random> from "Andrea Arcangeli" at Jan 10, 2001 04:31:58 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
> (spotted by Andi) util-linux-2.10o/mount/nfs_mount4.h:
> 
> struct nfs3_fh {
>         unsigned short          size;
>         unsigned char           data[64];
> };
> 
> (see also nfs_mount_data structure in both kernel and mount)

Well, let me put it this way:

1. NFS locking worked on ARM in 2.2.17 without any problems or modifications
   what so ever.

2. NFS locking does NOT work on ARM without the above patch.  It FAILS
   completely.

> I also don't understand Alan's comment, what has the cast of data to a
> structure have to do with the size of a field in the structure?

I won't bother replying to this, since you obviously know the answer from
your following comment. ;)

> Furthmore
> the cast of data to a struct should work on all architectures as far as C is
> concerned (if you then run alignment problems then it's your mistake).

WRONG WRONG WRONG WRONG WRONG.  You are *SO* wrong.

C explicitly allows this behaviour.  The fact that most processors can load
unaligned data without any trouble is merely co-incidence and leads to BAD
programming techniques, like this one illusatrated above.

Therefore, it is BAD code which needs to be fixed.  Now, on ARM, all
structures are defined by the ABI to be aligned to a 32-bit word.  End
of story.  No other story will do.  Finito.  Capisco?

Yes, you can get around them by taking an alignment abort, but that is REALLY
REALLY expensive.  Eg, instead of a load taking 1 cycle, it turns into around
500 cycles, just to decode the instruction by hand, calculate the addresses,
calculate the side effects and implement them.

So, if we can get away with a little BETTER coding technique, then that is
FAR FAR better than thaning a 499 cycle penalty.

Oh, and did I mention that x86 also has a performance penalty for unaligned
loads as well?

> So for now I backed it out. If you want to push it in again then implement
> it right and make an mount backwards compatible nfs_fh type for the
> nfs_mount_data.

This is pretty gawling, especially as the fix was posted to the NFS
development list and not one person complained that it would break any APIs.

I'd like the NFS developers to look at this.  Yes, I'm delegating it.  Why?
I've got too much on my plate at the moment, and I'm desperately trying to
get rid of the 2.2 ARM kernel tree so I can concentrate on 2.4 only.  In the
spirit of open source, I am willing to test patches that claim to fix this
problem once I've got my 2.2 kernel tree back into a reasonable state (after
chasing some 128MB bad DIMM problem around for 2 months across 2 versions of
Linux).

And yes, APIs shouldn't break in a major kernel release.  Its a shame some
API broke in 2.2.18.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
