Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282187AbRLQS6s>; Mon, 17 Dec 2001 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRLQS6j>; Mon, 17 Dec 2001 13:58:39 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:15635 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282187AbRLQS62>; Mon, 17 Dec 2001 13:58:28 -0500
Message-ID: <3C1E400B.A4D25F9D@zip.com.au>
Date: Mon, 17 Dec 2001 10:57:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrea Arcangeli <andrea@suse.de>, GOTO Masanori <gotom@debian.org>,
        Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <20011217181840.G2431@athlon.random> <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> >
> > I'm unsure (it's basically a matter of API, not something a kernel
> > developer can choose liberally), and the SuSv2 is not saying anything about
> > O_SYNC failures in the write(2) manapge, but I guess it would be at
> > least saner to put the "pos" backwards if we fail osync but we just
> > written something (so if we previously advanced pos).
> 
> I don't have references to back me up, don't take my word for it:
> but I'm sure that the correct behaviour for a partially successful
> read or write in any UNIX is that it return the count done, O_SYNC
> or not, and file position should match that count; only when none
> has been done is -1 returned with errno set.  Most implementations will
> get this wrong in one corner or another, but that's how it should be.
> 

SUS says: ( http://www.opengroup.org/onlinepubs/007908799/xsh/write.html )

 RETURN VALUE

     Upon successful completion, write() and pwrite() will return the number of bytes
     actually written to the file associated with fildes. This number will never be greater
     than nbyte. Otherwise, -1 is returned and errno is set to indicate the error. 

I take that to mean that if an error occurs, we return that
error regardless of how much was written.

Which makes sense.  Consider this code:

	open(file)
	write(100k)
	close(fd)

if the write gets an IO error halfway through, it looks like
the caller never gets to hear about it at present.  Except via
the short return value from the write.  But from my reading of SUS,
a short return value from write implicitly means ENOSPC.  If we
give a short return for EIO, the calling app has no way to distinguish
this from ENOSPC.

Regarding ENOSPC, SUS says:

     If a write() requests that more bytes be written than there is room for (for example, the
     ulimit or the physical end of a medium), only as many bytes as there is room for will be
     written. For example, suppose there is space for 20 bytes more in a file before reaching
     a limit. A write of 512 bytes will return 20. The next write of a non-zero number of
     bytes will give a failure return (except as noted below)  and the implementation will
     generate a SIGXFSZ signal for the thread.

(We don't do the SIGXFSZ in this case either).

Note that I'm not talking about the O_SYNC case here.  Just bog-standard
write(), if ->prepare_write() fails.


Blah.  Hard.  Our behaviour at present seems to be mostly correct
for ENOSPC, and probably incorrect (and undesirable) for EIO.
I'd vote for leaving it as-is for the while.  Getting this
right is a medium-sized project.  There's also the matter of getting
the file pointer in the correct place on error.

-
