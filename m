Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVERNzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVERNzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVERNzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:55:41 -0400
Received: from gate.perex.cz ([82.113.61.162]:26240 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262204AbVERNxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:53:53 -0400
Date: Wed, 18 May 2005 15:53:51 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Karel Kulhavy <clock@twibright.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
In-Reply-To: <20050518133215.GB13736@kestrel>
Message-ID: <Pine.LNX.4.58.0505181540440.1840@pnote.perex-int.cz>
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net>
 <20050517141307.GA7759@kestrel> <1116354762.31830.12.camel@mindpipe>
 <20050517192412.GA19431@kestrel.twibright.com> <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
 <1116362191.32210.24.camel@mindpipe> <20050518133215.GB13736@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Karel Kulhavy wrote:

> On Tue, May 17, 2005 at 04:36:30PM -0400, Lee Revell wrote:
> 
> [...]
> 
> > alsa-lib, which is part of userspace.  From the application's point of
> > view, it does not matter whether the mixing happens in kernel or not.
> > ALSA follows the philosophy of doing as little as possible in the
> > kernel, and since mixing and volume control work fine in userspace,
> > that's where they live.
> 
> Mixing is IMHO action that should be in kernel because
> 
> 1) needs realtime scheduling to keep latency down

With a realtime scheduler and properly written drivers (no "schedule"  
gaps) you'll reach same results. For x86 we use special instructions like
xchg and locking-free algorithm in dmix, so the latency is SAME for all 
concurent apps with minimal overhead..

> 2) needs tight cooperation with the hardware to prevent dropouts
> on underruns

Yes, but having the code which computes something in interrupt is not 
sane.

> 3) Is a trivial linear algorithm involving memory blocks and linear
>    arithmetic, no complicated computations that are difficult to
>    check for BugFree(TM) so shouldn't present a great risk on kernel
>    stability

You need to write complete new virtual layer or use a new special driver 
which connect to real soundcard. Thats a lot of new code - it's better to 
do it safely in the user space.

> 4) Fits into the kernel philosophy. Kernel is a program meant to provide
>    time-sharing access to limited hardware resource. Sound card is a
>    limited hardware resource.

Why X drivers aren't in kernel, too? Because they're big and kernel should
drive the real bottom of hardware (interrupts, DMA, memory mapping), but
abstraction (which sound mixing _IS_) should be implemented in the user 
space. Otherwise we will end up with a huge kernel implementing nearly 
everything...

> 5) From the knowledge of the exact hardware, the mixing routine in
>    kernel can know maximum allowable levels etc. to prevent clipping.

You can obtain all necessary info in the userspace as well.

We should definitely fix the dmix bugs. Or, if you want, you might buy
an accelerated soundcard which supports multiple streams in hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
