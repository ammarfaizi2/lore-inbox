Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbRFNH51>; Thu, 14 Jun 2001 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbRFNH5R>; Thu, 14 Jun 2001 03:57:17 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:418 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S261394AbRFNH5N>;
	Thu, 14 Jun 2001 03:57:13 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.6-pre2, pre3 VM Behavior
Date: Thu, 14 Jun 2001 08:59:07 +0100
Message-ID: <JKEGJJAJPOLNIFPAEDHLGEMBDCAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Behalf Of Rik van Riel
> On Wed, 13 Jun 2001, Tom Sightler wrote:
> > Quoting Rik van Riel <riel@conectiva.com.br>:
> > 
> > > After the initial burst, the system should stabilise,
> > > starting the writeout of pages before we run low on
> > > memory. How to handle the initial burst is something
> > > I haven't figured out yet ... ;)
> > 
> > Well, at least I know that this is expected with the VM, although I do
> > still think this is bad behavior.  If my disk is idle why would I wait
> > until I have greater than 100MB of data to write before I finally
> > start actually moving some data to disk?
> 
> The file _could_ be a temporary file, which gets removed
> before we'd get around to writing it to disk. Sure, the
> chances of this happening with a single file are close to
> zero, but having 100MB from 200 different temp files on a
> shell server isn't unreasonable to expect.
> 
> > > This is due to this smarter handling of the flushing of
> > > dirty pages and due to a more subtle bug where the system
> > > ended up doing synchronous IO on too many pages, whereas
> > > now it only does synchronous IO on _1_ page per scan ;)
> > 
> > And this is definitely a noticeable fix, thanks for your continued
> > work.  I know it's hard to get everything balanced out right, and I
> > only wrote this email to describe some behavior I was seeing and make
> > sure it was expected in the current VM.  You've let me know that it
> > is, and it's really minor compared to problems some of the earlier
> > kernels had.
> 
> I'll be sure to keep this problem in mind. I really want
> to fix it, I just haven't figured out how yet  ;)
> 
> Maybe we should just see if anything in the first few MB
> of inactive pages was freeable, limiting the first scan to
> something like 1 or maybe even 5 MB maximum (freepages.min?
> freepages.high?) and flushing as soon as we find more unfreeable
> pages than that ?
> 

Would it be possible to maintain a dirty-rate count 
for the dirty buffers?

For example, we it is possible to figure an approximate
disk subsystem speed from most of the given information.
If it is possible to know the rate at which new buffers
are being dirtied then we could compare that to the available
memory and the disk speed to calculate some maintainable
rate at which buffers need to be expired.  The rates would
have to maintain some historical data to account for
bursty data...

It may be possible to use a very similar mechanism to do
both.  I.e. not actually calculate the rate from the hardware,
but use a similar counter for the expiry rate of buffers.

I don't know how difficult the accounting would be
but it seems possible to make it automatically tuning.

This is a little different than just keeping a list
of dirty buffers and free buffers because you have
the rate information which tells you how long you
have until all the buffers expire.

Laramie.
