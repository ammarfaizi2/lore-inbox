Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGZJVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGZJVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUGZJVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:21:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61343 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265086AbUGZJVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:21:46 -0400
Date: Mon, 26 Jul 2004 11:22:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: preempt timing violations
Message-ID: <20040726092251.GA25904@elte.hu>
References: <1090813907.6936.56.camel@mindpipe> <20040726085002.GA25519@elte.hu> <1090832953.6936.114.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090832953.6936.114.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-0.908, required 5.9,
	autolearn=not spam, BAYES_10 -0.91
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > this is the normal sys_exit()->exit_mmap()->unmap_vmas() path. It's
> > weird that it generated a 2ms latency. What are the values of
> > voluntary_preemption and kernel_preemption on your current kernel? With
> > a 2:0 setting we ought to have a reschedule point every 32 pages.  Do
> > you know which application triggers this latency and is it easy to
> > reproduce?
> > 
> 
> 2 and 1.  Now that I think about it, this could have happened during
> bootup, before my rc.local set these.  I will try passing them on the
> kernel command line. 

hm, if you enabled kernel_preemption then the get_user_pages() fix in
-J3 should already be available via normal kernel preemption, because
make_pages_present() is preemptible. I am wondering whether the
preempt-timing patch properly deals with CONFIG_PREEMPT? Did those
latencies get accompanied by a real Alsa XRUN as well? (assuming you can
set the XRUN threshold to be close to the preempt-timing threshold.)

> Not sure I understand the difference between 2:1 and 2:0.  Would the
> latter make the kernel only preemptible at the voluntary preemption
> points?

yes, this is the default on bootup. 1:0 is in essence what we are using
in the latest development kernels of Fedora Core 3, hence the focus and
distinction. It is an intermediate preemptability step between the
vanilla kernel and full CONFIG_PREEMPT. If the concept produces a stable
enough kernel for use in bigger distros such as FC3 it could pave the
way for more mainstream acceptance of CONFIG_PREEMPT.

> > does this one trigger when you are using the VGA console? (or fbcon)?
> > 
> > it's not immediately obvious to me precisely where this latency comes
> > from, it would be nice to know how to reproduce it.
> 
> It think this one was caused by switching virtual consoles.  At one
> point Andrew Morton suggested I remove the (un)lock_kernel calls from
> do_tty_write.  This fixed the problem, with no detectable side
> effects.  Maybe this could be incorporated into voluntary-preempt, it
> would be useful to have more than one person to test it.

if it's the text consoles that you used then most latencies are caused
by the text-video-RAM copying. Even today's fast videocards do that with
very bad performance - especially since we often do copies within
videoram too. Such a copying of ~6K of videoram can easily take 3-4
msecs.

If the tty layer is run without the kernel lock then this copying
becomes preemptible. Could you send me the current tty-unlock patch that
you are using? (i've seen some early ones.)

	Ingo
