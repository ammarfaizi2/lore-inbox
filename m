Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUGTHKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUGTHKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 03:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUGTHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 03:10:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23243 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263736AbUGTHKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 03:10:17 -0400
Date: Tue, 20 Jul 2004 09:11:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040720071136.GA28696@elte.hu>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu> <1090306769.22521.32.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090306769.22521.32.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> But the current behavior only causes latency problems for an IDE
> system, so if this were made runtime-tunable then it would only be an
> issue for SATA, right?  This would cover 99.9% of audio users, who
> would gladly trade some disk throughput for lower latency.  You can
> record a *lot* of tracks with even a few MB/s of disk throughput.

it's an issue for all block IO drivers that do IO completions from IRQ
context and that can do DMA - i.e. every block IO hardware that uses
interrupts. This includes SCSI too. In fact for SCSI it's a norm to have
tagged queueing active so there the latencies ought to be even higher
(although i havent measured this). IDE/PATA's limitation in this regard
limits latencies as well.

being able to control the max size of sg-tables and the max # of
outstanding commands per IRQ source [this later should already be
possible via driver options] should enable us to control the maximum
hardirq latency introduced by block IO.

(if the hardware & disk is fast enough, or you use a high # of
controllers and disks then you could still overload your system with a
stream of interrupts and cause unbound scheduling latencies - but this
is a separate problem.)

	Ingo
