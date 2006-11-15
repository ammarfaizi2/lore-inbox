Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030632AbWKOQUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbWKOQUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbWKOQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:20:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030632AbWKOQUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:20:16 -0500
Date: Wed, 15 Nov 2006 08:19:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
cc: David Miller <davem@davemloft.net>, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <s5hbqn99f2v.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
 <20061114.192117.112621278.davem@davemloft.net> <s5hbqn99f2v.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Takashi Iwai wrote:
> 
> The snd-hda-intel driver has a test of MSI, but it seems not working
> on every machine.  It caused non-cared interrupts and the kernel
> disabled that irq.

Yes. 

Btw, this was why I was claiming that maybe some devices might raise 
_both_ the MSI and the INTx interrupt, which can indeed cause problems 
like that: because we see spurious interrupts on some other irq line (the 
INTx one), we might decide to end up disabling that one, just because we 
can't seem to shut it up.

However, the same kind of schenario may happen if the MSI irq from a 
device simply doesn't _work_ - the device may claim MSI capabilities but 
always uses INTx, and you'd get the same behaviour from just _testing_ the 
MSI line - the irq comes in on the wrong vector, and since you're not 
handling that vector, the kernel has no choice but to say "I will have to 
disable this screaming irq".

So "testing" that an MSI works isn't actually goign to solve any real 
problems. It may or may not show that the MSI works, but regardless of the 
success of the test, it can have deadly consequences for _other_ devices 
if the irq routing (which may be INTx) is broken.

This is why I'm so adamant that we need to _know_ that it works before we 
use it. When irq's get mis-routed, things go downhill real fast. We're 
usually talking "dead machines", and there is very little that a driver 
can do about it.

			Linus
