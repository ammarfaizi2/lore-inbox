Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUKWOmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUKWOmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKWOke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:40:34 -0500
Received: from pop.gmx.de ([213.165.64.20]:49123 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261261AbUKWOkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:40:00 -0500
X-Authenticated: #4399952
Date: Tue, 23 Nov 2004 15:41:03 +0100
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
       Esben Nielsen <simlo@phys.au.dk>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041123154103.56c25300@mango.fruits.de>
In-Reply-To: <20041123152126.GB22714@elte.hu>
References: <20041122020741.5d69f8bf@mango.fruits.de>
	<20041122094602.GA6817@elte.hu>
	<56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
	<20041122132459.GB19577@elte.hu>
	<20041122142744.0a29aceb@mango.fruits.de>
	<65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
	<20041122154516.GC2036@elte.hu>
	<9182.195.245.190.93.1101142412.squirrel@195.245.190.93>
	<20041123144622.GA20085@elte.hu>
	<20041123145718.250a7649@mango.fruits.de>
	<20041123152126.GB22714@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 16:21:26 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > ~$ ps -C jack_test -cmL
> >   PID   LWP CLS PRI TTY          TIME CMD
> >   988     - -     - pts/1    00:00:00 jack_test
> >     -   988 TS   20 -        00:00:00 -
> >     -   989 FF   99 -        00:00:00 -
> > 
> > So when you ctrl-z out of jack_test you cause its process() thread to
> > be suspended, too, thus jackd cannot finish processing its graph.
> 
> so in theory any scheduling delay of PID 988 in the above setup (the
> SCHED_OTHER task) should not be able to negatively influence jackd,
> correct? 

correct

> In fact, does in this particular jack_test case PID 988 do
> anything substantial?

Well, it registers the client with jackd, sets up the ports, registers
the process() callback and then simply goes to sleep() for the desired
runtime of the program. All these are non RT ops and should never be
able to cause any xruns.

All the work is done by the process() callback which is called by
libjack in a SCHED_FIFO thread. The process() callback is called once
for each buffer that jackd processes.

I cannot explain the detailed mechanism of how jackd wakes its clients
and communicates with them myself too well, so i'll leave this to Paul
Davis (CC'ed). Care to elaborate, Paul?

flo
