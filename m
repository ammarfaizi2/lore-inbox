Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVL1RWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVL1RWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVL1RWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:22:04 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:8589 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932538AbVL1RWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:22:01 -0500
Date: Wed, 28 Dec 2005 18:23:23 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific
 test-case (since 2.6.10-bk12)
Message-ID: <20051228182323.7ec6d163@localhost>
In-Reply-To: <20051228123547.7d52501f@localhost>
References: <20051227190918.65c2abac@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<20051228120129.2a8d1199@localhost>
	<200512282219.24185.kernel@kolivas.org>
	<20051228123547.7d52501f@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005 12:35:47 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > This latter thing sounds more like your transcode job pushed everything out to 
> > swap... You need to instrument this case better.
> > 
> 
> I don't know. The combination Swapped Out Programs + "normal" priority
> strangeness can potentially result in a total disaster... but why
> renicing transcode to "0" gets the system usable again?
> 
> Next time I'll grab "/proc/meminfo"... and what other info can help to
> understand?

I'm doing some tests with "ingosched" and a bit longer trancoding
session and I've found a strange thing.

DD running time can change a LOT between one run and another (always
while transcode is running):

----------------------------------------------------------------------
paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
of=/dev/null bs=1M count=256; umount space/ 256+0 records in
256+0 records out

real    0m15.754s
user    0m0.000s
sys     0m0.500s

paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
of=/dev/null bs=1M count=256; umount space/ 256+0 records in
256+0 records out

real    0m52.966s
user    0m0.000s
sys     0m0.504s

paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
of=/dev/null bs=1M count=256; umount space/ 256+0 records in
256+0 records out

real    0m48.928s
user    0m0.004s
sys     0m0.524s
---------------------------------------------------------------------

Looking at top while running these I've seen that this is related to
how transcode's (the one that eats a lot of CPU) priority changes.

When only transcoding his priority is 16, but when also DD test is
running then that value fluctuate between 16 and 18.

DD priority is always 18 instead.

Usually transcode's prio go to 17/18 and DD runs in 15/20s, but
sometimes it doesn't fluctuate staying stuck to 16 and DD runs in ~50s.


PS:
I'm not yet able to reproduce the "totally unusable system" I was
talking about.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
