Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbUJaNMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUJaNMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 08:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUJaNMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 08:12:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:31403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261615AbUJaNLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 08:11:36 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 15:11:30 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031151130.675cb012@mango.fruits.de>
In-Reply-To: <20041031124828.GA22008@elte.hu>
References: <1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
	<20041030233849.498fbb0f@mango.fruits.de>
	<20041031120721.GA19450@elte.hu>
	<20041031124828.GA22008@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 13:48:28 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > ok, could you try the -RT-V0.6.0 patch i've just uploaded? It could i
> > believe improve these latencies.
> 
> hm, CONFIG_PARPORT_1284 seems broken, and USB too, it locks up during
> bootup. Investigating ...

i will try anyways since i don't use neither USB nor my parallel port :)

also, i have uploaded an overhauled version of the wakeup timer program. It
now deferres all output to another SCHED_FIFO thread [with prio 1 lower than
the main process]. The data is passed via a lockless fifo [ripped from jack
sourcecode]. Also it handles commandline options better and has sensible [?]
defaults:

~/source/my_projects/wakeup$ ./rtc_wakeup -h
usage: wakeup [options]
options:
-f freqency(hz) (default 1024) 
-p realtime prio (default 90(91))
-n max number of interrupts (default 0: run until stopped)
-t jitter threshold (%) (default 5) 
-o history_file (default /dev/null)
-h show help

The "history" file contains three rows: irq #, cycle count at wakeup,
jitter(%). The first few entries are probably off [due to startup stuff, all
reporting during runtime takes only irq's after the third into account, to
avoid the startup mess]..

grab it at http://affenbande.org/~tapas/rtc_wakeup.tgz

Here's a typical run (still on V0.5.16, will try V0.6 now):

~/source/my_projects/rtc_wakeup$ ./rtc_wakeup 
rtc_wakeup - press ctrl-c to stop
freq:             1024
max # of irqs:    0 (run until stopped)
jitter threshold: 5%
output filename:  /dev/null
rt priority:      90(91)
getting cpu speed
1194909286.409 Hz (1194.909 MHz)
# of cycles for "perfect" period: 1166903
setting up ringbuffer
setting up consumer thread
setting up /dev/rtc.
locking memory...
turning irq on, beginning measurement (might take a while).
new max. jitter: 0.268231%
threshold violated: 2523891286957 (26.3406%)
new max. jitter: 26.3406%
threshold violated: 2523892156958 (25.4436%)
threshold violated: 2523896074240 (36.5712%)
new max. jitter: 36.5712%
threshold violated: 2523896831195 (35.1313%)
threshold violated: 2523899757527 (50.2766%)
new max. jitter: 50.2766%
threshold violated: 2523900328433 (51.0751%)
new max. jitter: 51.0751%
threshold violated: 2523903338753 (57.0041%)
new max. jitter: 57.0041%
threshold violated: 2523903827419 (58.1228%)
new max. jitter: 58.1228%
threshold violated: 2523905321471 (28.0357%)
threshold violated: 2523906161154 (28.0417%)
threshold violated: 2523909924647 (22.6959%)
threshold violated: 2523911166386 (6.41322%)
threshold violated: 2523911990002 (29.4186%)
threshold violated: 2523913267054 (9.43943%)
threshold violated: 2523914321799 (9.6116%)
threshold violated: 2523915653813 (14.1495%)
threshold violated: 2523916760657 (5.14687%)
threshold violated: 2523917830826 (8.28981%)
threshold violated: 2523920520433 (29.74%)
threshold violated: 2523921329137 (30.6966%)
done.
total # of irqs:      2754
missed irqs:          0
threshold violations: 20
max jitter:           58.1228%


flo
