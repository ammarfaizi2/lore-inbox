Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVLGWOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVLGWOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVLGWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:14:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47594 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030393AbVLGWOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:14:18 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133982048.2869.60.camel@laptopd505.fenrus.org>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <1133978128.2869.51.camel@laptopd505.fenrus.org>
	 <1133978996.24344.42.camel@localhost>
	 <1133982048.2869.60.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:13:56 -0800
Message-Id: <1133993636.30387.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 20:00 +0100, Arjan van de Ven wrote:
> > So, like in the global pidspace (which can see all pids and appears to
> > applications to be just like normal) you end up returning "kernel" pids
> > to userspace.  That didn't seem to make sense.  
> 
> hmm this is scary. If you don't have "unique" pids inside the kernel a
> lot of stuff will subtly break. DRM for example (which has the pid
> inside locking to track ownership and recursion), but I'm sure there's
> many many cases like that. I guess the address of the task struct is the
> ultimate unique pid in this sense.... but I suspect the way to get there
> is first make a ->user_pid field, and switch all userspace visible stuff
> to that, and then try to get rid of ->pid users one by one by
> eliminating their uses... 

OK, what I'm talking about here is the way that it is done now with
existing code.  It seems to work and make people happy, but it certainly
isn't the only possible way to do it.  I'm very open to suggestions. :)

There really are two distinct pid spaces.  Instead of vservers, we tend
to call the different partitioned areas containers.

Each container can only see processes in its own container.  The
exception is the "global container", which has a view of all of the
system processes.  Having the global container allows you to do things
like see all of the processes on the whole system with top.

So, the current tsk->pid is still unique.  However, there is also a
tsk->virtual_pid (or some name) that is unique _inside_ of a container.
These two pids are completely unrelated.  Having this virtualized pid
allows you to have the real tsk->pid change without userspace ever
knowing.

For example, that tsk->pid might change if you checkpointed a process,
it crashed, and you restarted it later from the checkpoint.

> but I'm really afraid that if you make the "fake" pid visible to normal
> kernel code, too much stuff will go bonkers and end up with an eternal
> stream of security hazards. "Magic" hurts here, and if you don't do
> magic I don't see a reason to add an abstraction which in itself doesn't
> mean anything or doesn't abstract anything....

99% of the time, the kernel can deal with the same old tsk->pid that
it's always dealt with.  Generally, the only times the kernel has to
worry about the virtualized one is where (as Eric noted) it cross the
user<->kernel boundary.

-- Dave

