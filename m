Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbRBBXWp>; Fri, 2 Feb 2001 18:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRBBXWf>; Fri, 2 Feb 2001 18:22:35 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:38975 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129480AbRBBXW2>;
	Fri, 2 Feb 2001 18:22:28 -0500
Message-ID: <3A7B409E.F63CA509@sgi.com>
Date: Fri, 02 Feb 2001 15:19:58 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        kiobuf-io-devel@lists.sourceforge.net,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] Re: 1st glance at kiobuf overhead in kernelaio vs 
 pread vs user aio
In-Reply-To: <Pine.LNX.4.30.0102021523430.5491-100000@today.toronto.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> Hey Ingo,
> 
> On Fri, 2 Feb 2001, Ingo Molnar wrote:
> 
> > - first of all, great patch! I've got a conceptual question: exactly how
> > does the AIO code prevent filesystem-related scheduling in the issuing
> > process' context? I'd like to use (and test) your AIO code for TUX, but i
> > do not see where it's guaranteed that the process that does the aio does
> > not block - from the patch this is not yet clear to me. (Right now TUX
> > uses separate 'async IO' kernel threads to avoid this problem.) Or if it's
> > not yet possible, what are the plans to handle this?
> 
> Thanks!  Right now the code does the page cache lookup allocations and
> lookups in the caller's thread, the write path then attempts to lock all
> pages sequentially during io using the async page locking function
> wtd_lock_page.  I've tried to get this close to some of the ideas proposed
> by Jeff Merkey, and have implemented async page and buffer locking
> mechanisms so far.  The down in the write path is still synchronous,
> mostly because I want some feedback before going much further down this
> path.  The read path verifies the up2date state of individual pages, and
> if it encounters one which is not, then it queues the request for the
> worker thread which calls readpage on all the pages that need updating.

[ Ben, good to see you have a patch to send, something which I've been requesting
  you for sometime now ;-) ]

Do you really have worker threads? In my reading of the patch it seems
that the wtd is serviced by keventd. And by using mapped kiobuf's you've
avoided issues such as:

	a. (not) requiring a requestor's process context to perform the copy (copy-out
           on read, for example)
        b. avoiding requestor's (user) page from being unmapped when a
             __iodesc_read_finish is being executed.

These are two major improvements I'm glad to see over my earlier KAIO patch
(obURL: http://oss.sgi.com/projects/kaio/) ... of course, several abstractions,
including kiobufs & more generic task queues in 2.4 have made this easier,
which is a good thing.

I see several similarities to the KAIO patch too; stuff like splitting
generic_read routine (which now you have expanded to include the write
routine also), and the handling of RAW devices.

A nice addition in your patch is the introduction of kiobuf as a common container of
pages, which in the KAIO patch was handled with an ad-hoc (page *) vector
for non RAW & kiobuf's for the RAW case.

One point which is not clear is how one would implement aio_suspend(...)
which waits for any ONE of N aiocb's to complete. The aio_complete(...)
routine in your patch expects a particular idx to wait on, so I assume
as is, only one aiocb can be waited upon. Am I correct? This particular
case is solved in the KAIO patch ...

Also, can you also put out a library that goes with the kernel patch?
I can imagine what it would look like, but ...

Cheers,

ananth.

--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
