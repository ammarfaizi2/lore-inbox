Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281513AbRK0Qjb>; Tue, 27 Nov 2001 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0QjV>; Tue, 27 Nov 2001 11:39:21 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44037 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280817AbRK0QjL>; Tue, 27 Nov 2001 11:39:11 -0500
Date: Tue, 27 Nov 2001 17:39:04 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127173904.C13416@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011125221418.A9672@weta.f00f.org> <0111261159080F.02001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0111261159080F.02001@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Rob Landley wrote:

> Having no write caching on the IDE side isn't a solution either.  The problem 
> is the largest block of data you can send to an ATA drive in a single command 
> is smaller than modern track sizes (let alone all the tracks under the heads 
> on a multi-head drive), so without any sort of cacheing in the drive at all 
> you add rotational latency between each write request for the point you left 
> off writing to come back under the head again.  This will positively KILL 
> write performance.  (I suspect the situation's more or less the same for read 
> too, but nobody's objecting to read cacheing.)
> 
> The solution isn't to avoid write cacheing altogether (performance is 100% 
> guaranteed to suck otherwise, for reasons unrelated to how well your hardware 
> works but to legacy request size limits in the ATA specification), but to 
> have a SMALL write buffer, the size of one or two tracks to allow linear ATA 
> write requests to be assembled into single whole-track writes, and to make 
> sure the disks' electronics has enough capacitance in it to flush this buffer 
> to disk.  (How much do capacitors cost?  We're talking what, an extra 20 
> miliseconds?  The buffer should be small enough you don't have to do that 
> much seeking.)

Two things:

1- power loss. Fixing things to write to disk is bound to fail in
   adverse conditions. If the drive suffers from write problems and the
   write    takes longer than the charge of your capacitor lasts, your
   data is still toasted. nonvolatile memory with finite write time
   (like NVRAM/Flash) will help to save the Cache. I don't think vendors
   will do that soon.

2- error handling with good power: with automatic remapping turned on,
   there's no problem, the drive can re-write a block it has taken
   responsibility of, IBM DTLA drives will automatically switch off the
   write cache when the number of spare block gets low.

   with automatic remapping turned off, write errors with enabled write
   cache get a real problem because the way it is now, when the drive
   reports the problem, the block has already expired from the write
   queue and is no longer available to be rescheduled. That may mean
   that although fsync() completed OK your block is gone.

Tagged queueing may help, as would locking a block with write faults in
the drive and sending it back along with the error condition to the
host.

(*) of course, journal data must be written in an ordered fashion to
prevent trouble in case of power loss.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
