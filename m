Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSGaAkS>; Tue, 30 Jul 2002 20:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSGaAkS>; Tue, 30 Jul 2002 20:40:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29482 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317546AbSGaAkR>; Tue, 30 Jul 2002 20:40:17 -0400
Date: Wed, 31 Jul 2002 02:44:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020731004451.GI1181@dualathlon.random>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random> <20020730175421.J10315@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730175421.J10315@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 05:54:21PM -0400, Benjamin LaHaise wrote:
> On Tue, Jul 30, 2002 at 11:41:16PM +0200, Andrea Arcangeli wrote:
> > Can you point me out to a patch with the new cancellation API that you
> > agree with for merging in 2.5 so I can synchronize? I'm reading your
> > very latest patch loaded on some site in June. that will be really
> > helpful, many thanks!
> 
> Here is what I've got for the aio core that has the cancellation 
> change to return the completion event.  The other slight change that 
> I meant to get in before going into the mainstream is to have the 
> timeout io_getevents takes be an absolute timeout, which helps for 
> applications that have specific deadlines they are attempting to 
> schedule to (think video playback).  This drop is untested, but I'd 

are you sure this is a good idea? this adds an implicit gettimeofday
(thought no entry/exit kernel) to every getevents syscall with a
"when" specificed, so the user may now need to do gettimeofday both
externally and internally to use the previous "timeout" feature (given
the kernel can delay only of a timeout, so the kernel has to calculate
the timeout internally now). I guess I prefer the previous version that
had the "timeout" information instead of "when". Also many soft
multimedia only expect the timeout to take "timeout", and if a frame
skips they'll just slowdown the frame rate, so they won't be real time
but you'll see something on the screen/audio. Otherwise they can keep
timing out endlessy if they cannot keep up with the stream, and they
will show nothing rather than showing a low frame rate.

So I'm not very excited about this change, I would prefer the previous
version. Also consider with the vsyscall doing the gettimeofday
calculation in userspace based on "when" rather than in-kernel isn't
going to be more expensive than your new API even of applications that
really want the "when" behaviour instead of the "timeout". While the
applications that wants the "timeout" this way we'll be forced to a
vgettimeofday in userspace and one in kernel which is a pure overhead
for them.

So unless anybody can see a flaw in my reasoning, I would suggest you to
backout the "when" change and to resend to Linus.

Also the vsyscall sections would better be deleted instead of under #if
0.

Everything else looks great, thanks!

Andrea
