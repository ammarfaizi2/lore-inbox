Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTJGRGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJGRGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:06:34 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:54789 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S262531AbTJGRGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:06:30 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB214@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Daniel B.'" <dsb@smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Whyn
	ot   re-do failed op?
Date: Tue, 7 Oct 2003 11:06:25 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel B. [mailto:dsb@smart.net]
> Sent: Monday, October 06, 2003 11:24 PM
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet?
> Whynot re-do failed op?
> 
> Other than the write-back caching, it's not an open-loop system, 
> right?  Regardless of how commands are batched or queued, isn't there 
> some acknowledgment back from the drive that some batch of commands
> (or some command, or some part of some command) was completed?
> 
> Surely the kernel checks for such acknowledgments, right? 

Normal writes are fire-and-forget.  UDMA CRC errors are about the only place
you can catch this stuff with write cache on, but only then with
restrictions (see below).  After a UDMA write, the drive goes busy then must
post ending status which represents the end-of-transfer status, not the
status of the write to the media.  In theory, this should be catching your
problem.

However, here's the trick... Just because the drive is holding off good
status at the end of write number N (and hence no completion interrupt ---
I'm assuming the drive is working as intended, and intentionally not
generating IRQ...) doesn't mean that write N is the reason for holding off
that status.  The disk could be trying to put write N-20938409283409234 on
the media and having an issue, recognize that it can't accept more write
data, and be choosing to hold off ending status instead of posting ready.
If a drive starts to recognize it needs to throttle the host, there are
several places for this to happen... and ending status on a DMA transfer is
one possible place.  (Not a great choice, but it is possible...)

In that case, you're just toast, unless you have stored every write done in
the last 8 months in host buffer ram so you can retry them all.
 
> DMA-complete interrupts are probably how some of those 
> acknowledgments 
> are communicated, right?
>
>	[munch]
>
> Given the serious of disk data corruption, why isn't the Linux kernel
> more reliable here?  Hasn't this family of IDE problems been around
> for a couple of years now?

Actually, 48-bit LBA transfers (32MiB/command) opened a whole new can of
worms...

If you do a UDMA write exceeding the drive's cache size, and get a CRC error
at the end or any sort of DMA overrun/underrun, you have to assume that the
drive has just nuked the entire write space for that command.  I'm sure we
could get around that problem if people were willing to pay for disk drives
with 32+MB buffers on them.  (Actually we'd need a bit more to hold our own
runtime code and variables)  However, they aren't.

>From watching bus traces and the like, I'm pretty happy with the linux IDE
code.  There are a *lot* of production machines out there with IDE drives in
them that aren't having these problems.

--eric


