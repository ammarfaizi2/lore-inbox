Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUJXXHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUJXXHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJXXFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:05:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28548 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261621AbUJXXEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:04:46 -0400
Date: Mon, 25 Oct 2004 01:06:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] SCSI: Replace semaphores with wait_even
Message-ID: <20041024230601.GA14956@elte.hu>
References: <1098300579.20821.65.camel@thomas> <1098647869.10824.247.camel@mulgrave> <1098648414.22387.46.camel@thomas> <1098658889.10906.361.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098658889.10906.361.camel@mulgrave>
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


* James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Sun, 2004-10-24 at 16:06, Thomas Gleixner wrote:
> > Hmm, strange. It works on two systems here and others using this
> > modification had no problem either. 
> > I will check again.
> 
> Yes, very strange given what the mistake is:
> 
> -               down_interruptible(&sem);
> +               wait_event_interruptible(eh_wait, shost->eh_kill ||
> +                               (shost->host_busy ==
> shost->host_failed));
> 
> This condition is always true when the eh thread first starts because
> the default quiescent state of a scsi host is
> 
> shost->host_busy = shost->host_failed = 0
> 
> so your change makes the eh_thread spin forever locking everything
> else off the CPU.  On a UP system, this is a complete hang.

i think i fixed this in my PREEMPT_REALTIME tree (having seen spinning
eh_threads) - maybe Thomas forgot to merge those fixes back?

(in a PREEMPT_REALTIME kernel a spinning thread is just a thread eating
up CPU power, it doesnt cause a hang.)

	Ingo
