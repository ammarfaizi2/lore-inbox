Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJNKle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJNKle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUJNKle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:41:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24193 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266683AbUJNKlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:41:13 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay> <20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
	<20041007105425.02e26dd8.pj@sgi.com>
	<1344740000.1097172805@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2004 04:35:54 -0600
In-Reply-To: <1344740000.1097172805@[10.10.2.4]>
Message-ID: <m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> My main problem is that I don't think we want lots of overlapping complex 
> interfaces in the kernel. Plus I think some of the stuff proposed is fairly 
> klunky as an interface (physical binding where it's mostly not needed, and
> yes I sort of see your point about keeping jobs on separate CPUs, though I
> still think it's tenuous), and makes heavy use of stuff that doesn't work 
> well (e.g. cpus_allowed). So I'm searching for various ways to address that.

Sorry I spotted this thread late.  People seem to be looking at how things
are done on clusters and then apply them to numa machines.  Which I agree
looks totally backwards.  

The actual application requirement (ignoring the sucky batch schedulers)
is for a group of processes (a magic process group?) to all be
simultaneously runnable.  On a cluster that is accomplished by having
an extremely stupid scheduler place one process per machine.   On a
NUMA machine you can do better because you can suspend and migrate
processes.  

The other difference on these large machines is these compute jobs
that are cpu hogs will often have priority over all of the other
processes in the system.  

A batch scheduler should be able to prevent a machine from being
overloaded by simply not putting too many processes on the machine at
a time.  Or if a higher priority job comes in suspending all of
the processes that of some lower priority job to make run for the
new job.  Being able to swap page tables is likely a desirable feature
in that scenario so all of the swapped out jobs resources can be
removed from memory.

> It all just seems like a lot of complexity for a fairly obscure set of
> requirements for a very limited group of users, to be honest. 

I think that is correct to some extent.  I think the requirements are
much more reasonable when people stop hanging on to the cludges they
have been using because they cannot migrate jobs, or suspend
sufficiently jobs to get out of the way of other jobs. 

Martin does enhancing the scheduler to deal with a group of processes 
that all run in lock-step, usually simultaneously computing or
communicating sound sane?  Where preempting one is effectively preempting
all of them.

I have been quite confused by this thread in that I have not seen
any mechanism that looks beyond an individual processes at a time,
which seems so completely wrong.


Eric
