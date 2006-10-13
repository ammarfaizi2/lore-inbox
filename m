Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWJMVZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWJMVZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWJMVZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:25:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17041 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932077AbWJMVZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:25:10 -0400
Date: Sat, 14 Oct 2006 02:54:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20061013212450.GC7477@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com> <200610132318.02512.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610132318.02512.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 11:18:01PM +0200, Karsten Wiese wrote:
> Am Samstag, 30. September 2006 20:18 schrieb Dipankar Sarma:
> > On Sat, Sep 30, 2006 at 02:06:04PM -0400, Lee Revell wrote:
> > > On Wed, 2006-09-20 at 16:19 +0200, Ingo Molnar wrote:
> > > > I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded 
> > > > from the usual place:
> > > > 
> > > >    http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > I got this Oops with -rt3, looks RCU related.  Apologies in advance if
> > > it's already known.
> > > 
> > > Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> > >  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
> > > PGD 46a3067 PUD 4e27067 PMD 0 
> > > Oops: 0002 [1] PREEMPT SMP 
> > > CPU 1 
> > 
> > I see a very similar crash while running rcutorture on 2.6.18-mm1 and
> > my rcu patchset that has rcupreempt stuff rom -rt. I don't see this
> > 
> 
> Bug just happened here on a tainted UP x86_64 running rt4.
> IIRC this is the second time in 2 weeks or so.
> Machine seams to be fine still after the oops...
> 
> <Oops>
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
>  [<ffffffff802a1b21>] __rcu_read_unlock+0x2e/0x80
> PGD 3b616067 PUD 1718b067 PMD 0
> Oops: 0002 [1] PREEMPT
> CPU 0
> Modules linked in: autofs4 sunrpc video button ac lp parport_pc parport nvram snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq nvidia snd_pcm_oss snd_mixer_oss snd_pcm ehci_hcd uhci_hcd snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi pcspkr snd_seq_device snd i2c_viapro i2c_core r8169 soundcore ext3 jbd
> Pid: 7102, comm: sh Tainted: P      2.6.18-rt4 #4
> RIP: 0010:[<ffffffff802a1b21>]  [<ffffffff802a1b21>] __rcu_read_unlock+0x2e/0x80


Sorry, I should have published my investigations long ago. I tracked
this down (atleast the crash in my machine) to NMI interference
with rcu_read_lock()/rcu_read_unlock(). We use those APIs
from NMI context as well 
(default_do_nmi()->notify_die()->atomic_notifier_call_chain()).

Can you try with nmi_watchdog=0 in the kernel command line ?

Paul has an NMI-safe patch for rcupreempt which I am adopting
and testing at the moment. If this works well, I will publish
a new patchset.

Thanks
Dipankar
