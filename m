Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282464AbRKZUCn>; Mon, 26 Nov 2001 15:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282473AbRKZUBI>; Mon, 26 Nov 2001 15:01:08 -0500
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:37792 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282463AbRKZUAO>; Mon, 26 Nov 2001 15:00:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 11:59:08 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011125221418.A9672@weta.f00f.org>
In-Reply-To: <20011125221418.A9672@weta.f00f.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0111261159080F.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 November 2001 04:14, Chris Wedgwood wrote:

>
> P.S. Write-caching in hard-drives is insanely dangerous for
>      journalling filesystems and can result in all sorts of nasties.
>      I recommend people turn this off in their init scripts (perhaps I
>      will send a patch for the kernel to do this on boot, I just
>      wonder if it will eat some drives).

Anybody remember back when hard drives didn't reliably park themselves when 
they cut power?  This isn't something drive makers seem to pay much attention 
to until customers scream at them for a while...

Having no write caching on the IDE side isn't a solution either.  The problem 
is the largest block of data you can send to an ATA drive in a single command 
is smaller than modern track sizes (let alone all the tracks under the heads 
on a multi-head drive), so without any sort of cacheing in the drive at all 
you add rotational latency between each write request for the point you left 
off writing to come back under the head again.  This will positively KILL 
write performance.  (I suspect the situation's more or less the same for read 
too, but nobody's objecting to read cacheing.)

The solution isn't to avoid write cacheing altogether (performance is 100% 
guaranteed to suck otherwise, for reasons unrelated to how well your hardware 
works but to legacy request size limits in the ATA specification), but to 
have a SMALL write buffer, the size of one or two tracks to allow linear ATA 
write requests to be assembled into single whole-track writes, and to make 
sure the disks' electronics has enough capacitance in it to flush this buffer 
to disk.  (How much do capacitors cost?  We're talking what, an extra 20 
miliseconds?  The buffer should be small enough you don't have to do that 
much seeking.)

Just add an off-the-shelf capacitor to your circuit.  The firmware already 
has to detect power failure in order to park the head sanely, so make it 
flush the buffers along the way.  This isn't brain surgery, it just wasn't a 
design criteria on IBM's checklist of features approved in the meeting.  
(Maybe they ran out of donuts and adjourned the meeting early?)

Rob
