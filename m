Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280086AbRJaGUU>; Wed, 31 Oct 2001 01:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280089AbRJaGUJ>; Wed, 31 Oct 2001 01:20:09 -0500
Received: from [63.231.122.81] ([63.231.122.81]:10839 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280086AbRJaGTw>;
	Wed, 31 Oct 2001 01:19:52 -0500
Date: Tue, 30 Oct 2001 23:19:27 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Theodore Tso <tytso@mit.edu>, Oliver Xymoron <oxymoron@waste.org>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011030231926.E800@lynx.no>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Oliver Xymoron <oxymoron@waste.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011029163920.F806@lynx.no> <Pine.LNX.4.30.0110291814100.30096-100000@waste.org> <20011029205005.L806@lynx.no> <20011030110713.A583@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011030110713.A583@thunk.org>; from tytso@mit.edu on Tue, Oct 30, 2001 at 11:07:13AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2001  11:07 -0500, Theodore Tso wrote:
> On Mon, Oct 29, 2001 at 08:50:05PM -0700, Andreas Dilger wrote:
> > Well, I just saw that the "in++" and "nwords * 4" patches went into -pre4.
> > These are the only real non-cosmetic parts of what has been sent.  The
> > other patches were not officially submitted to Linus yet (using bytes
> > as parameters, and removing poolwords from the struct).  I have reverted
> > those patches in my tree, and gone back to using words as units for
> > add_entropy(), since it doesn't make sense to take bytes as a parameter
> > and then require a multiple of 4 bytes for input sizes.
> 
> Oops, ouch.  Thanks for catching the in++ bug; I can't believe that
> remained unnoticed for so long.  
> 
> Could you send me a pointer to the proposed change to remove poolwords
> from the struct?  I'm not sure why that wwould be a good thing at all.

No point - I reverted them and will not use them.  The goal was to
simplify the "unit" issue in random.c becuase the previous bug about
truncating "entropy_count" to "poolwords" instead of "poolbits" was
caused specifically by a misunderstanding about the unit sizes of
function parameters.

add_entropy_words -> words == 4 bytes
credit_entropy_store -> bits
extract_entropy -> bytes

What I have done instead of changing "poolwords" to "poolbytes"
everywhere, is rename "credit_entropy_store" to "credit_entropy_bits"
and rename the struct field "entropy_count" to "entropy_bits".

> Also, the reason why add_entropy_words did stuff in multiple of 4
> bytes was simply because it made the code much more efficient.

I didn't disagree with that at all.  All that I tried (and ended up not
using) was to change all the word units to be bytes.  The algorithm was
not changed.  In the end, one of the reasons to not use it was that it
introduced a few cases where we scaled a variable value instead of a
constant value, and introduced a small run-time overhead.  It also didn't
make sense to pass a byte value to add_entropy_words() and then restrict
it to being a multiple of 4.  Ugh.

> Zero-padding isn't a problem, since it's perfectly safe to mix in zero
> bytes into the pool.

Well, Oliver tends to disagree.  I don't know enough either way.  It _does_
seem bad that if you wrote continually wrote 1-byte values into /dev/random
and padded out the end of the word that it would be bad.  However, in the
end this is no worse than cat /dev/zero > /dev/random, which is also allowed.

The only place were we submit non-word-sized values to add_entropy_words()
is in random_write(), and I fixed that to accumulate bytes until we
have a full word to mix in.  One possible "optimization" that could
be done in that function is instead of copy_from_user(), we could use
verify_area() instead, directly add any fully-aligned words into the pool,
and then "accumulate" any misaligned or partial words.  This saves us a
memcpy() of all the data being written into /dev/random, but whether the
performance improvement is noticable on this non-fast-path is important
is questionable.  Another question is whether "rounding" a char pointer
to a multiple of 4 is legal/portable.  Maybe I'll put in a comment and
wait until someone else wants to do it...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

