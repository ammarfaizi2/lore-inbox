Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUKATzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUKATzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291748AbUKATbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:31:49 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:6125 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S291902AbUKATa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:29 -0500
Message-Id: <200411011930.iA1JULiQ009302@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Mon, 01 Nov 2004 15:30:49 +0100."
             <20041101143049.GA22221@elte.hu> 
Date: Mon, 01 Nov 2004 14:30:21 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [141.152.250.245] at Mon, 1 Nov 2004 13:30:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>poll() is quite complex and with a good number of locks in the path the
>maximum latency increases accordingly.

how can poll(2) be more complex than read/write? if it is, it
shouldn't be ;)

>btw., couldnt jackd use a separate input and output thread (of identical
>priority), to be purely read()/write() based? This method should also
>solve the priority problems of poll(): the thread woken up later will do
>the work later. (hence the _earlier_ interrupt source will be handled
>first.) With poll() how do you tell which fd needs attention first, if
>both are set?

we don't really care which one needs attention "first". the jack process
cycle ends up consuming and producing data - 

      before the ALSA backend tells jackd to run the process cycle,
         it will read the data from the capture fd (though its done
	 using mmap, so there is no read(2) call)

      just before jackd goes back to sleep waiting for the next
         interrupt, the ALSA backend will write data to the playback fd
	 (again, using mmap, so there is no actual write(2) call)

it is important to use mmap - it avoids multiple kernel entries and
data copying. for consumer cards this doesn't matter much, but for
high end multichannel cards, the data copy would be inexcusable.

--p


