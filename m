Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVAUM4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVAUM4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVAUM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:56:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17117 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262359AbVAUM4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:56:33 -0500
Date: Fri, 21 Jan 2005 13:55:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121125558.GA5596@elte.hu>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121124701.GA5179@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121124701.GA5179@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > > This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
> > > Cpushare (until trusted computing will hit the hardware market). 
> > > [...]
> > 
> > why do you need any kernel code for this? This seems to be a limited
> > ptrace implementation: restricting untrusted userspace code to only be
> > able to exec read/write/sigreturn.
> > 
> > So this patch, unless i'm missing something, duplicates in essence what
> > ptrace can do [...]
> 
> there's one thing ptrace wont do: if the ptrace parent dies
> unexpectedly and the child was 'running' (there is a small window
> where the child might not be stopped and where this may happen) then
> the child can get runaway. While i think this is theoretical (UML
> doesnt suffer from this problem), it is simple to fix - find below a
> proof-of-concept patch that introduces PTRACE_ATTACH_JAIL - ptraced
> children can never escape out of such a jail. (barely tested - but you
> get the idea.)

maybe this could even be fit into existing ptrace semantics, without any
need for PTRACE_ATTACH_JAIL. What we need is to catch the case where a
ptraced child is running (i.e. the signal_wake_up() has already been
done, and the parent is waiting for the child to stop again), and the
ptrace parent is killed unexpectedly.  Would it be a correct fix to just
unconditionally stop the child in this case (and leave it hanging in
such a state)? Or to kill it right away?

	Ingo
