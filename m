Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUHHE6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUHHE6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHHE6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:58:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:28057 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264386AbUHHE6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:58:21 -0400
Subject: Re: [Jackit-devel] Re: xruns
From: Lee Revell <rlrevell@joe-job.com>
To: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040807222832.GA29571@login.ecs.soton.ac.uk>
References: <20040807205138.4d170cfd@mango.fruits.de>
	 <1091916076.894.23.camel@mindpipe>
	 <20040807222832.GA29571@login.ecs.soton.ac.uk>
Content-Type: text/plain
Message-Id: <1091941106.1183.76.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 00:58:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-07 at 18:28, Steve Harris wrote:
> On Sat, Aug 07, 2004 at 06:01:16 -0400, Lee Revell wrote:
> > I have not found a good solution to this issue.  It's possibe that this
> > is an ALSA bug, though Steve Harris says this xrun is inevitable.  I am
> > not sure I understand why.
> 

It looks like this one is actually real, because when I use the
preempt-timing patch it corresponds to a report of a 10ms
non-preemptible section.  get_user_pages appears to be the offender.

jackd does not print an xrun report here due to this code in
alsa-driver.c:

/* Delay (in process calls) before jackd will report an xrun */
#define XRUN_REPORT_DELAY 64

...

if (snd_pcm_status_get_state(status) == SND_PCM_STATE_XRUN
  && driver->process_count > XRUN_REPORT_DELAY) {
  ... print xrun errmsg ...
}

Presumably the author thought this behavior was by design.

(jackd/6566): 10952us non-preemptible critical section violated 1000 us preempt threshold starting at kmap_atomic+0x10/0x60 and ending at kunmap_atomic+0x8/0x20
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c0111ce8>] kunmap_atomic+0x8/0x20
 [<c013e2cb>] do_anonymous_page+0x8b/0x190
 [<c013e41e>] do_no_page+0x4e/0x310
 [<c013e8a1>] handle_mm_fault+0xc1/0x170
 [<c013d280>] get_user_pages+0x110/0x380
 [<c013e9f8>] make_pages_present+0x68/0x90
 [<c0140196>] do_mmap_pgoff+0x3e6/0x620
 [<c010b656>] sys_mmap2+0x76/0xb0
 [<c01060b7>] syscall_call+0x7/0xb

Lee

