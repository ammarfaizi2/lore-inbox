Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUKWN4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUKWN4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKWN4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:56:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:37258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261246AbUKWN4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:56:08 -0500
X-Authenticated: #4399952
Date: Tue, 23 Nov 2004 14:57:18 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123145718.250a7649@mango.fruits.de>
In-Reply-To: <20041123144622.GA20085@elte.hu>
References: <20041118164612.GA17040@elte.hu>
	<20041122005411.GA19363@elte.hu>
	<20041122020741.5d69f8bf@mango.fruits.de>
	<20041122094602.GA6817@elte.hu>
	<56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
	<20041122132459.GB19577@elte.hu>
	<20041122142744.0a29aceb@mango.fruits.de>
	<65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
	<20041122154516.GC2036@elte.hu>
	<9182.195.245.190.93.1101142412.squirrel@195.245.190.93>
	<20041123144622.GA20085@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 15:46:22 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> i tried your new test-client, and i've got a generic question: should a
> jack client be able to generate an xrun via, other than via overloading
> jackd? E.g. i'm wondering about the following behavior: if start up
> jackd in the usual way:

The process() callback in a jackd client is run in a thread created by
libjack. This thread is run with SCHED_FIFO and at the same priority (or
one lower it seems) as the jackd server. Thus a client can only cause an
xrun when it takes a too long time to return from its process callback.

~$ ps  -C jackd -cmL
  PID   LWP CLS PRI TTY          TIME CMD
  975     - -     - ?        00:00:00 jackd
    -   975 TS   19 -        00:00:00 -
    -   976 TS   23 -        00:00:00 -
    -   977 FF  110 -        00:00:00 -
    -   978 FF  100 -        00:00:00 -

~$ ps -C jack_test -cmL
  PID   LWP CLS PRI TTY          TIME CMD
  988     - -     - pts/1    00:00:00 jack_test
    -   988 TS   20 -        00:00:00 -
    -   989 FF   99 -        00:00:00 -

So when you ctrl-z out of jack_test you cause its process() thread to be
suspended, too, thus jackd cannot finish processing its graph.

flo
