Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUJCUPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUJCUPx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUJCUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:15:52 -0400
Received: from [66.35.79.110] ([66.35.79.110]:23451 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S268120AbUJCUNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:13:08 -0400
Date: Sun, 3 Oct 2004 13:10:05 -0700
From: Tim Hockin <thockin@hockin.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Hubertus Franke <frankeh@watson.ibm.com>, dipankar@in.ibm.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20041003201005.GA27757@hockin.org>
References: <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821020000.1096814205@[10.10.2.4]>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2004 at 07:36:46AM -0700, Martin J. Bligh wrote:
> > This is where I see the need for "CPU sets".  I.e. as a 
> > replacement/modification to the CPU affinity mechanism basically adding 
> > an extra level of abstraction to make it easier to use for implementing 
> > the type of isolation that people seem to want.  I say this because, 
> > strictly speaking and as you imply, the current affinity mechanism is 
> > sufficient to provide that isolation BUT it would be a huge pain to 
> > implement.
> 
> The way cpusets uses the current cpus_allowed mechanism is, to me, the most
> worrying thing about it. Frankly, the cpus_allowed thing is kind of tacked
> onto the existing scheduler, and not at all integrated into it, and doesn't
> work well if you use it heavily (eg bind all the processes to a few CPUs,
> and watch the rest of the system kill itself). 

7 years ago, before cpus_allowed was dreamed up, I proposed a pset patch
and was shot down hard.  Now it's back, and we're trying to find a way to
cram it in on top.

Yeah, it does not fit nicely with cpus_allowed.

I have to ask - do we REALLY need cpusets?  I meant, even SGI dropped
PSET at some point, because (if I recall) NO ONE USED IT.

What's the problem being solved that *requires* psets?

I have a customer I work with periodically who was using my pset patch up
until they moved to RH8, when the O(1) scheduler and cpus_allowed changed
everything.  This was their requirement for pset:

1. Take a processor out of the general execution pool (call it
PROC_RESTRICTED).  This processor will not schedule general tasks.
2. Assign a task to the PROC_RESTRICTED cpu.  Now that CPU will only
schedule the assigned task (and it's children).
3. Repeat for every CPU, with the caveat that one CPU must remain
PROC_ENABLED.

I had an array of enum procstate and a new syscall pair:
sched_{gs}etprocstate().  The scheduler checks the procstate, and if it is
not ENABLED, it checks that (cpus_allowed == 1<<cpu).  Simple, but works.
Could be baked a bit more, for general use.

What if I proposed a patch like this, now?  It would require cleanup for
2.6, but I'm game if it's useful.

Tim

