Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUHEShf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUHEShf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267870AbUHESgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:36:47 -0400
Received: from fmr12.intel.com ([134.134.136.15]:59078 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267892AbUHESbp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:31:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [robustmutexes] Re: [RFC/PATCH] FUSYN Realtime & robust mutexes forLinux, v2.3.1
Date: Thu, 5 Aug 2004 11:29:50 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C5@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [robustmutexes] Re: [RFC/PATCH] FUSYN Realtime & robust mutexes forLinux, v2.3.1
Thread-Index: AcR64ibW0HqohgaQTFaGv8yBvVIE5wAN0lHw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>,
       "Ulrich Drepper" <drepper@redhat.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <robustmutexes@lists.osdl.org>,
       "Ingo Molnar" <mingo@elte.hu>, <jamie@shareable.org>,
       "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 18:29:56.0957 (UTC) FILETIME=[3576F0D0:01C47B1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rusty Russell
> 
> On Thu, 2004-08-05 at 17:37, Ulrich Drepper wrote:
> > Andrew Morton wrote:
> > > Passing the lock to a non-rt task when there's an rt-task waiting for it
> > > seems pretty poor form, too.
> >
> > No no, that's not what is wanted.  Robust mutexes are a special kind of
> > mutex and not related to rt issues.  Lockers of robust mutexes have to
> > register with the kernel (i.e., the locking must actually be performed
> > by the kernel) so that in case the thread goes away or the entire
> > process dies, the mutex is unlocked and other waiters (other threads, in
> > the same or other processes) can get the lock.
> 
> I don't think this is neccessarily true: I think that platforms with
> 64-bit compare-and-exchange can do the whole thing in userspace.  They
> would set the mutex and stamp in the thread ID simultanously, allowing
> for "dead thread" detection (ie. I didn't get the lock, and it's a
> robust mutex: check the holder is still alive).
> 
> W/o 64-bit compare-and-exchange a 100% robust solution may not be
> possible though.

Exactly, this is the only weakness in the implementation. In 32 bits the
space for stamping an ID in user space that the kernel can resolve is
pretty limited to avoid PID reusage conflicts. As soon as I have some time
I want to try hashing something like an xPID with the task->pid and the
task->start_time, that should be pretty unique. In 64 bit arches that hash
should be almost unbreakable and collision chance so slim as to be negligible.

On 32 bits arches though (or on all) I want to add some more code to the
task ID code that checks if the task that was found shares any memory with
the calling task. If not, that would be a collision and would mean the owner
died previously. If yes, it could be deemed as a good positive [with still
an small chance of collision, but the hashing + this should make it truly 
slim already].

As well, increasing the PID-space/actual-number-of-running-tasks ratio should
improve it. Ingo, you wrote the PID allocator--increasing the PID max 
automatically means PIDs take more time to be reused or am I completely
wrong?

Final thing: when you cannot live with the slim chance of collision, you
can always flip a bit in the mutex ([pthread_mutexattr_setfast_np()] and
it will always go through the kernel. Total determinism, at the expense of
performance.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
