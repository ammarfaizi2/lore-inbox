Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129977AbQK3RPa>; Thu, 30 Nov 2000 12:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129982AbQK3RPU>; Thu, 30 Nov 2000 12:15:20 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:53393 "EHLO
        green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
        id <S129572AbQK3RPQ>; Thu, 30 Nov 2000 12:15:16 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: Arnaud Installe <ainstalle@filepool.com>,
        Ray Bryant <raybry@austin.ibm.com>
Subject: Re: high load & poor interactivity on fast thread creation
Date: Thu, 30 Nov 2000 16:37:19 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org> <3A266895.F522A0E2@austin.ibm.com> <20001130171137.A1851@bartok.filepool.com>
In-Reply-To: <20001130171137.A1851@bartok.filepool.com>
MIME-Version: 1.0
Message-Id: <00113016451700.12212@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, Arnaud Installe wrote:
> On Thu, Nov 30, 2000 at 08:47:49AM -0600, Ray Bryant wrote:
> > The IBM implementations of the Java language use native threads --
> > the result is that every time you do a Java thread creation, you
> > end up with a new cloned process.  Now this should be pretty fast,
> 
> Well, I think the problem is that it is *too* fast.  :-/  What I think
> happens is that a lot of threads get created at the same time, and they
> all run a bit of initialization code.  This way a lot of processes are in
> the running state, so that the load average gets *very* high, which makes
> the system very unresponsive.

Certainly sounds plausible; if the first process is able to create a lot of
runnable processes/threads in a single timeslice, the scheduler is then hit
with a huge queue to plough through once that timeslice ends.

Making calls to clone() force a schedule() might help here? That way, hopefully
each thread can run its initialisation code before the next one is created,
avoiding the problem?

> Could this be correct ?  Also, I haven't seen this happen with NT.  Could
> it be that Java on NT uses user-mode threading and creates threads much
> more slowly, resulting in a lower load ?

Perhaps; alternatively, if it schedules the new thread to run before resuming
the parent thread, each thread is initialised when created, rather than
building up a huge backlog, that would avoid the problem.

> > so I am surprised that it stalls like that.  It is possible this
> > is a scheduler effect.  Do you have a program example you can
> > share with us?
> 
> So I suppose it is a scheduler effect.  Can this be solved on the kernel
> side (a /proc/sys setting perhaps ?), or should a check be built-in into
> the software that no more than a certain number of threads are created per
> time unit ?

Either of those could help. Alternatively, have you tried inserting a yield
instruction in the Java code after creating each thread, to make sure the new
thread gets a chance to initialise?


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
