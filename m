Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280254AbRKNHSm>; Wed, 14 Nov 2001 02:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280255AbRKNHSd>; Wed, 14 Nov 2001 02:18:33 -0500
Received: from spmx.securepipe.com ([64.73.37.194]:60569 "HELO
	spmx.securepipe.com") by vger.kernel.org with SMTP
	id <S280254AbRKNHSU>; Wed, 14 Nov 2001 02:18:20 -0500
Date: Wed, 14 Nov 2001 01:18:18 -0600 (EST)
From: "M.J. Pomraning" <mjp@pilcrow.madison.wi.us>
X-X-Sender: <mjp@alice.wi.securepipe.com>
To: <linux-kernel@vger.kernel.org>
cc: Jeremy Elson <jelson@circlemud.org>
Subject: open(O_ASYNC) sets futile flag
Message-ID: <Pine.LNX.4.33.0111132311140.24267-100000@alice.wi.securepipe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sys_open() doesn't meaningfully respect the O_ASYNC flag -- the resulting
fd/filp has the flag set, but f_op->fasync() is not invoked.  Worse yet,
fcntl()/ioctl() only call f_op->fasync() if FASYNC changes, so one must
presently undo and then redo the O_ASYNC before it works.

This contradicts fcntl(2)'s explicit remarks under the F_SETOWN section.  (Man
page is excerpting glibc manual.)  Behavior can be seen with ttys open()d
O_ASYNC or, as I noticed it, with a FIFO using Jeremy Elson's excellent
pipe-fasync patch on 2.4.14 (hope to see that in 2.5!). [1]

Two tempting corrections:
  A. open() implies FASYNCery
     (fasync() called if defined)
  B. open() unconditionally clears O_ASYNC
     (FASYNC must be manually F_SETFL'd/FIOASYNC'd)

Obviously A follows the man page and common sense.  Jeremy was kind enough to
do some preliminary investigation of modifying sys_open() to accomplish this,
noting that f_op->release would have to be called if fasync failed [2] (and
that this might pose some subtle difficulties).

OTOH, B is simple and agreeable.  Sockets and (even patched) unnamed pipes
don't have the luxury of an atomic O_ASYNC upon initialization AFAIK.
Further, the merit of fasync() alongside open() is debatable -- one still must
separately F_SETOWN before signals start rolling in.

Time to solicit more input.  Are there serious implementation barriers to A?
Are there better alternatives to A and B that correct the obstinate O_ASYNC
flag upon open() problem?

Pls. CC me in any replies.

Regards,
Mike

Notes:

[1] Jeremy Elson: "[PATCH] SIGIO for FIFOs (fs/pipe.c, kernel 2.4.x)"
    http://marc.theaimsgroup.com/?l=linux-kernel&m=99803716129556&w=2

[2] open() could return the fd and unset O_ASYNC on f_op->fasync failure,
    but that's rather awkward -- little better than manual fcntl()ing.


