Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbSJPCGu>; Tue, 15 Oct 2002 22:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSJPCGu>; Tue, 15 Oct 2002 22:06:50 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:47505 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S264638AbSJPCGt>; Tue, 15 Oct 2002 22:06:49 -0400
Message-Id: <5.1.0.14.2.20021016110841.04120008@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 16 Oct 2002 12:11:36 +1000
To: Dan Kegel <dank@kegel.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] async poll for 2.5
Cc: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3DAC4DEB.3E6002E8@kegel.com>
References: <3DAB46FD.9010405@watson.ibm.com>
 <20021015110501.B11395@redhat.com>
 <3DAC4B0E.EBB3A2AB@kegel.com>
 <20021015130311.A14596@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:18 AM 15/10/2002 -0700, Dan Kegel wrote:
>Benjamin LaHaise wrote:
> >
> > On Tue, Oct 15, 2002 at 10:06:22AM -0700, Dan Kegel wrote:
> > > Doesn't the F_SETSIG/F_SETOWN/SIGIO stuff qualify as a scalable
> > > alternative?
> >
> > No.
>
>What's the worst part about it?  The use of the signal queue?

there are four things that really suck about sigio.
in order of most-significant-suckage to least-significant-suckage, i see 
them as:

  [1] signals are very heavy.
      thousands of signals/second does not scale on SMP due to the
      serialization of them in the kernel.
      (just look at the code path for delivering a signal)

      signals also resulted in 128 u32's being transferred from kernel
      to userspace for every signal.  thats a lot of memory i/o
      bandwidth consumed at 1000's of concurrent sockets
      and tens-of-thousands of events/sec happening.

  [2] SIGIO only exposes half of the POLL_OUT semantics.
      with poll(), you can use POLL_OUT to indicate if there
      is free buffer space to write into or not.
      with SIGIO, for most applications, you can only find out
      by issuing a write() and get back a -EWOULDBLOCK.
      to indicate !POLL_OUT.
      (perhaps that has been addressed in the last 12 months or so;
      but i doubt it)

  [3] SIGIO had no easy recovery path if you hit the maximum-
      queue-limit for number of signals queued to userspace.
      (ok, you *could* do a poll() and start again, but it couldn't
      be done in a 100% race-free manner)

  [4] you couldn't enable SIGIO on a incoming socket
      accept()ed without there being a race window where
      something happened to that socket between accept() and
      enable-SIGIO.  [sort-of related to (3); you could work-around
      it by doing a poll() on the socket after enable-SIGIO, but
      it makes a clean interface a horrible interface]

other miscellaneous things that makes SIGIO less usable in the real-world:
  - you can only get one event at a time -- that means tens-of-thousands
    to hundreds-of-thousands of system calls / second just to get event
    status, when it'd probably make more sense to poll for multiple signals
    at the same time
  - SIGIO only addressed "event notification".  it did nothing to address the
    other large scalability that you typically hit when writing 
high-performance i/o
    systems: overhead of memory-copy from userspace<->kernelspace.
    various zerocopy mechanisms help address that side of thing, but if you're
    comparing aio to SIGIO, aio *is* addressing a much larger problem than just
    SIGIO on its own


cheers,

lincoln.

