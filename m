Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVARREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVARREv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 12:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVARREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 12:04:51 -0500
Received: from mail.joq.us ([67.65.12.105]:60061 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261351AbVARREs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 12:04:48 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us>
	<871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu>
	<87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu>
	<87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 18 Jan 2005 11:05:24 -0600
In-Reply-To: <20050118080218.GB615@elte.hu> (Ingo Molnar's message of "Tue,
 18 Jan 2005 09:02:18 +0100")
Message-ID: <87pt02pt0r.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Jack O'Quin <joq@io.com> wrote:
>
>> In the absence of any documentation, I'm guessing about storing the
>> nice value in the priority field of the sched_param struct.  But, I
>> have not been able to figure out how to make that work.
>
> the call you need is:
>
>        setpriority(PRIO_PROCESS, tid, -20);
>
> where 'tid' is the TID (pid) of the thread in question. There's no way i
> know of to utilize the pthread_t ID to do this, so you'll have to figure
> the TID out via gettid() - which needs to happen in the child context -
> how hard would it be to attach the TID field to some per-thread Jack
> structure? [while the purpose is still a quick hack.]

Adding a tid field is relatively easy.  Fixing the race condition
between setting it in the new thread and using it in the creating
thread is harder, but not impossible.  But, even setting it in the new
thread would create an incompatible interface.  With hundreds of JACK
client applications, binary compatibility is a serious consideration.

Due to the absurd difficulty of successfully creating a realtime
thread under the various incompatible Linux kernels and pthread
libraries, we export jack_create_thread() to applications.  That way,
they can take advantage of our latest fix for the latest NPTL botch
(0.60 was particularly bad).

So, the new thread's start_routine is not necessarily ours.  I suppose
we could provide an internal function to intialize the thread and then
call the requester's start_routine.  But, this is getting to be a
significant time sink.

Eventually, I can probably cobble something together that will
establish whether your current 2.6.10 SCHED_OTHER works with nice -20.
Is that all we're trying to accomplish?  I do think it can be made to
work (on some kernel versions, given appropriate privileges, with
kernel thread priorities adjusted properly, etc.).

But, that does not meet any of my needs.
-- 
  joq
