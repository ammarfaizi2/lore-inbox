Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVDEPSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVDEPSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVDEPSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:18:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:23969 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261747AbVDEPS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:18:27 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050405152954.00bf4e60@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 05 Apr 2005 17:18:17 +0200
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Esben Nielsen <simlo@phys.au.dk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <Pine.LNX.4.61.0504050156420.2566@montezuma.fsmlabs.com>
References: <Pine.OSF.4.05.10504050106110.8387-100000@da410.phys.au.dk>
 <Pine.OSF.4.05.10504050106110.8387-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0513-2, 04/01/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:57 AM 4/5/2005 -0600, Zwane Mwaikambo wrote:
>On Tue, 5 Apr 2005, Esben Nielsen wrote:
>
> > > I'm sure a lot of the yield() users could be converted to
> > > schedule_timeout(), some of the users i saw were for low memory 
> conditions
> > > where we want other tasks to make progress and complete so that we a bit
> > > more free memory.
> > >
> >
> > Easy, but damn ugly. Completions are the right answer. The memory system
> > needs a queue system where tasks can sleep (with a timeout) until the
> > right amount of memory is available instead of half busy-looping.
>
>I agree entirely, that would definitely be a better way to go eventually.

I wouldn't bet on it.  There used to be a queue - minus the 
timeout.  Throughput improved markedly with it's removal.

That said, yield()s in the kernel can be quite evil.  I once instrumented 
semaphores, and under hefty load, frequently found tasks waiting for a 
semaphore held by someone in the expired array.  When you've got a busy 
cpu, that wait can be _extremely_ painful.  The yield()s in mm/*.c are long 
gone (thank god), but after a quick grep/peek, I can imagine the one in 
free_more_memory() causing some throughput grief in a cpu intense 
environment, and the one in __wait_on_freeing_inode() would punt you into 
the dungeon while you're holding the inode lock... that looks like it could 
be pretty unpleasant.

         -Mike 

