Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272518AbTGaPiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTGaPhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:37:08 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28617 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S270148AbTGaPgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:36:46 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Fri, 1 Aug 2003 10:38:49 -0500
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F22FB33.5080703@wmich.edu>
In-Reply-To: <3F22FB33.5080703@wmich.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308011038.49528.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 17:05, Ed Sweetman wrote:
> My comment was towards the fact that although playing audio is a
> realtime priority, decoding audio is not, and is not coded that way in
> many programs, in fact, many programs will sleep() in order to decode
> only when the output buffer is getting low.

Decoding is realtime too, though the bounds are more relaxed than for the DMA 
refill process.  In fact, it's the decoding task that causes skipping, 
because the DMA refill normally runs in interrupt context (so should mixing 
and equalizing, but that's another story) where essentially everything is 
realtime, modulo handwaving.

To convince yourself of this, note that when DMA refill fails to meet its 
deadline you will hear repeats, not skipping, because the DMA hardware on the 
sound card has been set up to automatically restart the DMA each time the 
buffer expires.  Try running the kernel under kgdb and breaking to the 
monitor while sound is playing.

So you need to reevaluate your thinking re the realtime nature of audio 
decoders.

To be sure, for perfect audio reproduction, any file IO involved has to be 
realtime as well, as does the block layer.  We're not really in position to 
take care of all that detail at this point, mainly because no Linux 
filesystem has realtime IO support.  (I believe Irix XFS has realtime IO and 
that part didn't get ported because of missing infrastructure in Linux.)  But 
the block layer isn't really that far away from being able to make realtime 
guarantees.  Mainly, that work translates into plugging in a different IO 
scheduler.

Beyond that, there's priority inversion to worry about, which is a hard 
problem from a theoretical point of view.  However, once we get to the point 
where priority inversion is the worst thing about Linux audio, we will be 
lightyears ahead of where we now stand.

> Technically, you shouldn't be
> able to get aplay to skip at all as long as no other processes are at an
> equal or higher nice value.

This got fuzzier with the interactivity hacks, which effectively allow the 
nice values to vary within some informally defined range.

Regards,

Daniel

