Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVBAXpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVBAXpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVBAXpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:45:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44486 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262135AbVBAXpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:45:16 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-04
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tom Rini <trini@kernel.crashing.org>, Bill Huey <bhuey@lnxw.com>,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050201204359.GA346@elte.hu>
References: <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <20050104064013.GA19528@nietzsche.lynx.com>
	 <20050104094518.GA13868@elte.hu> <20050107192651.GG5259@smtp.west.cox.net>
	 <20050126080952.GC4771@elte.hu> <1107288076.18349.7.camel@krustophenia.net>
	 <20050201201704.GA32139@elte.hu>
	 <1107289878.18349.20.camel@krustophenia.net> <20050201204359.GA346@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 18:45:14 -0500
Message-Id: <1107301515.27870.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 21:44 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > OK.  So for application triggered tracing you need LATENCY_TRACING
> > enabled, as described here:
> > 
> > http://lkml.org/lkml/2004/10/29/312
> 
> correct, that too should still work fine - with the small change that
> there's now a separate flag to active it:
> 
> 	echo 1 > /proc/sys/kernel/trace_user_triggered  # default: 0
> 
> it is an orthogonal mechanism to atomicity-debugging.

OK.  Rereading my old mail, it looks like there were some possibly
unresolved false positives with the userspace atomicity debugger.

Here's one I get from alsaplayer.  Would more information be required to
know if this is a false positive?

alsaplayer:5718 userspace BUG: scheduling in user-atomic context!
 [<c0102a97>] dump_stack+0x17/0x20 (20)
 [<c026268c>] schedule+0x6c/0x100 (24)
 [<c026330c>] rwsem_down_read_failed+0x9c/0x170 (48)
 [<c01277f5>] .text.lock.futex+0x7/0xb2 (44)
 [<c01276bf>] do_futex+0x4f/0x80 (28)
 [<c01277ba>] sys_futex+0xca/0xe0 (68)
 [<c0102457>] syscall_call+0x7/0xb (-4028)

(gdb) bt
#0  0x4117c4ec in __lll_mutex_unlock_wake () from /lib/tls/libpthread.so.0
#1  0x41179a69 in _L_mutex_unlock_26 () from /lib/tls/libpthread.so.0
#2  0x0824d3c0 in ?? ()
#3  0xb7ef3958 in ?? ()
#4  0x41179a60 in pthread_mutex_unlock () from /lib/tls/libpthread.so.0
#5  0x41179a60 in pthread_mutex_unlock () from /lib/tls/libpthread.so.0
#6  0x08057a30 in CorePlayer::Read32 (this=0x1, data=0xb7508008, samples=64) at CorePlayer.cpp:1076
#7  0x08057f89 in CorePlayer::streamer_func (arg=0x824d3c0, data=0x824cc80, size=128) at CorePlayer.cpp:1257
#8  0xb7ffcd52 in process (nframes=64, arg=0x824b258) at jack.cpp:350
#9  0xb7ef99f9 in jack_client_thread (arg=0x824bb48) at client.c:1264
#10 0x41177b63 in start_thread () from /lib/tls/libpthread.so.0
#11 0x410f0c4a in clone () from /lib/tls/libc.so.6

The backtrace is incomplete because I was unable to reproduce the
problem with the debug glibc.

Lee


