Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSGPBkm>; Mon, 15 Jul 2002 21:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317704AbSGPBkl>; Mon, 15 Jul 2002 21:40:41 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:15351 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317701AbSGPBkj>;
	Mon, 15 Jul 2002 21:40:39 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com> <1026767676.4751.499.camel@tiny> <s5gy9ccr84k.fsf@egghead.curl.com> <200207160102.g6G12BiH022986@lin2.andrew.cmu.edu>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 21:43:34 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/200207160102.g6G12BiH022986@lin2.andrew.cmu.edu>
Message-ID: <s5g8z4cphvd.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Greenfield <leg+@andrew.cmu.edu> writes:

> Actually, it's not all that simple (you have to find the enclosing
> directories of any files you're modifying, which might require string
> manipulation)

No, you have to find the directories you are modifying.  And the
application knows darn well which directories it is modifying.

Don't speculate.  Show some sample code, and let's see how hard it
would be to use the "Linux way".  I am betting on "not hard at all".

> or necessarily all that fast (you're doubling the number of system
> calls and now the application is imposing an ordering on the
> filesystem that didn't exist before).

No, you are not doubling the number of system calls.  As I have tried
to point out repeatedly, doing this stuff reliably and portably
already requires a sequence like this:

   write data
   flush data
   write "validity" indicator (e.g., rename() or fchmod())
   flush validity indicator

On Linux, flushing a rename() means calling fsync() on the directory
instead of the file.  That's it.  Doing that instead of fsync'ing the
file adds at most two system calls (to open and close the directory),
and those can be amortized over many operations on that directory
(think "mail spool").  So the system call overhead is non-existent.

As for "imposing an ordering on the filesystem that didn't exist
before", that is complete nonsense.  This is imposing *precisely* the
ordering required for reliable operation; no more, no less.  Relying
on mount options, "chattr +S", or journaling artifacts for your
ordering is the inefficient approach; since they impose extra
ordering, they can never be faster and will usually be slower.

> It's only necessary for ext2. Modern Linux filesystems (such as ext3
> or reiserfs) don't require it.

Only because they take the performance hit of flushing the whole log
to disk on every fsync().  Combine that with "data=ordered" and see
what happens to your performance.  (Perhaps "data=ordered" should be
called "fsync=sync".)  I would rather get back the performance and
convince application authors to understand what they are doing.

> Finally: ext2 isn't safe even if you do call fsync() on the directory!

Wrong.

   write temp file
   fsync() temp file
   rename() temp file to actual file
   fsync() directory

No matter where this crashes, it is perfectly safe on ext2.  (If not,
ext2 is badly broken.)  The worst that can happen after a crash is
that the file might exist with both the old name and the new name.
But an application can detect this case on startup and clean it up.

 - Pat
