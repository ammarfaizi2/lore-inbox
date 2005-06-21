Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFUODy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFUODy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFUOAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:00:22 -0400
Received: from soufre.accelance.net ([213.162.48.15]:19424 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261471AbVFUN4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:56:35 -0400
Message-ID: <42B81C8D.3050608@xenomai.org>
Date: Tue, 21 Jun 2005 15:56:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Kristian Benoit <kbenoit@opersys.com>
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
References: <42B35B07.7080703@xenomai.org> <20050618170139.GA477@openzaurus.ucw.cz> <42B7272F.2040503@xenomai.org> <42B74781.8000109@opersys.com> <42B7BE86.6060502@xenomai.org> <42B817AF.5040700@opersys.com>
In-Reply-To: <42B817AF.5040700@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Philippe Gerum wrote:
> 
>>Any objection to make the pipeline a static-only feature?
> 
> 
> FWIW, we conducted our tests with the I-pipe loaded as a module.
> Though we didn't publish that particular result as part of our
> earlier posting, we found that the price for having it loaded,
> but unused, versus not having it loaded at all made virtually
> no difference on overall system overhead. Such results would
> seem to indicate that having it as a loadable module has no
> specific advantage. Note, though, that we didn't do the test on
> all configs, just the "plain" one.
> 
> Of course the issue would be much easier to decide if you
> could provide a brief explanation as to what the difference is, in
> terms of execution path, between having it compilled as a module
> and not loaded, versus having it built-in and unused.

Having it built statically but unused by any other domain but Linux is 
basically like having local_irq_disable() and friends as out-of-line 
code, still with real hw masking, but with all interrupts going through 
the I-pipe's interrupt handler before being dispatched to the regular 
Linux handler.

OTOH, having the I-pipe as an unloaded module leaves the original 
interrupt path untouched (at least on x86), but requires a boolean check 
into each stall/unstall/test operations, and a few more (~4) in the 
interrupt path just to make sure that we are operating in real or 
virtual (i.e. pipelined) mode, IOW to check if the pipelining engine is 
engaged or not, and further decide if we should use the CPU or I-pipe 
masking ops. The other solution would have been to play the function 
pointer game in order to reach the pipelined/non-pipelined operations 
depending on the box being i-piped or not, but I was unsure of the 
impact on performances.

-- 

Philippe.
