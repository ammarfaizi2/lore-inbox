Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135688AbRDSOrS>; Thu, 19 Apr 2001 10:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135689AbRDSOrI>; Thu, 19 Apr 2001 10:47:08 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:7184 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135688AbRDSOqz>;
	Thu, 19 Apr 2001 10:46:55 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191446.f3JEkiZ30750@oboe.it.uc3m.es>
Subject: Re: block devices don't work without plugging in 2.4.3
In-Reply-To: <20010419155930.G22517@suse.de> from "Jens Axboe" at "Apr 19, 2001
 03:59:30 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Thu, 19 Apr 2001 16:46:44 +0200 (MET DST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jens Axboe wrote:"
> [ptb wrote]
> > through merge_reqeusts function controls.
> > My unease derives, I think, from the fact that I have occasionally used
> > plugging for other purposes. Namely for throttling the device. These
> > uses have always been experimental and uniformly unsuccessful, because
> > throttling that way backs up the VFS with dirty buffers and provokes
> > precisely the deadlock against VFS that I was trying to avoid. So ..
> > 
> >  ... how can I tell when VFS is nearly full?  In those circumstances I
> > want to sync every _other_ device, thus giving me enough buffers at
> > least to flush something to the net with, thus freeing a request of
> > mine, plus its buffers.
> 
> You can't, there's currently no way of doing what you suggest. The block
> layer will throttle locked buffers for you. Besides, this would be the
> very wrong place to do it. If you reject or throttle requests, you are
> effectively throttling stuff that is already locked down and cannot be
> touched.

Oh, I agree. Exactly. It's pointless to throttle via requests/plugging.

However, it appears possible to deadlock if there is no way to detect
generic VFS fullness.  Let me explain the setting: part of the driver is
in user space, and it sends requests over the net.  It holds onto the
requests and their buffers while the user space process does the
networking (over ssl, sometimes) until an ack comes back.  There is an
obvious deadlock against VFS if the remote is on localhost (it has to
write the received requests to disk before acking, and it needs buffers
to do so ..), but there have been persistent sporadic reports that the
driver can occasionally deadlock even against a true remote host.

No such reports arise when I have forced a sync on the sender every
thousand requests or so, and people with problems report that mounting
an FS sync on the device solves their problem completely. This is
empirical evidence, but it suggests that there is a problem to be
avoided here. Thus I am keen to be able to detect how many buffers
there are that could be liberated by fsyncing _other_ devices, and
doing it.

I've never seen a way.

Peter
